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
TARGET_FIRMWARE="SM-F731N/KOO/359222391422026"
TARGET_EXTRA_FIRMWARES=()
TARGET_PLATFORM_SDK_VERSION=36

# SEC Product Feature
TARGET_COMMON_SUPPORT_DYN_RESOLUTION_CONTROL=false
TARGET_DVFSAPP_CONFIG_SSRM_POLICY_FILENAME="siop_b5q_sm8550"
TARGET_WLAN_CONFIG_CUSTOM_BACKOFF="CAM_FRONT -1 -1 -1 -1 12 8 CAM_BACK -1 -1 -1 -1 12 8"