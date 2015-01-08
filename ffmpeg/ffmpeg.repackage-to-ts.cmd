:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a mpeg video

CALL "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE%"=="" SET FFMPEG_INPUT_FILE=%~1

for %%i in ("%FFMPEG_INPUT_FILE%") do (
  SET FFMPEG_INPUT_FILE_BASE=%%~dpni
  SET FFMPEG_INPUT_FILE_EXT=%%~xi
)

if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%~2
if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%FFMPEG_INPUT_FILE_BASE%.ts

"%FFMPEG_EXE%" ^
  -i "%FFMPEG_INPUT_FILE%" ^
  -c copy ^
  -f mpegts ^
  "%FFMPEG_OUTPUT_FILE%"
  
::-target ntsc-dvd ^
:: -acodec libmp3lame -ac 2 -af "aresample=matrix_encoding=dplii" -q:a 2 ^
  
if "%SCRIPT_MODE%"=="" pause