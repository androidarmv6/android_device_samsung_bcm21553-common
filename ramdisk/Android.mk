LOCAL_PATH:= $(call my-dir)

#######################################
# fstab.gt-xxxxx

include $(CLEAR_VARS)
LOCAL_MODULE		:= fstab.$(SAMSUNG_BOOTLOADER)
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= fstab.bcm21553
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

$(LOCAL_BUILT_MODULE): $(LOCAL_PATH)/$(LOCAL_SRC_FILES)
	@echo "Adjust init rc script for $(SAMSUNG_BOOTLOADER): $< -> $@"
	@mkdir -p $(dir $@)
	$(hide) sed -e 's/fstab.bcm21553/fstab.$(SAMSUNG_BOOTLOADER)/g' -e 's/init.bcm21553/init.$(SAMSUNG_BOOTLOADER)/g' $< >$@

#######################################
# init.gt-xxxxx.bt.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).bt.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.bt.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.fs.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).fs.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.fs.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.gps.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).gps.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.gps.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.usb.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).usb.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.usb.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.wifi.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).wifi.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.wifi.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.recovery.gt-xxxxx.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.recovery.$(SAMSUNG_BOOTLOADER).rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.recovery.bcm21553.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

$(LOCAL_BUILT_MODULE): $(LOCAL_PATH)/$(LOCAL_SRC_FILES)
	@echo "Adjust init rc script for $(SAMSUNG_BOOTLOADER): $< -> $@"
	@mkdir -p $(dir $@)
	$(hide) sed -e 's/fstab.bcm21553/fstab.$(SAMSUNG_BOOTLOADER)/g' -e 's/init.bcm21553/init.$(SAMSUNG_BOOTLOADER)/g' $< >$@

#######################################
# init.gt-xxxxx.sensors.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).sensors.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.sensors.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# init.gt-xxxxx.swapart.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= init.$(SAMSUNG_BOOTLOADER).swapart.rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= init.bcm21553.swapart.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
# ueventd.gt-xxxxx.rc

include $(CLEAR_VARS)
LOCAL_MODULE		:= ueventd.$(SAMSUNG_BOOTLOADER).rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES		:= ueventd.bcm21553.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
