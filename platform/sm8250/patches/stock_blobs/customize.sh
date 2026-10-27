# Prebuilts carried over from other ports are not all in this repo; skip the
# missing ones instead of aborting (the source already ships its own copies).
_SB_ADD()
{
    local SRC="$1" PART="$2" FILE="${3#/}" BLOB

    if [ ! -d "$SRC" ] && [ -z "$(cut -d "/" -f 2 -s <<< "$SRC")" ]; then
        BLOB="$SRC_DIR/prebuilts/samsung/$SRC"
        if [[ "$PART" == "system" ]]; then
            BLOB+="/system/${FILE#system/}"
        else
            BLOB+="/$PART/$FILE"
        fi
        if [ ! -e "$BLOB" ] && [ ! -e "$BLOB.00" ]; then
            LOGW "Skipping /$PART/$FILE: not in prebuilts/samsung/$SRC"
            return 0
        fi
    fi
    ADD_TO_WORK_DIR "$@"
}

LOG_STEP_IN "- Merging stock framework vintf HALs from $TARGET_CODENAME"
SB_TARGET_MANIFEST="$FW_DIR/$(cut -d "/" -f 1 <<< "$TARGET_FIRMWARE")_$(cut -d "/" -f 2 <<< "$TARGET_FIRMWARE")/system/system/etc/vintf/manifest.xml"
SB_SOURCE_MANIFEST="$WORK_DIR/system/system/etc/vintf/manifest.xml"
if [ -f "$SB_TARGET_MANIFEST" ] && [ -f "$SB_SOURCE_MANIFEST" ]; then
    # HALs the source already declares in another framework manifest
    # (system_ext, product, fragments) must not be added a second time
    SB_OTHER=()
    while IFS= read -r -d "" SB_XML; do
        [[ "$SB_XML" == "$SB_SOURCE_MANIFEST" ]] || SB_OTHER+=("$SB_XML")
    done < <(find "$WORK_DIR/system/system/etc/vintf" \
        "$WORK_DIR/system/system/system_ext/etc/vintf" "$WORK_DIR/system_ext/etc/vintf" \
        "$WORK_DIR/system/system/product/etc/vintf" "$WORK_DIR/product/etc/vintf" \
        -name "*.xml" ! -name "compatibility_matrix*" -print0 2> /dev/null)
    SB_ADDED="$(python3 "$MODPATH/vintf_merge.py" "$SB_SOURCE_MANIFEST" "$SB_TARGET_MANIFEST" "${SB_OTHER[@]}")" || \
        ABORT "Failed to merge the stock framework vintf manifest"
    while IFS= read -r SB_HAL; do
        [ -n "$SB_HAL" ] && LOG "- Added $SB_HAL"
    done <<< "$SB_ADDED"
else
    LOGW "Stock or source framework vintf manifest not found, skipping merge"
fi
unset SB_TARGET_MANIFEST SB_SOURCE_MANIFEST SB_ADDED SB_HAL SB_OTHER SB_XML
LOG_STEP_OUT

LOG_STEP_IN "- Fixing vintf manifest"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/etc/vintf/manifest.xml"
sed -i 's/manifest version="8\.0"/manifest version="9.0"/' "$WORK_DIR/system/system/system_ext/etc/vintf/manifest.xml"
LOG_STEP_OUT

if [[ "$TARGET_CODENAME" == "x1q" || "$TARGET_CODENAME" == "y2q" || "$TARGET_CODENAME" == "z3q" ]]; then
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/LedBackCoverAppHubble/LedBackCoverAppHubble.apk" 0 0 644 "u:object_r:system_file:s0"
    ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/privapp-permissions-com.samsung.android.app.ledbackcover.xml" 0 0 644 "u:object_r:system_file:s0"
fi
LOG_STEP_OUT

DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.clearcameraviewcover.xml"
DELETE_FROM_WORK_DIR "system" "system/etc/permissions/com.sec.feature.cover.flip.xml"
LOG_STEP_IN "- Add stock system features"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.clearsideviewcover.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT


LOG_STEP_IN "- Add stock GameDriver"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/GameDriver-SM8250/GameDriver-SM8250.apk" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Add r9qxxx libhwui"
# Disabled: r9q libhwui is ABI-incompatible with the S24U source (protobuf)
# ADD_TO_WORK_DIR "r9qxxx" "system" "system/lib/libhwui.so" 0 0 644 "u:object_r:system_lib_file:s0"
# Disabled: r9q libhwui is ABI-incompatible with the S24U source (protobuf)
# ADD_TO_WORK_DIR "r9qxxx" "system" "system/lib64/libhwui.so" 0 0 644 "u:object_r:system_lib_file:s0"
# The r9q libhwui links versioned AIDL NDK libs (e.g. graphics.common-V6) that
# a newer source no longer ships. Frozen AIDL versions are supersets with the
# same symbols, so point each missing -V<n>-ndk dependency at the highest
# version the source has. Without this zygote, bootanimation and mediaserver
# fail to link libhwui and the device hangs at boot.
for LIBDIR in lib lib64; do
    HWUI="$WORK_DIR/system/system/$LIBDIR/libhwui.so"
    [ -f "$HWUI" ] || continue
    while read -r NEEDED; do
        [ -e "$WORK_DIR/system/system/$LIBDIR/$NEEDED" ] && continue
        BASE="${NEEDED%-V*-ndk.so}"
        NEWEST="$(find "$WORK_DIR/system/system/$LIBDIR" -maxdepth 1 -name "$BASE-V*-ndk.so" -printf '%f\n' 2> /dev/null | sort -V | tail -n 1)"
        if [ -n "$NEWEST" ]; then
            LOG "- $LIBDIR/libhwui.so: $NEEDED -> $NEWEST"
            EVAL "patchelf --replace-needed \"$NEEDED\" \"$NEWEST\" \"$HWUI\""
        else
            LOGW "- $LIBDIR/libhwui.so needs $NEEDED, which the source does not provide"
        fi
    done < <(readelf -d "$HWUI" | sed -n 's/.*(NEEDED).*\[\(.*-V[0-9]*-ndk\.so\)\].*/\1/p')
