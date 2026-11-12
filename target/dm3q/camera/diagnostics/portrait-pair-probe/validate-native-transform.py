#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Audit the recovered stock mode4 radial/crop math on existing 54/52 points.

Host-only float64 reproduction of selected native scalar formulas, not an ABI
adapter or a complete emulator. Requires numpy/OpenCV. Never fits calibration.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct

import cv2
import numpy as np


CALIBRATION_SHA256 = "ee645b3ee69a2a4401370f234473e0adf096cd2de4c1ed41a9d6884ef2364884"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def cross(v):
    x, y, z = v
    return np.array([[0., -z, y], [z, 0., -x], [-y, x, 0.]])


def rotation(v):
    """FUN_0209501c: Rodrigues axis-angle vector, radians."""
    theta = np.linalg.norm(v)
    if theta < np.finfo(float).eps:
        return np.eye(3)
    axis = np.asarray(v) / theta
    return (np.eye(3) * np.cos(theta) + np.outer(axis, axis) * (1-np.cos(theta))
            + cross(axis) * np.sin(theta))


def crop_intrinsics(values, calibration_size, crop_size, output_size):
    """Centered FUN_02096de4 branch: C truncation of signed half-offsets.

    Both axes use outputWidth/cropWidth as the native wrapper does. An explicit
    offset crop or nonuniform resize requires a different path.
    """
    k = np.eye(3)
    fx, fy, cx, cy = values
    scale = output_size[0] / crop_size[0]
    if abs(output_size[1] / crop_size[1] - scale) > 1e-9:
        raise ValueError("This recovered branch requires equal X/Y scaling")
    offsets = [int((a-b)/2) for a, b in zip(calibration_size, crop_size)]
    k[0, 0], k[1, 1] = fx*scale, fy*scale
    k[0, 2], k[1, 2] = (cx-offsets[0])*scale, (cy-offsets[1])*scale
    return k


def radial_scale(radius, coefficients):
    """FUN_020904a4, coefficients ordered k1,k2,k3,k4,k5,k6.

    These are NOT OpenCV rational coefficients. The packed size remainders at
    D[2:4] are not used in this examined normal-map worker.
    """
    k1, k2, k3, k4, k5, k6 = coefficients
    r2 = radius*radius
    return 1 + r2*(k1+r2*(k2+r2*k3)) + radius*(k4+r2*(k5+r2*k6))


def inverse_radial(points, k, coefficients):
    xy = (points-k[:2, 2]) / np.diag(k)[:2]
    rho = np.linalg.norm(xy, axis=1)
    radius = rho.copy()
    k1, k2, k3, k4, k5, k6 = coefficients
    for _ in range(40):
        derivative = (1+2*k4*radius+3*k1*radius**2+4*k5*radius**3
                      +5*k2*radius**4+6*k6*radius**5+7*k3*radius**6)
        if np.any(derivative <= 0):
            raise ValueError("Radial inversion left a positive-derivative domain")
        radius -= (radius*radial_scale(radius, coefficients)-rho)/derivative
    residual = np.abs(radius*radial_scale(radius, coefficients)-rho)
    if np.any(radius < 0) or not np.all(np.isfinite(radius)) or np.max(residual) > 1e-9:
        raise ValueError("Radial inversion did not converge")
    factor = np.divide(radius, rho, out=np.ones_like(radius), where=rho > 0)
    return np.c_[xy*factor[:, None], np.ones(len(points))], float(np.max(residual))


def summary(values):
    if not len(values):
        return {"count": 0}
    return {"count": len(values), "median_px": float(np.median(values)),
            "p90_px": float(np.percentile(values, 90)),
            "fraction_within_1_5px": float(np.mean(values <= 1.5))}


def self_test():
    np.testing.assert_allclose(rotation([0, 0, 0]), np.eye(3), atol=1e-15)
    np.testing.assert_allclose(rotation([0, 0, np.pi/2]),
                               [[0, -1, 0], [1, 0, 0], [0, 0, 1]], atol=1e-15)
    k = crop_intrinsics([100, 120, 50, 60], [103, 125], [100, 120], [50, 60])
    np.testing.assert_allclose(k, [[50, 0, 24.5], [0, 60, 29], [0, 0, 1]])
    k = crop_intrinsics([100, 120, 50, 60], [97, 115], [100, 120], [50, 60])
    np.testing.assert_allclose(k[:2, 2], [25.5, 31])
    coefficients = np.array([.1, -.02, .003, -.05, .01, -.001])
    r = np.linspace(0, .3, 100)
    expanded = 1+coefficients[3]*r+coefficients[0]*r**2+coefficients[4]*r**3
    expanded += coefficients[1]*r**4+coefficients[5]*r**5+coefficients[2]*r**6
    np.testing.assert_allclose(radial_scale(r, coefficients), expanded, atol=1e-15)
    xy = np.c_[r, r/2]
    distorted = xy*radial_scale(np.linalg.norm(xy, axis=1), coefficients)[:, None]
    rays, _ = inverse_radial(distorted, np.eye(3), coefficients)
    np.testing.assert_allclose(rays[:, :2], xy, atol=1e-12)


