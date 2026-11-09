#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Summarize crop and physical sensor timing; never infer calibrated depth."""
import argparse
from collections import defaultdict
import json
from pathlib import Path
import re
import statistics


def number(value):
    try:
        return int(value)
    except (TypeError, ValueError):
        return None


def distribution(values):
    return {"count": len(values), "min": min(values), "median": statistics.median(values),
            "max": max(values)} if values else {"count": 0}


def analyze(rows):
    begin = next(row for row in reversed(rows) if row.get("event") == "begin")
    main, aux = str(begin.get("main", "54")), str(begin.get("aux", "52"))
    if (main, aux) not in (("54", "52"), ("52", "56")):
        raise ValueError("Unsupported diagnostic pair")
    rows = [row for row in rows if row.get("run_id") == begin["run_id"]]
    cameras = {r["id"]: r for r in rows if r["event"] == "camera"}
    frames = defaultdict(dict)
    logical = {}
    for row in rows:
        if row["event"] == "physical_result":
            frames[(row.get("phase", "legacy_zoom10"), row["frame"])][row["id"]] = row
        if row["event"] == "result":
            logical[number(row.get("timestamp_ns"))] = row
    phases = {}
    for phase in sorted({key[0] for key in frames}):
        pairs = [pair for (p, _), pair in sorted(frames.items())
                 if p == phase and main in pair and aux in pair]
        deltas, centers = [], []
        streams = defaultdict(list)
        for pair in pairs:
            a, b = pair[main], pair[aux]
            ta, tb = number(a.get("timestamp_ns")), number(b.get("timestamp_ns"))
            if ta is not None and tb is not None:
                deltas.append((ta - tb) / 1e6)
                ea, eb = number(a.get("exposure_ns")), number(b.get("exposure_ns"))
                if ea is not None and eb is not None:
                    centers.append((ta - tb + (ea - eb) / 2) / 1e6)
            for id in (main, aux):
                streams[id].append(pair[id])
        details = {}
        for id, samples in streams.items():
            timestamps = [number(r.get("timestamp_ns")) for r in samples]
            timestamps = [t for t in timestamps if t is not None]
            active = re.findall(r"-?\d+", cameras.get(id, {}).get("active_array", ""))
            crops = []
            for crop in sorted({r.get("crop", "") for r in samples}):
                rect = re.findall(r"-?\d+", crop)
                entry = {"rect": crop}
                if len(active) == len(rect) == 4:
                    ax, ay, ar, ab = map(int, active)
                    x, y, right, bottom = map(int, rect)
                    if right > x and bottom > y:
                        entry.update(width=right-x, height=bottom-y,
                                     active_to_crop_x=(ar-ax)/(right-x),
                                     active_to_crop_y=(ab-ay)/(bottom-y))
                crops.append(entry)
            details[id] = {"crops": crops,
                "sensor_frame_interval_ms": distribution([(b-a)/1e6 for a, b in zip(timestamps, timestamps[1:])]),
                "exposure_ns": distribution([v for r in samples if (v := number(r.get("exposure_ns"))) is not None]),
                "rolling_shutter_skew_ns": distribution([v for r in samples if (v := number(r.get("rolling_shutter_skew_ns"))) is not None])}
        phases[phase] = {"paired_result_samples": len(pairs), "sensor_"+main+"_minus_"+aux+"_ms": distribution(deltas),
                         "exposure_midpoint_"+main+"_minus_"+aux+"_ms": distribution(centers), "streams": details}
    saved = []
    for row in rows:
        if row["event"] == "saved_luma":
            result = logical.get(number(row.get("timestamp_ns")))
            saved.append({**row, "matched_result_frame": result.get("frame") if result else None,
                          "matched_result_phase": result.get("phase") if result else None})
    return {"run_id": begin["run_id"], "version": begin.get("version", "legacy"), "main": main, "aux": aux, "phases": phases,
            "saved_luma": saved, "complete": any(r["event"] == "summary" for r in rows),
            "errors": [r for r in rows if r["event"] in ("error", "device_error", "configure_failed", "capture_failed")],
            "optical_framing_validated": False, "depth_validated": False,
            "limitations": ["Crop ratios describe reported active-array coordinates, not measured optical fields.",
                            "Identical Image timestamps do not establish synchronized sensor exposures.",
                            "Exposure midpoint omits row-dependent rolling-shutter timing.",
                            "A saved image is associated only when its timestamp matches a logical result; arrival phase is advisory.",
                            "No automatic geometric or timing pass threshold is asserted."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    args = parser.parse_args()
    print(json.dumps(analyze([json.loads(line) for line in args.report.read_text().splitlines() if line.strip()]), indent=2))
