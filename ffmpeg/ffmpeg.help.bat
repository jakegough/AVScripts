setlocal

call "%~dp0.\ffmpeg.settings.cmd"
"%FFMPEG_EXE%" --help > "%~dpn0.output.txt" 2>&1
"%FFMPEG_EXE%" --help

endlocal

pause