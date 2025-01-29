@echo off
title User Preferences - System Controls v1
color 0A
cls

:: Ensure access only from Welcome screen
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:MAIN_MENU
echo ===================================================================================
echo                             USER PREFERENCES MENU
echo ===================================================================================
echo [1] Change Console Colors
echo [2] Enable/Disable Warning Messages
echo [3] Set Custom Timeout Duration
echo [M] Return to Main Menu
echo ===================================================================================
set /p choice=Enter your choice: 

if "%choice%"=="1" (
    echo Select a new console color (e.g., 0A for green on black)...
    set /p color_code=Enter new color code: 
    color !color_code!
    echo Console color changed successfully!
    timeout /t 2 >nul
    goto MAIN_MENU
)
if "%choice%"=="2" (
    echo Enable or disable warning messages.
    echo [1] Enable
    echo [2] Disable
    set /p warn_choice=Enter your choice: 
    
    if "%warn_choice%"=="1" (
        echo Warning messages enabled.
    )
    if "%warn_choice%"=="2" (
        echo Warning messages disabled.
    )
    timeout /t 2 >nul
    goto MAIN_MENU
)
if "%choice%"=="3" (
    echo Set a custom timeout duration (in seconds)...
    set /p custom_timeout=Enter timeout duration: 
    timeout /t !custom_timeout! >nul
    goto MAIN_MENU
)
if /i "%choice%"=="M" (
    call MainMenu.bat
    exit
)

echo Invalid selection! Please enter a valid option.
timeout /t 2 >nul
goto MAIN_MENU
