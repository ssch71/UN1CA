#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Read the last in-app report and opted-in samples into a fresh host archive."""
import argparse
import datetime
import hashlib
import json
from pathlib import Path
import re
import shlex
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--serial", required=True)
    parser.add_argument("--adb", default="/mnt/c/platform-tools/adb.exe")
    args = parser.parse_args()
    source = Path(__file__).resolve().parent
    repo = Path(subprocess.check_output(["git", "-C", str(source), "rev-parse", "--show-toplevel"], text=True).strip())
    destination = repo / "out/archived" / ("portrait-geometry-device-" + datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%d-%H%M%S-%f"))
    destination.mkdir()
    adb = [args.adb, "-s", args.serial]
    private = "/data/user/0/com.sec.android.app.camera/files/portrait-pair-probe/"

    def read(name):
        return subprocess.check_output(adb + ["exec-out", "su -c " + shlex.quote("cat " + shlex.quote(private + name))], timeout=45)

    data = read("report.jsonl")
    rows = [json.loads(line) for line in data.decode().splitlines() if line.strip()]
    begin = next(r for r in reversed(rows) if r.get("event") == "begin")
    rows = [r for r in rows if r.get("run_id") == begin["run_id"]]
    report = destination / "report.jsonl"
    report.write_text("".join(json.dumps(r) + "\n" for r in rows))
    for row in rows:
        if row.get("event") in ("saved_luma", "saved_yuv"):
            name = row["file"]
            suffix = "nv21" if row["event"] == "saved_yuv" else "pgm"
            pair = (str(begin["main"]), str(begin["aux"]))
            if pair not in (("54", "52"), ("52", "56")):
                raise ValueError("Unsupported diagnostic pair")
            ids = "(?:" + "|".join(map(re.escape, pair)) + ")"
            if row.get("id") not in pair or not re.fullmatch(re.escape(begin["run_id"]) + r"-(?:zoom1|zoom10|auto|manual|pulse)-" + ids + r"-\d+\." + suffix, name):
                raise ValueError("Unexpected sample filename; refusing private-file read")
            payload = read(name)
            if suffix == "nv21" and (len(payload) != row["bytes"] or hashlib.sha256(payload).hexdigest() != row["sha256"]):
                raise ValueError("YUV payload length/hash mismatch")
            (destination / name).write_bytes(payload)
    result = subprocess.check_output(["python3", str(source / "analyze-geometry.py"), str(report)])
    (destination / "geometry.json").write_bytes(result)
    print(destination)
    print(result.decode())


if __name__ == "__main__":
    main()
