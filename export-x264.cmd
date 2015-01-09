::@SET DEBUG_MODE=1
@if "%DEBUG_MODE%"=="" echo off

@echo.
@echo.
@echo Conversion Started...
@if not "%DEBUG_MODE%"=="" echo Debug mode enabled.
@echo.

REM SETUP:
set DEFAULT_OUTPUT_FILE_SUFFIX=.x264
set DEFAULT_OUTPUT_FILE_EXT=.mp4

if "%INPUT_FILE%"=="" SET INPUT_FILE=%~1

for %%i in ("%INPUT_FILE%") do (
  SET INPUT_FILE_NAME_BASE=%%~ni
  SET INPUT_FILE_NAME_ONLY=%%~nxi
  SET INPUT_FILE_NAME_DIR=%%~dpi
)

TITLE %INPUT_FILE_NAME_ONLY%

if "%WORKING_FOLDER%"=="" SET WORKING_FOLDER=%INPUT_FILE_NAME_DIR%
chdir /d "%WORKING_FOLDER%"
SET WORKING_FOLDER=%CD%\

if "%TEMP_FOLDER%"=="" SET TEMP_FOLDER=%WORKING_FOLDER%.\.temp\
mkdir "%TEMP_FOLDER%"
chdir /d "%TEMP_FOLDER%"
SET TEMP_FOLDER=%CD%\

if "%OUTPUT_FILE%"=="" SET OUTPUT_FILE=%~2
if "%OUTPUT_FILE%"=="" SET OUTPUT_FILE=%WORKING_FOLDER%.\%INPUT_FILE_NAME_BASE%%DEFAULT_OUTPUT_FILE_SUFFIX%%DEFAULT_OUTPUT_FILE_EXT%

for %%i in ("%OUTPUT_FILE%") do (
  set OUTPUT_FILE_NAME_ONLY=%%~nxi
  set OUTPUT_FILE_NAME_DIR=%%~dpi
)

SET JOB=%RANDOM%
SET TEMP_AUDIO_EXTRACTED=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.wav
SET TEMP_AUDIO_NORM=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.norm.wav
SET TEMP_AUDIO_AAC=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.m4a
SET TEMP_VIDEO_X264=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.m4v

@echo Input File:
@echo   [%INPUT_FILE_NAME_ONLY%]
@echo Input File Location:
@echo   [%INPUT_FILE_NAME_DIR%]
@echo Output File:
@echo   [%OUTPUT_FILE_NAME_ONLY%]
@echo Output File Location:
@echo   [%OUTPUT_FILE_NAME_DIR%]
@echo Working Folder:
@echo   [%WORKING_FOLDER%]
@echo Temp Folder:
@echo   [%TEMP_FOLDER%]
if not "%DEBUG_MODE%"=="" pause

REM ## extract the audio
del "%TEMP_AUDIO_EXTRACTED%"

setlocal
set SCRIPT_MODE=1
call "%~dp0.\ffmpeg\ffmpeg.extract-audio.cmd" "%INPUT_FILE%" "%TEMP_AUDIO_EXTRACTED%"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## normalize the audio
del "%TEMP_AUDIO_NORM%"

setlocal
set SCRIPT_MODE=1
call "%~dp0.\wavegain\wavegain.cmd" "%TEMP_AUDIO_EXTRACTED%" "%TEMP_AUDIO_NORM%"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## Encode audio
del "%TEMP_AUDIO_AAC%"

setlocal
set SCRIPT_MODE=1
set NEROAAC_INPUT_FILE=%TEMP_AUDIO_NORM%
set NEROAAC_OUTPUT_FILE=%TEMP_AUDIO_AAC%
call "%~dp0.\neroaac\neroaac.cmd"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## Encode video
del "%TEMP_VIDEO_X264%"

setlocal
set SCRIPT_MODE=1
set HANDBRAKE_INPUT_FILE_VIDEO=%INPUT_FILE%
set HANDBRAKE_OUTPUT_FILE=%TEMP_VIDEO_X264%
set HANDBRAKE_SKIP_AUDIO=1
call "%~dp0.\handbrake\handbrake.transcode-x264.cmd"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## merge audio & video
del "%OUTPUT_FILE%"

setlocal
set SCRIPT_MODE=1
set FFMPEG_INPUT_FILE_AUDIO=%TEMP_AUDIO_AAC%
set FFMPEG_INPUT_FILE_VIDEO=%TEMP_VIDEO_X264%
set FFMPEG_OUTPUT_FILE=%OUTPUT_FILE%
call "%~dp0.\ffmpeg\ffmpeg.merge-audio-video.cmd"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## Cleanup
del "%TEMP_AUDIO_EXTRACTED%"
del "%TEMP_AUDIO_NORM%"
del "%TEMP_AUDIO_AAC%"
del "%TEMP_VIDEO_X264%"

@echo.
@echo.
@echo Conversion finished.
@echo   [%OUTPUT_FILE%]
@echo.

if "%SCRIPT_MODE%"=="" pause
