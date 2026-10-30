# Copyright (c) 2025 Salvo Giangreco
# SPDX-License-Identifier: GPL-3.0-or-later

# Overlays
SYSTEM_DEBLOAT+="
system/app/WifiRROverlayAppH2E
system/app/WifiRROverlayAppQC
system/app/WifiRROverlayAppWifiLock
"
PRODUCT_DEBLOAT+="
overlay/SoftapOverlay6GHz
overlay/SoftapOverlayDualAp
overlay/SoftapOverlayOWE
"

# mAFPC
SYSTEM_DEBLOAT+="
system/bin/mafpc_write
"

#MobileFeliCaMenu
SYSTEM_DEBLOAT+="
system/priv-app/MobileFeliCaMenuMainApp
system/priv-app/MobileFeliCaSettingApp
system/priv-app/MobileFeliCaWebPluginBoot
"

# Google
PRODUCT_DEBLOAT+="
priv-app/Velvet
"

# GameDriver
SYSTEM_DEBLOAT+="
system/priv-app/GameDriver-SM8550
"

# system_ext clean-up
SYSTEM_DEBLOAT+="
system/etc/permissions/org.carconnectivity.android.digitalkey.rangingintent.xml
system/etc/permissions/org.carconnectivity.android.digitalkey.secureelement.xml
"
SYSTEM_EXT_DEBLOAT+="
app/QCC
bin/qccsyshal@1.2-service
etc/init/vendor.qti.hardware.qccsyshal@1.2-service.rc
etc/permissions/com.qti.location.sdk.xml
etc/permissions/com.qualcomm.location.xml
etc/permissions/privapp-permissions-com.qualcomm.location.xml
framework/com.qti.location.sdk.jar
framework/org.carconnectivity.android.digitalkey.rangingintent.jar
framework/org.carconnectivity.android.digitalkey.secureelement.jar
lib/libqcc.so
lib/libqccdme.so
lib/libqccfileservice.so
lib/vendor.qti.hardware.qccsyshal@1.0.so
lib/vendor.qti.hardware.qccsyshal@1.1.so
lib/vendor.qti.hardware.qccsyshal@1.2.so
lib/vendor.qti.hardware.qccvndhal@1.0.so
lib/vendor.qti.qccvndhal_aidl-V1-ndk.so
lib64/libqcc.so
lib64/libqccdme.so
lib64/libqccfileservice.so
lib64/vendor.qti.hardware.qccsyshal@1.0.so
lib64/vendor.qti.hardware.qccsyshal@1.1.so
lib64/vendor.qti.hardware.qccsyshal@1.2-halimpl.so
lib64/vendor.qti.hardware.qccsyshal@1.2.so
lib64/vendor.qti.hardware.qccvndhal@1.0.so
lib64/vendor.qti.qccvndhal_aidl-V1-ndk.so
priv-app/com.qualcomm.location
priv-app/com.qualcomm.qti.services.systemhelper
"

SYSTEM_DEBLOAT+="
system/etc/default-permissions/default-permissions-com.samsung.android.service.aircommand.xml
system/etc/permissions/privapp-permissions-com.samsung.android.app.readingglass.xml
system/etc/permissions/privapp-permissions-com.samsung.android.service.aircommand.xml
system/etc/permissions/privapp-permissions-com.samsung.android.service.airviewdictionary.xml
system/etc/sysconfig/airviewdictionaryservice.xml
system/media/audio/pensounds
"

# SKT,KT,LG
SYSTEM_DEBLOAT+="
system/app/KTAuth_Stub
system/app/KTCustomerService
system/app/LGUMiniCustomerCenter
system/app/LGUplusTsmProxy
system/app/SKTMemberShip_new
system/app/TWorld
system/priv-app/KTOneStore
system/priv-app/KTServiceAgent
system/priv-app/KTServiceMenu
system/priv-app/LGUOZStore
system/priv-app/OneStoreService
system/priv-app/SKTOneStore
system/priv-app/TPhoneOnePackage
system/priv-app/TService
"

#I don't need
SYSTEM_DEBLOAT+="
system/app/BookmarkProvider
system/app/Fast
system/app/KidsHome_Installer
system/app/Rampart
system/app/SmartManager_v6_DeviceSecurity
system/priv-app/AREmoji
system/priv-app/HybridRadio
system/priv-app/QRreader
system/priv-app/SOAgent77
system/priv-app/SPPPushClient
system/priv-app/SamsungMagnifier3
system/priv-app/SwiftkeyIme
system/priv-app/SwiftkeySetting
"