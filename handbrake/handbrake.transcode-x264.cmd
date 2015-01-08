:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a x264 mp4 video
::  2) call this script from another script with any of the environment varialbes already set:
::     � HANDBRAKE_INPUT_FILE_VIDEO
::     � HANDBRAKE_INPUT_FILE_SUBTITLES
::     � HANDBRAKE_OUTPUT_FILE
::     � RESOLUTION
::         240p, 360p, 480p, 720p, 1080p
::     � RESOLUTION_QUALITY
::         LOW, STD, HQ, VHQ
::         uses CRF appropriate for RESOLUTION
::         (pro tip: use STD for Full resolution like 1280x720, HQ for narrower aspect like 404x720)
::     � HANDBRAKE_VIDEO_W
::         ignored if RESOLUTION provided
::     � HANDBRAKE_VIDEO_H
::         ignored if RESOLUTION provided
::     � HANDBRAKE_X264_QUALITY_CRF
::         0-51: where 0 is lossless, 23 is default, and 51 is worst possible
::     � HANDBRAKE_X264_PRESET
::         ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
::     � HANDBRAKE_X264_TUNE
::         film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
::     � HANDBRAKE_FRAME_RATE
::         5/10/12/15/23.976/24/25/29.97/30/50/59.94/60
::     � HANDBRAKE_X264_PROFILE
::     � HANDBRAKE_X264_LEVEL
::     � HANDBRAKE_SKIP_AUDIO
::     � HANDBRAKE_CLIP_START
::     � HANDBRAKE_CLIP_DURATION

setlocal

call "%~dp0.\handbrake.settings.cmd"

if "%HANDBRAKE_INPUT_FILE_VIDEO%"=="" set HANDBRAKE_INPUT_FILE_VIDEO=%~1

if /I "%RESOLUTION%"=="240p" (
  set RESOLUTION_VIDEO_W=%RES_240p_W%
  set RESOLUTION_VIDEO_H=%RES_240p_H%
  set RESOLUTION_VIDEO_X264_CRF_LOW=%RES_240p_X264_CRF_LOW%
  set RESOLUTION_VIDEO_X264_CRF_STD=%RES_240p_X264_CRF_STD%
  set RESOLUTION_VIDEO_X264_CRF_HQ=%RES_240p_X264_CRF_HQ%
  set RESOLUTION_VIDEO_X264_CRF_VHQ=%RES_240p_X264_CRF_VHQ%
)

if /I "%RESOLUTION%"=="360p" (
  set RESOLUTION_VIDEO_W=%RES_360p_W%
  set RESOLUTION_VIDEO_H=%RES_360p_H%
  set RESOLUTION_VIDEO_X264_CRF_LOW=%RES_360p_X264_CRF_LOW%
  set RESOLUTION_VIDEO_X264_CRF_STD=%RES_360p_X264_CRF_STD%
  set RESOLUTION_VIDEO_X264_CRF_HQ=%RES_360p_X264_CRF_HQ%
  set RESOLUTION_VIDEO_X264_CRF_VHQ=%RES_360p_X264_CRF_VHQ%
)

if /I "%RESOLUTION%"=="480p" (
  set RESOLUTION_VIDEO_W=%RES_480p_W%
  set RESOLUTION_VIDEO_H=%RES_480p_H%
  set RESOLUTION_VIDEO_X264_CRF_LOW=%RES_480p_X264_CRF_LOW%
  set RESOLUTION_VIDEO_X264_CRF_STD=%RES_480p_X264_CRF_STD%
  set RESOLUTION_VIDEO_X264_CRF_HQ=%RES_480p_X264_CRF_HQ%
  set RESOLUTION_VIDEO_X264_CRF_VHQ=%RES_480p_X264_CRF_VHQ%
)

if /I "%RESOLUTION%"=="720p" (
  set RESOLUTION_VIDEO_W=%RES_720p_W%
  set RESOLUTION_VIDEO_H=%RES_720p_H%
  set RESOLUTION_VIDEO_X264_CRF_LOW=%RES_720p_X264_CRF_LOW%
  set RESOLUTION_VIDEO_X264_CRF_STD=%RES_720p_X264_CRF_STD%
  set RESOLUTION_VIDEO_X264_CRF_HQ=%RES_720p_X264_CRF_HQ%
  set RESOLUTION_VIDEO_X264_CRF_VHQ=%RES_720p_X264_CRF_VHQ%
)

