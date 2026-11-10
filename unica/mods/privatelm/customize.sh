#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later

# Samsung filters preinstalled packages through this allowlist, independently
# of APK placement and runtime permission grants.
_PRIVATE_LM_ALLOWLIST="$WORK_DIR/system/system/etc/sysconfig/allowed-system-preload-apps.xml"
[[ -f "$_PRIVATE_LM_ALLOWLIST" ]] || ABORT "Samsung system preload allowlist is missing"
if ! grep -q -F 'package="com.orailnoor.privatelm"' "$_PRIVATE_LM_ALLOWLIST"; then
    LOG "- Allow PrivateLM as a Samsung system preload"
    EVAL "LC_ALL=C patch --batch --fuzz=0 --no-backup-if-mismatch -p1 -d \"$WORK_DIR/system/system/etc/sysconfig\" < \"$MODPATH/patches/0001-Allow-PrivateLM-system-preload.patch\"" \
        || ABORT "Failed to allow PrivateLM system preload"
fi
unset _PRIVATE_LM_ALLOWLIST
