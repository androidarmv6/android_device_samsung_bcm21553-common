#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

LOCAL_PATH:= $(call my-dir)

# Kernel
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_PROVIDES_INIT := true
TARGET_PROVIDES_INIT_RC := true

# Recovery
TARGET_RECOVERY_INITRC := device/samsung/bcm21553-common/recovery/recovery.rc
TARGET_RECOVERY_FSTAB := device/samsung/bcm21553-common/recovery/recovery.fstab
BOARD_BML_BOOT := "/dev/block/bml7"
BOARD_BML_RECOVERY := "/dev/block/bml8"
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_RECOVERY_HANDLES_MOUNT := true
BOARD_HAS_DOWNLOAD_MODE := true

# Boot Animation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Platform
TARGET_BOARD_PLATFORM := bcm21553
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv6-vfp
TARGET_CPU_ABI := armeabi-v6l
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT_FPU := vfp
TARGET_ARCH_VARIANT_CPU := arm1136jf-s
#TARGET_BOARD_PLATFORM_GPU := videocoreIV
TARGET_SPECIFIC_HEADER_PATH := device/samsung/bcm21553-common/include
BCM21553_HARDWARE := true

# Touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN := true

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_HAVE_SAMSUNG_AUDIO := true
BOARD_USES_ALSA_AUDIO := true

# RIL
BOARD_USES_LEGACY_RIL := true
BOARD_MOBILEDATA_INTERFACE_NAME := "pdp0"

# Camera
USE_CAMERA_STUB := true
BOARD_V4L2_DEVICE := /dev/video2
BOARD_CAMERA_DEVICE := /dev/video0
BOARD_USE_JPEG := true

# GPU Stuff
BOARD_EGL_CFG := brcm_usrlib/dag/vmcsx/egl.cfg
BOARD_NO_RGBX_8888 := true
#BOARD_NO_32BPP := true
BOARD_LCD_PARTIAL_UPDATES_ENABLED := true
#BOARD_NO_PAGE_FLIPPING := true
COMMON_GLOBAL_CFLAGS += -DNO_RGBX_8888 -DMISSING_EGL_PIXEL_FORMAT_YV12
USE_OPENGL_RENDERER := true

# Minimal Fonts
SMALLER_FONT_FOOTPRINT := true

# USB
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/lm-2/gadget/lun0/file
BOARD_UMS_LUNFILE := "/sys/devices/lm-2/gadget/lun0/file"

# Wifi
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
BOARD_WLAN_DEVICE := bcm4330
BOARD_WLAN_DEVICE_REV := bcm4330

WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/dhd.ko"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/wifi/bcm4330_aps.bin"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/wifi/bcm4330_sta.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/wifi/bcm4330_aps.bin"
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/etc/wifi/bcm4330_sta.bin nvram_path=/system/etc/wifi/nvram.txt"
WIFI_DRIVER_MODULE_NAME := "bcm4330"

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_HAVE_SAMSUNG_BLUETOOTH := true

# Browser
JS_ENGINE := v8
HTTP := chrome
WITH_JIT := true
ENABLE_JSC_JIT := true
TARGET_WEBKIT_USE_MORE_MEMORY := true
TARGET_FORCE_CPU_UPLOAD := true

# FM
#BOARD_HAVE_FM_RADIO := true
#BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO
#BOARD_FM_DEVICE := bcm4329
