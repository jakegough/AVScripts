:: USAGE: drag and drop a bunch of video files onto this script, and it will 
::        call ffmpeg.extract-video.cmd for each one

setlocal

set SCRIPT_MODE=1

for %%x in (%*) do call "%~dp0.\ffmpeg.extract-video.cmd" %%x

endlocal

pause