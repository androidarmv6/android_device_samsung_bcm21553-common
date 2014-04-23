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

# Add common package overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/bcm21553-common/overlay

TARGET_SPECIFIC_HEADER_PATH := device/samsung/bcm21553-common/include

# These are the hardware-specific configuration files
PRODUCT_COPY_FILES := \
    device/samsung/bcm21553-common/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/samsung/bcm21553-common/prebuilt/etc/bluetooth/main.conf:system/etc/bluetooth/main.conf

# Init files
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/ramdisk/init.rc:root/init.rc \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.rc:root/init.bcm21553.rc \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.gps.rc:root/init.bcm21553.gps.rc \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.wifi.rc:root/init.bcm21553.wifi.rc \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.usb.rc:root/init.bcm21553.usb.rc \
    device/samsung/bcm21553-common/ramdisk/init.charge.rc:root/init.charge.rc \
    device/samsung/bcm21553-common/ramdisk/ueventd.bcm21553.rc:root/ueventd.bcm21553.rc \
    device/samsung/bcm21553-common/ramdisk/init:root/init \
    device/samsung/bcm21553-common/ramdisk/adbd:root/sbin/adbd \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.usb.rc:recovery/root/usb.rc \
    device/samsung/bcm21553-common/ramdisk/init.bcm21553.fs.rc:recovery/root/fs.rc \
    device/samsung/bcm21553-common/ramdisk/init:recovery/root/init \
    device/samsung/bcm21553-common/ramdisk/adbd:recovery/root/sbin/adbd

# HW drivers
PRODUCT_PACKAGES += \
    libGLES_hgl \
    hwcomposer.bcm21553 \
    gralloc.bcm21553

# Audio
PRODUCT_PACKAGES += \
    audio.primary.bcm21553 \
    audio_policy.bcm21553 \
    libtinyalsa \
    audio.a2dp.default \
    libaudioutils

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

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.software.sip.xml:system/etc/permissions/android.software.sip.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
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

# Media
#PRODUCT_COPY_FILES += \
#    device/samsung/bcm21553-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml
#    device/samsung/bcm21553-common/prebuilt/etc/asound.conf:system/etc/asound.conf

# WIFI
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/bcm21553-common/prebuilt/bin/get_macaddrs:system/bin/get_macaddrs

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# Graphics properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    debug.enabletr=false \
    debug.composition.type=gpu \
    hwui.render_dirty_regions=true \
    hwui.disable_vsync=true \
    hwui.print_config=choice \
    persist.sys.strictmode.visual=false \
    persist.sys.use_dithering=0

# Misc. Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lge.proximity.delay=25 \
    mot.proximity.delay=25 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=true \
    media.stagefright.enable-scan=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-record=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapgrowthlimit=36m \
    dalvik.vm.heapsize=64m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.debug.alloc=0 \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.telephony.call_ring.delay=0 \
    ro.ril.disable.power.collapse=0

# Wifi interface
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=15

# USB / SD card
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=adb,mass_storage \
    persist.service.adb.enable=1 \
    ro.vold.umsdirtyratio=20

# Memory
PRODUCT_PROPERTY_OVERRIDES += \
    ro.HOME_APP_ADJ=1

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
    wifi.interface=eth0 \
    mobiledata.interfaces=pdp0,eth0,gprs,ppp0

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
