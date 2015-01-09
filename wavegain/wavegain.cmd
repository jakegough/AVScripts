:: USAGE:
::  1) drag and drop a wav file onto this script, and it will output a gain normalized file
::  2) call this script from another with any of the environment varialbes already set:
::     a. WAVEGAIN_INPUT_FILE
::     b. WAVEGAIN_OUTPUT_FILE

setlocal

call "%~dp0.\wavegain.settings.cmd"

if "%WAVEGAIN_INPUT_FILE%"=="" set WAVEGAIN_INPUT_FILE=%~1
if "%WAVEGAIN_OUTPUT_FILE%"=="" set WAVEGAIN_OUTPUT_FILE=%~2
if "%WAVEGAIN_OUTPUT_FILE%"=="" set WAVEGAIN_OUTPUT_FILE=%~dpn1.wavegain%~x1

REM default setting in WaveGain is 89dB
REM '--gain 3' will add 3 db (bringing it to 92db)
REM http://www.hydrogenaud.io/forums//lofiversion/index.php/t83995.html

copy "%WAVEGAIN_INPUT_FILE%" "%WAVEGAIN_OUTPUT_FILE%"

"%WAVEGAIN_EXE%" ^
  --apply ^
  "%WAVEGAIN_OUTPUT_FILE%"

endlocal

if "%SCRIPT_MODE%"=="" pause