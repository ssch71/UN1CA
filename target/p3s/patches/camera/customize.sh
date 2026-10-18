# Skip stock blobs the current target firmware no longer ships.
_CAM_ADD()
{
    local SRC="$1" PART="$2" FILE="${3#/}"
    local DIR
    if [[ "$PART" != "system_ext" ]] && [ "$(cut -d "/" -f 2 -s <<< "$SRC")" ]; then
        DIR="$FW_DIR/$(cut -d "/" -f 1 <<< "$SRC")_$(cut -d "/" -f 2 <<< "$SRC")"
        if [ ! -e "$DIR/$PART/$FILE" ] && [ ! -L "$DIR/$PART/$FILE" ]; then
            LOGW "Skipping /$PART/$FILE: not in ${DIR//$SRC_DIR\//}"
            return 0
        fi
    fi
    ADD_TO_WORK_DIR "$@"
}

# Add camera libs
_CAM_ADD "$TARGET_FIRMWARE" "system" "system/lib64/libsame_source_hdr.arcsoft.so" 0 0 644 "u:object_r:system_lib_file:s0"
EVAL "echo \"libsame_source_hdr.arcsoft.so\" >> \"$WORK_DIR/system/system/etc/public.libraries-arcsoft.txt\""
_CAM_ADD "$TARGET_FIRMWARE" "system" "system/lib64/libsuperresolution_raw.arcsoft.so" 0 0 644 "u:object_r:system_lib_file:s0"
EVAL "echo \"libsuperresolution_raw.arcsoft.so\" >> \"$WORK_DIR/system/system/etc/public.libraries-arcsoft.txt\""
_CAM_ADD "$TARGET_FIRMWARE" "system" "system/lib64/libsuperresolutionraw_wrapper_v2.camera.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
_CAM_ADD "$TARGET_FIRMWARE" "system" "system/lib64/libuwsuperresolution.arcsoft.so" 0 0 644 "u:object_r:system_lib_file:s0"
EVAL "echo \"libuwsuperresolution.arcsoft.so\" >> \"$WORK_DIR/system/system/etc/public.libraries-arcsoft.txt\""
_CAM_ADD "$TARGET_FIRMWARE" "system" "system/lib64/libuwsuperresolution_wrapper_v1.camera.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
EVAL "echo \"libuwsuperresolution_wrapper_v1.camera.samsung.so\" >> \"$WORK_DIR/system/system/etc/public.libraries-camera.samsung.txt\""

unset -f _CAM_ADD
