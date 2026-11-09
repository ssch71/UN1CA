#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Render intermediate framing from real 3x YUV without cropping depth inputs.

Host diagnostic only. No device access, lens switching, blur or synthetic depth.
Zoom labels are nominal; effective optical framing still needs measurement.
"""
import argparse
import hashlib
import json
import math
from pathlib import Path

import cv2
import numpy as np


def output_transform(width, height, zoom):
    if not math.isfinite(zoom) or not 3 <= zoom <= 10:
        raise ValueError("Nominal output zoom must be between 3 and 10")
    scale = zoom / 3
    # Pixel-centre convention: the centre stays fixed through crop and resize.
    matrix = np.array([[scale, 0, (1-scale)*(width-1)/2],
                       [0, scale, (1-scale)*(height-1)/2]], dtype=np.float64)
    return matrix


def load_frame(folder, timestamp=None):
    rows = [json.loads(line) for line in (folder/"report.jsonl").read_text().splitlines() if line.strip()]
    begin = next(r for r in reversed(rows) if r.get("event") == "begin")
    pair = (str(begin.get("main")), str(begin.get("aux")))
    if pair not in (("54", "52"), ("52", "56")) or not begin.get("save_yuv"):
        raise ValueError("Requires a recognized complete-YUV diagnostic run")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    results = {int(r["timestamp_ns"]): r for r in rows
               if r.get("event") == "result" and r.get("timestamp_ns") != "null"}
    candidates = [r for r in rows if r.get("event") == "saved_yuv" and str(r.get("id")) == "52"
                  and int(r["timestamp_ns"]) in results
                  and (timestamp is not None or results[int(r["timestamp_ns"])].get("phase") == "auto")
                  and (timestamp is None or int(r["timestamp_ns"]) == timestamp)]
    if not candidates:
        raise ValueError("No timestamp-associated saved 3x frame")
    row = min(candidates, key=lambda r: int(r["timestamp_ns"]))
    result = results[int(row["timestamp_ns"])]
    physical = next(r for r in rows if r.get("event") == "physical_result"
                    and r.get("frame") == result["frame"] and str(r.get("id")) == "52")
    camera = next(r for r in rows if r.get("event") == "camera" and str(r.get("id")) == "52")
    if physical.get("crop") != camera.get("active_array") or physical.get("zoom") not in (None, "1.0", 1, 1.0):
        raise ValueError("3x frame is not reported as full physical input")
    width, height = row["width"], row["height"]
    if (width, height, row.get("format"), row.get("bytes")) != (640, 480, "NV21", 460800):
        raise ValueError("Requires the bounded 640x480 NV21 profile")
    if row.get("image_crop") != "Rect(0, 0 - 640, 480)":
        raise ValueError("Unsupported delivered buffer crop")
    path = (folder/row["file"]).resolve()
    if not path.is_relative_to(folder.resolve()):
        raise ValueError("Input escapes capture archive")
    data = path.read_bytes()
    if len(data) != row["bytes"] or hashlib.sha256(data).hexdigest() != row["sha256"]:
        raise ValueError("Capture payload hash/size mismatch")
    frame = cv2.cvtColor(np.frombuffer(data, np.uint8).reshape(height*3//2, width), cv2.COLOR_YUV2BGR_NV21)
    return frame, {"run_id": begin["run_id"], "capture_pair": pair,
                   "source_file": str(path), "source_sha256": row["sha256"],
                   "timestamp_ns": row["timestamp_ns"], "physical_result": physical}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("folder", type=Path)
    p.add_argument("--output", type=Path, required=True, help="New directory; never overwrites")
    p.add_argument("--timestamp", type=int)
    p.add_argument("--zoom", type=float, nargs="+", default=[3, 4, 5, 7.5, 10])
    args = p.parse_args()
    frame, provenance = load_frame(args.folder, args.timestamp)
    h, w = frame.shape[:2]
    matrices = [output_transform(w, h, z) for z in args.zoom]
    args.output.mkdir(parents=True, exist_ok=False)
    views, transforms = [], []
    for index, (zoom, matrix) in enumerate(zip(args.zoom, matrices)):
        view = cv2.warpAffine(frame, matrix, (w, h), flags=cv2.INTER_LINEAR)
        name = f"{index:02d}-3x-source-at-{zoom:g}x.png"
        if not cv2.imwrite(str(args.output/name), view):
            raise OSError("Could not save rendered frame")
        scale = zoom/3
        transforms.append({"nominal_output_zoom": zoom, "source_lens": "52", "linear_crop": scale,
                           "source_pixel_centres_to_output": matrix.tolist(),
                           "output_to_source_pixel_centres": cv2.invertAffineTransform(matrix).tolist(),
                           "source_crop_edges": [(w-w/scale)/2, (h-h/scale)/2, (w+w/scale)/2, (h+h/scale)/2],
                           "file": name})
        labelled = view.copy()
        cv2.putText(labelled, f"{zoom:g}x framing / 3x source", (12, 28), cv2.FONT_HERSHEY_SIMPLEX, .65, (255,255,255), 2)
        views.append(labelled)
    if not cv2.imwrite(str(args.output/"framing-strip.jpg"), np.hstack(views)):
        raise OSError("Could not save strip")
    report = {"source": provenance, "output_size": [w,h], "transforms": transforms,
              "native_inputs_modified": False, "depth_generated": False,
              "depth_alignment_validated": False, "optical_framing_validated": False,
              "lens_transition_executed": False, "ready_for_rom_enablement": False,
              "limitations": ["640x480 diagnostic imagery; enlargement does not add detail.",
                              "No cross-lens crop/pose registration or handoff boundary has been validated.",
                              "Full calibrated inputs must reach depth first; output image/depth/ROIs then need coherent transforms."]}
    (args.output/"framing.json").write_text(json.dumps(report, indent=2)+"\n")
    print(args.output)


if __name__ == "__main__":
    main()
