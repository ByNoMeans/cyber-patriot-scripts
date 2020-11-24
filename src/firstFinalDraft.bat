@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

SET fileName=%~nx0
SET location=%~dp0
set v1=false
set v2=false

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
echo 1: Hosts File
echo 2: MISC (ADD IN)
echo.
choice /c 123456789 /m "Enter an Option: "
if errorlevel 2 goto Two
if errorlevel 1 goto One

:One

if "%v1%"=="true" (
  choice /c YN /m "This task has already been done. Do it again?"
  if errorlevel 2 goto MENU
)

set v1=true

if exist C:\Windows\System32\drivers\etc\hosts (
  xcopy /v /y hostReplacement.txt "%WinDir%\system32\drivers\etc\hosts"
  echo.
  echo Host file copied. Verifying integrity:
  echo.
  fc /b hostReplacement.txt "%WinDir%\system32\drivers\etc\hosts"
) else (
  echo Host file not found; put it in C:\Windows\System32\drivers\etc\hosts with no extension
)

echo Exiting Option 1.
pause
goto MENU

:Two
    if "%v2%"=="true" (
      choice /c YN /m "This task has already been done. Do it again?"
      if errorlevel 2 goto MENU
    )

    set v2=true

    echo Exiting Option 2.
    pause
    goto MENU

    :: UAC
    :: reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
    :: Terminal sessions/server bad
    :: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
    :: Actually disable RDP
    :: reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
    :: Failsafe
    :: if %errorlevel%==1 netsh advfirewall firewall set service type = remotedesktop mode = disable
    :: choice /c YN /m "Continue and enable automatic updates? (downloaded automatically, installed manually)"
    :: if errorlevel 1 (
    ::     echo Don't forget to install the updates
    ::     reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f
    :: )
    :: choice /c YN /m "Continue and clean DNS cache?"
    :: if errorlevel 1 (
    ::   ipconfig /flushdns
    :: )

:end
endlocal
@echo on
@exit /B 0