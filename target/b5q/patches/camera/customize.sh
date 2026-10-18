# Skip stock blobs the current target firmware no longer ships.
_CAM_ADD()
{
    local SRC="$1" PART="$2" FILE="${3#/}"
    if [[ "$PART" != "system_ext" ]] && [ "$(cut -d "/" -f 2 -s <<< "$SRC")" ]; then
        local DIR="$FW_DIR/$(cut -d "/" -f 1 <<< "$SRC")_$(cut -d "/" -f 2 <<< "$SRC")"
        if [ ! -e "$DIR/$PART/$FILE" ] && [ ! -L "$DIR/$PART/$FILE" ]; then
            LOGW "Skipping /$PART/$FILE: not in ${DIR//$SRC_DIR\//}"
            return 0
        fi
    fi
    ADD_TO_WORK_DIR "$@"
}

echo "Add stock camera libs and configs (b5q)"
BLOBS_LIST="
system/etc/public.libraries-arcsoft.txt
system/etc/public.libraries-camera.samsung.txt
system/lib64/libAEBHDR_wrapper.camera.samsung.so
system/lib64/libBeauty_v4.camera.samsung.so
system/lib64/libDeFlickerHdr.arcsoft.so
system/lib64/libDualCamBokehCapture.camera.samsung.so
system/lib64/libEventDetector.camera.samsung.so
system/lib64/libFace_Landmark_API.camera.samsung.so
system/lib64/libFace_Landmark_Engine.camera.samsung.so
system/lib64/libFacialBasedSelfieCorrection.camera.samsung.so
system/lib64/libFood.camera.samsung.so
system/lib64/libLocalTM_pcc.camera.samsung.so
system/lib64/libMPISingleRGB40.camera.samsung.so
system/lib64/libMPISingleRGB40Tuning.camera.samsung.so
system/lib64/libSceneDetector_v1.camera.samsung.so
system/lib64/libSmartScan.camera.samsung.so
system/lib64/libSwIsp_core.camera.samsung.so
system/lib64/libSwIsp_wrapper_v1.camera.samsung.so
system/lib64/libWideDistortionCorrection.camera.samsung.so
system/lib64/libacz_hhdr.arcsoft.so
system/lib64/libae_bracket_hdr.arcsoft.so
system/lib64/libaiclearzoom_raw.arcsoft.so
system/lib64/libaiclearzoomraw_wrapper_v1.camera.samsung.so
system/lib64/libbeautyshot.arcsoft.so
system/lib64/libface_landmark.arcsoft.so
system/lib64/libfacialrestoration.arcsoft.so
system/lib64/libfrtracking_engine.arcsoft.so
system/lib64/libhumantracking.arcsoft.so
system/lib64/libhybridHDR_wrapper.camera.samsung.so
system/lib64/libimage_enhancement.arcsoft.so
system/lib64/libsimba.media.samsung.so
system/lib64/libsuperresolution_raw.arcsoft.so
system/lib64/libsuperresolutionraw_wrapper_v2.camera.samsung.so
system/lib64/libswuwdc.arcsoft.so
"

for blob in $BLOBS_LIST
do
    SRC_PATH="out/fw/${TARGET_FIRMWARE}/system/${blob}"
    if [ ! -f "$SRC_PATH" ]; then
        echo "WARN: missing $blob, skipping"
        continue
    fi
    if [[ "$blob" == *.txt ]]; then
        _CAM_ADD "$TARGET_FIRMWARE" "system" "$blob" 0 0 644 "u:object_r:system_file:s0"
    else
        _CAM_ADD "$TARGET_FIRMWARE" "system" "$blob" 0 0 644 "u:object_r:system_lib_file:s0"
    fi
done
unset -f _CAM_ADD