if /I "%RESOLUTION%"=="1080p" (
  set RESOLUTION_VIDEO_W=%RES_1080p_W%
  set RESOLUTION_VIDEO_H=%RES_1080p_H%
  set RESOLUTION_VIDEO_X264_CRF_LOW=%RES_1080p_X264_CRF_LOW%
  set RESOLUTION_VIDEO_X264_CRF_STD=%RES_1080p_X264_CRF_STD%
  set RESOLUTION_VIDEO_X264_CRF_HQ=%RES_1080p_X264_CRF_HQ%
  set RESOLUTION_VIDEO_X264_CRF_VHQ=%RES_1080p_X264_CRF_VHQ%
)

if "%RESOLUTION_VIDEO_X264_CRF_LOW%"=="" set RESOLUTION_VIDEO_X264_CRF_LOW=%DEFAULT_X264_CRF_LOW%
if "%RESOLUTION_VIDEO_X264_CRF_STD%"=="" set RESOLUTION_VIDEO_X264_CRF_STD=%DEFAULT_X264_CRF_STD%
if "%RESOLUTION_VIDEO_X264_CRF_HQ%"=="" set RESOLUTION_VIDEO_X264_CRF_HQ=%DEFAULT_X264_CRF_HQ%
if "%RESOLUTION_VIDEO_X264_CRF_VHQ%"=="" set RESOLUTION_VIDEO_X264_CRF_VHQ=%DEFAULT_X264_CRF_VHQ%

if "%RESOLUTION_VIDEO_X264_CRF%"=="" if /I "%RESOLUTION_QUALITY%"=="LOW" set RESOLUTION_VIDEO_X264_CRF=%RESOLUTION_VIDEO_X264_CRF_LOW%
if "%RESOLUTION_VIDEO_X264_CRF%"=="" if /I "%RESOLUTION_QUALITY%"=="STD" set RESOLUTION_VIDEO_X264_CRF=%RESOLUTION_VIDEO_X264_CRF_STD%
if "%RESOLUTION_VIDEO_X264_CRF%"=="" if /I "%RESOLUTION_QUALITY%"=="HQ" set RESOLUTION_VIDEO_X264_CRF=%RESOLUTION_VIDEO_X264_CRF_HQ%
if "%RESOLUTION_VIDEO_X264_CRF%"=="" if /I "%RESOLUTION_QUALITY%"=="VHQ" set RESOLUTION_VIDEO_X264_CRF=%RESOLUTION_VIDEO_X264_CRF_VHQ%
if "%RESOLUTION_VIDEO_X264_CRF%"=="" if /I "%RESOLUTION_QUALITY%"=="LOSSLESS" set RESOLUTION_VIDEO_X264_CRF=0
if "%RESOLUTION_VIDEO_X264_CRF%"=="" set RESOLUTION_VIDEO_X264_CRF=%RESOLUTION_VIDEO_X264_CRF_STD%

if "%HANDBRAKE_VIDEO_W%"=="" set HANDBRAKE_VIDEO_W=%RESOLUTION_VIDEO_W%
if "%HANDBRAKE_VIDEO_H%"=="" set HANDBRAKE_VIDEO_H=%RESOLUTION_VIDEO_H%

if not "%HANDBRAKE_VIDEO_W%"=="" set HANDBRAKE_CLI_VIDEO_W=--maxWidth %HANDBRAKE_VIDEO_W%
if not "%HANDBRAKE_VIDEO_H%"=="" set HANDBRAKE_CLI_VIDEO_H=--maxHeight %HANDBRAKE_VIDEO_H%

for %%i in ("%HANDBRAKE_INPUT_FILE_VIDEO%") do (
  set HANDBRAKE_INPUT_FILE_VIDEO_BASE=%%~dpni
  set HANDBRAKE_INPUT_FILE_VIDEO_EXT=%%~xi
)

if "%HANDBRAKE_OUTPUT_FILE%"=="" SET HANDBRAKE_OUTPUT_FILE=%HANDBRAKE_INPUT_FILE_VIDEO_BASE%.x264.mp4

if /I "%HANDBRAKE_INPUT_FILE_VIDEO_EXT%"==".iso" if not "%HANDBRAKE_TITLE%"=="" set HANDBRAKE_CLI_TITLE=--title %HANDBRAKE_TITLE%
if /I "%HANDBRAKE_INPUT_FILE_VIDEO_EXT%"==".iso" if "%HANDBRAKE_TITLE%"=="" set HANDBRAKE_CLI_TITLE=--main-feature

