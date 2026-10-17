#!/usr/bin/env bash
# shellcheck disable=SC2034
# Copyright (c) 2026 Rezoss
# SPDX-License-Identifier: GPL-3.0-or-later

# shellcheck disable=SC2034
SKIPUNZIP=1

# SM8550 targets: dm1q = S23, dm2q = S23+, dm3q = S23U, b5q = Z Flip5, q5q = Z Fold5
case "$TARGET_CODENAME" in
    dm1q|dm2q|dm3q)
        ;;
    *)
        LOG "- Skipping FZH3 Hermes compatibility: unsupported target $TARGET_CODENAME"
        return 0
        ;;
esac

if [[ "$SOURCE_PLATFORM_SDK_VERSION" != "37" ]]; then
    LOG "- Skipping FZH3 Hermes compatibility: requires SDK 37 (got $SOURCE_PLATFORM_SDK_VERSION)"
    return 0
fi

LOG "- Applying experimental FZH3 Hermes backend on $TARGET_CODENAME; credential verification remains enabled"
ADD_TO_WORK_DIR "$MODPATH" "vendor" "bin/hermesd" 0 2000 755 "u:object_r:hermesd_exec:s0"
ADD_TO_WORK_DIR "$MODPATH" "vendor" "lib64/libhermes_bdbridge.so" 0 0 644 "u:object_r:vendor_file:s0"
ADD_TO_WORK_DIR "$MODPATH" "vendor" "lib64/libhwvault.so" 0 0 644 "u:object_r:vendor_file:s0"