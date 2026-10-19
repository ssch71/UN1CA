# One UI 8.5+ ships several framework.jar dexes right at the 65,535
# method-reference limit, and the UN1CA hooks (Keybox/PIF/HMA/...) add their
# references to classes3 and classes6. Move a few self-contained classes that
# no patch touches into the last (smallest) dex to leave headroom. The class
# descriptors are unchanged; only their dex container is different.
if [ "$SOURCE_PLATFORM_SDK_VERSION" -ge 36 ]; then
    _FW="$APKTOOL_DIR/system/framework/framework.jar"
    _LAST="$(find "$_FW" -mindepth 1 -maxdepth 1 -type d -name "smali_classes*" -printf "%f\n" | sort -V | tail -n 1)"

    _MOVE_FW_CLASS()
    {
        local FROM="$1"
        local CLASS="$2"
        local FILE

        [ -n "$_LAST" ] && [ "$FROM" != "$_LAST" ] || return 0
        [ -f "$_FW/$FROM/$CLASS.smali" ] || return 0

        LOG "- Moving $CLASS from $FROM to $_LAST"
        mkdir -p "$_FW/$_LAST/$(dirname "$CLASS")" || ABORT "Failed to create $_LAST/$(dirname "$CLASS")"
        for FILE in "$_FW/$FROM/$CLASS.smali" "$_FW/$FROM/$CLASS\$"*.smali; do
            [ -f "$FILE" ] || continue
            mv "$FILE" "$_FW/$_LAST/${FILE#"$_FW/$FROM/"}" || ABORT "Failed to move $FILE"
        done
    }

    _MOVE_FW_CLASS "smali_classes3" "android/os/BaseBundle"
    _MOVE_FW_CLASS "smali_classes6" "com/android/internal/telephony/ITelephony"

    unset -f _MOVE_FW_CLASS
    unset _FW _LAST
fi
