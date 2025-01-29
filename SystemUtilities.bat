@echo off
title System Utilities - System Controls v1
color 0A
cls

:: Ensure access only from Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:MENU_LOOP
cls
echo ===================================================================================
echo                              SYSTEM UTILITIES MENU
echo ===================================================================================
echo [1] Disk Cleanup
echo [2] View System Information
echo [3] Open Task Manager
echo [M] Return to Main Menu
echo ===================================================================================
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo Running Disk Cleanup...
    cleanmgr /sagerun:1
    pause
    goto MENU_LOOP
)
if "%choice%"=="2" (
    echo Displaying system information...
    systeminfo
    pause
    goto MENU_LOOP
)
if "%choice%"=="3" (
    echo Launching Task Manager...
    start /wait taskmgr
    goto MENU_LOOP
)
if /i "%choice%"=="M" (
    call MainMenu.bat
    exit
)

echo Invalid selection! Please enter a valid option.
timeout /t 2 >nul
goto MENU_LOOP
