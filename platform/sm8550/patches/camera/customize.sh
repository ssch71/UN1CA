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

echo "Add stock camera libs"
BLOBS_LIST="
system/etc/public.libraries-arcsoft.txt
system/etc/public.libraries-camera.samsung.txt
system/lib64/libacz_hhdr.arcsoft.so
system/lib64/libaiclearzoom_raw.arcsoft.so
system/lib64/libaiclearzoomraw_wrapper_v1.camera.samsung.so
system/lib64/libae_bracket_hdr.arcsoft.so
system/lib64/libsuperresolution_raw.arcsoft.so
system/lib64/libsuperresolutionraw_wrapper_v2.camera.samsung.so
system/lib64/libSwIsp_core.camera.samsung.so
system/lib64/libSwIsp_wrapper_v1.camera.samsung.so
"
for blob in $BLOBS_LIST
do
    _CAM_ADD "$TARGET_FIRMWARE" "system" "$blob" 0 0 644 "u:object_r:system_lib_file:s0"
done
unset -f _CAM_ADD
