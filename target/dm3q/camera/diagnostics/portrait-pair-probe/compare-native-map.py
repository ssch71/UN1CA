#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Compare isolated native map samples to the previously recovered scalar math.

This checks an implementation, not real-image optical/depth alignment. The
extended-path main-map pixel-center adjustment is reported separately.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path

import numpy as np


def analyze(runtime):
    spec = importlib.util.spec_from_file_location("native_math", Path(__file__).with_name("validate-native-transform.py"))
    math = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(math)
    math.self_test()
    rows = [json.loads(line) for line in runtime.read_text().splitlines() if line.startswith("{")]
    state = next(r for r in rows if r.get("event") == "state" and r.get("phase") == "after_setup")
    if state["table_flag"] or state["mix_flag"] or state["alternate_map_flag"]:
        raise ValueError("Host polynomial comparison does not cover selected table/alternate branches")
    fields = {r["name"]: r["values"] for r in rows if r["event"] == "float_fields"}
    f = np.asarray(fields["normalized_calibration_f30"])
    if f.shape != (30,) or fields["optional_euler_correction"] != [0, 0, 0]:
        raise ValueError("Requires observed F30 and zero optional corrections")
    begin = next(r for r in rows if r["event"] == "begin")
    layout = next(r for r in rows if r["event"] == "map_layout")
    scale = layout["base_width"] / begin["buffer_size"][0]
    if scale != layout["base_height"] / begin["buffer_size"][1]:
        raise ValueError("Nonuniform resize unsupported")
    main_k = f[22:26]
    results = []
    for m in (r for r in rows if r["event"] == "map"):
        aux = m["name"] == "aux"
        k = f[26:30] if aux else main_k
        coefficients = f[[14, 15, 18, 19, 20, 21] if aux else [6, 7, 10, 11, 12, 13]]
        nominal_errors, centered_errors = [], []
        details = []
        for sample in m["samples"]:
            pixel = np.array([sample["u"], sample["v"]], dtype=float)
            if aux:
                pixel -= [layout["aux_padding_x"], layout["aux_padding_y"]]
            ray = np.r_[(pixel/scale-main_k[2:])/main_k[:2], 1.]
            if aux:
                # Native R_aux=Rodrigues(-Tilt); inverse-map uses inverse R.
                ray = math.rotation(f[:3]) @ ray
            xy = ray[:2]/ray[2]
            nominal = k[2:]+k[:2]*xy*math.radial_scale(np.linalg.norm(xy), coefficients)
            adjusted = nominal.copy()
            if m["name"] == "main":
                adjusted -= (1-1/scale)/2
            elif m["name"] == "main_secondary":
                nominal = (nominal+.5)*scale-.5
                adjusted *= scale
            measured = np.array([sample["source_x"], sample["source_y"]])
            nominal_errors.append(float(np.linalg.norm(nominal-measured)))
            centered_errors.append(float(np.linalg.norm(adjusted-measured)))
            details.append({"u": sample["u"], "v": sample["v"], "native_xy": measured.tolist(),
                            "nominal_prediction": nominal.tolist(), "pixel_center_prediction": adjusted.tolist()})
        results.append({"map": m["name"], "samples": len(details),
                        "nominal_max_error_px": max(nominal_errors),
                        "with_pixel_center_adjustment_max_error_px": max(centered_errors), "points": details})
    return {"runtime_sha256": hashlib.sha256(runtime.read_bytes()).hexdigest(),
            "pixel_center_correction_source": "FUN_01dd89ec: inputSize/mapSize*0.5-0.5 added to main maps",
            "map_comparisons": results, "factory_geometry_validated": False,
            "production_camera_branch_observed": False,
            "limitations": ["This compares native-generated map coordinates, not image correspondences.",
                            "Main-map center adjustment is reported explicitly; nominal errors are retained.",
                            "Float64 host vs native float/NEON arithmetic is not bit-exact.",
                            "Only this isolated profile with observed fields and sampled coordinates is covered."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("runtime", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    result = analyze(args.runtime)
    with args.output.open("x") as output:
        json.dump(result, output, indent=2, allow_nan=False)
        output.write("\n")
