@echo off
title Network Tools
color 0A

if not "%menu_access%"=="authorized" (
    echo Please start from the Main Menu to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call MainMenu.bat
    exit
)

:NETWORK_TOOLS
cls
echo ====================================================
echo                  Network Tools
echo ====================================================
echo [1] View IP Configuration
echo [2] View Active Connections
echo [3] Test Internet Connectivity
echo [4] Return to Main Menu
echo ====================================================
echo     Choose an option (1-4): 
set /p choice= 

if %choice%==1 goto VIEW_IP_CONFIG
if %choice%==2 goto VIEW_ACTIVE_CONNECTIONS
if %choice%==3 goto TEST_CONNECTIVITY
if %choice%==4 call MainMenu.bat

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto NETWORK_TOOLS

:VIEW_IP_CONFIG
cls
echo ====================================================
echo              IP Configuration
echo ====================================================
ipconfig
echo ====================================================
echo [M] Return to Network Tools
echo [E] Exit
echo ====================================================
set /p choice=Please choose an option (M/E): 
if /i "%choice%"=="M" goto NETWORK_TOOLS
if /i "%choice%"=="E" goto EXIT

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto VIEW_IP_CONFIG

:VIEW_ACTIVE_CONNECTIONS
cls
echo ====================================================
echo           Active Network Connections
echo ====================================================
netstat -an
echo ====================================================
echo [M] Return to Network Tools
echo [E] Exit
echo ====================================================
set /p choice=Please choose an option (M/E): 
if /i "%choice%"=="M" goto NETWORK_TOOLS
if /i "%choice%"=="E" goto EXIT

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto VIEW_ACTIVE_CONNECTIONS

:TEST_CONNECTIVITY
cls
echo ====================================================
echo        Internet Connectivity Test
echo ====================================================
ping -n 4 8.8.8.8
echo ====================================================
echo [M] Return to Network Tools
echo [E] Exit
echo ====================================================
set /p choice=Please choose an option (M/E): 
if /i "%choice%"=="M" goto NETWORK_TOOLS
if /i "%choice%"=="E" goto EXIT

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto TEST_CONNECTIVITY

:EXIT
exit
