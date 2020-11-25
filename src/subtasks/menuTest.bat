@echo off

:MENU

set /p input="Enter you choice: "

echo %input%
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
echo You're in One

REM echo Disabling RDP
REM reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
REM reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
REM
REM REM                  vvvv   Check Failsafe Command   vvvv
REM if %errorlevel%==1 netsh advfirewall firewall set service type = remotedesktop mode = disable
REM
REM echo Enabling automatic updates; They'll download, but YOU must MANUALLY INSTALL THEM!!!
REM REM Set registry value (d-value) to 4 for normal automatic download/installation process
REM REM DO THIS AT END
REM
REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f

goto MENU

:Two
echo You're in Two
goto MENU

:Three
echo You're in Three
goto MENU

:Four
echo You're in Four
goto MENU

:Five
echo You're in Five
goto MENU

:Six
echo You're in Six
goto MENU

:Seven
echo You're in Seven
goto MENU

:Eight
echo You're in Eight
goto MENU

:Nine
echo You're in Nine
goto MENU

@echo on
