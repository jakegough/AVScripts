:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a video 
::      file stripped of subtitle and audio tracks
::  2) call this script from another with any of the environment varialbes already set:
::     a. FFMPEG_INPUT_FILE
::     b. FFMPEG_OUTPUT_FILE

CALL "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE%"=="" SET FFMPEG_INPUT_FILE=%~1
if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%~2
if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%~dpn1.video%~x1

if not "%FFMPEG_BEGIN%"=="" if not "%FFMPEG_DURATION%"=="" SET FFMPEG_CLIP= -ss %FFMPEG_BEGIN% -t %FFMPEG_DURATION%

"%FFMPEG_EXE%" ^
  -i "%FFMPEG_INPUT_FILE%" ^
  -vcodec copy ^
  -sn ^
  -an ^
  %FFMPEG_CLIP% ^
  "%FFMPEG_OUTPUT_FILE%"
  
if "%SCRIPT_MODE%"=="" pause