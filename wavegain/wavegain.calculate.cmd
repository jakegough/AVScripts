:: USAGE:
::  1) drag and drop a wav file onto this script
::  2) call this script from another with any of the environment varialbes already set:
::     a. WAVEGAIN_INPUT_FILE

setlocal

call "%~dp0.\wavegain.settings.cmd"

if "%WAVEGAIN_INPUT_FILE%"=="" set WAVEGAIN_INPUT_FILE=%~1

"%WAVEGAIN_EXE%" ^
  --calculate ^
  --fast ^
  "%WAVEGAIN_INPUT_FILE%"

endlocal

if "%SCRIPT_MODE%"=="" pause