:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a divx video
::  2) drag and drop a video file and a wav audio file onto this script, and it will 
::      output a divx video using the supplied wav file as the audio track
::  3) call this script from another script with any of the environment varialbes already set:
::     a. FFMPEG_INPUT_FILE_VIDEO
::         self explanitory
::     b. FFMPEG_INPUT_FILE_AUDIO
::         optional separate audio track for muxing
::     c. FFMPEG_OUTPUT_FILE
::         optional custom output file name
::     d. RESOLUTION
::         values: 240p, 360p, 480p, 720p, 1080p
::     e. FFMPEG_VIDEO_W
::         frame width, ignored if RESOLUTION provided
::     f. FFMPEG_VIDEO_H
::         frame height, ignored if RESOLUTION provided
::     g. FFMPEG_VIDEO_QUALITY
::         1-31, 3�5 recommended, 2 = visually lossless, double the value = half the bitrate (see https://trac.ffmpeg.org/wiki/Encode/MPEG-4)
::     h. FFMPEG_AUDIO_QUALITY
::         0-9 where a lower value is a higher quality (libmp3lame quality, see https://trac.ffmpeg.org/wiki/Encode/MP3)

setlocal

call "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE_AUDIO%"=="" if /I "%~x1"==".wav" SET FFMPEG_INPUT_FILE_AUDIO=%~1
if "%FFMPEG_INPUT_FILE_AUDIO%"=="" if /I "%~x2"==".wav" SET FFMPEG_INPUT_FILE_AUDIO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".avi" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".avi" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".mpg" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".mpg" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".mpeg" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".mpeg" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".mp4" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".mp4" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".m4v" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".m4v" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".mkv" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".mkv" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if /I "%RESOLUTION%"=="240p" (
  set RESOLUTION_VIDEO_W=%RES_240p_W%
  set RESOLUTION_VIDEO_H=%RES_240p_H%
  set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%RES_240p_QUALITY_DIVX_LOW%
  set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%RES_240p_QUALITY_DIVX_STD%
  set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%RES_240p_QUALITY_DIVX_HQ%
  set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%RES_240p_QUALITY_DIVX_VHQ%
)

if /I "%RESOLUTION%"=="360p" (
  set RESOLUTION_VIDEO_W=%RES_360p_W%
  set RESOLUTION_VIDEO_H=%RES_360p_H%
  set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%RES_360p_QUALITY_DIVX_LOW%
  set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%RES_360p_QUALITY_DIVX_STD%
  set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%RES_360p_QUALITY_DIVX_HQ%
  set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%RES_360p_QUALITY_DIVX_VHQ%
)

if /I "%RESOLUTION%"=="480p" (
  set RESOLUTION_VIDEO_W=%RES_480p_W%
  set RESOLUTION_VIDEO_H=%RES_480p_H%
  set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%RES_480p_QUALITY_DIVX_LOW%
  set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%RES_480p_QUALITY_DIVX_STD%
  set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%RES_480p_QUALITY_DIVX_HQ%
  set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%RES_480p_QUALITY_DIVX_VHQ%
)

if /I "%RESOLUTION%"=="720p" (
  set RESOLUTION_VIDEO_W=%RES_720p_W%
  set RESOLUTION_VIDEO_H=%RES_720p_H%
  set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%RES_720p_QUALITY_DIVX_LOW%
  set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%RES_720p_QUALITY_DIVX_STD%
  set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%RES_720p_QUALITY_DIVX_HQ%
  set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%RES_720p_QUALITY_DIVX_VHQ%
)

if /I "%RESOLUTION%"=="1080p" (
  set RESOLUTION_VIDEO_W=%RES_1080p_W%
  set RESOLUTION_VIDEO_H=%RES_1080p_H%
  set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%RES_1080p_QUALITY_DIVX_LOW%
  set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%RES_1080p_QUALITY_DIVX_STD%
  set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%RES_1080p_QUALITY_DIVX_HQ%
  set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%RES_1080p_QUALITY_DIVX_VHQ%
)

if "%RESOLUTION_VIDEO_QUALITY_DIVX_LOW%"=="" set RESOLUTION_VIDEO_QUALITY_DIVX_LOW=%DEFAULT_QUALITY_DIVX_LOW%
if "%RESOLUTION_VIDEO_QUALITY_DIVX_STD%"=="" set RESOLUTION_VIDEO_QUALITY_DIVX_STD=%DEFAULT_QUALITY_DIVX_STD%
if "%RESOLUTION_VIDEO_QUALITY_DIVX_HQ%"=="" set RESOLUTION_VIDEO_QUALITY_DIVX_HQ=%DEFAULT_QUALITY_DIVX_HQ%
if "%RESOLUTION_VIDEO_QUALITY_DIVX_VHQ%"=="" set RESOLUTION_VIDEO_QUALITY_DIVX_VHQ=%DEFAULT_QUALITY_DIVX_VHQ%

if "%FFMPEG_VIDEO_QUALITY%"=="" if /I "%RESOLUTION_QUALITY%"=="LOW" set FFMPEG_VIDEO_QUALITY=%RESOLUTION_VIDEO_QUALITY_DIVX_LOW%
if "%FFMPEG_VIDEO_QUALITY%"=="" if /I "%RESOLUTION_QUALITY%"=="STD" set FFMPEG_VIDEO_QUALITY=%RESOLUTION_VIDEO_QUALITY_DIVX_STD%
if "%FFMPEG_VIDEO_QUALITY%"=="" if /I "%RESOLUTION_QUALITY%"=="HQ" set FFMPEG_VIDEO_QUALITY=%RESOLUTION_VIDEO_QUALITY_DIVX_HQ%
if "%FFMPEG_VIDEO_QUALITY%"=="" if /I "%RESOLUTION_QUALITY%"=="VHQ" set FFMPEG_VIDEO_QUALITY=%RESOLUTION_VIDEO_QUALITY_DIVX_VHQ%
if "%FFMPEG_VIDEO_QUALITY%"=="" set FFMPEG_VIDEO_QUALITY=%RESOLUTION_VIDEO_QUALITY_DIVX_STD%

if "%FFMPEG_VIDEO_W%"=="" set FFMPEG_VIDEO_W=%RESOLUTION_VIDEO_W%
if "%FFMPEG_VIDEO_H%"=="" set FFMPEG_VIDEO_H=%RESOLUTION_VIDEO_H%


for %%i in ("%FFMPEG_INPUT_FILE_VIDEO%") do (
  SET FFMPEG_INPUT_FILE_VIDEO_BASE=%%~dpni
  SET FFMPEG_INPUT_FILE_VIDEO_EXT=%%~xi
)

if "%FFMPEG_INPUT_FILE_AUDIO%"=="" (
  set FFMPEG_CLI_INPUT_FILES=-i "%FFMPEG_INPUT_FILE_VIDEO%"
  set FFMPEG_CLI_INPUT_FILES_MAP=
) ELSE (
  set FFMPEG_CLI_INPUT_FILES=-i "%FFMPEG_INPUT_FILE_VIDEO%" -i "%FFMPEG_INPUT_FILE_AUDIO%"
  set FFMPEG_CLI_INPUT_FILES_MAP=-map 0:v:0 -map 1:a:0
)

if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%FFMPEG_INPUT_FILE_VIDEO_BASE%.divx.avi

if "%FFMPEG_VIDEO_QUALITY%"=="" set FFMPEG_VIDEO_QUALITY=4
if not "%FFMPEG_VIDEO_QUALITY%"=="" set FFMPEG_CLI_VIDEO_QUALITY=-q:v %FFMPEG_VIDEO_QUALITY%

if "%FFMPEG_AUDIO_QUALITY%"=="" set FFMPEG_AUDIO_QUALITY=4
if not "%FFMPEG_AUDIO_QUALITY%"=="" set FFMPEG_CLI_AUDIO_QUALITY=-q:a %FFMPEG_AUDIO_QUALITY%

if "%FFMPEG_VIDEO_W%"=="" if "%FFMPEG_VIDEO_H%"=="" set FFMPEG_CLI_VIDEO_SIZE=-vf scale=iw:trunc((ow/dar)/4)*4
if not "%FFMPEG_VIDEO_W%"=="" if not "%FFMPEG_VIDEO_H%"=="" set FFMPEG_CLI_VIDEO_SIZE=-vf scale="min(iw*min(%FFMPEG_VIDEO_W%/iw\,%FFMPEG_VIDEO_H%/(iw/dar))\,min(%FFMPEG_VIDEO_W%\,iw)):trunc((ow/dar)/4)*4"

"%FFMPEG_EXE%" ^
  %FFMPEG_CLI_INPUT_FILES% ^
  -c:v mpeg4 -tag:v DIVX ^
  %FFMPEG_CLI_VIDEO_QUALITY% ^
  %FFMPEG_CLI_VIDEO_SIZE% ^
  -c:a libmp3lame  -ac 2 -ar 44100 -af "aresample=matrix_encoding=dplii" ^
  %FFMPEG_CLI_AUDIO_QUALITY% ^
  %FFMPEG_CLI_INPUT_FILES_MAP% ^
  "%FFMPEG_OUTPUT_FILE%"

endlocal

if "%SCRIPT_MODE%"=="" pause