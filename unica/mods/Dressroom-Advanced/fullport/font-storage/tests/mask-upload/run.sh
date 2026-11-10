#!/usr/bin/env bash
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
PROVIDER=${1:-$ROOT/../../src/dev/denver/dressroomadvanced/SettingsProvider.java}
WORK=$(mktemp -d /tmp/dressroom-mask-tests.XXXXXX)
mapfile -t STUBS < <(find "$ROOT/stubs" -name '*.java' | sort)
javac -d "$WORK" "${STUBS[@]}" "$PROVIDER" "$ROOT/MaskUploadTest.java"
java -cp "$WORK" dev.denver.dressroomadvanced.MaskUploadTest
