#
# Copyright (C) 2012 The Android Open-Source Project
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
#

# Target
TARGET_ARCH            := arm
TARGET_ARCH_LOWMEM     := true
TARGET_ARCH_VARIANT    := armv6-vfp
TARGET_BOARD_PLATFORM  := msm7x27
TARGET_CPU_ABI         := armeabi
TARGET_CPU_ABI2        := armeabi-v6l
TARGET_CPU_VARIANT     := arm11
TARGET_NO_BOOTLOADER   := true
TARGET_NO_RADIOIMAGE   := true
COMMON_GLOBAL_CFLAGS   += -DTARGET_MSM7x27

# For assembly error
#COMMON_GLOBAL_CFLAGS   += --save-temps

# Graphics
USE_OPENGL_RENDERER                     := true
TARGET_NO_HW_OVERLAY                    := true
TARGET_QCOM_DISPLAY_VARIANT             := legacy
BOARD_ADRENO_DECIDE_TEXTURE_TARGET      := true
#BOARD_EGL_CFG                           := device/qcom/msm7x27/egl.cfg
BOARD_EGL_NEEDS_LEGACY_FB               := true
BOARD_EGL_WORKAROUND_BUG_10194508       := true
BOARD_USE_MHEAP_SCREENSHOT              := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE                := true
BOARD_USES_QCOM_LIBS                    := true
COMMON_GLOBAL_CFLAGS                    += -DQCOM_HARDWARE
#COMMON_GLOBAL_CFLAGS                    += -DQCOM_ICS_COMPAT

# Video
TARGET_QCOM_LEGACY_OMX                  := true
TARGET_QCOM_MEDIA_VARIANT               := legacy
TARGET_ENABLE_QC_AV_ENHANCEMENTS        := true
COMMON_GLOBAL_CFLAGS                    += -DQCOM_NO_SECURE_PLAYBACK

# Camera
TARGET_DISABLE_ARM_PIE          := true
BOARD_NEEDS_MEMORYHEAPPMEM      := true

# Javascript, Browser and Webkit
WITH_JIT                := true
ENABLE_JSC_JIT          := true
JS_ENGINE               := v8
HTTP                    := chrome
TARGET_FORCE_CPU_UPLOAD := true

# Squisher
TARGET_SYSTEMIMAGE_USE_SQUISHER := true