if not "%HANDBRAKE_SKIP_AUDIO%"=="" (
  set HANDBRAKE_CLI_AUDIO= --audio none
) else (
  set HANDBRAKE_CLI_AUDIO= --aencoder faac --ab 160 --mixdown dpl2
)

if not "%HANDBRAKE_INPUT_FILE_SUBTITLES%"=="" set HANDBRAKE_CLI_SUBTITLES=--srt-file "%HANDBRAKE_INPUT_FILE_SUBTITLES%"
:: set HANDBRAKE_CLI_SUBTITLE_MODE=--subtitle-forced --subtitle-burn

:: 0-51: where 0 is lossless, 23 is default, and 51 is worst possible
if "%HANDBRAKE_X264_QUALITY_CRF%"=="" set HANDBRAKE_X264_QUALITY_CRF=%RESOLUTION_VIDEO_X264_CRF%
if not "%HANDBRAKE_X264_QUALITY_CRF%"=="" set HANDBRAKE_CLI_X264_QUALITY_CRF=--quality %HANDBRAKE_X264_QUALITY_CRF%

:: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
if "%HANDBRAKE_X264_PRESET%"=="" set HANDBRAKE_X264_PRESET=veryslow
if not "%HANDBRAKE_X264_PRESET%"=="" set HANDBRAKE_CLI_X264_PRESET=--x264-preset %HANDBRAKE_X264_PRESET%

:: film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
if not "%HANDBRAKE_X264_TUNE%"=="" set HANDBRAKE_CLI_X264_TUNE=--x264-tune %HANDBRAKE_X264_TUNE%

::if "%HANDBRAKE_X264_PROFILE%"=="" set HANDBRAKE_X264_PROFILE=main
if not "%HANDBRAKE_X264_PROFILE%"=="" set HANDBRAKE_CLI_X264_PROFILE=--h264-profile %HANDBRAKE_X264_PROFILE%

::if "%HANDBRAKE_X264_LEVEL%"=="" set HANDBRAKE_X264_LEVEL=4.0
if not "%HANDBRAKE_X264_LEVEL%"=="" set HANDBRAKE_CLI_X264_LEVEL=--h264-level "%HANDBRAKE_X264_LEVEL%"

:: 5/10/12/15/23.976/24/25/29.97/30/50/59.94/60
if not "%HANDBRAKE_FRAME_RATE%"=="" set HANDBRAKE_CLI_FRAME_RATE=--rate "%HANDBRAKE_FRAME_RATE%"

if not "%HANDBRAKE_CROP%"=="" set HANDBRAKE_CLI_CROP=--crop "%HANDBRAKE_CROP%"

if not "%HANDBRAKE_CLIP_START%"=="" set HANDBRAKE_CLI_CLIP_START= --start-at duration:%HANDBRAKE_CLIP_START%
if not "%HANDBRAKE_CLIP_DURATION%"=="" set HANDBRAKE_CLI_CLIP_DURATION= --stop-at duration:%HANDBRAKE_CLIP_DURATION%

"%HANDBRAKE_CLI_EXE%" ^
  --input "%HANDBRAKE_INPUT_FILE_VIDEO%" %HANDBRAKE_CLI_TITLE% ^
  --output "%HANDBRAKE_OUTPUT_FILE%" ^
  --optimize ^
  %HANDBRAKE_CLI_VIDEO_W% %HANDBRAKE_CLI_VIDEO_H% ^
  --cfr %HANDBRAKE_CLI_FRAME_RATE% ^
  --modulus 4 %HANDBRAKE_CLI_ANAMORPHIC% %HANDBRAKE_CLI_CROP% ^
  --encoder x264 %HANDBRAKE_CLI_X264_QUALITY_CRF% %HANDBRAKE_CLI_X264_PRESET% %HANDBRAKE_CLI_X264_TUNE% %HANDBRAKE_CLI_X264_PROFILE% %HANDBRAKE_CLI_X264_LEVEL% ^
  %HANDBRAKE_CLI_AUDIO% ^
  %HANDBRAKE_CLI_SUBTITLE_MODE% %HANDBRAKE_CLI_SUBTITLES% ^
  %HANDBRAKE_CLI_CLIP_START% %HANDBRAKE_CLI_CLIP_DURATION% ^
  --verbose=1

endlocal

if "%SCRIPT_MODE%"=="" pause