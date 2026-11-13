#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Build the local AIOS backend: Gemma 4 E2B with a runtime GPU/CPU accelerator
# choice by default, or the single-engine Gemma GPU build.
set -euo pipefail
: "${SRC_DIR:?Source buildenv.sh <target> first}"
OUTPUT=${1:?Usage: build_rom_backend.sh NEW_OUTPUT_APK}
[[ ! -e "$OUTPUT" ]] || { echo "Refusing existing output: $OUTPUT" >&2; exit 1; }
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
case "${UNICA_LOCAL_LLM_BACKEND:-hybrid}" in
    hybrid) exec bash "$ROOT/hybrid/build.sh" "$OUTPUT" ;;
    gemma-gpu)
        STAGE=$(mktemp -d /tmp/unica-gemma-rom.XXXXXX)
        bash "$ROOT/gemma/build.sh" "$STAGE/build"
        mkdir -p "$(dirname -- "$OUTPUT")"
        cp "$STAGE/build/AIOS-Gemma4-E2B-GPU.apk" "$OUTPUT"
        cp "$STAGE/build/AIOS-Gemma4-E2B-GPU.apk.version" "$OUTPUT.version"
        ;;
    *) echo "Unsupported local LLM backend: $UNICA_LOCAL_LLM_BACKEND" >&2; exit 1 ;;
esac
