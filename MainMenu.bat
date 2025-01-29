@echo off
title System Control v1 - Main Menu
setlocal enabledelayedexpansion

:: Security check to ensure access only from the Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

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
