# Copyright (C) 2008 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SHARED_LIBRARIES := liblog libEGL libc libGLESv1_CM libv3d
LOCAL_SRC_FILES := hwcomposer.cpp

LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES += \
		device/samsung/bcm21553-common/libgralloc \
		hardware/broadcom/brcm_usrlib/dag/v3d_library/inc \
		hardware/common/opencore/codec/include 

LOCAL_CFLAGS += -DDIRECT_RENDERING

LOCAL_MODULE := hwcomposer.$(TARGET_BOARD_PLATFORM)
LOCAL_CFLAGS:= -DLOG_TAG=\"hwcomposer\"
LOCAL_MODULE_TAGS := eng

include $(BUILD_SHARED_LIBRARY)
