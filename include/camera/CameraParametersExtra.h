/*
 * Copyright (C) 2014 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define CAMERA_PARAMETERS_EXTRA_C \
const char CameraParameters::AUTO_EXPOSURE_CENTER_WEIGHTED[] = "center-weighted"; \
const char CameraParameters::AUTO_EXPOSURE_FRAME_AVG[] = "frame-average"; \
const char CameraParameters::AUTO_EXPOSURE_SPOT_METERING[] = "spot-metering"; \
const char CameraParameters::FOCUS_MODE_NORMAL[] = "normal"; \
const char CameraParameters::ISO_100[] = "ISO100"; \
const char CameraParameters::ISO_200[] = "ISO200"; \
const char CameraParameters::ISO_400[] = "ISO400"; \
const char CameraParameters::ISO_50[] = "ISO50"; \
const char CameraParameters::ISO_AUTO[] = "auto"; \
const char CameraParameters::KEY_AUTO_EXPOSURE[] = "metering"; \
const char CameraParameters::KEY_CAM_DTP_MODE[] = "chk_dataline"; \
const char CameraParameters::KEY_CAM_MODE[] = "mode"; \
const char CameraParameters::KEY_SUPPORTED_AUTO_EXPOSURE[] = "auto-exposure-values"; \
const char CameraParameters::SCENE_MODE_BACKLIGHT[] = "back-light"; \
const char CameraParameters::SCENE_MODE_DUSKDAWN[] = "dusk-dawn"; \
const char CameraParameters::SCENE_MODE_FALL[] = "fall-color"; \
int CameraParameters::getMode() const { return 0; }

#define CAMERA_PARAMETERS_EXTRA_H \
static const char AUTO_EXPOSURE_CENTER_WEIGHTED[]; \
static const char AUTO_EXPOSURE_FRAME_AVG[]; \
static const char AUTO_EXPOSURE_SPOT_METERING[]; \
static const char FOCUS_MODE_NORMAL[]; \
static const char ISO_100[]; \
static const char ISO_200[]; \
static const char ISO_400[]; \
static const char ISO_50[]; \
static const char ISO_AUTO[]; \
static const char KEY_AUTO_EXPOSURE[]; \
static const char KEY_CAM_DTP_MODE[]; \
static const char KEY_CAM_MODE[]; \
static const char KEY_SUPPORTED_AUTO_EXPOSURE[]; \
static const char SCENE_MODE_BACKLIGHT[]; \
static const char SCENE_MODE_DUSKDAWN[]; \
static const char SCENE_MODE_FALL[]; \
int getMode() const;