def analyze(folder, calibration, correspondences):
    if digest(calibration) != CALIBRATION_SHA256:
        raise ValueError("Requires the hash-verified real per-unit T1-T2 blob")
    blob = calibration.read_bytes()
    data = json.loads(correspondences.read_text())
    if digest(folder / "report.jsonl") != data["report_sha256"]:
        raise ValueError("Capture report differs from correspondence provenance")
    if len(blob) != 760:
        raise ValueError("Expected 760-byte calibration")
    unpack = lambda offset, count: np.array(struct.unpack_from("<"+"f"*count, blob, offset))
    intrinsics = [struct.unpack_from("<4H", blob, offset) for offset in (0x114, 0x11c)]
    coefficients = [unpack(offset, 6) for offset in (0xe4, 0xfc)]
    tilt, shift = unpack(0x124, 3), unpack(0x130, 3)
    # Native normal rectification sets main R=I and aux R=Rodrigues(-Tilt).
    # The E below additionally ASSUMES Shift is t in X_aux=R*X_main+t.
    # That translation convention is a hypothesis, not recovered by this path.
    e = cross(shift) @ rotation(tilt)
    pairs = []
    for pair in data["pairs"]:
        if pair["ratio_matches"] < 8:
            raise ValueError("Insufficient correspondences")
        keys = pair["geometry_key"]
        if any(key != [[480, 640], "Rect(0, 0 - 3648, 2736)"] for key in keys):
            raise ValueError("Audit scoped to recorded full-array 640x480 pair")
        for image in pair["images"]:
            path = (folder / image["file"]).resolve()
            if not path.is_relative_to(folder.resolve()) or digest(path) != image["sha256"]:
                raise ValueError("Image provenance mismatch")
        points = [np.asarray(pair[key], dtype=float) for key in ("points_54", "points_52")]
        if any(p.shape != (pair["ratio_matches"], 2) or not np.all(np.isfinite(p)) for p in points):
            raise ValueError("Malformed correspondence points")
        cv2.setRNGSeed(26)
        empirical, mask = cv2.findFundamentalMat(*points, cv2.FM_RANSAC, 1.5, .999)
        if empirical is None or empirical.shape != (3, 3) or mask is None:
            raise ValueError("Cannot form the separately labelled scene-derived subset")
        mask = mask.ravel().astype(bool)
        ks = [crop_intrinsics(k, (3648, 2736), (3648, 2736), (640, 480)) for k in intrinsics]
        output = {"timestamp_ns": pair["timestamp_ns"], "phase": pair["phase"],
                  "ratio_matches": len(points[0]), "scene_derived_subset_count": int(mask.sum()),
                  "scene_derived_subset_indices": np.flatnonzero(mask).tolist(),
                  "scene_derived_F_for_subset_label_only": empirical.tolist(), "domains": {}}
        for domain in ("native_radial_input_assumption", "already_corrected_input_assumption"):
            if domain.startswith("native"):
                inversion = [inverse_radial(p, k, c) for p, k, c in zip(points, ks, coefficients)]
                rays = [item[0] for item in inversion]
                closure = max(item[1] for item in inversion)
            else:
                rays = [np.c_[(p-k[:2, 2])/np.diag(k)[:2], np.ones(len(p))]
                        for p, k in zip(points, ks)]
                closure = None
            # Distances to epilines in each UNDISTORTED output-pixel plane.
            # This consistently symmetric metric differs from one-sided tests.
            pixels = [(k @ r.T).T[:, :2] for k, r in zip(ks, rays)]
            f = np.linalg.inv(ks[1]).T @ e @ np.linalg.inv(ks[0])
            ah, bh = [np.c_[p, np.ones(len(p))] for p in pixels]
            lines_b, lines_a = ah @ f.T, bh @ f
            numerator = np.abs(np.sum(bh*lines_b, axis=1))
            error = .5*numerator*(1/np.linalg.norm(lines_a[:, :2], axis=1)
                                  + 1/np.linalg.norm(lines_b[:, :2], axis=1))
            output["domains"][domain] = {
                "all_matches_symmetric_epiline_error": summary(error),
                "scene_derived_subset_symmetric_epiline_error": summary(error[mask]),
                "inverse_radial_forward_closure_normalized_max": closure}
        pairs.append(output)
    return {"factory_geometry_validated": False, "rectification_validated": False,
            "calibration_sha256": digest(calibration), "correspondences_sha256": digest(correspondences),
            "report_sha256": data["report_sha256"], "opencv_version": cv2.__version__,
            "numpy_version": np.__version__, "self_tests_passed": True,
            "supplementary_K": intrinsics, "supplementary_radial_six": [c.tolist() for c in coefficients],
            "tilt_axis_angle_radians": tilt.tolist(), "shift_raw": shift.tolist(), "pairs": pairs,
            "limitations": [
                "Float64 scalar formula reproduction; native float/NEON rounding is not emulated.",
                "Six radial coefficients include three fields absent from the short native runtime log.",
                "Fixed supplementary intrinsics; dynamic focus/OIS geometry is not reconstructed.",
                "Centered full-array crops and delivered-buffer orientation are assumptions.",
                "E assumes Shift is relative-camera translation; the normal native map does not baseline-align with Shift.",
                "No alternate 11-sample full-distortion table or Euler correction is reproduced.",
                "Actual native runtime branch and input distortion domain remain unknown.",
                "Empirical masks only label a scene-derived subset; no factory parameter is fitted or selected.",
                "Repeated/planar scene features can yield false correspondences; neither domain is auto-selected.",
                "No native disparity, APK, ROM, or device change is performed."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("folder", type=Path)
    parser.add_argument("--calibration", required=True, type=Path)
    parser.add_argument("--correspondences", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    self_test()
    result = analyze(args.folder, args.calibration, args.correspondences)
    with args.output.open("x") as output:
        json.dump(result, output, indent=2, allow_nan=False)
        output.write("\n")
