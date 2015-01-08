set SCRIPT_MODE=1

for %%x in (%*) do (
  setlocal
  call "%~dp0.\ffmpeg.transcode-divx.cmd" %%x
  endlocal
)

pause