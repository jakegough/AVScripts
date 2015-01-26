:: USAGE: drag-n-drop an ISO to extract mkv's

setlocal

call "%~dp0.\makemkv.settings.cmd"

if "%MAKEMKV_INPUT_FILE%"=="" set MAKEMKV_INPUT_FILE=%~1

for %%i in ("%MAKEMKV_INPUT_FILE%") do (
  set MAKEMKV_INPUT_FILE_BASE=%%~dpni
  set MAKEMKV_INPUT_FILE_EXT=%%~xi
)

if "%MAKEMKV_OUTPUT_FOLDER%"=="" set MAKEMKV_OUTPUT_FOLDER=%MAKEMKV_INPUT_FILE_BASE%.makemkv

if "%MAKEMKV_TITLE%"=="" set MAKEMKV_TITLE=0

if not "%MAKEMKV_MINLENGTH%"=="" set MAKEMKV_CLI_MINLENGTH= --minlength=%MAKEMKV_MINLENGTH%

mkdir "%MAKEMKV_OUTPUT_FOLDER%"

"%MAKEMKV_CLI_EXE%" ^
  %MAKEMKV_CLI_PROFILE% ^
  %MAKEMKV_CLI_MINLENGTH% ^
  --robot ^
  mkv "iso:%MAKEMKV_INPUT_FILE%" ^
  "%MAKEMKV_TITLE%" ^
  "%MAKEMKV_OUTPUT_FOLDER%"

endlocal

if "%SCRIPT_MODE%"=="" pause