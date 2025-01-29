@echo off
title Custom Scripts - System Controls v1
color 0A
cls

:: Ensure access only from Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:: Check for available custom scripts
if not exist CustomScripts (
    mkdir CustomScripts
)

setlocal enabledelayedexpansion
set "script_found=false"

echo ===================================================================================
echo                          AVAILABLE CUSTOM SCRIPTS
echo ===================================================================================

for %%F in (CustomScripts\*.bat) do (
    set "script_found=true"
    echo [SCRIPT] %%~nF
)

if "!script_found!"=="false" (
    echo No custom scripts found in the CustomScripts folder.
)

echo ===================================================================================
echo [M] Return to Main Menu
echo ===================================================================================
set /p choice=Enter the script name to run (or press M to return): 

if /i "%choice%"=="M" (
    call MainMenu.bat
    exit
)

if exist "CustomScripts\\%choice%.bat" (
    call "CustomScripts\\%choice%.bat"
) else (
    echo Script not found! Please enter a valid script name.
    timeout /t 2 >nul
)

goto MAIN_MENU
