@echo off
echo Regenerating dynamic includes...
echo.

REM Run the AutoHotkey generator script
"C:\Program Files\AutoHotkey\AutoHotkey.exe" "%~dp0generate_includes.ahk"

echo.
echo Done! Press any key to exit.
pause >nul
