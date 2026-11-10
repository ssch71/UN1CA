# shellcheck disable=SC2034
SKIPUNZIP=1

# X810/gts9pwifi (A16) SemDisplayQualityManagerService.<init> -> SemDisplayQualityAidlClient.<init>
# blocks the system_server MAIN THREAD in:
#   ServiceManager.waitForService("vendor.samsung.hardware.displayquality.ISehDisplayQuality/default")
# The gts7xlwifi (T970, A11) vendor does NOT declare that AIDL HAL, so waitForService never returns:
# 66s -> platform watchdog (PF_WD) kills system_server -> RescueParty -> boot loop.
# (Confirmed on the Jeys X810 8.0 port; the framework<->vendor mismatch is identical here.)
# Fix: use checkService (non-blocking) instead. It returns null immediately when the HAL is
# absent, and SemDisplayQualityAidlClient.<init> already handles null (logs + returns, leaving
# mSehDisplayQuality=null, all callers null-guard), so boot proceeds normally.
LOG_STEP_IN "- Fixing DisplayQuality HAL wait (waitForService -> checkService)"
SMALI_PATCH "system" "system/framework/services.jar" \
    "smali_classes2/com/samsung/android/displayquality/SemDisplayQualityAidlClient.smali" "replace" \
    "<init>()V" \
    "invoke-static {v2}, Landroid/os/ServiceManager;->waitForService(Ljava/lang/String;)Landroid/os/IBinder;" \
    "invoke-static {v2}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;"

# SMALI_PATCH downgrades every failure to a warning (module_utils/smali_utils), so a donor bump
# that renames the method or changes the invoke line would ship a build that looks clean and
# still blocks system_server for 66s -> watchdog -> RescueParty -> boot loop. That is this
# project's worst failure mode and it had no gate at all until now. Read the body back: after a
# successful replace the constructor calls checkService and no longer calls waitForService.
_DQ="$(RESOLVE_SMALI "system" "framework/services.jar" \
    "smali_classes2/com/samsung/android/displayquality/SemDisplayQualityAidlClient.smali")"
[ -f "$_DQ" ] || ABORT "[$TARGET_CODENAME] SemDisplayQualityAidlClient.smali missing - services.jar layout changed"
_DQ_BODY="$(awk '/^\.method.*<init>\(\)V/ {f=1} f{print} f && /^\.end method/ {exit}' "$_DQ")"
[ -n "$_DQ_BODY" ] || ABORT "[$TARGET_CODENAME] SemDisplayQualityAidlClient.<init>()V not found"
grep -q 'ServiceManager;->waitForService' <<< "$_DQ_BODY" \
    && ABORT "[$TARGET_CODENAME] <init> still calls waitForService - the patch did not take, this ROM would boot loop"
grep -q 'ServiceManager;->checkService' <<< "$_DQ_BODY" \
    || ABORT "[$TARGET_CODENAME] <init> calls neither waitForService nor checkService - anchor moved, check by hand"
unset _DQ _DQ_BODY
LOG "- verified: the constructor no longer blocks on the absent HAL"
LOG_STEP_OUT
