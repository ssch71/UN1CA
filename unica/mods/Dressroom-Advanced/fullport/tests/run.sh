#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
WORK=$(mktemp -d /tmp/dressroom-native-algorithms.XXXXXX)
NAMES=(FontAxes BlurOpacity WidgetLayout WallpaperMotionPacket CaptureInstanceState DepthSourcePolicy IdentityLocks DeferredRefresh LatestDepthWork StretchRestorePolicy WidgetCellBounds WidgetBoundaryMetrics WidgetFormModel Reflect)
SOURCES=()
for NAME in "${NAMES[@]}"; do
    mapfile -t MATCHES < <(find "$ROOT" -path "$ROOT/tests" -prune -o -type f -name "$NAME.java" -print)
    [[ ${#MATCHES[@]} -eq 1 ]] || { echo "Ambiguous algorithm source: $NAME" >&2; exit 1; }
    SOURCES+=("${MATCHES[0]}")
done
TESTS=("$ROOT/tests/upstream/"*Test.java
    "$ROOT/clock-runtime/tests/StretchRestorePolicyTest.java"
    "$ROOT/widgets-extras/tests/dev/denver/dressroomadvanced/WidgetCellBoundsTest.java"
    "$ROOT/widgets-extras/tests/dev/denver/dressroomadvanced/WidgetBoundaryMetricsTest.java"
    "$ROOT/widgets-extras/tests/dev/denver/dressroomadvanced/WidgetFormModelTest.java")
javac --release 17 -d "$WORK" "${SOURCES[@]}" "${TESTS[@]}"
for TEST in "${TESTS[@]}"; do
    java -cp "$WORK" "dev.denver.dressroomadvanced.$(basename "$TEST" .java)"
done
if [[ $# -gt 0 ]]; then "$ROOT/font-storage/tests/run.sh" "$1"; fi

"$ROOT/font-storage/tests/mask-upload/run.sh"
python3 -m unittest discover -s "$ROOT/depth-wallpaper/tests" -p 'test_*.py'

"$ROOT/editor-runtime/tests/panel-dismiss/run.sh"

"$ROOT/widgets-extras/tests/run-provider-forms.sh"
