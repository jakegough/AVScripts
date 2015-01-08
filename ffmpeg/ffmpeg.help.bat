setlocal

call "%~dp0.\ffmpeg.settings.cmd"
"%FFMPEG_EXE%" --help

endlocal

pause