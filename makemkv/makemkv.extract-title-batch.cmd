set SCRIPT_MODE=1

for %%x in (%*) do call "%~dp0.\makemkv.extract-title.cmd" %%x

pause