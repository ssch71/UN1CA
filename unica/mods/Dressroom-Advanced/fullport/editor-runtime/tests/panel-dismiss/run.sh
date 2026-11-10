#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
SRC="$ROOT/../../src/dev/denver/dressroomadvanced"
WORK=$(mktemp -d /tmp/dressroom-panel-dismiss.XXXXXX)
mapfile -t STUBS < <(find "$ROOT/stubs" -name '*.java' | sort)
javac --release 17 -d "$WORK" "${STUBS[@]}" "$SRC/ScreenBounds.java" "$SRC/OutsidePanelTap.java" "$SRC/AdvancedPanelDismiss.java" "$ROOT/PanelDismissTest.java"
java -cp "$WORK" dev.denver.dressroomadvanced.PanelDismissTest

