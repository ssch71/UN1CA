#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Audit real T1-T2 calibration against saved per-frame crop/intrinsics metadata."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct


def numbers(value):
    return [float(x) for x in re.findall(r"[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?", value)]


def mapped_intrinsics(values, crop, width, height):
    fx, fy, cx, cy, skew = values
    x, y, right, bottom = crop
    if right <= x or bottom <= y or width <= 0 or height <= 0:
        raise ValueError("Invalid crop or output size")
    sx, sy = width / (right - x), height / (bottom - y)
    return [[fx*sx, skew*sx, (cx-x)*sx], [0, fy*sy, (cy-y)*sy], [0, 0, 1]]


def engine_reference(blob, native_log):
    """Reproduce the observed stock InitEx(1,4) decode, not a rotation matrix."""
    f = lambda offset, count: list(struct.unpack_from("<" + "f"*count, blob, offset))
    left, right = [list(struct.unpack_from("<4H", blob, o)) for o in (0x114, 0x11c)]
    observed = {"Tilt": f(0x124, 3), "Shift": f(0x130, 3),
                "CameraL": left, "CameraR": right,
                "KL": f(0xe4, 2) + [364800.0, 273600.0] + f(0xec, 1),
                "KR": f(0xfc, 2) + [364800.0, 273600.0] + f(0x104, 1)}
    # Resolution fields in the recovered container are packed as pixels*100.
    for name, offset in (("KL", 0x74), ("KR", 0xa4)):
        observed[name][2:4] = [x*100 for x in f(offset, 2)]
    result = {"engine_sha256": "4c153d7c3b0ae1278ba0ec4723f11b4755a6cb481b692e7b1ad5af90c8a6882c",
              "initialization": "ARC_DCIR_InitEx(handle,1,4)",
              "decoded_values": observed, "matched_native_log": False,
              "tilt_to_rotation_matrix_convention_recovered": False,
              "distortion_model_recovered": False,
              "note": "KL/KR contain packed resolution fields; do not pass these arrays directly as OpenCV distortion coefficients."}
    if native_log is not None:
        lines = [line for line in native_log.read_text().splitlines()
                 if "ARC_DCIR_SetCaliData GetCalibrationData Tilt[0]=" in line]
        if len(lines) != 1:
            raise ValueError("Expected exactly one isolated native calibration record")
        parsed = {}
        for name, index, value in re.findall(
                r"\b(Tilt|Shift|KL|KR|CameraL|CameraR)\[(\d+)\]\s*=\s*([-+]?\d+(?:\.\d+)?)", lines[0]):
            parsed[name, int(index)] = float(value)
        if len(parsed) != sum(map(len, observed.values())):
            raise ValueError("Native calibration log is incomplete")
        for name, values in observed.items():
            for index, value in enumerate(values):
                if abs(parsed[name, index]-value) > 1e-6:
                    raise ValueError("Native decoder mismatch: " + name + str(index))
        result.update(matched_native_log=True,
                      native_log_sha256=hashlib.sha256(native_log.read_bytes()).hexdigest(),
                      native_record=lines[0])
    return result


def analyze(folder, calibration, native_log=None):
    blob = calibration.read_bytes()
    if len(blob) != 760:
        raise ValueError("Requires the exact 760-byte real T1-T2 buffer")
    fields = {i: list(struct.unpack_from("<12f", blob, offset))
              for i, offset in (("54", 0x4c), ("52", 0x7c))}
    report = folder / "report.jsonl"
    rows = [json.loads(s) for s in report.read_text().splitlines() if s.strip()]
    begin = next(r for r in reversed(rows) if r["event"] == "begin")
    if (begin.get("main"), begin.get("aux")) != ("54", "52"):
        raise ValueError("Expected the recorded physical54-main/52-auxiliary experiment")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    logical = {int(r["timestamp_ns"]): r for r in rows if r["event"] == "result"}
    physical = {(r["frame"], r["id"]): r for r in rows if r["event"] == "physical_result"}
    cameras = {r["id"]: r for r in rows if r["event"] == "camera"}
    saved = {}
    for r in rows:
        if r["event"] == "saved_luma":
            saved.setdefault(int(r["timestamp_ns"]), {})[r["id"]] = r
    samples, skipped = [], []
    for timestamp, images in sorted(saved.items()):
        if timestamp not in logical or not all(i in images for i in fields):
            skipped.append({"timestamp_ns": timestamp, "reason": "missing matched result or complete pair"})
            continue
        frame = logical[timestamp]["frame"]
        pair = {"frame": frame, "timestamp_ns": timestamp,
                "phase": logical[timestamp]["phase"], "streams": {}}
        for i in fields:
            r = physical[frame, i]
            values, crop = numbers(r["intrinsics"]), numbers(r["crop"])
            if len(values) != 5 or len(crop) != 4:
                raise ValueError("Missing per-frame intrinsic/crop data")
            active = numbers(cameras[i]["active_array"])
            if not (active[0] <= crop[0] < crop[2] <= active[2]
                    and active[1] <= crop[1] < crop[3] <= active[3]):
                raise ValueError("Reported crop escapes physical active array")
            im = images[i]
            path = (folder / im["file"]).resolve()
            if not path.is_relative_to(folder.resolve()):
                raise ValueError("Saved image escapes archive")
            factory = fields[i][:5]
            k = mapped_intrinsics(values, crop, im["width"], im["height"])
            fk = mapped_intrinsics(factory, crop, im["width"], im["height"])
            pair["streams"][i] = {
                "image": path.name, "image_sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                "factory_intrinsics": factory, "frame_intrinsics": values,
                "focus_diopters": r.get("focus_diopters"), "crop": crop,
                "K_from_frame_assuming_direct_crop_mapping": k,
                "K_from_factory_assuming_direct_crop_mapping": fk,
                "focal_change_percent": [100*(values[n]/factory[n]-1) for n in (0, 1)],
                "principal_point_change_output_px": [k[0][2]-fk[0][2], k[1][2]-fk[1][2]],
                "calibration_resolution": fields[i][10:12],
                "recorded_orientation_degrees": cameras[i].get("orientation"),
                "unrecorded_transform_fields": [key for key in (
                    "distortion_correction_mode", "rotate_and_crop", "distortion",
                    "ois_mode", "video_stabilization_mode") if key not in r]}
        samples.append(pair)
    return {"run_id": begin["run_id"], "report_sha256": hashlib.sha256(report.read_bytes()).hexdigest(),
            "calibration_sha256": hashlib.sha256(blob).hexdigest(), "complete_pairs": samples,
            "skipped_samples": skipped, "factory_geometry_validated": False,
            "stock_mode4_reference": engine_reference(blob, native_log),
            "limitations": ["Matrices assume direct edge-aligned crop-to-output scaling; native mapping is not yet validated.",
                            "Sensor orientation alone does not prove delivered-buffer rotation.",
                            "Missing distortion/crop processing fields remain unknown, not disabled.",
                            "Per-frame intrinsic metadata is measured metadata, not independent optical validation.",
                            "No extrinsic convention, rectification, depth or feature enablement is inferred."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("folder", type=Path)
    parser.add_argument("--calibration", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--native-log", type=Path, help="Isolated stock mode4 calibration log to cross-check")
    args = parser.parse_args()
    result = analyze(args.folder, args.calibration, args.native_log)
    with args.output.open("x") as output:
        json.dump(result, output, indent=2, allow_nan=False)
        output.write("\n")
