# hardware/libaudio-alsa/Android.mk
#
# Copyright 2008 Wind River Systems
#

ifeq ($(BOARD_USES_ALSA_AUDIO),true)
ifneq ($(TARGET_PROVIDES_LIBAUDIO),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
LOCAL_CFLAGS := -D_POSIX_SOURCE

LOCAL_SRC_FILES := \
  AudioHardwareALSA.cpp 	\
  AudioStreamOutALSA.cpp 	\
  AudioStreamInALSA.cpp 	\
  ALSAStreamOps.cpp		\
  audio_hw_hal.cpp

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper \
    libaudiohw_legacy

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia \
    libhardware \
    libc        \
    libpower    \
    libalsa-intf

LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audcal
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-acdb-util
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/libalsa-intf
LOCAL_C_INCLUDES += hardware/libhardware/include
LOCAL_C_INCLUDES += hardware/libhardware_legacy/include
LOCAL_C_INCLUDES += frameworks/base/include
LOCAL_C_INCLUDES += system/core/include

ifeq ($(BOARD_HAVE_SAMSUNG_AUDIO),true)
LOCAL_CFLAGS += -DSAMSUNG_AUDIO
endif

LOCAL_MODULE := audio.primary.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

# This is the ALSA audio policy manager

include $(CLEAR_VARS)

LOCAL_CFLAGS := -D_POSIX_SOURCE

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  LOCAL_CFLAGS += -DWITH_A2DP
endif

LOCAL_SRC_FILES := \
    AudioPolicyManagerALSA.cpp	\
    audio_policy_hal.cpp

LOCAL_MODULE := audio_policy.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper \
    libaudiopolicy_legacy

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia

LOCAL_C_INCLUDES += hardware/libhardware_legacy/audio

include $(BUILD_SHARED_LIBRARY)


# This is the ALSA module which behaves closely like the original

include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_CFLAGS := -D_POSIX_SOURCE -Wno-multichar

ifneq ($(ALSA_DEFAULT_SAMPLE_RATE),)
    LOCAL_CFLAGS += -DALSA_DEFAULT_SAMPLE_RATE=$(ALSA_DEFAULT_SAMPLE_RATE)
endif

LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/libalsa-intf

LOCAL_SRC_FILES:= \
    alsa_default.cpp \
    ALSAControl.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog    \
    libalsa-intf

LOCAL_MODULE:= alsa.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif # TARGET_PROVIDES_LIBAUDIO 
endif # BOARD_USES_ALSA_AUDIO
