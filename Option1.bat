@echo off
title System Control v1 - Option 1
setlocal enabledelayedexpansion

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

:: Main Option 1 Logic Here
echo Displaying System Information...
timeout /t 5 >nul

:: Cleanup on exit
del "%mutex_file%" >nul 2>&1
exit
