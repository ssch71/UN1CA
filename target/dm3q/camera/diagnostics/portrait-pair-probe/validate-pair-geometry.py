#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Cross-check 10x/3x image geometry on held-out pairs, without claiming depth."""
import argparse
import hashlib
import json
from pathlib import Path

import cv2
import numpy as np


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def errors(matrix, a, b):
    ah, bh = (np.c_[p, np.ones(len(p))] for p in (a, b))
    la, lb = (matrix.T @ bh.T).T, (matrix @ ah.T).T
    numerator = np.abs(np.sum(bh * lb, axis=1))
    # Symmetric distance in the original output-pixel coordinates.
    return (numerator / np.maximum(np.linalg.norm(la[:, :2], axis=1), 1e-12)
            + numerator / np.maximum(np.linalg.norm(lb[:, :2], axis=1), 1e-12)) / 2


def summary(values):
    return {"count": len(values), "median_px": float(np.median(values)),
            "p90_px": float(np.percentile(values, 90)),
            "fraction_within_1_5px": float(np.mean(values <= 1.5))}


def analyze(folder):
    report = folder / "report.jsonl"
    rows = [json.loads(line) for line in report.read_text().splitlines() if line.strip()]
    begin = next(r for r in reversed(rows) if r["event"] == "begin")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    logical = {int(r["timestamp_ns"]): r for r in rows if r["event"] == "result"}
    physical = {(r["frame"], r["id"]): r for r in rows if r["event"] == "physical_result"}
    saved = {}
    for row in rows:
        if row["event"] == "saved_luma":
            saved.setdefault(int(row["timestamp_ns"]), {})[row["id"]] = row
    detector = cv2.SIFT_create(nfeatures=3000, contrastThreshold=0.015)
    cv2.setRNGSeed(26)
    pairs, skipped = [], []
    for stamp, images in sorted(saved.items()):
        if stamp not in logical or not all(i in images for i in ("54", "52")):
            skipped.append({"timestamp_ns": stamp, "reason": "incomplete pair or missing logical result"})
            continue
        frame = logical[stamp]["frame"]
        if not all((frame, i) in physical for i in ("54", "52")):
            skipped.append({"timestamp_ns": stamp, "reason": "missing physical result"})
            continue
        paths = [(folder / images[i]["file"]).resolve() for i in ("54", "52")]
        if any(not p.is_relative_to(folder.resolve()) for p in paths):
            raise ValueError("Sample path escapes capture folder")
        pixels = [cv2.imread(str(p), cv2.IMREAD_GRAYSCALE) for p in paths]
        if any(p is None for p in pixels):
            raise ValueError("Unreadable saved image")
        features = [detector.detectAndCompute(im, None) for im in pixels]
        matches = []
        if all(d is not None and len(d) >= 2 for _, d in features):
            for candidates in cv2.BFMatcher().knnMatch(features[0][1], features[1][1], k=2):
                if len(candidates) == 2 and candidates[0].distance < 0.7 * candidates[1].distance:
                    matches.append(candidates[0])
        points = [np.float64([features[i][0][m.queryIdx if i == 0 else m.trainIdx].pt
                             for m in matches]).reshape(-1, 2) for i in (0, 1)]
        pairs.append({"timestamp_ns": stamp, "frame": frame, "phase": logical[stamp]["phase"],
                      "images": [{"file": p.name, "sha256": digest(p)} for p in paths],
                      "geometry_key": [(list(im.shape), physical[frame, i].get("crop"))
                                       for i, im in zip(("54", "52"), pixels)],
                      "ratio_matches": len(matches), "points_54": points[0].tolist(),
                      "points_52": points[1].tolist()})
    trials = []
    for train in pairs:
        a, b = (np.asarray(train[k]) for k in ("points_54", "points_52"))
        if len(a) < 12:
            continue
        matrix, mask = cv2.findFundamentalMat(a, b, cv2.FM_RANSAC, 1.5, 0.999)
        if matrix is None or matrix.shape != (3, 3) or mask is None or mask.sum() < 12:
            continue
        _, planar = cv2.findHomography(a, b, cv2.RANSAC, 1.5)
        trial = {"training_timestamp_ns": train["timestamp_ns"], "fundamental_matrix": matrix.tolist(),
                 "training_inliers": int(mask.sum()),
                 "training_homography_inliers": int(planar.sum()) if planar is not None else 0,
                 "held_out": []}
        for test in pairs:
            if test is train:
                continue
            if train["geometry_key"] != test["geometry_key"] or test["ratio_matches"] < 1:
                trial["held_out"].append({"timestamp_ns": test["timestamp_ns"],
                                          "skipped": "different crop/size or no matches"})
                continue
            # No held-out RANSAC or rejection by the evaluated matrix: retain all
            # descriptor-ratio matches so self-fitting cannot masquerade as validation.
            residual = errors(matrix, np.asarray(test["points_54"]), np.asarray(test["points_52"]))
            trial["held_out"].append({"timestamp_ns": test["timestamp_ns"],
                                      "symmetric_epipolar_error": summary(residual)})
        trials.append(trial)
    return {"run_id": begin["run_id"], "report_sha256": digest(report),
            "opencv_version": cv2.__version__, "pairs": pairs, "skipped": skipped,
            "leave_one_pair_out": trials, "factory_calibration_validated": False,
            "rectification_validated": False, "depth_validated": False,
            "limitations": ["Empirical matrices are scene-derived, not the real factory calibration.",
                            "A static or planar scene can conceal incorrect geometry; inspect homography support.",
                            "Held-out matches may repeat the same scene points and contain false matches.",
                            "Equal buffer timestamps do not establish physical exposure synchronization.",
                            "No disparity, native pose adaptation or camera enablement is performed."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("folder", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    result = analyze(args.folder)
    # Preserve prior evidence instead of silently replacing it.
    with args.output.open("x") as output:
        json.dump(result, output, indent=2, allow_nan=False)
        output.write("\n")
