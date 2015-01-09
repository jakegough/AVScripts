@REM SET DEBUG_MODE=1
@if "%DEBUG_MODE%"=="" echo off

@echo.
@echo.
@echo Conversion Started...
@if not "%DEBUG_MODE%"=="" echo Debug mode enabled.
@echo.

REM SETUP:
::SET VFR_WORKAROUND=1
set DEFAULT_OUTPUT_FILE_SUFFIX=.divx
set DEFAULT_OUTPUT_FILE_EXT=.avi

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
SET TEMP_VIDEO_EXTRACTED=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.mp4
SET TEMP_AUDIO_EXTRACTED=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.wav
SET TEMP_AUDIO_NORM=%TEMP_FOLDER%.\%INPUT_FILE_NAME_BASE%.temp%JOB%.norm.wav

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

REM ## extract the video
del "%TEMP_VIDEO_EXTRACTED%"

setlocal
set SCRIPT_MODE=1
if not "%VFR_WORKAROUND%"=="" call "%~dp0.\ffmpeg\ffmpeg.extract-video-cfr-lossless.cmd" "%INPUT_FILE%" "%TEMP_VIDEO_EXTRACTED%"
endlocal

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

REM ## Encode audio & video into output file
del "%OUTPUT_FILE%"

setlocal
set SCRIPT_MODE=1
if "%VFR_WORKAROUND%"=="" set FFMPEG_INPUT_FILE_VIDEO=%INPUT_FILE%
if not "%VFR_WORKAROUND%"=="" set FFMPEG_INPUT_FILE_VIDEO=%TEMP_VIDEO_EXTRACTED%
set FFMPEG_INPUT_FILE_AUDIO=%TEMP_AUDIO_NORM%
set FFMPEG_OUTPUT_FILE=%OUTPUT_FILE%
call "%~dp0.\ffmpeg\ffmpeg.transcode-divx.cmd"
endlocal

if not "%DEBUG_MODE%"=="" pause

REM ## Cleanup
del "%TEMP_VIDEO_EXTRACTED%"
del "%TEMP_AUDIO_EXTRACTED%"
del "%TEMP_AUDIO_NORM%"

@echo.
@echo.
@echo Conversion finished.
@echo   [%OUTPUT_FILE%]
@echo.

if "%SCRIPT_MODE%"=="" pause