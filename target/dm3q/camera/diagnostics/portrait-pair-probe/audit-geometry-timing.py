#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Read-only timing/geometry audit of saved focused YUV pairs; never fits calibration."""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct

import cv2
import numpy as np


def module(name, filename):
    spec = importlib.util.spec_from_file_location(name, Path(__file__).with_name(filename))
    result = importlib.util.module_from_spec(spec); spec.loader.exec_module(result)
    return result


def numbers(value):
    return [float(x) for x in re.findall(r"[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?", value)]


def distribution(values):
    a = np.asarray(values, dtype=float)
    return {"count": len(a), "min": float(a.min()), "median": float(np.median(a)),
            "max": float(a.max())} if len(a) else {"count": 0}


def row_time_bounds(main, aux):
    """Reported exposure-midpoint bounds over ANY first-to-last sensor rows.

    A deliberately relaxed bound: no crop/readout direction or correspondence
    row is fitted. Metadata timing is not an optical synchronization measurement.
    """
    fields = ("timestamp_ns", "exposure_ns", "rolling_shutter_skew_ns")
    if any(r.get(k) in (None, "null") for r in (main, aux) for k in fields):
        return None
    a, b = [[int(r[k]) for k in fields] for r in (main, aux)]
    if any(v < 0 for v in a + b): raise ValueError("Negative sensor timing field")
    center = a[0] - b[0] + (a[1] - b[1]) / 2
    low, high = center - b[2], center + a[2]
    return {"lower_ms": low / 1e6, "upper_ms": high / 1e6,
            "minimum_absolute_ms": (0 if low <= 0 <= high else min(abs(low), abs(high))) / 1e6,
            "skews_ns": [a[2], b[2]], "optically_validated": False}


def epiline_errors(e, ks, rays):
    pixels = [(k @ ray.T).T[:, :2] for k, ray in zip(ks, rays)]
    a, b = [np.c_[p, np.ones(len(p))] for p in pixels]
    f = np.linalg.inv(ks[1]).T @ e @ np.linalg.inv(ks[0])
    la, lb = b @ f, a @ f.T
    numerator = np.abs(np.sum(b*lb, axis=1))
    return .5*numerator*(1/np.maximum(np.linalg.norm(la[:, :2], axis=1), 1e-12)
                         + 1/np.maximum(np.linalg.norm(lb[:, :2], axis=1), 1e-12))


