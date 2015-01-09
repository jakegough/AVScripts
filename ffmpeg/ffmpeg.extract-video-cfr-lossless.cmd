:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a video 
::      file stripped of subtitle and audio tracks
::  2) call this script from another with any of the environment varialbes already set:
::     a. FFMPEG_INPUT_FILE
::     b. FFMPEG_OUTPUT_FILE

setlocal

call "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE%"=="" set FFMPEG_INPUT_FILE=%~1
if "%FFMPEG_OUTPUT_FILE%"=="" set FFMPEG_OUTPUT_FILE=%~2
if "%FFMPEG_OUTPUT_FILE%"=="" set FFMPEG_OUTPUT_FILE=%~dpn1.video-cfr-lossless.mp4

if not "%FFMPEG_BEGIN%"=="" if not "%FFMPEG_DURATION%"=="" set FFMPEG_CLIP= -ss %FFMPEG_BEGIN% -t %FFMPEG_DURATION%

"%FFMPEG_EXE%" ^
  -i "%FFMPEG_INPUT_FILE%" ^
  -c:v libx264 -crf 0 -preset veryfast -x264opts force-cfr ^
  -sn ^
  -an ^
  %FFMPEG_CLIP% ^
  "%FFMPEG_OUTPUT_FILE%"
  
endlocal
  
if "%SCRIPT_MODE%"=="" pause