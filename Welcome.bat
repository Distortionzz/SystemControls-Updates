@echo off
title Welcome - System Controls v1
color 0A
cls

:: Enable Delayed Expansion
setlocal enabledelayedexpansion

:: Set access variable (ensures users go through Welcome first)
set "menu_access=authorized"

:: Define GitHub update server URL (Correct raw URL)
set "UPDATE_SERVER=https://raw.githubusercontent.com/Distortionzz/SystemControls-Updates/main"

:: List of files to check for updates
set "FILES=Option1.bat Option2.bat Option3.bat MainMenu.bat SplashScreen.bat SystemUtilities.bat"
set "VER_FILES=Option1_version.txt Option2_version.txt Option3_version.txt MainMenu_version.txt SplashScreen_version.txt SystemUtilities_version.txt"
set "WELCOME_VERSION_FILE=Welcome_version.txt"

:: Ensure local version files exist
for %%F in (%VER_FILES%) do (
    if not exist %%F echo 1.0 > %%F
)

:: Ensure Welcome version file exists locally
if not exist !WELCOME_VERSION_FILE! echo 1.0 > !WELCOME_VERSION_FILE!

:: Hide version files after creating them
attrib +h Welcome_version.txt
attrib +h MainMenu_version.txt

:MAIN_MENU
cls
echo ===================================================================================
echo                              WELCOME TO SYSTEM CONTROLS v1
echo ===================================================================================
echo                                        By Eddy
echo                                  Built with ChatGPT
echo ===================================================================================
echo Please select an option:
echo.
echo   [1] Launch Main Frame
echo   [2] Restart Program
echo   [3] Help
echo   [4] Check for Updates
echo   [5] Exit
echo.
set /p choice=Enter your choice: 

if "%choice%"=="1" goto launch_main_frame
if "%choice%"=="2" goto restart_program
if "%choice%"=="3" goto help_menu
if "%choice%"=="4" goto check_updates
if "%choice%"=="5" goto exit_program

:: Invalid input handling - Loop back to the menu
echo Invalid selection! Please enter a valid option.
timeout /t 2 >nul
goto MAIN_MENU

:launch_main_frame
echo Launching Main Frame...
call SplashScreen.bat
call MainMenu.bat
goto MAIN_MENU

:restart_program
echo Restarting...
timeout /t 2 >nul
goto MAIN_MENU

:help_menu
cls
echo ===================================================================================
echo                                     HELP MENU
echo ===================================================================================
echo [1] Launch Main Frame  - Start the main system interface.
echo [2] Restart Program    - Restart System Controls without closing the console.
echo [3] Help               - Display this help menu with detailed descriptions.
echo [4] Check for Updates  - Verify if a new version is available. If updates are 
echo                          found, a download link will be provided.
echo [5] Exit               - Close System Controls safely.
echo ===================================================================================
echo NOTE: Updates are manually installed. If an update is available, visit the 
echo       provided GitHub link to download the latest version.
echo ===================================================================================
echo Press any key to return to the Welcome screen...
pause >nul
goto MAIN_MENU

:check_updates
cls
echo ===================================================================================
echo                              CHECKING FOR UPDATES
echo ===================================================================================
echo Please wait, checking for updates...

:: Initialize update flag
set "UPDATE_FOUND=false"

:: Fetch latest version of Welcome.bat from GitHub
set "LATEST_VERSION="
for /f "tokens=* delims=" %%A in ('powershell -command "(New-Object Net.WebClient).DownloadString('%UPDATE_SERVER%/Welcome_version.txt')"') do set "LATEST_VERSION=%%A"

:: Read local version
set /p LOCAL_VERSION=<Welcome_version.txt

:: Display versions
echo.
echo Checking: Welcome.bat
echo Installed Version: %LOCAL_VERSION%
echo Latest Version: %LATEST_VERSION%

if not "%LOCAL_VERSION%"=="%LATEST_VERSION%" (
    echo.
    echo *** UPDATE AVAILABLE for Welcome.bat ***
    echo A new version is available. Please download it manually:
    echo %UPDATE_SERVER%/Welcome.bat
    echo.
    set "UPDATE_FOUND=true"
) else (
    echo No updates found for Welcome.bat.
)
echo.

:: Check updates for other files
for %%F in (%FILES%) do (
    set "LOCAL_VERSION="
    set "LATEST_VERSION="

    set "BASE_NAME=%%~nF"

    :: Read local version
    if exist !BASE_NAME!_version.txt (
        set /p LOCAL_VERSION=<!BASE_NAME!_version.txt
    ) else (
        echo 1.0 > !BASE_NAME!_version.txt
        set "LOCAL_VERSION=1.0"
    )

    :: Fetch latest version from GitHub
    for /f "tokens=* delims=" %%A in ('powershell -command "(New-Object Net.WebClient).DownloadString('%UPDATE_SERVER%/!BASE_NAME!_version.txt')"') do set "LATEST_VERSION=%%A"

    :: Display versions
    echo Checking: %%F
    echo Installed Version: !LOCAL_VERSION!
    echo Latest Version: !LATEST_VERSION!

    if not "!LOCAL_VERSION!"=="!LATEST_VERSION!" (
        echo.
        echo *** UPDATE AVAILABLE for %%F ***
        echo A new version is available. Please download it manually:
        echo %UPDATE_SERVER%/%%F
        echo.
        set "UPDATE_FOUND=true"
    ) else (
        echo No updates found for %%F.
    )
    echo.
)

:: Notify user if updates were found
if "%UPDATE_FOUND%"=="true" (
    echo Updates are available. Please visit the GitHub repository to download the updated files.
    echo GitHub Repository: https://github.com/Distortionzz/SystemControls-Updates
) else (
    echo No updates available.
)

echo.
echo Update check completed successfully.
echo Press any key to return to the menu...
pause >nul
goto MAIN_MENU

:exit_program
echo Exiting System Controls...
timeout /t 2 >nul
exit