def analyze(folder, calibration):
    native = module("native_math", "validate-native-transform.py")
    trial = module("yuv_trial", "test-yuv-depth.py")
    if trial.digest(calibration) != trial.CAL_SHA: raise ValueError("Exact per-unit calibration required")
    rows = [json.loads(line) for line in (folder/"report.jsonl").read_text().splitlines() if line.strip()]
    begin = next(r for r in reversed(rows) if r["event"] == "begin")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    logical = {int(r["timestamp_ns"]): r for r in rows if r["event"] == "result"}
    physical = {(r["id"], r["frame"]): r for r in rows if r["event"] == "physical_result"}
    cameras = {r["id"]: r for r in rows if r["event"] == "camera"}
    timing, association = {}, {}
    for phase in ("auto", "manual", "pulse"):
        pairs = [(physical["54", r["frame"]], physical["52", r["frame"]])
                 for r in logical.values() if r["phase"] == phase and
                 all((i, r["frame"]) in physical for i in ("54", "52"))]
        starts, centers, periods, row_bounds = [], [], [], []
        for a, b in pairs:
            delta = int(a["timestamp_ns"])-int(b["timestamp_ns"])
            starts.append(delta/1e6)
            centers.append((delta+(int(a["exposure_ns"])-int(b["exposure_ns"]))/2)/1e6)
            periods.append(max(int(a["frame_duration_ns"]), int(b["frame_duration_ns"]))/1e6)
            bound = row_time_bounds(a, b)
            if bound is not None: row_bounds.append(bound)
        timing[phase] = {"start_54_minus_52_ms": distribution(starts),
                         "exposure_midpoint_54_minus_52_ms": distribution(centers),
                         "frame_period_ms": distribution(periods), "lenses": {},
                         "any_row_midpoint_bounds": {
                             "count": len(row_bounds),
                             "minimum_absolute_ms": distribution([r["minimum_absolute_ms"] for r in row_bounds]),
                             "pairs_whose_entire_bound_exceeds_2ms": sum(r["minimum_absolute_ms"] > 2 for r in row_bounds),
                             "assumption": "Reported SENSOR_TIMESTAMP is first-row exposure start; skew bounds the readout interval.",
                             "optically_validated": False}}
        for i in ("54", "52"):
            sample = [r for (camera, _), r in physical.items() if camera == i and r["phase"] == phase]
            timing[phase]["lenses"][i] = {
                "requested_iso_matches_reported": sum(r["requested_iso"] == r["iso"] for r in sample),
                "count": len(sample), "requested_iso": dict(Counter(r["requested_iso"] for r in sample)),
                "reported_iso": dict(Counter(r["iso"] for r in sample)),
                "requested_focus": dict(Counter(r["requested_focus_diopters"] for r in sample)),
                "reported_focus": dict(Counter(r["focus_diopters"] for r in sample))}
        timing[phase]["both_report_same_iso"] = sum(a["iso"] == b["iso"] for a, b in pairs)
    for i in ("54", "52"):
        samples = [(logical[int(r["timestamp_ns"])]["frame"], r["luma"]["mean"])
                   for r in rows if r["event"] == "image" and r["physical_output"] == i
                   and int(r["timestamp_ns"]) in logical and logical[int(r["timestamp_ns"])]["phase"] == "pulse"]
        lags = []
        for lag in range(-6, 7):
            pairs = [(mean, float(physical[i, frame+lag]["iso"])) for frame, mean in samples
                     if (i, frame+lag) in physical and physical[i, frame+lag]["phase"] == "pulse"]
            a = np.asarray(pairs)
            correlation = float(np.corrcoef(a.T)[0, 1]) if len(a) >= 20 and np.all(np.std(a, axis=0) > 1e-8) else None
            lags.append({"metadata_frame_minus_image_frame": lag, "count": len(a), "brightness_iso_correlation": correlation})
        association[i] = {"lags": lags, "external_optical_timing_validated": False}
    blob = calibration.read_bytes()
    unpack = lambda offset, count: np.array(struct.unpack_from("<"+"f"*count, blob, offset))
    fixed_k = [list(struct.unpack_from("<4H", blob, offset)) for offset in (0x114, 0x11c)]
    coefficients = [unpack(offset, 6) for offset in (0xe4, 0xfc)]
    e = native.cross(unpack(0x130, 3)) @ native.rotation(unpack(0x124, 3))
    saved = {}
    for r in rows:
        if r["event"] == "saved_yuv": saved.setdefault(int(r["timestamp_ns"]), set()).add(r["id"])
    geometry = []
    detector = cv2.SIFT_create(nfeatures=3000, contrastThreshold=.015)
    for tick, ids in sorted(saved.items()):
        if ids != {"54", "52"} or tick not in logical: continue
        _, metadata, inputs = trial.pair_inputs(folder, tick)
        features = [detector.detectAndCompute(cv2.cvtColor(im, cv2.COLOR_BGR2GRAY), None) for _, im in inputs]
        if any(d is None or len(d)<2 for _, d in features):
            geometry.append({"timestamp_ns": tick, "skipped": "insufficient texture"}); continue
        matches = [p[0] for p in cv2.BFMatcher().knnMatch(features[0][1], features[1][1], k=2)
                   if len(p)==2 and p[0].distance < .7*p[1].distance]
        points = [np.array([features[i][0][m.queryIdx if i==0 else m.trainIdx].pt for m in matches]) for i in (0, 1)]
        if len(matches)<8:
            geometry.append({"timestamp_ns": tick, "skipped": "insufficient correspondences", "matches": len(matches)}); continue
        cv2.setRNGSeed(26)
        empirical, mask = cv2.findFundamentalMat(*points, cv2.FM_RANSAC, 1.5, .999)
        _, plane_mask = cv2.findHomography(*points, cv2.RANSAC, 1.5)
        if empirical is None or empirical.shape != (3, 3) or mask is None: raise ValueError("Scene quality subset failed")
        mask = mask.ravel().astype(bool)
        frame_k = [numbers(metadata[i]["intrinsics"])[:4] for i in ("54", "52")]
        item = {"timestamp_ns": tick, "phase": logical[tick]["phase"], "ratio_matches": len(matches),
                "scene_subset_count": int(mask.sum()), "homography_inliers": int(plane_mask.sum()) if plane_mask is not None else 0,
                "points_54": points[0].tolist(), "points_52": points[1].tolist(),
                "frame_intrinsics": frame_k,
                "frame_fx_change_from_native_percent": [100*(k[0]/fixed[0]-1) for k, fixed in zip(frame_k, fixed_k)],
                "any_row_midpoint_bound": row_time_bounds(metadata["54"], metadata["52"]),
                "assumptions": {}}
        for name, values in (("native_supplementary_K", fixed_k), ("per_frame_K", frame_k)):
            ks = [native.crop_intrinsics(k, (3648, 2736), (3648, 2736), (640, 480)) for k in values]
            for domain in ("native_radial_input", "already_corrected_input"):
                rays = ([native.inverse_radial(p, k, c)[0] for p, k, c in zip(points, ks, coefficients)]
                        if domain == "native_radial_input" else
                        [np.c_[(p-k[:2, 2])/np.diag(k)[:2], np.ones(len(p))] for p, k in zip(points, ks)])
                errors = epiline_errors(e, ks, rays)
                item["assumptions"][name+"/"+domain] = {"all_matches_640px_domain": native.summary(errors),
                                                            "scene_subset_640px_domain": native.summary(errors[mask])}
        geometry.append(item)
    return {"run_id": begin["run_id"], "report_sha256": trial.digest(folder/"report.jsonl"),
            "calibration_sha256": trial.digest(calibration), "opencv_version": cv2.__version__,
            "sync_type": cameras["20"]["sync_type"], "timestamp_sources": {i: cameras[i]["timestamp_source"] for i in ("54", "52")},
            "timing": timing, "iso_image_association": association, "native_supplementary_K": fixed_k,
            "geometry_hypotheses": geometry, "factory_geometry_validated": False,
            "limitations": ["No calibration parameter, frame offset or winning model is selected/fitted.",
                            "Rolling-row bounds use reported timing semantics, not independently measured optical timing; overlapping exposures can still have separated midpoints.",
                            "Geometry assumes Shift is translation in X_aux=Rodrigues(Tilt)*X_main+Shift; native proof is incomplete.",
                            "Domain/K comparisons use the same saved raw-image points and640x480 pixel metric; do not compare directly to1024px remapped scores.",
                            "Per-frame intrinsics are reported metadata, not independently measured optics.",
                            "Native six coefficients plus per-frame K is an explicitly unverified combination.",
                            "Planar/repeated print features can confound empirical subsets.",
                            "ISO correlation tests frame association, not sub-frame optical synchronization.",
                            "No camera/device/ROM/native execution or disparity generation is performed."]}


if __name__ == "__main__":
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("folder", type=Path)
    p.add_argument("--calibration", required=True, type=Path)
    p.add_argument("--output", required=True, type=Path)
    args = p.parse_args()
    result = analyze(args.folder, args.calibration)
    with args.output.open("x") as f: json.dump(result, f, indent=2, allow_nan=False); f.write("\n")
