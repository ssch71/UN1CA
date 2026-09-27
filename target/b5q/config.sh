#
# Copyright (C) 2024 Salvo Giangreco
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Device configuration file for Galaxy Z Flip5 (b5q)
TARGET_NAME="Galaxy Z Flip5"
TARGET_CODENAME="b5q"
TARGET_PLATFORM="sm8550"
TARGET_FIRMWARE="SM-F731B/EUX/351717180006771"
TARGET_EXTRA_FIRMWARES=()
TARGET_PLATFORM_SDK_VERSION=36

TARGET_COMMON_SUPPORT_DYN_RESOLUTION_CONTROL=true
TARGET_DVFSAPP_CONFIG_SSRM_POLICY_FILENAME="siop_b5q_sm8550"
TARGET_LCD_CONFIG_HFR_MODE="3"
TARGET_WLAN_SUPPORT_MOBILEAP_DUALAP=false

# Device specific
TARGET_LCD_CONFIG_HFR_MODE="3"
TARGET_LCD_CONFIG_SUB_HFR_MODE="2"
TARGET_LCD_CONFIG_SUB_HFR_SUPPORTED_REFRESH_RATE="24,30,48,60,96,120"