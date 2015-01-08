CALL "%~dp0.\ffmpeg.settings.cmd"

IF "%FFMPEG_INPUT_FILE%"=="" SET FFMPEG_INPUT_FILE=%~1

"%FFMPEG_EXE%" -i "%FFMPEG_INPUT_FILE%"

pause