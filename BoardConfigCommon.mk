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

# Custom bootimg (recovery merged into boot ramdisk)
BOARD_CUSTOM_BOOTIMG_MK				:= device/samsung/bcm21553-common/bcm21553-bootimg.mk

# Kernel
BOARD_KERNEL_BASE				:= 0x81600000
BOARD_KERNEL_PAGESIZE				:= 4096
BOARD_NAND_PAGE_SIZE				:= 4096
BOARD_NAND_SPARE_SIZE				:= 128
TARGET_NO_BOOTLOADER				:= true
TARGET_NO_RADIOIMAGE				:= true

# Kernel ramdisk compression tool
MINIGZIP					:= $(shell which lzma)

# Kernel source
TARGET_KERNEL_CUSTOM_TOOLCHAIN			:= arm-eabi-4.4.3
TARGET_KERNEL_SOURCE				:= kernel/samsung/bcm21553-common

# Recovery
ifneq ($(RECOVERY_VARIANT),twrp)
	TARGET_RECOVERY_FSTAB			:= device/samsung/bcm21553-common/recovery/fstab.cm.bcm21553
else
	TARGET_RECOVERY_FSTAB			:= device/samsung/bcm21553-common/recovery/fstab.twrp.bcm21553
endif
BOARD_BML_BOOT					:= "/dev/block/bml7"
BOARD_BML_RECOVERY				:= "/dev/block/bml7"
BOARD_CUSTOM_RECOVERY_KEYMAPPING		:= ../../device/samsung/bcm21553-common/recovery/bcm21553_recovery_keys.c
BOARD_FLASH_BLOCK_SIZE				:= 131072
BOARD_RECOVERY_HANDLES_MOUNT			:= true
BOARD_HAS_DOWNLOAD_MODE				:= true
TARGET_RECOVERY_PIXEL_FORMAT			:= BGRA_8888
TARGET_NO_SEPARATE_RECOVERY			:= true
TARGET_RECOVERY_LCD_BACKLIGHT_PATH		:= \"/sys/class/backlight/aat1401-backlight/brightness\"

# TWRP
ifeq ($(RECOVERY_VARIANT),twrp)
	TW_CUSTOM_CPU_TEMP_PATH := /sys/class/power_supply/battery/batt_temp
	TW_CUSTOM_POWER_BUTTON := 116
	TW_EXCLUDE_MTP := true
	TW_EXCLUDE_SUPERSU := true
	TW_EXCLUDE_ENCRYPTED_BACKUPS := true
	TW_DISABLE_TTF := true
	TW_HAS_DOWNLOAD_MODE := true
	TW_HAS_NO_RECOVERY_PARTITION := true
	TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
	TW_NO_REBOOT_BOOTLOADER := true
	RECOVERY_GRAPHICS_USE_LINELENGTH := true
endif

# Charger mode
BOARD_CHARGER_RES				:= device/samsung/bcm21553-common/prebuilt/res/charger
BOARD_CHARGING_CMDLINE_NAME			:= "BOOT_MODE"
BOARD_CHARGING_CMDLINE_VALUE			:= "1"
BOARD_CHARGING_CMDLINE_RECOVERY_VALUE		:= "4"

# Health daemon
BOARD_HAL_STATIC_LIBRARIES			:= libhealthd.bcm21553

# Boot Animation
TARGET_BOOTANIMATION_PRELOAD			:= true
TARGET_BOOTANIMATION_TEXTURE_CACHE		:= true

# Platform
TARGET_BOARD_PLATFORM				:= bcm21553
TARGET_ARCH					:= arm
TARGET_ARCH_LOWMEM				:= true
TARGET_ARCH_VARIANT				:= armv6-vfp
TARGET_CPU_ABI					:= armeabi
TARGET_CPU_ABI2					:= armeabi-v6l
TARGET_CPU_VARIANT				:= arm11
TARGET_ARCH_VARIANT_FPU				:= vfp
TARGET_ARCH_VARIANT_CPU				:= arm1136jf-s
#TARGET_BOARD_PLATFORM_GPU			:= videocoreIV
ARCH_ARM_HAVE_TLS_REGISTER			:= true
TARGET_SPECIFIC_HEADER_PATH			:= device/samsung/bcm21553-common/include
BCM21553_HARDWARE				:= true
BOARD_USES_BROADCOM_HARDWARE			:= true
COMMON_GLOBAL_CFLAGS				+= -DBCM_HARDWARE

