#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Build/run an isolated exact-engine map probe; never opens device cameras."""
import argparse
import datetime
import hashlib
import json
from pathlib import Path
import re
import shlex
import subprocess

ENGINE_SHA = "4c153d7c3b0ae1278ba0ec4723f11b4755a6cb481b692e7b1ad5af90c8a6882c"
CAL_SHA = "ee645b3ee69a2a4401370f234473e0adf096cd2de4c1ed41a9d6884ef2364884"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--serial", required=True)
    parser.add_argument("--calibration", required=True, type=Path)
    parser.add_argument("--clang", required=True, type=Path)
    parser.add_argument("--adb", default="/mnt/c/platform-tools/adb.exe")
    args = parser.parse_args()
    # This per-unit blob is from this device, not a transferable profile.
    if args.serial != "R5CW72R7SDF" or digest(args.calibration) != CAL_SHA:
        raise SystemExit("Refusing an unverified device/calibration combination")
    source = Path(__file__).resolve().parent
    repo = Path(subprocess.check_output(["git", "-C", str(source), "rev-parse", "--show-toplevel"], text=True).strip())
    archive = repo / "out/archived" / ("portrait-native-map-" + datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%d-%H%M%S-%f"))
    archive.mkdir()
    print(archive, flush=True)
    c = source / "native-map-probe.c"
    binary = archive / "native-map-probe"
    build = [str(args.clang), "-std=c11", "-Wall", "-Wextra", "-Werror", "-O2", str(c), "-ldl", "-lm", "-o", str(binary)]
    compiled = subprocess.run(build, capture_output=True, timeout=60)
    (archive / "build.txt").write_bytes(compiled.stdout+compiled.stderr)
    compiled.check_returncode()
    (archive / c.name).write_bytes(c.read_bytes())
    staged_calibration = archive / "calibration.bin"
    staged_calibration.write_bytes(args.calibration.read_bytes())
    adb = [args.adb, "-s", args.serial]
    engine = "/system/lib64/libdualcam_refocus_image.so"
    before = subprocess.check_output(adb+["shell", "sha256sum "+engine], timeout=15).decode().strip()
    if before.split()[0] != ENGINE_SHA:
        raise SystemExit("Installed engine hash mismatch; internal calls forbidden")
    remote = subprocess.check_output(adb+["shell", "mktemp -d /data/local/tmp/portrait-map.XXXXXX"], timeout=15).decode().strip()
    if not re.fullmatch(r"/data/local/tmp/portrait-map\.[A-Za-z0-9]+", remote):
        raise SystemExit("Unexpected staging directory")
    manifest = {"serial": args.serial, "engine_before": before, "engine_sha256": ENGINE_SHA,
                "calibration_sha256": CAL_SHA, "binary_sha256": digest(binary),
                "source_sha256": digest(c), "remote_directory": remote,
                "scope": "isolated InitEx(1,4) defaults, NOT production Camera state",
                "build_command": build, "camera_opened": False, "disparity_called": False}
    with (archive / "manifest.json").open("x") as output:
        json.dump(manifest, output, indent=2); output.write("\n")
    staged = [remote+"/probe", remote+"/calibration.bin"]
    try:
        for path, local in zip(staged, (binary, staged_calibration)):
            # Windows adb requires a Windows/UNC path. Sync push closes the file
            # before returning; exec-in cat can leave its writer open briefly.
            local_name = str(local)
            if args.adb.endswith(".exe"):
                local_name = subprocess.check_output(["wslpath", "-w", local_name], text=True).strip()
            transfer = subprocess.run(adb+["push", local_name, path], capture_output=True, timeout=30)
            (archive / (local.name+".transfer.txt")).write_bytes(transfer.stdout+transfer.stderr)
            transfer.check_returncode()
        script = f"""set -eu
test \"$(sha256sum {engine} | cut -d ' ' -f1)\" = {ENGINE_SHA}
test \"$(sha256sum {staged[0]} | cut -d ' ' -f1)\" = {manifest['binary_sha256']}
test \"$(sha256sum {staged[1]} | cut -d ' ' -f1)\" = {CAL_SHA}
chmod 700 {staged[0]}
exec {staged[0]} {staged[1]}
"""
        result = subprocess.run(adb+["shell", "sh -c "+shlex.quote(script)], capture_output=True, timeout=45)
        (archive / "runtime.jsonl").write_bytes(result.stdout)
        (archive / "stderr.txt").write_bytes(result.stderr)
        (archive / "exit-code.txt").write_text(str(result.returncode)+"\n")
        after = subprocess.check_output(adb+["shell", "sha256sum "+engine], timeout=15)
        (archive / "engine-after.txt").write_bytes(after)
        result.check_returncode()
        rows = [json.loads(line) for line in result.stdout.decode().splitlines() if line.startswith("{")]
        state = next(r for r in rows if r.get("event") == "state" and r.get("phase") == "after_setup")
        maps = [r for r in rows if r.get("event") == "map"]
        released = rows[-1].get("event") == "uninit" and rows[-1].get("released") and rows[-1].get("rc") == 0
        valid = (state["maps_ready"] == 1 and len(maps) == 3 and released
                 and all(len(m["samples"]) == 9 and all(s["source_x"] is not None and s["source_y"] is not None for s in m["samples"]) for m in maps)
                 and after.decode().split()[0] == ENGINE_SHA)
        summary = {"isolated_map_setup_passed": valid, "selected_table_flag": state["table_flag"],
                   "selected_mix_flag": state["mix_flag"], "native_map_samples": sum(len(m["samples"]) for m in maps),
                   "production_camera_branch_observed": False, "factory_geometry_validated": False}
        (archive / "summary.json").write_text(json.dumps(summary, indent=2)+"\n")
        print(json.dumps(summary), flush=True)
        if not valid: raise SystemExit("Native map evidence incomplete")
    finally:
        # Remove only the two files created in our unique temporary directory.
        cleanup = "rm -f "+" ".join(map(shlex.quote, staged))+" && rmdir "+shlex.quote(remote)
        result = subprocess.run(adb+["shell", cleanup], capture_output=True, timeout=15)
        (archive / "cleanup.txt").write_bytes(result.stdout+result.stderr)
        if result.returncode: raise SystemExit("Device staging cleanup failed; see archive")


if __name__ == "__main__":
    main()
