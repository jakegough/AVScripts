setlocal

call "%~dp0.\makemkv.settings.cmd"
"%MAKEMKV_CLI_EXE%"
"%MAKEMKV_CLI_EXE%" > "%~dpn0.output.txt" 2>&1

endlocal

pause