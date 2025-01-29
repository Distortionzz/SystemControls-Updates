@echo off
title Application Launcher
color 0A

if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:APP_LAUNCHER
cls
echo ==============================
echo       Application Launcherss
echo ==============================
echo [1] Open Default Browser
echo [2] Open YouTube
echo [3] Manual Launch
echo [4] Return to Main Menu
echo ==============================
set /p choice=Choose an option (1-4): 

if %choice%==1 goto OPEN_BROWSER
if %choice%==2 goto OPEN_YOUTUBE
if %choice%==3 goto MANUAL_LAUNCH
if %choice%==4 call MainMenu.bat

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto APP_LAUNCHER

:OPEN_BROWSER
cls
echo ==============================
echo       Open Default Browser
echo ==============================
start "" "https://www.google.com"
echo Browser launched. Returning to Application Launcher...
timeout /t 3 >nul
goto APP_LAUNCHER

:OPEN_YOUTUBE
cls
echo ==============================
echo        Open YouTube
echo ==============================
start "" "https://www.youtube.com"
echo YouTube opened in your browser. Returning to Application Launcher...
timeout /t 3 >nul
goto APP_LAUNCHER

:MANUAL_LAUNCH
cls
echo ==============================
echo         Manual Launch
echo ==============================
echo Enter the full path of the application (.exe) or website (URL):
set /p shortcut_path=Path: 
if "%shortcut_path%"=="" (
    echo No path entered. Returning to Application Launcher...
    timeout /t 3 >nul
    goto APP_LAUNCHER
)
start "" "%shortcut_path%"
echo Shortcut launched. Returning to Application Launcher...
timeout /t 3 >nul
goto APP_LAUNCHER
