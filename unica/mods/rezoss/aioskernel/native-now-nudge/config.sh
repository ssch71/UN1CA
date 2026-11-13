# SPDX-License-Identifier: GPL-3.0-or-later
# Device-local default; also accepts an exported environment override.
# Generation goes through the Rezoss AI provider (API or on-device llama.cpp),
# so the SM8250 targets (S20/S20 FE/Note20) can use it as well as SM8550.
# Set the default to false to restore the previous ROM packaging.
if [[ "$TARGET_CODENAME" =~ ^(dm1q|dm2q|dm3q|b5q|q5q|x1q|y2q|z3q|c1q|c2q|r8q|gts7l|gts7lwifi)$ ]]; then
    UNICA_ENABLE_NATIVE_NOW_NUDGE="${UNICA_ENABLE_NATIVE_NOW_NUDGE:-true}"
else
    UNICA_ENABLE_NATIVE_NOW_NUDGE="${UNICA_ENABLE_NATIVE_NOW_NUDGE:-false}"
fi

# Local generation only. Explicitly selected API providers are unaffected.
# hybrid: Gemma 4 E2B with the GPU/CPU accelerator chosen in AI backend settings.
# gemma-gpu: single-engine Gemma 4 E2B GPU build.
export UNICA_LOCAL_LLM_BACKEND="${UNICA_LOCAL_LLM_BACKEND:-hybrid}"
case "$UNICA_LOCAL_LLM_BACKEND" in hybrid|gemma-gpu) ;; *) echo "Unsupported local LLM backend: $UNICA_LOCAL_LLM_BACKEND" >&2; return 1 ;; esac
export UNICA_ENABLE_NATIVE_NOW_NUDGE
