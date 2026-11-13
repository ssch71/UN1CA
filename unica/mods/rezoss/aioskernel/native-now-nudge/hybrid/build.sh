#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Build the ROM AIOS backend running Gemma 4 E2B through LiteRT; the GPU or CPU
# accelerator is chosen at runtime in the Rezoss AI settings. The model stays
# separate. The settings app always reports Gemma as the local model.
set -euo pipefail
: "${SRC_DIR:?Source buildenv.sh <target> first}"
HERE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
ROOT=$(cd "$HERE/.." && pwd)
GEMMA=$ROOT/gemma
OUTPUT=${1:?Usage: build.sh NEW_OUTPUT_APK}
[[ ! -e "$OUTPUT" ]] || { echo "Refusing existing output: $OUTPUT" >&2; exit 1; }
SDK=${ANDROID_HOME:-$HOME/Android/Sdk}; TOOLS=$SDK/build-tools/37.0.0
# LiteRT-LM 0.19 ships Java 21 class files; prefer a JDK 21 javac when present.
JAVAC=javac
for JDK in "${JAVA_HOME_21_X64:-}" "${JAVA_HOME_21_ARM64:-}" "${JAVA_HOME_21:-}"; do
    [[ -n "$JDK" && -x "$JDK/bin/javac" ]] && { JAVAC=$JDK/bin/javac; break; }
done
WORK=$(mktemp -d /tmp/unica-hybrid-backend.XXXXXX)
BASE=$ROOT/prebuilt/AIOS-V73-base.apk
printf '%s  %s\n' aef3822a21d4c8821bbfd0b8db2630d8db7b3a1f86bd3d3e9c5e2a0f7fbd5a8c "$BASE" | sha256sum -c -
python3 "$GEMMA/fetch_runtime.py" "$WORK/deps" "${GEMMA_RUNTIME_CACHE:-$SRC_DIR/out/archived/gemma4-e2b-device-20261031}"
python3 - "$WORK" <<'PY'
from pathlib import Path
from zipfile import ZipFile
import sys
work=Path(sys.argv[1])
with ZipFile(work/'deps/litertlm-android-0.19.0.aar') as z:
    (work/'deps/litertlm-classes.jar').write_bytes(z.read('classes.jar'))
    (work/'deps/liblitertlm_jni.so').write_bytes(z.read('jni/arm64-v8a/liblitertlm_jni.so'))
PY
STAGE=$WORK/stage
mkdir -p "$STAGE/classes" "$STAGE/dex"
cp -a "$ROOT/backend" "$STAGE/"
cp -a "$GEMMA/java/." "$STAGE/backend/java/"
patch --dry-run --fuzz=0 -p1 -d "$STAGE" -i "$HERE/0001-Select-local-engine-at-runtime.patch"
patch --fuzz=0 -p1 -d "$STAGE" -i "$HERE/0001-Select-local-engine-at-runtime.patch"
cat > "$STAGE/backend/java/io/mesalabs/rezoss/nudge/GemmaBuild.java" <<'JAVA'
package io.mesalabs.rezoss.nudge;
final class GemmaBuild { static final String BACKEND="gpu"; }
JAVA
python3 - "$STAGE/backend/AndroidManifest.xml" <<'PY'
import sys,xml.etree.ElementTree as ET
path=sys.argv[1];ns='{http://schemas.android.com/apk/res/android}'
ET.register_namespace('android',ns[1:-1]);tree=ET.parse(path);root=tree.getroot()
root.set(ns+'versionCode','142801212');root.set(ns+'versionName','1.4.29')
app=root.find('application');app.set(ns+'label','AIOS Gemma')
ET.SubElement(app,'meta-data',{ns+'name':'unica.local_model_name',ns+'value':'Gemma 4 E2B'})
for lib in ['libOpenCL.so','libvndksupport.so']:
    ET.SubElement(app,'uses-native-library',{ns+'name':lib,ns+'required':'false'})
activity=ET.SubElement(app,'activity',{ns+'name':'io.mesalabs.rezoss.nudge.GemmaSetupActivity',ns+'exported':'true',ns+'configChanges':'orientation|screenSize|uiMode'})
f=ET.SubElement(activity,'intent-filter');ET.SubElement(f,'action',{ns+'name':'android.intent.action.MAIN'});ET.SubElement(f,'category',{ns+'name':'android.intent.category.LAUNCHER'})
tree.write(path,encoding='utf-8',xml_declaration=True)
PY
mapfile -t SOURCES < <(find "$STAGE/backend/java" -name '*.java' -type f | sort)
"$JAVAC" -source 8 -target 8 -Xlint:-options -classpath "$SDK/platforms/android-37.0/android.jar:$WORK/deps/litertlm-classes.jar:$WORK/deps/kotlin-stdlib.jar" -d "$STAGE/classes" "${SOURCES[@]}"
jar cf "$STAGE/backend.jar" -C "$STAGE/classes" .
"$TOOLS/d8" --min-api 30 --lib "$SDK/platforms/android-37.0/android.jar" --output "$STAGE/dex" "$STAGE/backend.jar" "$WORK/deps/"*.jar
"$TOOLS/aapt2" link --manifest "$STAGE/backend/AndroidManifest.xml" -I "$SDK/platforms/android-37.0/android.jar" -o "$STAGE/manifest.apk"
# The GPU packaging carries every LiteRT accelerator, so CPU and GPU are both
# selectable at runtime. The base APK's runner libraries are kept unchanged.
python3 "$GEMMA/package.py" "$BASE" "$STAGE" "$WORK/deps" gpu
"$TOOLS/zipalign" -P 16 -f 4 "$STAGE/unsigned.apk" "$STAGE/aligned.apk"
CERT=aosp
if ${ROM_IS_OFFICIAL:-false}; then CERT=unica; fi
mkdir -p "$(dirname -- "$OUTPUT")"
"$TOOLS/apksigner" sign --key "$SRC_DIR/security/${CERT}_platform.pk8" --cert "$SRC_DIR/security/${CERT}_platform.x509.pem" --out "$OUTPUT" "$STAGE/aligned.apk"
"$TOOLS/apksigner" verify "$OUTPUT"
"$TOOLS/zipalign" -c -P 16 4 "$OUTPUT"
unzip -tq "$OUTPUT"
unzip -l "$OUTPUT" | grep -q 'lib/arm64-v8a/libnudge_runner.so' || { echo "V73 runner missing from hybrid backend" >&2; exit 1; }
printf 'Built hybrid backend: %s\n' "$OUTPUT"
