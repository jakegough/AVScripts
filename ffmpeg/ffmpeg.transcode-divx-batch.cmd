:: USAGE: drag and drop a bunch of video files onto this script, and it will 
::        call ffmpeg.transcode-divx.cmd for each one

setlocal

set SCRIPT_MODE=1

for %%x in (%*) do call "%~dp0.\ffmpeg.transcode-divx.cmd" %%x

endlocal

pause