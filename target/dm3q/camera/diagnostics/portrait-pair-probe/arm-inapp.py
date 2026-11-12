#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Arm one manual Camera -> Settings diagnostic after installing the patched ROM."""
import argparse
import io
import shlex
import subprocess
import zipfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--serial", required=True)
    parser.add_argument("--adb", default="/mnt/c/platform-tools/adb.exe")
    parser.add_argument("--geometry", action="store_true", help="Compare logical zoom10 and zoom1, with full-run physical metadata")
    parser.add_argument("--save-frames", action="store_true", help="Opt in to up to twelve grayscale framing samples (controlled profile) in Camera private storage; requires --geometry")
    parser.add_argument("--controlled", action="store_true", help="32-second per-physical AF/FPS/manual timing and ISO association test")
    parser.add_argument("--save-yuv", action="store_true", help="Explicit opt-in: bounded complete YUV pairs and metadata; implies controlled/save-frames")
    parser.add_argument("--pair", choices=("10x-3x", "3x-wide"), default="10x-3x",
                        help="Diagnostic streams only; 3x-wide requires --save-yuv and v4f")
    args = parser.parse_args()
    if args.pair == "3x-wide" and not args.save_yuv:
        parser.error("--pair 3x-wide requires --save-yuv")
    if args.save_yuv: args.controlled = True; args.save_frames = True
    if args.controlled: args.geometry = True
    if args.save_frames and not args.geometry:
        parser.error("--save-frames requires --geometry")
    adb = [args.adb, "-s", args.serial]
    paths = subprocess.check_output(adb+["shell", "pm path com.sec.android.app.camera"], text=True).splitlines()
    paths = [p.removeprefix("package:").strip() for p in paths if p.startswith("package:")]
    if len(paths) != 1 or not paths[0].startswith("/"):
        raise SystemExit("Expected one installed Camera APK; refusing to arm an unknown layout")
    command = "su -c " + shlex.quote("cat " + shlex.quote(paths[0]))
    data = subprocess.check_output(adb+["exec-out", command], timeout=45)
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        if "classes5.dex" not in archive.namelist():
            raise SystemExit("Installed Camera has no diagnostic classes5.dex. Build/install the patched ROM first.")
        helper = archive.read("classes5.dex")
        if args.pair == "3x-wide" and b"portrait-controls-v3-yuv-v4f" not in helper:
            raise SystemExit("Installed diagnostic does not support the 3x-wide profile; refusing to arm")
        if args.save_yuv and b"portrait-controls-v3-yuv-v4" not in helper:
            raise SystemExit("Installed diagnostic does not support complete YUV; refusing to arm")
        descriptor = b"Lcom/rezoss/camera/diagnostics/InAppPortraitPairProbe;"
        if descriptor not in helper or b"portrait-pair-probe.arm" not in helper or descriptor not in archive.read("classes2.dex"):
            raise SystemExit("Installed Camera does not contain both the helper and the Settings reference; refusing to arm")
        if args.controlled and b"portrait-controls-v3" not in helper:
            raise SystemExit("Installed helper does not support controlled-v3")
        if args.geometry and b"portrait-geometry-v2" not in helper and b"portrait-controls-v3" not in helper:
            raise SystemExit("Installed Camera has the old probe. Rebuild/install the updated ROM before geometry testing.")
    profile = ("controlled-frames" if args.save_frames else "controlled") if args.controlled else "geometry-frames" if args.save_frames else "geometry" if args.geometry else ""
    if args.save_yuv: profile = "controlled-yuv"
    if args.pair == "3x-wide": profile = "controlled-yuv-3x"
    # Only this new marker is created/chowned/relabelled. Existing cache data is untouched.
    script = r'''
set -eu
probe_cache=/data/user/0/com.sec.android.app.camera/cache
probe_arm=$probe_cache/portrait-pair-probe.arm
test -d "$probe_cache"
if test -e "$probe_arm"; then
    echo "Already armed; consume or disarm existing marker before choosing a profile." >&2
    exit 1
fi
probe_owner=$(stat -c '%u:%g' "$probe_cache")
probe_context=$(ls -Zd "$probe_cache" | awk '{print $1}')
case "$probe_context" in u:object_r:app_data_file:*) ;; *) echo "Unexpected cache context; refusing to arm" >&2; exit 1;; esac
umask 077
set -C
printf '%s\n' __PROFILE__ > "$probe_arm"
chown "$probe_owner" "$probe_arm"
chcon "$probe_context" "$probe_arm"
echo "Armed once. Open Camera normally, then its Settings screen. Keep Settings foreground for the test (controlled:32 seconds; default:15 seconds)."
'''
    script = script.replace("__PROFILE__", shlex.quote(profile))
    subprocess.run(adb+["shell", "su -c " + shlex.quote(script)], check=True, timeout=15)


if __name__ == "__main__":
    main()
