@echo off
powershell -ExecutionPolicy Unrestricted -File "OpenMouse.ps1"
:menu
cls
echo ================================
echo     Metaa's Cursor manager
echo ================================
echo.
echo   1. Save current cursor
echo   2. Load a random cursor
echo   3. Enable/Disable random cursor on startup
echo   4. Exit
echo.


set /p choice=Choose an option (1-4): 

if "%choice%"=="1" (
    powershell -ExecutionPolicy Unrestricted -File "SaveCursor.ps1"
    pause
    goto menu
)

if "%choice%"=="2" (
    powershell -ExecutionPolicy Unrestricted -File "RandomCursor.ps1"
    pause
    goto menu
)

if "%choice%"=="3" (
    powershell -ExecutionPolicy Unrestricted -File "InitStartup.ps1"
    pause
    goto menu
)


if "%choice%"=="4" (
    exit
)

echo Try again.
pause
goto menu
