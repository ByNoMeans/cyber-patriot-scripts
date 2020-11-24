@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

SET fileName=%~nx0
SET location=%~dp0

set v1=false

:: Admin permissions
net session >nul 2>&1
if %errorlevel% GEQ 1 (
    echo Enable Administrator rights. Exiting script.
    pause
    exit
)

:MENU
echo.
echo Options:
echo 1: Host File

choice /c 1 /m "Enter an Option: "
echo.

if errorlevel 1 goto One

:One
if "%v1%"=="true" (
    choice /c YN /m "This task has already been done. Do it again?"
    if errorlevel 2 goto MENU
    echo.
)

set v1=true
echo Overriding /etc/hosts file

if exist C:\Windows\System32\drivers\etc\hosts (
    xcopy /v /y hostReplacement.txt "%WinDir%\system32\drivers\etc\hosts"
    echo.
    echo Host file copied. Verifying integrity:
    echo.
    fc /b hostReplacement.txt "%WinDir%\system32\drivers\etc\hosts"
    echo.
) else (
    echo Host file not found; put it in C:\Windows\System32\drivers\etc\hosts with no extension
)

pause
goto MENU