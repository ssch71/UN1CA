#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Generate and validate the opt-in Samsung Camera diagnostic smali patch."""
import argparse
import datetime
import difflib
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile


def run(args, log):
    with log.open("ab") as output:
        output.write(("\n$ " + " ".join(map(str, args)) + "\n").encode())
        output.flush()
        subprocess.run(list(map(str, args)), stdout=output, stderr=subprocess.STDOUT, check=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write-patch", action="store_true", help="Back up and update the ROM source patch")
    parser.add_argument("--build", action="store_true", help="Also rebuild the temporary patched Camera APK")
    args = parser.parse_args()
    source = Path(__file__).resolve().parent
    repo = Path(subprocess.check_output(["git", "-C", str(source), "rev-parse", "--show-toplevel"], text=True).strip())
    archive = Path(tempfile.mkdtemp(prefix="portrait-pair-inapp.", dir=repo / "out/archived"))
    temporary = Path(tempfile.mkdtemp(prefix="portrait-pair-inapp.", dir="/tmp"))
    log = archive / "validation.log"
    sdk = Path(os.environ.get("ANDROID_SDK_ROOT", os.environ.get("ANDROID_HOME", str(Path.home() / "Android/Sdk"))))
    tools = sdk / "build-tools/37.0.0"
    android = sdk / "platforms/android-37.0/android.jar"
    apk = repo / "out/fw/SM-S918B_EUX/system/system/priv-app/SamsungCamera/SamsungCamera.apk"
    patch_dir = repo / "unica/mods/rezoss/smali/system/priv-app/SamsungCamera/SamsungCamera.apk"
    patch_file = patch_dir / "0004-Add-opt-in-in-app-portrait-pair-diagnostic.patch"
    if (repo / "unica/mods/rezoss/disable").exists():
        raise RuntimeError("rezoss mod is disabled; refusing active integration")
    classes = temporary / "classes"
    dex = temporary / "dex"
    classes.mkdir(); dex.mkdir()
    run(["javac", "-source", "8", "-target", "8", "-bootclasspath", str(android)+":"+str(tools/"core-lambda-stubs.jar"),
         "-d", classes, source / "InAppPortraitPairProbe.java"], log)
    run([tools / "d8", "--lib", android, "--min-api", "30", "--output", dex] + sorted(classes.rglob("*.class")), log)
    helper = temporary / "helper"
    run(["baksmali", "disassemble", "--debug-info", "false", "--accessor-comments", "false", "--use-locals", "--sequential-labels",
         "-j", "2", "-o", helper, dex / "classes.dex"], log)
    decoded = temporary / "camera"
    run(["apktool", "d", "-r", "--no-debug-info", "-j", "2", "-o", decoded, apk], log)
    if (decoded / "smali_classes5").exists():
        raise RuntimeError("Baseline already has classes5; review helper placement before regenerating")
    activity = "smali_classes2/com/sec/android/app/camera/setting/CameraSettingActivity.smali"
    original = (decoded / activity).read_text()
    anchor = ".method public final onResume()V\n    .locals 7\n\n    invoke-super {p0}, Landroidx/fragment/app/FragmentActivity;->onResume()V\n"
    if original.count(anchor) != 1:
        raise RuntimeError("CameraSettingActivity.onResume baseline drift")
    replacement = anchor + "\n    invoke-static {p0}, Lcom/rezoss/camera/diagnostics/InAppPortraitPairProbe;->maybeStart(Landroid/app/Activity;)V\n"
    modified = original.replace(anchor, replacement)
    header = ("From: UN1CA <unica@local>\nSubject: [PATCH] Add opt-in in-app Portrait pair diagnostic\n\n"
              "Run only after an explicit diagnostic extra or a consumed app-private\n"
              "cache marker. Test logical20 physical54+52 or opt-in52+56 for up to32\n"
              "seconds in Camera. Controlled profile tests per-physical AF and timing.\n"
              "Bounded grayscale/complete YUV samples require explicit profile opt-in.\n"
              "Preserve onResume registers and normal control flow. Helper classes\n"
              "use a separate classes5.dex. No native/feature/permission changes.\n\n")
    patch = header + "".join(difflib.unified_diff(original.splitlines(True), modified.splitlines(True),
                                                    fromfile="a/"+activity, tofile="b/"+activity))
    helper_files = sorted(helper.rglob("*.smali"))
    if not helper_files:
        raise RuntimeError("Helper disassembly is empty")
    for file in helper_files:
        relative = file.relative_to(helper)
        if any((folder / relative).exists() for folder in decoded.glob("smali*")):
            raise RuntimeError("Helper class already exists in baseline: " + relative.as_posix())
        target = "smali_classes5/" + file.relative_to(helper).as_posix()
        patch += "".join(difflib.unified_diff([], file.read_text().splitlines(True), fromfile="/dev/null", tofile="b/"+target))
    # Match the repository's blank-context style without storing trailing spaces.
    patch = "".join("\n" if line == " \n" else line for line in patch.splitlines(True))
    generated = archive / patch_file.name
    generated.write_text(patch)
    # Apply modules in repository order: rezoss, then settings. The earlier camera
    # legacy patches are gated off by SDK37 in the inspected dm3q out/config.sh.
    existing = sorted(p for p in patch_dir.glob("*.patch") if p != patch_file)
    for item in existing + [generated]:
        run(["patch", "--batch", "--fuzz=0", "--dry-run", "-p1", "-d", decoded, "-i", item], log)
        run(["patch", "--batch", "--fuzz=0", "-p1", "-d", decoded, "-i", item], log)
    settings = repo / "unica/mods/settings"
    if not (settings / "disable").exists():
        for item in sorted((settings / "smali/system/priv-app/SamsungCamera/SamsungCamera.apk").glob("*.patch")):
            run(["patch", "--batch", "--fuzz=0", "--dry-run", "-p1", "-d", decoded, "-i", item], log)
            run(["patch", "--batch", "--fuzz=0", "-p1", "-d", decoded, "-i", item], log)
    if list(decoded.rglob("*.rej")):
        raise RuntimeError("Patch rejects remain")
    # Assert the entire pre-existing activity is unchanged apart from the one call.
    assert (decoded / activity).read_text() == modified
    if args.build:
        rebuilt = archive / "SamsungCamera.diagnostic.unsigned.apk"
        run(["apktool", "-JXmx4096m", "b", "-j", "2", "-o", rebuilt, decoded], log)
        run(["unzip", "-tq", rebuilt], log)
        import zipfile
        with zipfile.ZipFile(rebuilt) as z:
            assert z.getinfo("classes5.dex").file_size > 112
            assert z.getinfo("classes2.dex").file_size > 112
    if args.write_patch:
        if patch_file.exists():
            stamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y%m%d_%H%M%S_%f")
            shutil.copy2(patch_file, archive / (patch_file.name+".bak."+stamp))
        patch_file.write_text(patch)
    metadata = {
        "apk": str(apk), "apk_sha256": hashlib.sha256(apk.read_bytes()).hexdigest(),
        "helper_source_sha256": hashlib.sha256((source/"InAppPortraitPairProbe.java").read_bytes()).hexdigest(),
        "patch_sha256": hashlib.sha256(generated.read_bytes()).hexdigest(),
        "generated_patch": str(generated), "temporary_decode": str(decoded),
        "helper_smali_files": len(helper_files), "register_count_preserved": True,
        "active_patch_stack_passed": True, "apk_rebuild_passed": args.build,
        "source_patch_updated": args.write_patch, "runtime_tested": False,
    }
    (archive / "validation.json").write_text(json.dumps(metadata, indent=2)+"\n")
    print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    main()
