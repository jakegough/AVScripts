:: USAGE:
::  1) drag and drop a video file onto this script, and it will output a decompressed 
::      PCM wav audio file, downmixed to stereo Dolby Pro Logic II
::  2) call this script from another with any of the environment varialbes already set:
::     a. FFMPEG_INPUT_FILE
::     b. FFMPEG_OUTPUT_FILE
::     c. FFMPEG_INPUT_FILE_AUDIO_TRACK
::     d. FFMPEG_OUTPUT_FILE_AUDIO_DOWNMIX_STEREO

CALL "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE%"=="" SET FFMPEG_INPUT_FILE=%~1
if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%~2

if not "%FFMPEG_INPUT_FILE_AUDIO_TRACK%"=="" set FFMPEG_CLI_AUDIO_TRACK= -map 0:%FFMPEG_INPUT_FILE_AUDIO_TRACK%
if not "%FFMPEG_INPUT_FILE_AUDIO_TRACK%"=="" set FFMPEG_OUTPUT_FILE_SUFFIX=.track%FFMPEG_INPUT_FILE_AUDIO_TRACK%

if "%FFMPEG_OUTPUT_FILE_AUDIO_DOWNMIX_STEREO%"=="" SET FFMPEG_OUTPUT_FILE_AUDIO_DOWNMIX_STEREO=1
if "%FFMPEG_OUTPUT_FILE_AUDIO_DOWNMIX_STEREO%"=="1" SET FFMPEG_CLI_AUDIO_CHANNELS= -ac 2 -af "aresample=matrix_encoding=dplii"

if not "%FFMPEG_BEGIN%"=="" if not "%FFMPEG_DURATION%"=="" SET FFMPEG_CLI_CLIP= -ss %FFMPEG_BEGIN% -t %FFMPEG_DURATION%

if "%FFMPEG_OUTPUT_FILE%"=="" SET FFMPEG_OUTPUT_FILE=%FFMPEG_INPUT_FILE%%FFMPEG_OUTPUT_FILE_SUFFIX%.wav

"%FFMPEG_EXE%" ^
  -i "%FFMPEG_INPUT_FILE%" ^
  %FFMPEG_CLI_AUDIO_TRACK% ^
  -vn ^
  -acodec pcm_s16le ^
  %FFMPEG_CLI_AUDIO_CHANNELS% ^
  %FFMPEG_CLI_CLIP% ^
  "%FFMPEG_OUTPUT_FILE%"
  
if "%SCRIPT_MODE%"=="" pause