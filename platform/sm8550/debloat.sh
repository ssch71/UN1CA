# Copyright (c) 2026 Salvo Giangreco

# SPDX-License-Identifier: GPL-3.0-or-later

# Debloat list for Snapdragon 8 Gen 2 devices (sm8550)
# - Add entries inside the specific partition containing that file (<PARTITION>_DEBLOAT+="")
# - DO NOT add the partition name at the start of any entry (eg. "/system/dpolicy_system")
# - DO NOT add a slash at the start of any entry (eg. "/dpolicy_system")

# GameDriver
SYSTEM_DEBLOAT+="
system/priv-app/GameDriver-SM8450
"

# system_ext cleanup
SYSTEM_EXT_DEBLOAT+="
etc/permissions/com.qti.location.sdk.xml
etc/permissions/com.qualcomm.location.xml
etc/permissions/privapp-permissions-com.qualcomm.location.xml
framework/com.qti.location.sdk.jar
priv-app/com.qualcomm.location
"
