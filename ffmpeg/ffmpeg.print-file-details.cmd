:: USAGE:  drag and drop a video file onto this script, and it will output the ffmpeg analysis of the file

setlocal

call "%~dp0.\ffmpeg.settings.cmd"

if "%FFMPEG_INPUT_FILE%"=="" set FFMPEG_INPUT_FILE=%~1

"%FFMPEG_EXE%" -i "%FFMPEG_INPUT_FILE%"

endlocal

pause