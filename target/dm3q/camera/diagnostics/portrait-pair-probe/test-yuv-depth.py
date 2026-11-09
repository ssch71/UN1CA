#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Apply actual native maps to one recorded pair; gate isolated native depth.

Requires numpy/OpenCV on host. Never installs APKs or opens cameras. Creates
only a unique remote temporary directory and a new host results directory.
"""
import argparse
import datetime
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shlex
import struct
import subprocess

import cv2
import numpy as np

ENGINE_SHA = "4c153d7c3b0ae1278ba0ec4723f11b4755a6cb481b692e7b1ad5af90c8a6882c"
CAL_SHA = "ee645b3ee69a2a4401370f234473e0adf096cd2de4c1ed41a9d6884ef2364884"


def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()


def vendor_contract(result):
    """Decode only exact byte layouts recovered from this CamX/provider build.

    Returned metadata is a processing contract, not an optical measurement.
    In particular the provider can populate identical physical crop fields.
    """
    values = result.get("vendor_geometry", {}).get("values", {})
    def words(name, count):
        item = values.get(name, {})
        data = item.get("values", [])
        if item.get("type") != "[B" or item.get("length") != count*4 or len(data) != count*4 or item.get("truncated"):
            return None
        if any(type(v) is not int or not -128 <= v <= 255 for v in data):
            return None
        return list(struct.unpack("<"+"i"*count, bytes(v & 255 for v in data)))
    sync = words("com.qti.chi.multicamerainfo.SyncMode", 2)
    crop = words("com.qti.cropregions.crop_regions", 16)
    names = ("userCropRegion", "dzWindowNoMargin", "pipelineCropRegion", "ifeLimitCropRegion")
    return {"sync_words": sync,
            "sync_enable_word": None if sync is None else sync[0],
            "sync_request_enabled_in_returned_record": None if sync is None else sync[0] == 1,
            "crop_rectangles": None if crop is None else {name: crop[i*4:i*4+4] for i,name in enumerate(names)},
            "optical_synchronization_verified": False,
            "crop_fields_are_independent_measurements": False}


def validate_centered_input(metadata):
    """Fail before native staging when the dimensions-only helper is unsuitable.

    SCALER_CROP_REGION describes the advertised input contract; it does not
    prove the provider's internal IFE/residual crop or distortion domain.
    """
    for camera in ("54", "52"):
        result = metadata[camera]
        if result.get("crop") != "Rect(0, 0 - 3648, 2736)":
            raise ValueError(camera + ": native helper supports only the measured full-array crop; offset crops require the native noncentered API")
        if result.get("rotate_and_crop") != "0":
            raise ValueError(camera + ": unrotated input must be observed before using these native maps")


def validate_map_contract(rows):
    begin = next(r for r in rows if r["event"] == "begin")
    if begin.get("buffer_size") != [640, 480] or begin.get("crop_size") != [3648, 2736]:
        raise ValueError("Native map helper input dimensions differ from the matched capture")
    crop = next(r for r in reversed(rows) if r["event"] == "crop_config")
    words = crop["words"]
    if crop["kind"] != 1 or len(words) < 13 or any(
            words[start:start+4] != [0, 0, 3648, 2736] for start in (3, 8)):
        raise ValueError("Native engine selected an unsupported offset/size crop")
    return {"reported_crop_matches_native_centered_config": True,
            "buffer_size": [640, 480], "native_crop_size": [3648, 2736],
            "provider_internal_crop_observed": False,
            "distortion_domain_validated": False}


def pair_inputs(folder, timestamp=None):
    rows = [json.loads(line) for line in (folder/"report.jsonl").read_text().splitlines() if line.strip()]
    begin = next(r for r in reversed(rows) if r["event"] == "begin")
    if begin.get("main") != "54" or begin.get("aux") != "52" or not begin.get("save_yuv"):
        raise ValueError("Requires complete-YUV physical54/52 diagnostic")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    saved = {}
    for r in rows:
        if r["event"] == "saved_yuv": saved.setdefault(int(r["timestamp_ns"]), {})[r["id"]] = r
    logical = {int(r["timestamp_ns"]): r for r in rows if r["event"] == "result" and r["timestamp_ns"] != "null"}
    candidates = sorted(t for t, images in saved.items() if set(images) == {"54", "52"} and t in logical)
    if timestamp is None:
        candidates = [t for t in candidates if logical[t]["phase"] == "auto"]
        if not candidates: raise ValueError("No complete timestamp-associated autofocus YUV pair")
        timestamp = candidates[0]
    if timestamp not in candidates: raise ValueError("Timestamp has no complete pair/result")
    result = logical[timestamp]
    physical = {r["id"]: r for r in rows if r["event"] == "physical_result" and r["frame"] == result["frame"]}
    if not all(i in physical for i in ("54", "52")): raise ValueError("Missing matched physical results")
    images = []
    for i in ("54", "52"):
        r = saved[timestamp][i]; p = (folder/r["file"]).resolve()
        if not p.is_relative_to(folder.resolve()) or r["format"] != "NV21" or (r["width"], r["height"], r["bytes"]) != (640, 480, 460800):
            raise ValueError("YUV path/format/size unsupported")
        if p.stat().st_size != 460800 or digest(p) != r["sha256"]: raise ValueError("YUV input hash/length mismatch")
        if r.get("image_crop") != "Rect(0, 0 - 640, 480)": raise ValueError("Unsupported delivered-image crop")
        images.append((p, cv2.cvtColor(np.frombuffer(p.read_bytes(), np.uint8).reshape(720, 640), cv2.COLOR_YUV2BGR_NV21)))
    return timestamp, physical, images


def alignment(main, aux, normalized, scale):
    source = Path(__file__).with_name("validate-native-transform.py")
    spec = importlib.util.spec_from_file_location("native_math", source)
    math = importlib.util.module_from_spec(spec); spec.loader.exec_module(math)
    sift = cv2.SIFT_create(nfeatures=3000, contrastThreshold=.015)
    features = [sift.detectAndCompute(cv2.cvtColor(im, cv2.COLOR_BGR2GRAY), None) for im in (main, aux)]
    if any(d is None or len(d)<2 for _, d in features): return {"passed": False, "reason": "insufficient texture"}
    matches = [pair[0] for pair in cv2.BFMatcher().knnMatch(features[0][1], features[1][1], k=2)
               if len(pair) == 2 and pair[0].distance < .7*pair[1].distance]
    if len(matches)<8: return {"passed": False, "reason": "insufficient correspondences", "matches": len(matches)}
    points = [np.array([features[i][0][m.queryIdx if i==0 else m.trainIdx].pt for m in matches]) for i in (0, 1)]
    f30 = np.array(normalized); fx, fy, cx, cy = f30[22:26]*scale
    k = np.array([[fx, 0, cx], [0, fy, cy], [0, 0, 1.]])
    # Explicit factory-translation hypothesis. No fitted substitute or sign search.
    translation = math.rotation(-f30[:3]) @ f30[3:6]
    f = np.linalg.inv(k).T @ math.cross(translation) @ np.linalg.inv(k)
    a, b = [np.c_[p, np.ones(len(p))] for p in points]
    la, lb = b@f, a@f.T
    numerator = np.abs(np.sum(b*lb, axis=1))
    errors = .5*numerator*(1/np.linalg.norm(la[:, :2], axis=1)+1/np.linalg.norm(lb[:, :2], axis=1))
    cv2.setRNGSeed(26)
    _, mask = cv2.findFundamentalMat(*points, cv2.FM_RANSAC, 1.5, .999)
    subset = errors[mask.ravel().astype(bool)] if mask is not None else np.array([])
    summary = math.summary(errors)
    return {"passed": len(matches)>=20 and summary["fraction_within_1_5px"]>=.8 and summary["p90_px"]<=3,
            "all_ratio_matches": summary, "scene_derived_subset_only": math.summary(subset),
            "factory_F": f.tolist(), "points_main": points[0].tolist(), "points_aux": points[1].tolist(),
            "translation_convention_assumed": "X_aux=Rodrigues(Tilt)*X_main+Shift",
            "fitted_calibration": False}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("folder", type=Path)
    p.add_argument("--tools", required=True, type=Path, help="Built bundle directory containing both native executables")
    p.add_argument("--calibration", required=True, type=Path)
    p.add_argument("--serial", required=True)
    p.add_argument("--timestamp", type=int)
    p.add_argument("--project-id", type=int, choices=(48, 49), help="Explicit isolated stock project; does not establish production plugin state")
    p.add_argument("--run-native-depth", action="store_true", help="Run real-buffer native depth only if all gates pass")
    p.add_argument("--exploratory-native-depth", action="store_true",
                   help="Explicit isolated engine experiment despite optical validation blockers; never validates geometry/depth")
    p.add_argument("--apply-capture-metadata", action="store_true",
                   help="Pass measured main ISO and traced Qualcomm normal-capture mode to isolated depth helper")
    p.add_argument("--adb", default="/mnt/c/platform-tools/adb.exe")
    args = p.parse_args()
    if args.exploratory_native_depth and not args.run_native_depth:
        p.error("--exploratory-native-depth requires --run-native-depth")
    if args.apply_capture_metadata and (not args.run_native_depth or args.project_id is None):
        p.error("--apply-capture-metadata requires --run-native-depth and explicit --project-id")
    if args.serial != "R5CW72R7SDF" or digest(args.calibration) != CAL_SHA: raise SystemExit("Device/calibration mismatch")
    timestamp, metadata, images = pair_inputs(args.folder, args.timestamp)
    validate_centered_input(metadata)
    capture_arg = ""
    if args.apply_capture_metadata:
        iso = int(metadata["54"]["iso"])
        if not 50 <= iso <= 3200: raise ValueError("Measured main ISO outside supported range")
        capture_arg = " "+str(iso)
    output = args.folder/("native-depth-"+datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%d-%H%M%S-%f")); output.mkdir()
    print(output, flush=True)
    adb = [args.adb, "-s", args.serial]
    def shell(script): return subprocess.check_output(adb+["shell", "sh -c "+shlex.quote(script)], timeout=80)
    def read(path): return subprocess.check_output(adb+["exec-out", "cat "+shlex.quote(path)], timeout=45)
    engine = "/system/lib64/libdualcam_refocus_image.so"
    if shell("sha256sum "+engine).decode().split()[0] != ENGINE_SHA: raise SystemExit("Engine mismatch")
    remote = shell("mktemp -d /data/local/tmp/portrait-depth.XXXXXX").decode().strip()
    if not re.fullmatch(r"/data/local/tmp/portrait-depth\.[A-Za-z0-9]+", remote): raise SystemExit("Invalid staging directory")
    staged = []
    def push(local, name):
        path = remote+"/"+name; staged.append(path)
        value = subprocess.check_output(["wslpath", "-w", str(local.resolve())], text=True).strip() if args.adb.endswith(".exe") else str(local.resolve())
        subprocess.run(adb+["push", value, path], capture_output=True, check=True, timeout=30)
        if shell("sha256sum "+shlex.quote(path)).decode().split()[0] != digest(local): raise ValueError("Transfer hash mismatch")
        return path
    try:
        cal = push(args.calibration, "cal.bin"); exe = push(args.tools/"native-map-probe", "map-probe")
        for name in ("main-x", "main-y", "aux-x", "aux-y"): staged.append(remote+"/"+name+".f32")
        project_arg = "" if args.project_id is None else " "+str(args.project_id)
        runtime = shell("chmod 700 "+exe+"; exec "+exe+" "+cal+" "+remote+project_arg)
        (output/"map-runtime.jsonl").write_bytes(runtime)
        rows = [json.loads(l) for l in runtime.decode().splitlines() if l.startswith("{")]
        crop_contract = validate_map_contract(rows)
        layout = next(r for r in rows if r["event"] == "map_layout")
        state = next(r for r in rows if r["event"] == "state" and r["phase"] == "after_setup")
        if args.project_id is not None and state["project_id"] != args.project_id:
            raise ValueError("Native map project differs from requested profile")
        if state["table_flag"] or state["mix_flag"] or state["alternate_map_flag"] or not state["maps_ready"]:
            raise ValueError("Unexpected map branch; no host interpretation")
        if rows[-1].get("released") is not True or rows[-1].get("rc") != 0: raise ValueError("Map handle release failed")
        w,h,aw,ah = [layout[k] for k in ("base_width", "base_height", "aux_width", "aux_height")]
        if not (0<w<=2048 and 0<h<=2048 and 0<aw<=4096 and 0<ah<=4096): raise ValueError("Unbounded map dimensions")
        maps = []
        for name, shape in (("main-x",(h,w)),("main-y",(h,w)),("aux-x",(ah,aw)),("aux-y",(ah,aw))):
            raw = read(remote+"/"+name+".f32")
            if len(raw) != shape[0]*shape[1]*4: raise ValueError("Native map length mismatch")
            (output/(name+".f32")).write_bytes(raw)
            array = np.frombuffer(raw, dtype="<f4").reshape(shape)
            if not np.all(np.isfinite(array)): raise ValueError("Non-finite map")
            maps.append(array)
        x,y = layout["aux_padding_x"],layout["aux_padding_y"]
        if x<0 or y<0 or x+w>aw or y+h>ah: raise ValueError("Invalid auxiliary padding")
        rectified = [cv2.remap(images[0][1], maps[0], maps[1], cv2.INTER_LINEAR),
                     cv2.remap(images[1][1], maps[2], maps[3], cv2.INTER_LINEAR)[y:y+h,x:x+w]]
        for i, im in zip(("54","52"), rectified): cv2.imwrite(str(output/("rectified-"+i+".png")), im)
        cv2.imwrite(str(output/"rectified-pair.png"), np.hstack(rectified))
        f30 = [r["values"] for r in rows if r.get("name") == "normalized_calibration_f30"][-1]
        score = alignment(*rectified, f30, w/640)
        reasons = []
        for i in ("54","52"):
            r=metadata[i]
            for key in ("distortion_correction_mode", "rotate_and_crop", "ois_mode", "video_stabilization_mode"):
                if r.get(key) != "0": reasons.append(i+":"+key+" must be observed0 for this native-input assumption")
            if r.get("crop") != "Rect(0, 0 - 3648, 2736)": reasons.append(i+": unsupported physical crop")
            if r.get("lens_state") != "0": reasons.append(i+": lens moving/unknown")
        try:
            offset=abs(int(metadata["54"]["timestamp_ns"])-int(metadata["52"]["timestamp_ns"]))
            if offset>2_000_000: reasons.append("Physical exposure timestamps differ by more than2ms")
        except (KeyError,ValueError): offset=None;reasons.append("Physical timing unknown")
        if not score["passed"]: reasons.append("Factory-derived correspondence gate failed")
        contracts = {i: vendor_contract(metadata[i]) for i in ("54", "52")}
        for i, contract in contracts.items():
            if contract["sync_enable_word"] != 1:
                reasons.append(i+": vendor SyncMode enable word is not observed1")
        reasons.append("Independent optical synchronization remains unverified; equal returned timestamps are insufficient")
        audit={"timestamp_ns": timestamp, "physical_results": metadata, "sensor_offset_ns": offset,
               "vendor_contracts": contracts,
               "crop_contract": crop_contract,
               "native_project_id": state["project_id"],
               "alignment": score, "depth_blockers": reasons, "native_depth_requested": args.run_native_depth,
               "native_depth_executed": False, "factory_geometry_validated": False,
               "depth_validated": False,
               "exploratory_native_depth": args.exploratory_native_depth,
               "capture_metadata_applied": args.apply_capture_metadata,
               "limitations": ["Isolated stock initialization, not production Portrait plugin state.",
                               "Alignment still assumes the recovered Shift translation convention.",
                               "8-bit native disparity codes are not metric depth."]}
        if args.run_native_depth and (not reasons or args.exploratory_native_depth):
            if shell("sha256sum "+engine).decode().split()[0] != ENGINE_SHA: raise ValueError("Engine changed before depth")
            depth_exe=push(args.tools/"native-depth-probe", "depth-probe")
            inputs=[push(image[0], name) for image,name in zip(images,("main.nv21","aux.nv21"))]
            depth_path=remote+"/depth.pgm";staged.append(depth_path)
            process=subprocess.run(adb+["shell", "sh -c "+shlex.quote("chmod 700 "+depth_exe+"; exec "+" ".join([depth_exe,cal,*inputs,depth_path])+project_arg+capture_arg)],capture_output=True,timeout=80)
            audit["native_depth_executed"]=True; audit["native_depth_exit_code"]=process.returncode
            (output/"depth-runtime.jsonl").write_bytes(process.stdout);(output/"depth-stderr.txt").write_bytes(process.stderr)
            if not process.returncode:
                payload=read(depth_path);(output/"depth.pgm").write_bytes(payload)
                depth=cv2.imdecode(np.frombuffer(payload,np.uint8),cv2.IMREAD_GRAYSCALE)
                if depth is None: raise ValueError("Invalid native depth PGM")
                color=cv2.applyColorMap(depth,cv2.COLORMAP_TURBO)
                base=cv2.resize(images[0][1],(depth.shape[1],depth.shape[0]))
                cv2.imwrite(str(output/"depth-overlay-assumed-full-frame.png"),cv2.addWeighted(base,.5,color,.5,0))
                audit["depth_overlay_alignment_validated"]=False
        with (output/"alignment-and-depth.json").open("x") as f:json.dump(audit,f,indent=2,allow_nan=False);f.write("\n")
        print(json.dumps({"output":str(output),"depth_blockers":reasons,"native_depth_executed":audit["native_depth_executed"]}),flush=True)
    finally:
        cleanup="rm -f "+" ".join(map(shlex.quote,staged))+" && rmdir "+shlex.quote(remote)
        (output/"cleanup.txt").write_bytes(shell(cleanup))


if __name__ == "__main__": main()
