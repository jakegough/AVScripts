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

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".mov" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".mov" SET FFMPEG_INPUT_FILE_VIDEO=%~2

if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x1"==".wmv" SET FFMPEG_INPUT_FILE_VIDEO=%~1
if "%FFMPEG_INPUT_FILE_VIDEO%"=="" if /I "%~x2"==".wmv" SET FFMPEG_INPUT_FILE_VIDEO=%~2

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

:: ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow, placebo
if "%FFMPEG_X264_PRESET%"=="" set FFMPEG_X264_PRESET=veryslow
if not "%FFMPEG_X264_PRESET%"=="" set FFMPEG_CLI_X264_PRESET=-preset %FFMPEG_X264_PRESET%

:: film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency
if not "%FFMPEG_X264_TUNE%"=="" set FFMPEG_CLI_X264_TUNE=-tune %FFMPEG_X264_TUNE%

:: 0-51: where 0 is lossless, 23 is default, and 51 is worst possible
if "%FFMPEG_X264_QUALITY_CRF%"=="" set FFMPEG_X264_QUALITY_CRF=23
if not "%FFMPEG_X264_QUALITY_CRF%"=="" set FFMPEG_CLI_X264_QUALITY_CRF=-crf %FFMPEG_X264_QUALITY_CRF%

if not "%FFMPEG_VIDEO_W%"=="" if not "%FFMPEG_VIDEO_H%"=="" set FFMPEG_CLI_VIDEO_SIZE=-vf scale="min(iw*min(%FFMPEG_VIDEO_W%/iw\,%FFMPEG_VIDEO_H%/ih)\,min(%FFMPEG_VIDEO_W%\,iw)):trunc(ow/a/2)*2"

:: libfaac quality.  100 = ~128kbps (default), 150 = ~175kbps
:: https://trac.ffmpeg.org/wiki/Encode/AAC
if "%FFMPEG_AUDIO_QUALITY%"=="" set FFMPEG_AUDIO_QUALITY=100
if not "%FFMPEG_AUDIO_QUALITY%"=="" set FFMPEG_CLI_AUDIO_QUALITY=-q:a %FFMPEG_AUDIO_QUALITY%

:: heads up
@echo.
@echo.
@echo.I could never get this to work with libfaac or libfdk-aac because they aren't distributed as part of the static .exe
@echo.
@echo.Bummmer.
@pause

"%FFMPEG_EXE%" ^
  %FFMPEG_CLI_INPUT_FILES% ^
  -c:v libx264 ^
  %FFMPEG_CLI_X264_TUNE% ^
  %FFMPEG_CLI_X264_PRESET% ^
  %FFMPEG_CLI_X264_QUALITY_CRF% ^
  %FFMPEG_CLI_VIDEO_SIZE% ^
  -c:a libfaac ^
  %FFMPEG_CLI_AUDIO_QUALITY% ^
  %FFMPEG_CLI_INPUT_FILES_MAP% ^
  "%FFMPEG_OUTPUT_FILE%"

endlocal
  
pause