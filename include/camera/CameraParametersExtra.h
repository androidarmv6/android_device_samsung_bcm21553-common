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
const char CameraParameters::FOCUS_MODE_FACEDETECT[] = "facedetect"; \
const char CameraParameters::FOCUS_MODE_TOUCHAF[] = "touchaf"; \
const char CameraParameters::ISO_50[] = "ISO50"; \
const char CameraParameters::KEY_ANTI_SHAKE_MODE[] = "antishake"; \
const char CameraParameters::KEY_AUTO_CONTRAST[] = "auto-contrast"; \
const char CameraParameters::KEY_BEAUTY_MODE[] = "beauty"; \
const char CameraParameters::KEY_BLUR_MODE[] = "blur"; \
const char CameraParameters::KEY_VINTAGE_MODE[] = "vintagemode"; \
const char CameraParameters::KEY_WDR_MODE[] = "wdr"; \
const char CameraParameters::VINTAGE_MODE_BNW[] = "bnw"; \
const char CameraParameters::VINTAGE_MODE_COOL[] = "cool"; \
const char CameraParameters::VINTAGE_MODE_NORMAL[] = "normal"; \
const char CameraParameters::VINTAGE_MODE_OFF[] = "off"; \
const char CameraParameters::VINTAGE_MODE_WARM[] = "warm"; \
const char CameraParameters::SCENE_MODE_DAWN[] = "dusk-dawn"; \
const char CameraParameters::SCENE_MODE_DUSKDAWN[] = "dusk-dawn"; \
const char CameraParameters::SCENE_MODE_FALL[] = "fall-color"; \
const char CameraParameters::SCENE_MODE_FALL_COLOR[] = "fall-color"; \
const char CameraParameters::SCENE_MODE_TEXT[] = "text"; \
const char CameraParameters::KEY_MAX_CONTRAST[] = "max-contrast"; \
const char CameraParameters::KEY_MAX_SATURATION[] = "max-saturation"; \
const char CameraParameters::KEY_MAX_SHARPNESS[] = "max-sharpness"; \
const char CameraParameters::KEY_CAM_DTP_MODE[] = "chk_dataline"; \
const char CameraParameters::KEY_CAM_MODE[] = "mode"; \
int CameraParameters::getMode() const { return 0; }

#define CAMERA_PARAMETERS_EXTRA_H \
static const char FOCUS_MODE_FACEDETECT[]; \
static const char FOCUS_MODE_TOUCHAF[]; \
static const char ISO_50[]; \
static const char KEY_ANTI_SHAKE_MODE[]; \
static const char KEY_AUTO_CONTRAST[]; \
static const char KEY_BEAUTY_MODE[]; \
static const char KEY_BLUR_MODE[]; \
static const char KEY_VINTAGE_MODE[]; \
static const char KEY_WDR_MODE[]; \
static const char VINTAGE_MODE_BNW[]; \
static const char VINTAGE_MODE_COOL[]; \
static const char VINTAGE_MODE_NORMAL[]; \
static const char VINTAGE_MODE_OFF[]; \
static const char VINTAGE_MODE_WARM[]; \
static const char SCENE_MODE_DAWN[]; \
static const char SCENE_MODE_DUSKDAWN[]; \
static const char SCENE_MODE_FALL[]; \
static const char SCENE_MODE_FALL_COLOR[]; \
static const char SCENE_MODE_TEXT[]; \
static const char KEY_MAX_CONTRAST[]; \
static const char KEY_MAX_SATURATION[]; \
static const char KEY_MAX_SHARPNESS[]; \
static const char KEY_CAM_DTP_MODE[]; \
static const char KEY_CAM_MODE[]; \
int getMode() const;
