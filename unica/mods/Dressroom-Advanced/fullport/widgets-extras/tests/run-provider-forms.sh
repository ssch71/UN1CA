#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
BASE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
WORK=$(mktemp -d /tmp/dressroom-provider-forms-test.XXXXXX)
SDK_JAR=${ANDROID_JAR:-$HOME/Android/Sdk/platforms/android-37.0/android.jar}
find "$BASE/tests/provider-stubs" -name '*.java' -print > "$WORK/sources"
printf '%s\n' "$BASE/java/dev/denver/dressroomadvanced/WidgetProviderForms.java" "$BASE/java/dev/denver/dressroomadvanced/WidgetFormModel.java" "$BASE/../editor-runtime/src/dev/denver/dressroomadvanced/Reflect.java" "$BASE/tests/dev/denver/dressroomadvanced/WidgetProviderFormsTest.java" >> "$WORK/sources"
javac --release 17 -cp "$SDK_JAR" -d "$WORK/classes" @"$WORK/sources"
java -cp "$WORK/classes:$SDK_JAR" dev.denver.dressroomadvanced.WidgetProviderFormsTest
