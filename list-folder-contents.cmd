@echo off
if "%INPUT_FOLDER%"=="" SET INPUT_FOLDER=%~1

if "%INPUT_FOLDER%"=="" goto help

if not exist "%INPUT_FOLDER%\*" goto end

set OUTPUT_FILE=%INPUT_FOLDER%.txt

for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set dateyyyymmdd=%%c-%%a-%%b)
for /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set timehhmm=%%a:%%b)

echo Created %dateyyyymmdd% @ %timehhmm%  > "%OUTPUT_FILE%"
echo. >> "%OUTPUT_FILE%"

for /f "tokens=*" %%i in ('dir /b /on /a "%INPUT_FOLDER%\*"') do (echo %%~nxi >> "%OUTPUT_FILE%")

goto end

:help
echo Drag and Drop a folder onto this script to list its contents.
echo.
echo Note: the output file will be named [folder name].txt
echo.
echo.
goto end

:end
pause