done
unset LIBDIR HWUI NEEDED BASE NEWEST
LOG_STEP_OUT


LOG_STEP_IN "- Adding r9qxxx keymaster libs"
DELETE_FROM_WORK_DIR "system" "system/lib/android.hardware.security.secureclock-V1-ndk.so"
DELETE_FROM_WORK_DIR "system" "system/lib/libdk_native_keymint.so"
DELETE_FROM_WORK_DIR "system" "system/lib64/libdk_native_keymint.so"
_SB_ADD "r9qxxx" "system" "system/lib/android.hardware.keymaster@3.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/android.hardware.keymaster@4.0.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/android.hardware.keymaster@4.1.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/lib_nativeJni.dk.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/libdk_native_keymaster.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/libkeymaster4_1support.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib/libkeymaster4support.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib64/lib_nativeJni.dk.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "r9qxxx" "system" "system/lib64/libdk_native_keymaster.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding a73xqxx NightMode libs"
_SB_ADD "a73xqxx" "system" "system/lib64/libSwIsp_core.camera.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
_SB_ADD "a73xqxx" "system" "system/lib64/libSwIsp_wrapper_v1.camera.samsung.so" 0 0 644 "u:object_r:system_lib_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing MIDAS, AI and camera"
_SB_ADD "a73xqxx" "system" "system/lib64/libSlowShutter_jni.media.samsung.so"
_SB_ADD "a73xqxx" "system" "system/lib64/lib_nativeJni.dk.samsung.so"
# TEST: use source midas libs (match libRemasterEngine) # ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libmidas_DNNInterface.camera.samsung.so"
# TEST: use source midas libs (match libRemasterEngine) # ADD_TO_WORK_DIR "a73xqxx" "system" "system/lib64/libmidas_core.camera.samsung.so"
_SB_ADD "a73xqxx" "system" "system/lib64/libsamsung_videoengine_9_0.so"
_SB_ADD "a73xqxx" "system" "system/lib64/libtensorflowLite.camera.samsung.so"
_SB_ADD "a73xqxx" "system" "system/lib64/libtensorflowlite_inference_api.camera.samsung.so"
LOG_STEP_OUT

LOG_STEP_IN "- Fixing Google Assistant"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentOKGoogleEx4HEXAGON"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentXGoogleEx4HEXAGON"
_SB_ADD "a73xqxx" "product" "priv-app/HotwordEnrollmentOKGoogleEx3HEXAGON"
_SB_ADD "a73xqxx" "product" "priv-app/HotwordEnrollmentXGoogleEx3HEXAGON"
LOG_STEP_OUT

LOG_STEP_IN "- Adding pa1qxxx nfc blobs"
_SB_ADD "pa1qxxx" "system" "system/lib64/libnfc_sec_jni.so"
_SB_ADD "pa1qxxx" "system" "system/lib64/libnfc-nci_flags.so"
_SB_ADD "pa1qxxx" "system" "system/lib64/libnfc-sec.so"
_SB_ADD "pa1qxxx" "system" "system/lib64/libstatslog_nfc.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.clearsideviewcover.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.cover.sview.xml" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/etc/permissions/com.sec.feature.nfc_authentication_cover.xml" 0 0 644 "u:object_r:system_file:s0"
LOG_STEP_OUT

LOG_STEP_IN "- Adding r9qxxx biometric blobs"
DELETE_FROM_WORK_DIR "vendor" "bin/hw/vendor.samsung.hardware.biometrics.face@2.0-service"
DELETE_FROM_WORK_DIR "vendor" "etc/init/vendor.samsung.hardware.biometrics.face@2.0-service.rc"
_SB_ADD "r9qxxx" "vendor" "bin/hw/vendor.samsung.hardware.biometrics.face@3.0-service"
_SB_ADD "r9qxxx" "vendor" "etc/init/vendor.samsung.hardware.biometrics.face@3.0-service.rc"
_SB_ADD "r9qxxx" "vendor" "lib/vendor.samsung.hardware.biometrics.face@2.0.so"
_SB_ADD "r9qxxx" "vendor" "lib/vendor.samsung.hardware.biometrics.face@3.0.so"
_SB_ADD "r9qxxx" "vendor" "lib64/vendor.samsung.hardware.biometrics.face@2.0.so"
_SB_ADD "r9qxxx" "vendor" "lib64/vendor.samsung.hardware.biometrics.face@3.0.so"
LOG_STEP_OUT

unset -f _SB_ADD
