#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Package the validated YUV helper into an exact installed Camera APK copy."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import zipfile


def run(command):
    subprocess.run(list(map(str, command)), check=True)


def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--baseline", type=Path, required=True)
    parser.add_argument("--validation", type=Path, required=True)
    parser.add_argument("--output-directory", type=Path, required=True)
    args = parser.parse_args()
    source = Path(__file__).resolve().parent
    repo = Path(subprocess.check_output(["git", "-C", str(source), "rev-parse", "--show-toplevel"], text=True).strip())
    tools = Path.home()/"Android/Sdk/build-tools/37.0.0"
    validation = json.loads(args.validation.read_text())
    if not validation["active_patch_stack_passed"] or digest(source/"InAppPortraitPairProbe.java") != validation["helper_source_sha256"]:
        raise SystemExit("Helper source differs from validated patch")
    temporary = Path(tempfile.mkdtemp(prefix="portrait-yuv-apk.", dir="/tmp"))
    output = args.output_directory
    output.mkdir(exist_ok=True)
    target = output/"SamsungCamera.yuv-depth.experimental.apk"
    if target.exists(): raise SystemExit("Refusing to overwrite existing APK")
    with zipfile.ZipFile(args.baseline) as z:
        activity = z.read("classes2.dex")
        if b"Lcom/rezoss/camera/diagnostics/InAppPortraitPairProbe;" not in activity:
            raise SystemExit("Baseline lacks the previously validated Settings diagnostic hook")
        (temporary/"old.dex").write_bytes(z.read("classes5.dex"))
    old, merged = temporary/"old", temporary/"merged"
    run(["baksmali", "disassemble", "--debug-info", "false", "-j", "2", "-o", old, temporary/"old.dex"])
    prefix = "com/rezoss/camera/diagnostics/"
    for path in old.rglob("*.smali"):
        relative = path.relative_to(old)
        if relative.as_posix().startswith(prefix): continue
        destination = merged/relative; destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
    fresh = Path(validation["temporary_decode"])/"smali_classes5/com/rezoss/camera/diagnostics"
    if not fresh.is_dir(): raise SystemExit("Validated helper decode missing")
    for path in fresh.rglob("*.smali"):
        destination = merged/prefix/path.relative_to(fresh)
        destination.parent.mkdir(parents=True, exist_ok=True); shutil.copy2(path, destination)
    run(["smali", "assemble", "-j", "2", "-o", temporary/"new.dex", merged])
    unsigned = output/"SamsungCamera.yuv-depth.unsigned.apk"
    with zipfile.ZipFile(args.baseline) as original, zipfile.ZipFile(unsigned, "x") as rebuilt:
        for info in original.infolist():
            if info.filename.upper().startswith("META-INF/"): continue
            rebuilt.writestr(info, (temporary/"new.dex").read_bytes() if info.filename == "classes5.dex" else original.read(info.filename))
    aligned = output/"SamsungCamera.yuv-depth.aligned.apk"
    run([tools/"zipalign", "-P", "16", "4", unsigned, aligned])
    run([tools/"apksigner", "sign", "--key", repo/"security/aosp_platform.pk8", "--cert", repo/"security/aosp_platform.x509.pem", "--out", target, aligned])
    run([tools/"apksigner", "verify", target]); run([tools/"zipalign", "-c", "-P", "16", "4", target])
    def certificate(path):
        text = subprocess.check_output([str(tools/"apksigner"), "verify", "--print-certs", str(path)], text=True)
        return re.search(r"certificate SHA-256 digest: ([0-9a-f]+)", text).group(1)
    if certificate(args.baseline) != certificate(target): raise SystemExit("Certificate mismatch")
    with zipfile.ZipFile(args.baseline) as before, zipfile.ZipFile(target) as after:
        names = [n for n in before.namelist() if not n.upper().startswith("META-INF/")]
        changed = [n for n in names if before.read(n) != after.read(n)]
        if changed != ["classes5.dex"]: raise SystemExit("Unexpected payload changes: "+str(changed))
        if after.testzip(): raise SystemExit("APK CRC failure")
    result = {"apk": str(target.resolve()), "apk_sha256": digest(target), "baseline_sha256": digest(args.baseline),
              "certificate_sha256": certificate(target), "changed_payload": changed,
              "unchanged_payload_entries": len(names)-1, "validation": str(args.validation.resolve()),
              "installed": False, "runtime_tested": False}
    with (output/"apk-verification.json").open("x") as f: json.dump(result, f, indent=2); f.write("\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__": main()
