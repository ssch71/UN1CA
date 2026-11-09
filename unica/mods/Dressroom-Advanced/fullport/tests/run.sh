#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
WORK=$(mktemp -d /tmp/dressroom-native-algorithms.XXXXXX)
NAMES=(FontAxes BlurOpacity WidgetLayout WallpaperMotionPacket CaptureInstanceState DepthSourcePolicy IdentityLocks DeferredRefresh LatestDepthWork)
SOURCES=()
for NAME in "${NAMES[@]}"; do
    mapfile -t MATCHES < <(find "$ROOT" -path "$ROOT/tests" -prune -o -type f -name "$NAME.java" -print)
    [[ ${#MATCHES[@]} -eq 1 ]] || { echo "Ambiguous algorithm source: $NAME" >&2; exit 1; }
    SOURCES+=("${MATCHES[0]}")
done
javac --release 17 -d "$WORK" "${SOURCES[@]}" "$ROOT/tests/upstream/"*.java
for TEST in "$ROOT/tests/upstream/"*Test.java; do
    java -cp "$WORK" "dev.denver.dressroomadvanced.$(basename "$TEST" .java)"
done
if [[ $# -gt 0 ]]; then "$ROOT/font-storage/tests/run.sh" "$1"; fi
