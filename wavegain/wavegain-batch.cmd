set SCRIPT_MODE=1

for %%x in (%*) do call "%~dp0.\wavegain.cmd" %%x

pause