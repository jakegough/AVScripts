CALL %~dp0.\handbrake.settings.cmd
"%HANDBRAKE_CLI_EXE%" --help > "%~dpn0.output.txt" 2>&1
"%HANDBRAKE_CLI_EXE%" --help
pause