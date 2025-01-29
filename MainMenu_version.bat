@echo off
title Main Menu - System Controls v1
color 0A
cls

:: Ensure access only from Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:: Display Main Menu
echo ===================================================================================
echo                              SYSTEM CONTROLS - MAIN MENU
echo ===================================================================================
echo                                        By Eddy
echo                                  Built with ChatGPT
echo ===================================================================================
echo Please select an option:
echo.
echo   [1] System Information
echo   [2] Network Tools
echo   [3] Application Launcher
echo   [4] Exit
echo.
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    call Option1.bat
    exit
)
if "%choice%"=="2" (
    call Option2.bat
    exit
)
if "%choice%"=="3" (
    call Option3.bat
    exit
)
if "%choice%"=="4" (
    exit
)

:: Invalid input handling
echo Invalid selection! Please enter a valid option.
timeout /t 2 >nul
cls
call MainMenu.bat
