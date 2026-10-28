#!/system/bin/sh
# UN1CA z3q boot debugging, started from unica_bootlog.rc.
# kmsg: mirror logcat one line per write (kmsg rejects long writes).
# file: append the full log to /metadata (readable from recovery).

kmsg() {
    echo "$1" > /dev/kmsg
}

case "$1" in
kmsg)
    kmsg "unica_bootlog: started"
    while true; do
        /system/bin/logcat -b main -b system -b crash -v brief '*:I' 2>&1 | \
            while IFS= read -r l; do
                echo "L ${l:0:900}" > /dev/kmsg
            done
        kmsg "unica_bootlog: logcat exited"
        sleep 1
    done
    ;;
file)
    if echo started > /metadata/unica_boot.marker; then
        kmsg "unica_bootlog_file: marker written"
    else
        kmsg "unica_bootlog_file: cannot write /metadata"
    fi
    sync
    (while true; do sleep 5; sync; done) &
    while true; do
        /system/bin/logcat -b all -v threadtime >> /metadata/unica_boot.log 2>&1
        kmsg "unica_bootlog_file: logcat exited"
        sleep 1
    done
    ;;
esac
