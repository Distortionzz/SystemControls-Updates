@echo off
title System Control v1 - Main Menu
setlocal enabledelayedexpansion

:: Define mutex file
set "mutex_file=%temp%\SystemControls.lock"

:: Check if another instance is already running
if exist "%mutex_file%" (
    echo Another instance of System Controls v1 is already running!
    echo Please close the other instance before starting this one.
    pause
    exit
)

:: Create the mutex
echo Running... > "%mutex_file%"

:: Security check to ensure access only from the Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:: Display Access Notice
cls
echo ===================================================
echo                Access Notice
echo ===================================================
echo.
echo WARNING: Unauthorized modification, distribution, or
echo use of this program and its source code is strictly
echo prohibited without written consent from EzMechanics.
echo Violators may face legal action.
echo.
echo NOTICE: This program does not collect or store any
echo personal information. Only hardware data is accessed
echo temporarily to ensure program functionality.
echo.
echo By continuing, you agree to these terms.
echo ===================================================
echo.
pause

:main_menu
cls
echo ===================================================
echo                System Control v1
echo ===================================================
echo.
echo [1] View System Information
echo [2] Network Information Viewer
echo [3] Application Launcher
echo [E] Exit
echo.
echo ===================================================
echo.

set /p menu_choice=Select an option: 

if /i "!menu_choice!"=="1" call Option1.bat
if /i "!menu_choice!"=="2" call Option2.bat
if /i "!menu_choice!"=="3" call Option3.bat
if /i "!menu_choice!"=="E" exit
if /i "!menu_choice!"=="e" exit

echo Invalid selection. Please try again.
timeout /t 2 >nul
goto main_menu

:: Cleanup on exit
del "%mutex_file%" >nul 2>&1
exit
