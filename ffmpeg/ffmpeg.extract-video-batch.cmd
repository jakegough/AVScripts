set SCRIPT_MODE=1

for %%x in (%*) do (
  setlocal
  call "%~dp0.\ffmpeg.extract-video.cmd" %%x
  endlocal
)

pause