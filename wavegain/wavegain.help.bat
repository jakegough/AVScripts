CALL %~dp0.\wavegain.settings.cmd
"%WAVEGAIN_EXE%" -help > "%~dpn0.output.txt" 2>&1
"%WAVEGAIN_EXE%" --help

if "%SCRIPT_MODE%"=="" pause