@echo off
title Loading System Controls v1
color 0A
cls

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

:: Enable Delayed Expansion
setlocal enabledelayedexpansion

:: Prevent direct access - Must come from Welcome.bat
if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)

:: Display Splash Screen
echo ===================================================================================
echo                                 SYSTEM CONTROLS v1
echo ===================================================================================
echo                                        By Eddy
echo                                  Built with ChatGPT
echo ===================================================================================
echo Initializing, please wait...
echo ===================================================================================

:: Define Helpful Tips
set tips[0]=Tip: Use Network Tools to diagnose internet issues.
set tips[1]=Tip: Check for updates regularly to get the latest features.
set tips[2]=Tip: Use the Application Launcher to quickly open your favorite apps.
set tips[3]=Tip: View system information to check your hardware specs.
set tips[4]=Tip: Press [M] to quickly return to the Main Menu.
set tips[5]=Tip: Restart your system if you experience slow performance.
set tips[6]=Tip: Save important data before making system changes.
set tips[7]=Tip: Run 'ipconfig /flushdns' to fix internet connection issues.
set tips[8]=Tip: Close unused applications to free up system memory.
set tips[9]=Tip: Regularly clean temporary files to improve performance.

:: Full-Width Loading Bar Setup
set "full_bar==================================================="
set progress=0
set tipIndex=0
set barLength=50
set /a totalTips=9

:LOADING
:: Random increase between 1-3 blocks
set /a randIncrease=(%random% %% 3) + 1

:: Update progress but limit it to 50 (full bar)
set /a progress+=%randIncrease%
if %progress% gtr %barLength% set progress=%barLength%

:: Calculate percentage (scales progress from 50 blocks to 100%)
set /a percent=progress * 2

:: Rotate tips dynamically
set /a tipIndex=(%random% %% %totalTips%)

:: Update loading bar dynamically
set "bar=!full_bar:~0,%progress%! [ %percent%%% ]"

cls
echo ===================================================================================
echo                                 SYSTEM CONTROLS v1
echo ===================================================================================
echo                                        By Eddy
echo                                  Built with ChatGPT
echo ===================================================================================
echo !tips[%tipIndex%]!
echo ===================================================================================
echo !bar!
echo ===================================================================================
timeout /t 1 >nul

if %progress% lss %barLength% goto LOADING

:: Final Screen Before Launching Main Menu
cls
echo ===================================================================================
echo                                 SYSTEM CONTROLS v1
echo ===================================================================================
echo                                        By Eddy
echo                                  Built with ChatGPT
echo ===================================================================================
echo System Ready!
echo ===================================================================================
timeout /t 2 >nul

:: Proceed to Main Menu
if exist MainMenu.bat (
    call MainMenu.bat
) else (
    echo ERROR: MainMenu.bat not found. Please ensure it is in the correct directory.
    pause
    exit
)

:: Cleanup on exit
del "%mutex_file%" >nul 2>&1
exit
