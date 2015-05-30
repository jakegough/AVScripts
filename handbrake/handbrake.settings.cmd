SET HANDBRAKE_SEARCH_PATH=%PROGRAMFILES%\Handbrake\
IF "%HANDBRAKE_CLI_EXE%" == "" SET PATH=%PATH%;%HANDBRAKE_SEARCH_PATH%;
SET HANDBRAKE_CLI_EXE=HandBrakeCLI.exe

SET HANDBRAKE_X264_PRESET=medium
SET HANDBRAKE_X264_PROFILE=main
SET HANDBRAKE_X264_LEVEL=3.0

SET DEFAULT_X264_CRF_LOW=30
SET DEFAULT_X264_CRF_STD=23
SET DEFAULT_X264_CRF_HQ=20
SET DEFAULT_X264_CRF_VHQ=16

SET RES_240p_W=360
SET RES_240p_H=240
SET RES_240p_X264_CRF_LOW=
SET RES_240p_X264_CRF_STD=23
SET RES_240p_X264_CRF_HQ=17
SET RES_240p_X264_CRF_VHQ=10

SET RES_360p_W=540
SET RES_360p_H=360
SET RES_360p_X264_CRF_LOW=
SET RES_360p_X264_CRF_STD=24
SET RES_360p_X264_CRF_HQ=17
SET RES_360p_X264_CRF_VHQ=11

SET RES_480p_W=720
SET RES_480p_H=480
SET RES_480p_X264_CRF_LOW=
SET RES_480p_X264_CRF_STD=23
SET RES_480p_X264_CRF_HQ=18
SET RES_480p_X264_CRF_VHQ=12

SET RES_720p_W=1280
SET RES_720p_H=720
SET RES_720p_X264_CRF_LOW=
SET RES_720p_X264_CRF_STD=26
SET RES_720p_X264_CRF_HQ=23
SET RES_720p_X264_CRF_VHQ=20

SET RES_1080p_W=1920
SET RES_1080p_H=1080
SET RES_1080p_X264_CRF_LOW=
SET RES_1080p_X264_CRF_STD=28
SET RES_1080p_X264_CRF_HQ=26
SET RES_1080p_X264_CRF_VHQ=23