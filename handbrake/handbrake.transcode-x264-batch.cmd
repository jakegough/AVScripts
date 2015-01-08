:: USAGE: drag and drop a bunch of video files onto this script, and it will 
::        call handbrake.transcode-x264.cmd for each one

setlocal

set SCRIPT_MODE=1

for %%x in (%*) do call "%~dp0.\handbrake.transcode-x264.cmd" %%x

endlocal

pause