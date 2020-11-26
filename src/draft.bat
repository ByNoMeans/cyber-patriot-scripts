@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

SET fileName=%~nx0
SET location=%~dp0


:: Administrator Permissions
net session >nul 2>&1
if %errorlevel% GEQ 1 (
    echo Enable Administrator rights. Exiting script.
    pause
    exit
)

set v1=false
set v2=false
set v3=false
set v4=false
set v5=false
set v6=false
set v7=false
set v8=false
set v9=false

:MENU
echo.
set returnToMenu=false
echo ----------------
echo MENU:
echo 1: Hosts File
echo 2: MISC (ADD IN)
echo 3: Chocolatey/Anti-Malware, Anti-Virus
echo ----------------
echo.

set /p input="Where would you like to go? "
echo.

if %input%==9 goto Nine
if %input%==8 goto Eight
if %input%==7 goto Seven
if %input%==6 goto Six
if %input%==5 goto Five
if %input%==4 goto Four
if %input%==3 goto Three
if %input%==2 goto Two
if %input%==1 goto One



:One
call :DetectIfTaskDone %v1%
@echo off
if "%returnToMenu%"=="true" goto MENU
set v1=true

if exist C:\Windows\System32\drivers\etc\hosts (
  xcopy /v /y "..\external\hostReplacement.txt" "%WinDir%\system32\drivers\etc\hosts"
  echo.
  echo Host file copied. Verifying integrity:
  echo.
  fc /b "..\external\hostReplacement.txt" "%WinDir%\system32\drivers\etc\hosts"
) else (
  echo Host file not found; put it in C:\Windows\System32\drivers\etc\hosts with no extension
)
goto MENU


:Two
call :DetectIfTaskDone %v2%
@echo off
if "%returnToMenu%"=="true" goto MENU
set v2=true


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
goto MENU


:Three
call :DetectIfTaskDone %v3%
@echo off
if "%returnToMenu%"=="true" goto MENU
set v3=true

powershell -Command "& {Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}"

choco install malwarebytes
choco install microsoftsecurityessentials

echo.
echo --------------------------------------------------
echo Verify existence of both programs (Control panel!)
echo --------------------------------------------------
echo.
pause

goto MENU

:Four



:Five



:Six



:DetectIfTaskDone
@echo off
if "%~1"=="true" (
  choice /c NY /M "This task has already been done. Return to menu?"
  if errorlevel 2 (
    set returnToMenu=true
  ) else (
    set returnToMenu=false
  )
  echo.
)


:end
endlocal
@echo on
@exit /B 0