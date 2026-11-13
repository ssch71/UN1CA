#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Build the settings/API app. It carries no model assets; Gemma 4 E2B runs in AIOS.
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
: "${SRC_DIR:?Source buildenv.sh <target> first}"
OUTPUT=${1:?Usage: build.sh OUTPUT_APK --stub}
MODE=${2:-}
[[ "$MODE" == --stub ]] || { echo "Usage: build.sh OUTPUT_APK --stub" >&2; exit 1; }
SDK=${ANDROID_HOME:-$HOME/Android/Sdk}; TOOLS=$SDK/build-tools/37.0.0
WORK=$(mktemp -d /tmp/rezoss-api-app.XXXXXX)
trap 'rm -rf "$WORK"' EXIT
mkdir -p "$WORK/classes" "$WORK/dex"
javac -source 8 -target 8 -Xlint:-options -classpath "$SDK/platforms/android-37.0/android.jar" \
    -d "$WORK/classes" "$ROOT"/java/io/mesalabs/rezoss/qwen/*.java
jar cf "$WORK/classes.jar" -C "$WORK/classes" .
"$TOOLS/d8" --min-api 30 --lib "$SDK/platforms/android-37.0/android.jar" --output "$WORK/dex" "$WORK/classes.jar"
MANIFEST="$WORK/AndroidManifest.xml"
python3 - "$ROOT/AndroidManifest.xml" "$MANIFEST" "$MODE" "${UNICA_LOCAL_LLM_BACKEND:-hybrid}" "${TARGET_CODENAME:-dm3q}" "${UNICA_ENABLE_NATIVE_NOW_NUDGE:-true}" <<'MANIFEST_PY'
from pathlib import Path
import sys, xml.etree.ElementTree as ET
source, output, mode, backend, target, native = sys.argv[1:]
ET.register_namespace('android', 'http://schemas.android.com/apk/res/android')
tree = ET.parse(source)
if mode == '--stub':
    root = tree.getroot()
    # Above every earlier Qwen APK (up to 12) so the system copy wins over a
    # leftover data update.
    root.set('{http://schemas.android.com/apk/res/android}versionCode', '13')
    root.set('{http://schemas.android.com/apk/res/android}versionName', '4.0-gemma')
tree.write(output, encoding='utf-8', xml_declaration=True)
MANIFEST_PY
"$TOOLS/aapt2" compile --dir "$ROOT/res" -o "$WORK/res.zip"
"$TOOLS/aapt2" link --manifest "$MANIFEST" -I "$SDK/platforms/android-37.0/android.jar" \
    -R "$WORK/res.zip" -o "$WORK/base.apk"
cp "$WORK/dex/classes.dex" "$WORK/"
(
    cd "$WORK"
    zip -q -0 base.apk classes.dex
)
"$TOOLS/zipalign" -P 16 -f 4 "$WORK/base.apk" "$WORK/aligned.apk"
CERT=aosp
if ${ROM_IS_OFFICIAL:-false}; then CERT=unica; fi
"$TOOLS/apksigner" sign --key "$SRC_DIR/security/${CERT}_platform.pk8" --cert "$SRC_DIR/security/${CERT}_platform.x509.pem" \
    --out "$WORK/signed.apk" "$WORK/aligned.apk"
"$TOOLS/apksigner" verify --verbose "$WORK/signed.apk"
"$TOOLS/zipalign" -c -P 16 4 "$WORK/signed.apk"
unzip -tq "$WORK/signed.apk"
mkdir -p "$(dirname -- "$OUTPUT")"
if [[ -e "$OUTPUT" ]]; then
    BACKUP="$OUTPUT.bak.$(date +%Y%m%d_%H%M%S)"
    [[ ! -e "$BACKUP" ]] || { echo "Backup exists: $BACKUP" >&2; exit 1; }
    cp -a "$OUTPUT" "$BACKUP"
    [[ ! -e "$OUTPUT.version" ]] || cp -a "$OUTPUT.version" "$BACKUP.version"
fi
mv "$WORK/signed.apk" "$OUTPUT"
APK_SHA256_LINE=$(sha256sum "$OUTPUT")
APK_SHA256=${APK_SHA256_LINE%% *}
APK_SIZE=$(stat -c %s "$OUTPUT")
GIT_COMMIT=$(git -C "$SRC_DIR" rev-parse --short=12 HEAD 2>/dev/null || true)
VERSION_FILE="$OUTPUT.version"
read -r VERSION_CODE VERSION_NAME < <(python3 - "$MANIFEST" <<'VERSION_PY'
import sys, xml.etree.ElementTree as ET
root = ET.parse(sys.argv[1]).getroot()
ns = '{http://schemas.android.com/apk/res/android}'
print(root.get(ns+'versionCode'), root.get(ns+'versionName'))
VERSION_PY
)
{
    printf "package=io.mesalabs.rezoss.qwen\n"
    printf "versionCode=%s\n" "$VERSION_CODE"
    printf "versionName=%s\n" "$VERSION_NAME"
    printf "apk=%s\n" "$OUTPUT"
    printf "sizeBytes=%s\n" "$APK_SIZE"
    printf "sha256=%s\n" "$APK_SHA256"
    printf "backend=local-gemma-or-explicit-api\n"
    printf "packaging=%s\n" "${MODE#--}"
    printf "model=Gemma 4 E2B via AIOS\n"
    printf "modelAssets=separate-import-required\n"
    printf "credentialStorage=android-keystore-aes-gcm\n"
    printf "builtAtUtc=%s\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    [[ -n "$GIT_COMMIT" ]] && printf "sourceCommit=%s\n" "$GIT_COMMIT"
} > "$VERSION_FILE"
sha256sum "$OUTPUT"
echo "version metadata: $VERSION_FILE"
