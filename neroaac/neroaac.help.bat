CALL %~dp0.\neroaac.settings.cmd
"%NEROAAC_EXE%" -help > "%~dpn0.output.txt" 2>&1
"%NEROAAC_EXE%" -help
pause