# Temporary z3q boot debugging; remove (or add a "disable" file) once z3q boots.
if [ -f "$MODPATH/disable" ]; then
    LOG "- Boot log mirroring disabled"
    return 0
fi

ADD_TO_WORK_DIR "$MODPATH" "system" "system/etc/init/unica_bootlog.rc" 0 0 644 "u:object_r:system_file:s0"

PLAT_CIL="$WORK_DIR/system/system/etc/selinux/plat_sepolicy.cil"
if ! grep -q "unica_bootlog" "$PLAT_CIL"; then
    LOG "- Adding permissive unica_bootlog domain"
    {
        echo "(type unica_bootlog)"
        echo "(roletype object_r unica_bootlog)"
        echo "(typeattributeset domain (unica_bootlog))"
        echo "(typepermissive unica_bootlog)"
        echo "(allow init unica_bootlog (process (transition rlimitinh siginh noatsecure)))"
        echo "(allow unica_bootlog logcat_exec (file (entrypoint read open execute getattr map)))"
    } >> "$PLAT_CIL"
fi
unset PLAT_CIL
