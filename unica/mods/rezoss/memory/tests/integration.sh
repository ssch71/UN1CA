#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
[[ $# == 3 ]] || { echo "Usage: $0 ORIGINAL_LAUNCHER.apk VALIDATED_SIGNED_LAUNCHER.apk CLEAN_SERVICES_DECODE" >&2; exit 2; }
MEMORY_TEST_ORIGINAL=$(realpath "$1")
MEMORY_TEST_SIGNED=$(realpath "$2")
MEMORY_TEST_SERVICES=$(realpath "$3")
MEMORY_TEST_SOURCE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
SRC_DIR=$(cd -- "$MEMORY_TEST_SOURCE/../../../.." && pwd)
source "$SRC_DIR/scripts/utils/common_utils.sh"
source "$SRC_DIR/scripts/utils/module_utils.sh"
TARGET_CODENAME=dm3q
TARGET_OS_BUILD_SYSTEM_EXT_PARTITION=true
MODPATH="$SRC_DIR/unica/mods/rezoss"
MEMORY_TEST_TEMP=$(mktemp -d /tmp/rezoss-memory-integration-test.XXXXXX)
APKTOOL_DIR="$MEMORY_TEST_TEMP/apktool"
MEMORY_TEST_BUILDS=0
# The actual signed package was built/verified separately. Substitute only that
# expensive build; staging and metadata use the real repository helpers.
bash() {
    if [[ "$1" == "$MEMORY_TEST_SOURCE/prepare-launcher.sh" ]]; then
        [[ -f "$2" && ! -e "$3" ]]
        cp -p "$MEMORY_TEST_SIGNED" "$3"
        MEMORY_TEST_BUILDS=$((MEMORY_TEST_BUILDS + 1))
    else
        command bash "$@"
    fi
}

TARGET_CODENAME=unsupported
source "$MEMORY_TEST_SOURCE/integrate.sh"
[[ "$MEMORY_TEST_BUILDS" == 0 ]]
TARGET_CODENAME=dm3q
MODPATH="$MEMORY_TEST_TEMP/disabled"
mkdir -p "$MODPATH/memory"
touch "$MODPATH/memory/disable"
source "$MEMORY_TEST_SOURCE/integrate.sh"
[[ "$MEMORY_TEST_BUILDS" == 0 ]]
MODPATH="$SRC_DIR/unica/mods/rezoss"

WORK_DIR="$MEMORY_TEST_TEMP/work"
mkdir -p "$WORK_DIR/system/system/priv-app/TouchWizHome_2017" "$WORK_DIR/configs" \
    "$WORK_DIR/system/system/framework" "$WORK_DIR/system/system/etc/permissions"
touch "$WORK_DIR/configs/fs_config-system" "$WORK_DIR/configs/file_context-system"
printf 'wrong launcher\n' > "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk"
if source "$MEMORY_TEST_SOURCE/integrate.sh"; then
    echo "FAIL: wrong launcher accepted" >&2; exit 1
fi
[[ "$MEMORY_TEST_BUILDS" == 0 && ! -e "$WORK_DIR/system/system/priv-app/Memory" ]]
cp -p "$MEMORY_TEST_ORIGINAL" "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk"
if source "$MEMORY_TEST_SOURCE/integrate.sh"; then
    echo "FAIL: missing required library accepted" >&2; exit 1
fi
[[ "$MEMORY_TEST_BUILDS" == 0 ]]
touch "$WORK_DIR/system/system/framework/samsungkeystoreutils.jar" \
    "$WORK_DIR/system/system/etc/permissions/samsungkeystoreutils.xml"
if source "$MEMORY_TEST_SOURCE/integrate.sh"; then
    echo "FAIL: missing preload allowlist accepted" >&2; exit 1
fi
[[ "$MEMORY_TEST_BUILDS" == 0 ]]
mkdir -p "$WORK_DIR/system/system/etc/sysconfig"
printf '<config>\n</config>\n' > "$WORK_DIR/system/system/etc/sysconfig/allowed-system-preload-apps.xml"
mkdir -p "$APKTOOL_DIR/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk"
if source "$MEMORY_TEST_SOURCE/integrate.sh"; then
    echo "FAIL: prior launcher decode accepted" >&2; exit 1
fi
[[ "$MEMORY_TEST_BUILDS" == 0 ]]
APKTOOL_DIR="$MEMORY_TEST_TEMP/no-prior-decodes"
# Seed the exact native policy in an isolated shared decode. APPLY_PATCH itself
# remains real, and creates the helper classes from the checked-in patch.
MEMORY_TEST_NATIVE='smali/com/android/server/input/KeyGestureController$LocalKeyGestureEventHandler.smali'
while read -r MEMORY_TEST_HASH MEMORY_TEST_POLICY; do
    mkdir -p "$APKTOOL_DIR/system/framework/services.jar/$(dirname "$MEMORY_TEST_POLICY")"
    cp "$MEMORY_TEST_SERVICES/$MEMORY_TEST_POLICY" "$APKTOOL_DIR/system/framework/services.jar/$MEMORY_TEST_POLICY"
done < "$MEMORY_TEST_SOURCE/sidekey/targets.sha256"
for entry in system/priv-app system/priv-app/TouchWizHome_2017 system/etc system/etc/permissions; do
    SET_METADATA system "$entry" 0 0 755 u:object_r:system_file:s0
done
mkdir -p "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/oat/arm64"
touch "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/oat/arm64/stale.odex" \
    "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk.prof"
source "$MEMORY_TEST_SOURCE/integrate.sh"
[[ "$MEMORY_TEST_BUILDS" == 1 ]]
grep -q 'MemorySideKey;->handle' "$APKTOOL_DIR/system/framework/services.jar/$MEMORY_TEST_NATIVE"
[[ -s "$APKTOOL_DIR/system/framework/services.jar/smali_classes2/io/mesalabs/rezoss/memory/MemorySideKey.smali" ]]
if python3 "$MEMORY_TEST_SOURCE/sidekey/check-target.py" "$APKTOOL_DIR/system/framework/services.jar"; then
    echo "FAIL: previously modified native policy accepted" >&2; exit 1
fi
cmp "$MEMORY_TEST_SIGNED" "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk"
[[ ! -e "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/oat" ]]
[[ ! -e "$WORK_DIR/system/system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk.prof" ]]
python3 - "$WORK_DIR" <<'PY'
from pathlib import Path
import hashlib
import sys
import xml.etree.ElementTree as E
root = Path(sys.argv[1])
memory = root / "system/system/priv-app/Memory/Memory.apk"
assert hashlib.sha256(memory.read_bytes()).hexdigest() == "28c74ddee923b8de0cf3abe816aa44a8135f6b5259d54d275d9c30f04f0bb5e8"
assert sorted(p.name for p in memory.parent.iterdir()) == ["Memory.apk"]
preloads = E.parse(root / "system/system/etc/sysconfig/allowed-system-preload-apps.xml")
assert len(preloads.findall('./allowed-system-preload[@package="com.samsung.android.app.memory"]')) == 1
xml = root / "system/system/etc/permissions/privapp-permissions-com.samsung.android.app.memory.xml"
permissions = E.parse(xml).findall("./privapp-permissions/permission")
assert len(permissions) == 6
signature_xml = root / "system/system/etc/permissions/signature-permissions-com.samsung.android.app.memory.xml"
signature = E.parse(signature_xml).find("signature-permissions")
assert signature.get("package") == "com.samsung.android.app.memory"
assert [p.get("name") for p in signature.findall("permission")] == ["android.permission.WRITE_SECURE_SETTINGS"]
config = (root / "configs/fs_config-system").read_text()
for entry, mode in [("system/priv-app/Memory", "755"),
                    ("system/priv-app/Memory/Memory.apk", "644"),
                    ("system/priv-app/TouchWizHome_2017/TouchWizHome_2017.apk", "644"),
                    ("system/etc/permissions/privapp-permissions-com.samsung.android.app.memory.xml", "644"),
                    ("system/etc/permissions/signature-permissions-com.samsung.android.app.memory.xml", "644")]:
    assert f"{entry} 0 0 {mode} capabilities=0x0" in config, entry
print("PASS: real-helper staging, original Memory APK hash, six privileged permissions, signature WRITE_SECURE_SETTINGS and metadata")
PY
echo "PASS: disabled/other targets skip; wrong APK, missing library and prior decode reject; stale profiles removed"
echo "Integration fixture retained: $MEMORY_TEST_TEMP"
