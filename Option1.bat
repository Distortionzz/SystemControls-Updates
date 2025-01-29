@echo off
title System Information
color 0A

if not "%menu_access%"=="authorized" (
    echo Please start from the Welcome screen to access this feature. Redirecting you now...
    timeout /t 3 >nul
    call Welcome.bat
    exit
)


:SYSTEM_INFO
cls
echo ==============================
echo       System Information
echo ==============================
echo Computer Name: %COMPUTERNAME%
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value ^| find "="') do echo Operating System: %%a
for /f "tokens=2 delims==" %%a in ('wmic cpu get Name /value ^| find "="') do echo Processor: %%a
for /f "tokens=*" %%a in ('powershell -command "Get-WmiObject Win32_VideoController | Select-Object -ExpandProperty Name"') do (
    echo Graphics Card: %%a
)
echo ==============================
echo [M] Return to Main Menu
echo [E] Exit
echo ==============================
set /p choice=Please choose an option (M/E): 
if /i "%choice%"=="M" call MainMenu.bat
if /i "%choice%"=="E" goto EXIT

echo Invalid choice. Please try again.
goto SYSTEM_INFO

:EXIT
exit