# Touchscreen
BOARD_USE_LEGACY_TOUCHSCREEN			:= true

# Audio
BOARD_USES_GENERIC_AUDIO			:= false

# RIL
BOARD_USES_LEGACY_RIL				:= true
BOARD_MOBILEDATA_INTERFACE_NAME			:= "pdp0"

# Camera
USE_CAMERA_STUB					:= false
BOARD_NEEDS_MEMORYHEAPPMEM			:= true
BOARD_CAMERA_HAVE_ISO				:= true
BOARD_CAMERA_NO_UNWANTED_MSG			:= true
BOARD_CAMERA_USE_GETBUFFERINFO			:= true
BOARD_USE_CAF_LIBCAMERA_GB_REL			:= true
BOARD_USE_NASTY_PTHREAD_CREATE_HACK		:= true
COMMON_GLOBAL_CFLAGS				+= -DNEEDS_VECTORIMPL_SYMBOLS
COMMON_GLOBAL_CFLAGS				+= -DSAMSUNG_CAMERA_LEGACY
COMMON_GLOBAL_CFLAGS 				+= -DBINDER_COMPAT

# GPU Stuff
BOARD_EGL_CFG					:= hardware/broadcom/brcm_usrlib/dag/vmcsx/egl.cfg
BOARD_USE_MHEAP_SCREENSHOT			:= true
HWUI_COMPILE_FOR_PERF				:= true
TARGET_DOESNT_USE_FENCE_SYNC			:= true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK		:= true
USE_OPENGL_RENDERER				:= true
COMMON_GLOBAL_CFLAGS				+= -DEGL_NEEDS_FNW
BOARD_NO_PAGE_FLIPPING				:= true


# Minimal Fonts
SMALLER_FONT_FOOTPRINT				:= true

# USB
TARGET_USE_CUSTOM_LUN_FILE_PATH			:= /sys/devices/lm-2/gadget/lun0/file
BOARD_UMS_LUNFILE				:= "/sys/devices/lm-2/gadget/lun0/file"

# Wifi
BOARD_WPA_SUPPLICANT_DRIVER			:= WEXT
WPA_SUPPLICANT_VERSION				:= VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB		:= lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE				:= bcm4330
BOARD_WLAN_DEVICE_REV				:= bcm4330_b1_totoro

WIFI_DRIVER_MODULE_PATH				:= "/system/lib/modules/bcmdhd.ko"
WIFI_DRIVER_FW_PATH_AP				:= "/system/etc/firmware/bcm4330_aps.bin"
WIFI_DRIVER_FW_PATH_STA				:= "/system/etc/firmware/bcm4330_sta.bin"
WIFI_DRIVER_FW_PATH_P2P				:= "/system/etc/firmware/bcm4330_aps.bin"
WIFI_DRIVER_MODULE_ARG				:= "firmware_path=/system/etc/firmware/bcm4330_sta.bin nvram_path=/system/etc/firmware/nvram.txt"
WIFI_DRIVER_MODULE_NAME				:= "bcmdhd"

# Wifi AP
USE_LEGACY_SOFTAP				:= true

# Bluetooth
BOARD_BLUEDROID_VENDOR_CONF			:= device/samsung/bcm21553-common/bluetooth/vnd_samsung.txt
BOARD_HAVE_BLUETOOTH				:= true
BOARD_HAVE_BLUETOOTH_BCM			:= true
BOARD_HAVE_SAMSUNG_BLUETOOTH			:= true

# Browser
JS_ENGINE					:= v8
HTTP						:= chrome
WITH_JIT					:= true
ENABLE_JSC_JIT					:= true
TARGET_WEBKIT_USE_MORE_MEMORY			:= true
TARGET_FORCE_CPU_UPLOAD				:= true

# FM
#BOARD_HAVE_FM_RADIO				:= true
#BOARD_FM_DEVICE				:= bcm4329
#BOARD_GLOBAL_CFLAGS+= -DHAVE_FM_RADIO

## TEMPORARY HACK: skip building external/chromium_org/
PRODUCT_PREBUILT_WEBVIEWCHROMIUM 		:= yes

# Squisher
TARGET_SYSTEMIMAGE_USE_SQUISHER			:= true

# Releasetools extras
TARGET_OTA_EXTRAS_FILE				:= device/samsung/bcm21553-common/releasetools-extras.txt

# zRAM size
BOARD_ZRAM_SIZE					:= 50331648

# SELinux
POLICYVERS					:= 24
