#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
JSON_JAR=${1:?Usage: run.sh /path/to/org-json.jar}
[[ -f "$JSON_JAR" ]] || { echo "Missing org.json host implementation" >&2; exit 2; }
WORK=$(mktemp -d /tmp/dressroom-profile-tests.XXXXXX)
mapfile -t STUBS < <(find "$ROOT/stubs" -name '*.java' | sort)
javac -cp "$JSON_JAR" -d "$WORK" "${STUBS[@]}" \
    "$ROOT/../src/dev/denver/dressroomadvanced/NativeProfileStore.java" "$ROOT/ProfileStoreTest.java"
java -cp "$WORK:$JSON_JAR" dev.denver.dressroomadvanced.ProfileStoreTest
