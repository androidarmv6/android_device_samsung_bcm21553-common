LOCAL_PATH := $(call my-dir)

$(INSTALLED_RAMDISK_TARGET): $(MKBOOTFS) $(INTERNAL_RAMDISK_FILES) $(recovery_ramdisk) | $(MINIGZIP)
	$(hide) mkdir -p $(TARGET_ROOT_OUT)/merge
	$(hide) cp -a $(TARGET_RECOVERY_ROOT_OUT)/* $(TARGET_ROOT_OUT)/merge/
	$(hide) mv $(TARGET_ROOT_OUT)/merge/default.prop $(TARGET_ROOT_OUT)/default.prop.recovery
	$(hide) mv $(TARGET_ROOT_OUT)/merge/init.rc $(TARGET_ROOT_OUT)/recovery.rc
	$(hide) cp -a $(TARGET_ROOT_OUT)/merge/* $(TARGET_ROOT_OUT)/
	$(hide) rm -r $(TARGET_ROOT_OUT)/merge
	$(call pretty,"Target ram disk [boot & recovery merged]: $@")
	$(hide) $(MKBOOTFS) $(TARGET_ROOT_OUT) | $(MINIGZIP) > $@

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

.PHONY: bootimage-nodeps
bootimage-nodeps: $(MKBOOTIMG)
	@echo "make $@: ignoring dependencies"
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $(INSTALLED_BOOTIMAGE_TARGET)
	$(hide) $(call assert-max-image-size,$(INSTALLED_BOOTIMAGE_TARGET),$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	@echo -e ${CL_INS}"Made boot image: $@"${CL_RST}

$(INSTALLED_RECOVERYIMAGE_TARGET): $(INSTALLED_BOOTIMAGE_TARGET)
	$(ACP) $(INSTALLED_BOOTIMAGE_TARGET) $@
