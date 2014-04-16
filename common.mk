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

# Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS := device/samsung/bcm21553-common/overlay

TARGET_SPECIFIC_HEADER_PATH := device/samsung/bcm21553-common/include

## HW drivers
PRODUCT_PACKAGES += \
    libGLES_hgl \
    hwcomposer.bcm21553 \
    gralloc.bcm21553

## Audio
PRODUCT_PACKAGES += \
    audio.primary.bcm21553 \
    audio_policy.bcm21553 \
    libtinyalsa \
    audio.a2dp.default \
    libaudioutils

## Video decoding
PRODUCT_PACKAGES += \
    libstagefrighthw \
    libopencorehw \
    libmm-omxcore \
    libOmxCore

## Other
PRODUCT_PACKAGES += \
    FileManager \
    setup_fs

## These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

## Keylayout
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/bcm_headset.kl:system/usr/keylayout/bcm_headset.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_key.kl:system/usr/keylayout/sec_key.kl \
    device/samsung/bcm21553-common/prebuilt/usr/keylayout/sec_keypad.kl:system/usr/keylayout/sec_keypad.kl

## Keychars
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/samsung/bcm21553-common/prebuilt/usr/keychars/sec_key.kcm.bin:system/usr/keychars/sec_key.kcm.bin

## Media
#PRODUCT_COPY_FILES += \
#    device/samsung/bcm21553-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml
#    device/samsung/bcm21553-common/prebuilt/etc/asound.conf:system/etc/asound.conf

## HW Drivers
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg

## WIFI
PRODUCT_COPY_FILES += \
    device/samsung/bcm21553-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    device/samsung/bcm21553-common/prebuilt/bin/get_macaddrs:system/bin/get_macaddrs

## Graphics properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    debug.enabletr=false \
    debug.composition.type=mdp \
    debug.gr.numframebuffers=2 \
    debug.qctwa.statusbar=1 \
    debug.qctwa.preservebuf=1 \
    debug.performance.tuning=1 \
    hwui.render_dirty_regions=false \
    hwui.disable_vsync=true \
    hwui.print_config=choice \
    persist.sys.strictmode.visual=false \
    persist.sys.use_dithering=1

PRODUCT_PROPERTY_OVERRIDES += \
    video.accelerate.hw=1 \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=false \
    media.stagefright.enable-scan=false \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true

## Samsung RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=SamsungRIL \
    mobiledata.interfaces=pdp0,eth0,gprs,ppp0

## We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
