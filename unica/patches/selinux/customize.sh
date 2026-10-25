# UN1CA SELinux entries removal list
# - Append new type entries to the ENTRIES list
# - Add the EXACT type entry, DO NOT just add a common pattern (eg. "fabriccrypto", "fabriccrypto_exec" and NOT just "fabriccrypto")
# - DO NOT add the API version at the end of the entry (eg. "fabriccrypto" and NOT "fabriccrypto_30_0")
# - DO NOT add any parenthesis or statements (eg. "fabriccrypto" and NOT "expanttypeattribute ... (fabriccrypto)")
# - DO NOT add unnecessary types or remove the existing ones unless they aren't necessary anymore for all devices

# One UI 8.0 additions
ENTRIES+="
heatmap_default
heatmap_default_exec
"

DUPLICATES+="
init.svc.vendor.wvkprov_server_hal
"

# One UI 7.0 additions
ENTRIES+="
attiqi_app
attiqi_app_data_file
ker_app
kpp_app
kpp_data_file
"

# One UI 6.1.1 additions
ENTRIES+="
hal_dsms_default
hal_dsms_default_exec
proc_compaction_proactiveness
sbauth
sbauth_exec
"

# One UI 5.1.1 additions
ENTRIES+="
audiomirroring
audiomirroring_exec
audiomirroring_service
fabriccrypto
fabriccrypto_exec
fabriccrypto_data_file
hal_dsms_service
uwb_regulation_skip_prop
"

# [
GET_SYSTEM_EXT()
{
    if $TARGET_OS_BUILD_SYSTEM_EXT_PARTITION; then
        echo "system_ext"
    else
        echo "system/system/system_ext"
    fi
}

CIL_NAME="$(head -n 1 "$WORK_DIR/vendor/etc/selinux/plat_sepolicy_vers.txt")"

# Newer system images drop mapping files for old vendor APIs (One UI 9 ships
# nothing older than 31.0), so init cannot compile the split policy on e.g.
# Android 11 (30.0) vendors and reboots right after first-stage mount.
# Synthesize the missing mapping from the oldest one that is still shipped.
GEN_COMPAT_MAPPING()
{
    local DIR="$1"
    local WITH_TYPES="$2"
    local BASE
    local PLATFORM=()

    [ -d "$DIR" ] || return 0
    [ -f "$DIR/$CIL_NAME.cil" ] && return 0
    BASE="$(find "$DIR" -maxdepth 1 -type f -name "[0-9]*.[0-9]*.cil" ! -name "*.compat.cil" -printf "%f\n" | \
        sed "s/\.cil$//" | sort -V | awk -v v="$CIL_NAME" '$0 + 0 > v + 0 { print; exit }')"
    if [ -z "$BASE" ]; then
        LOGW "No legacy sepolicy mapping to derive $CIL_NAME from in ${DIR//$WORK_DIR/}"
        return 0
    fi

    if $WITH_TYPES; then
        PLATFORM=("$WORK_DIR/system/system/etc/selinux/plat_sepolicy.cil")
        [ -f "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/system_ext_sepolicy.cil" ] && \
            PLATFORM+=("$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/system_ext_sepolicy.cil")
    fi

    LOG "- Generating ${DIR//$WORK_DIR/}/$CIL_NAME.cil from $BASE.cil"
    EVAL "python3 \"$SRC_DIR/unica/patches/selinux/gen_compat_mapping.py\" \"$DIR/$BASE.cil\" \"$DIR/$CIL_NAME.cil\" \
        \"$BASE\" \"$CIL_NAME\" \"$WORK_DIR/vendor/etc/selinux/plat_pub_versioned.cil\" ${PLATFORM[*]}" || return 1
    if [ -f "$DIR/$BASE.compat.cil" ]; then
        EVAL "python3 \"$SRC_DIR/unica/patches/selinux/gen_compat_mapping.py\" \"$DIR/$BASE.compat.cil\" \
            \"$DIR/$CIL_NAME.compat.cil\" \"$BASE\" \"$CIL_NAME\" \"$WORK_DIR/vendor/etc/selinux/plat_pub_versioned.cil\"" || return 1
    fi

    local REL="${DIR#"$WORK_DIR"/}"
    local f
    for f in "$CIL_NAME.cil" "$CIL_NAME.compat.cil"; do
        [ -f "$DIR/$f" ] || continue
        SET_METADATA "${REL%%/*}" "${REL#*/}/$f" 0 0 644 "u:object_r:system_file:s0" || return 1
    done
}

if [ -f "$WORK_DIR/vendor/etc/selinux/plat_pub_versioned.cil" ]; then
    GEN_COMPAT_MAPPING "$WORK_DIR/system/system/etc/selinux/mapping" true || ABORT "Failed to generate $CIL_NAME sepolicy mapping"
    GEN_COMPAT_MAPPING "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping" false || ABORT "Failed to generate $CIL_NAME sepolicy mapping"
    for PRODUCT_MAPPING in "$WORK_DIR/product/etc/selinux/mapping" "$WORK_DIR/system/system/product/etc/selinux/mapping"; do
        GEN_COMPAT_MAPPING "$PRODUCT_MAPPING" false || ABORT "Failed to generate $CIL_NAME sepolicy mapping"
    done
    unset PRODUCT_MAPPING
fi
PATCHED=false
VENDOR_API_LIST="$(find "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping" -type f -printf "%f\n" | \
                    sed '/.compat./d' | sed 's/.cil//' | sed 's/\./_/' | sort)"
# ]

for e in $ENTRIES; do
    if grep -q -F "($e)" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping/$CIL_NAME.cil" || \
         grep -q -F "${e}_${CIL_NAME//./_}" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping/$CIL_NAME.cil"; then
        # the problematic entry is currently present in system_ext, check if we need to remove it
        if ! grep -q -F "(type $e)" "$WORK_DIR/vendor/etc/selinux/plat_pub_versioned.cil"; then
            PATCHED=true
            # the problematic entry is not supported by the target device
            LOG "- \"$e\" SELinux entry not supported. Removing"
            sed -i "/($e)/d" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping/$CIL_NAME.cil"
            for a in $VENDOR_API_LIST; do
                sed -i "/${e}_${a}/d" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/mapping/$CIL_NAME.cil"
            done
            if grep -q "genfscon.*$e" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/system_ext_sepolicy.cil"; then
                sed -i "/genfscon.*$e/d" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/system_ext_sepolicy.cil"
            fi
            if grep -q "genfscon.*$e" "$WORK_DIR/system/system/etc/selinux/plat_sepolicy.cil"; then
                sed -i "/genfscon.*$e/d" "$WORK_DIR/system/system/etc/selinux/plat_sepolicy.cil"
            fi
        fi
    fi
done

for e in $DUPLICATES; do
    if grep -q "^$e.*" "$WORK_DIR/$(GET_SYSTEM_EXT)/etc/selinux/system_ext_property_contexts"; then
        # the problematic entry is currently present in system_ext, check if we need to remove it
        if grep -q "^$e.*" "$WORK_DIR/vendor/etc/selinux/vendor_property_contexts"; then
            PATCHED=true
            # the problematic entry is found in target vendor
            LOG "- \"$e\" SELinux duplicate entry found. Removing"
            sed -i "s/^$e/#SEC_DUPLICATE: $e/g" "$WORK_DIR/vendor/etc/selinux/vendor_property_contexts"
        fi
    fi
done

if ! $PATCHED; then
    LOG "\033[0;33m! Nothing to do\033[0m"
fi

unset ENTRIES DUPLICATES CIL_NAME PATCHED VENDOR_API_LIST
unset -f GET_SYSTEM_EXT
