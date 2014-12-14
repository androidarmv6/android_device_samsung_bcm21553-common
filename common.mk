# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## SAMSUNG_BOOTLOADER is the product model changed into appropriate string parsed by init.
## Example: -GT-I5500 becomes gt-i5500board, -GT-S5830 becomes gt-s5830board, and so on.
SAMSUNG_BOOTLOADER := $(shell echo $(PRODUCT_VERSION_DEVICE_SPECIFIC)board | tr '[A-Z]' '[a-z]' | cut -c 2-)

# Add common package overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/bcm21553-common/overlay

TARGET_SPECIFIC_HEADER_PATH := device/samsung/bcm21553-common/include

# These are the hardware-specific configuration files

## Ramdisk
PRODUCT_PACKAGES += \
	fstab.$(SAMSUNG_BOOTLOADER) \
	init.$(SAMSUNG_BOOTLOADER).rc \
	init.$(SAMSUNG_BOOTLOADER).bt.rc \
	init.$(SAMSUNG_BOOTLOADER).fs.rc \
	init.$(SAMSUNG_BOOTLOADER).gps.rc \
	init.$(SAMSUNG_BOOTLOADER).sensors.rc \
	init.$(SAMSUNG_BOOTLOADER).swapart.rc \
	init.$(SAMSUNG_BOOTLOADER).usb.rc \
	init.$(SAMSUNG_BOOTLOADER).wifi.rc \
	init.recovery.$(SAMSUNG_BOOTLOADER).rc \
	ueventd.$(SAMSUNG_BOOTLOADER).rc

# Audio
PRODUCT_PACKAGES += \
    audio.primary.bcm21553 \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default

# Camera
PRODUCT_PACKAGES += \
    camera.bcm21553

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# HW drivers
PRODUCT_PACKAGES += \
    libGLES_hgl \
    gralloc.bcm21553 \
    hwcomposer.bcm21553

# Lights
PRODUCT_PACKAGES += \
    lights.bcm21553

# Video decoding
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libopencorehw \
    libmm-omxcore \
    libOmxCore

# Other
PRODUCT_PACKAGES += \
    CMFileManager \
    make_ext4fs \
    setup_fs

# Device-specific packages
PRODUCT_PACKAGES += \
    SamsungServiceMode

# Usb accessory
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# swapart binary
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/bin/swapart:system/bin/swapart

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Keylayout
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/bcm_headset.kl:system/usr/keylayout/bcm_headset.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_key.kl:system/usr/keylayout/sec_key.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_keypad.kl:system/usr/keylayout/sec_keypad.kl

# Keychars
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/sec_key.kcm.bin:system/usr/keychars/sec_key.kcm.bin

# Audio mixer paths
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/mixer_paths.xml:system/etc/mixer_paths.xml

# Audio policy
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf

# Media codecs
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

# Media profiles
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# WIFI
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/bcm21553-common/prebuilt/bin/get_macaddrs:system/bin/get_macaddrs

# SELinux
BOARD_SEPOLICY_DIRS += device/samsung/bcm21553-common/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts

# Touchscreen
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/usr/idc/sec_touchscreen.idc:system/usr/idc/sec_touchscreen.idc \
    device/samsung/bcm21553-common/prebuilt/usr/idc/synaptics-rmi-touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# Graphics properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false \
    debug.sf.no_hw_vsync=1 \
    persist.sys.prefer_16bpp=1 \
    ro.hwui.layer_cache_size=0 \
    ro.opengles.surface.rgba8888=true \
    ro.systemui.use_gl_wallpaper=0 \
    ro.zygote.disable_gl_preload=true

## Graphics density
ifneq (,$(filter cooperve,$(CM_BUILD)))
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120
endif

# Memory
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.purgeable_assets=1 \
    ro.config.low_ram=true

# Reduce background apps limit to 12 on low-tier devices
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.fw.bg_apps_limit=12

# Set max background services
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.max_starting_bg=6

# Stagefright
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=false \
    media.stagefright.enable-scan=false \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libbrcm_ril.so \
    ro.ril.disable.power.collapse=0 \
    ro.ril.gprsclass=10 \
    ro.ril.hsxpa=1 \
    ro.telephony.call_ring.delay=0 \
    ro.telephony.default_network=0

# Wifi interface
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.ap.interface=wl0.1 \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=60

# USB / SD card
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=adb,mass_storage \
    persist.service.adb.enable=1 \
    ro.vold.umsdirtyratio=20

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=false \
    ro.kernel.android.checkjni=0

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=pdp0,eth0,gprs,ppp0

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# WebKit
PRODUCT_PACKAGES += \
    libwebcore

# Webkit (classic webview provider)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.webview.provider=classic

$(call inherit-product, frameworks/native/build/phone-hdpi-dalvik-heap.mk)
# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Install/Uninstall google apps
$(call inherit-product, vendor/google/gapps_armv6_tiny.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# GPS
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

