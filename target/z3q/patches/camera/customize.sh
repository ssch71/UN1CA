
# Android 17 only parses /vendor/etc/ueventd.rc, the sm8250 platform module
# already moved the legacy /vendor/ueventd.rc there.
if [ -f "$WORK_DIR/vendor/etc/ueventd.rc" ]; then
    LOG "- Patching /vendor/etc/ueventd.rc"
    EVAL "cat \"$MODPATH/ueventd.rc.diff\" >> \"$WORK_DIR/vendor/etc/ueventd.rc\""
else
    LOG "- Patching /vendor/ueventd.rc"
    EVAL "cat \"$MODPATH/ueventd.rc.diff\" >> \"$WORK_DIR/vendor/ueventd.rc\""
fi
