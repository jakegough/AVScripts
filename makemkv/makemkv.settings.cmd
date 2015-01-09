:: download and install makemkv
::  http://www.makemkv.com/download/

SET MAKEMKV_SEARCH_PATH=%PROGRAMFILES(x86)%\MakeMKV\
SET PATH=%PATH%;%MAKEMKV_SEARCH_PATH%;
SET MAKEMKV_CLI_EXE=makemkvcon.exe

:: see profile usage http://www.makemkv.com/forum2/viewtopic.php?f=10&t=4386
SET MAKEMKV_CLI_PROFILE="--profile=%~dp0.\profile.xml"
