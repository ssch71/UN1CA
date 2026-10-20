# Store-updated Galaxy AI packages (e.g. OfflineLanguageModel used by call
# screening) pick the Hexagon V73 QNN path on SM8550 and dlopen
# libQnnHtpV73Stub.so by name, but the stub only exists in /vendor/lib64/snap,
# which apps cannot reach. Expose the stock V73 stub as a public system
# library and put the matching skel on the default DSP search path.
QNN_FW_DIR="$FW_DIR/$(cut -d "/" -f 1 <<< "$SOURCE_FIRMWARE")_$(cut -d "/" -f 2 <<< "$SOURCE_FIRMWARE")"
QNN_STUB="$QNN_FW_DIR/vendor/lib64/snap/libQnnHtpV73Stub.so"
QNN_SKEL="$QNN_FW_DIR/vendor/lib/rfsa/adsp/snap/libQnnHtpV73Skel.so"
QNN_STAGE="$TMP_DIR/qnn_v73"
QNN_PUBLIC_LIBS="$WORK_DIR/system/system/etc/public.libraries.txt"

if [ ! -f "$QNN_STUB" ] || [ ! -f "$QNN_SKEL" ]; then
    LOGW "Hexagon V73 QNN stub/skel not found in ${QNN_FW_DIR//$SRC_DIR\//}, skipping"
else
    rm -rf "$QNN_STAGE"
    mkdir -p "$QNN_STAGE/system/system/lib64" "$QNN_STAGE/system/system/lib/rfsa/adsp"
    cp -a "$QNN_STUB" "$QNN_STAGE/system/system/lib64/libQnnHtpV73Stub.so"
    cp -a "$QNN_SKEL" "$QNN_STAGE/system/system/lib/rfsa/adsp/libQnnHtpV73Skel.so"

    ADD_TO_WORK_DIR "$QNN_STAGE" "system" "system/lib64/libQnnHtpV73Stub.so" 0 0 644 "u:object_r:system_lib_file:s0"
    ADD_TO_WORK_DIR "$QNN_STAGE" "system" "system/lib/rfsa/adsp/libQnnHtpV73Skel.so" 0 0 644 "u:object_r:system_file:s0"

    if [ ! -f "$QNN_PUBLIC_LIBS" ]; then
        LOGW "File not found: ${QNN_PUBLIC_LIBS//$WORK_DIR\//}, skipping public library entry"
    elif ! grep -qx "libQnnHtpV73Stub.so" "$QNN_PUBLIC_LIBS"; then
        LOG "- Adding libQnnHtpV73Stub.so to /system/etc/public.libraries.txt"
        echo "libQnnHtpV73Stub.so" >> "$QNN_PUBLIC_LIBS"
    fi

    rm -rf "$QNN_STAGE"
fi

unset QNN_FW_DIR QNN_STUB QNN_SKEL QNN_STAGE QNN_PUBLIC_LIBS
