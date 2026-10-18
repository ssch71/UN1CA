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
system/lib64/libDLInterface_aidl.camera.samsung.so
system/lib64/libDocDeblur.camera.samsung.so
system/lib64/libDocObjectRemoval.camera.samsung.so
system/lib64/libDocObjectRemoval.enhanceX.samsung.so
"
for blob in $BLOBS_LIST
do
    _CAM_ADD "$TARGET_FIRMWARE" "system" "$blob" 0 0 644 "u:object_r:system_lib_file:s0"
done

unset -f _CAM_ADD
