@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

SET fileName=%~nx0
SET location=%~dp0
set v1=false
set v2=false

goto comment
./firstFinalDraft.bat
:comment

echo DO NOT RUN THIS FILE ON NATIVE MACHINE; IT WILL DO DANGEROUS THINGS
pause
echo ARE YOU SURE?
pause
echo REALLY?
pause
echo FINE.
pause

net session >nul 2>&1
if %errorlevel%==0 (
    echo Administrator rights detected.
) else (
    echo Enable Administrator rights. Exiting script.
    pause
    exit
)

::Align these to menu; reorganize; make sure they say the right things
:MENU
echo Options:
echo 1: RDP, Automatic Updates, DNS Cache, Host File
echo 2: Removed Save Credentials
echo 3: Changing Password Policies
echo 4: Find Files
echo 5: Disable Remote Desktop
echo 6: Enable Auto-Update
echo 7: Disable Weak services
echo 8: System Integrity Scan
echo 9: Powershell rootkit detection

choice /c 123456789 /m "Enter an Option: "
if errorlevel 2 goto Two
if errorlevel 1 goto One


:One

    if "%v1%"=="true" (
      choice /c YN /m "This task has already been done. Do it again?"
      if errorlevel 2 goto MENU
    )

    set v1=true

    echo Disabling RDP (Remote Desktop Protocol)

    ::UAC
    reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
    ::Terminal sessions/server bad
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
    ::Actually disable RDP
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
    ::Failsafe
    if %errorlevel%==1 netsh advfirewall firewall set service type = remotedesktop mode = disable

    choice /c YN /m "Continue and enable automatic updates? (downloaded automatically, installed manually)"
    if errorlevel 1 (
        echo Don't forget to install the updates
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f
    )

    choice /c YN /m "Continue and clean DNS cache?"
    if errorlevel 1 (
      ipconfig /flushdns
    )

    choice /c YN /m "Continue and write over the hosts file?"
    if errorlevel 1 (
         :: Called hosts, not host
         if exist C:\Windows\System32\drivers\etc\hosts (
              if exist D:\hostReplacement (
                 type D:\hostReplacement > C:\Windows\System32\drivers\etc\hosts
                 echo Contents of hosts file overridden. Double checking contents are equal.
                 fc C:\Windows\System32\drivers\etc\hosts D:\hostReplacement
                 pause
               ) else (
                 echo hostReplacement not found; must be in D:\hostReplacement with no extension
                 pause
               )
         ) else (
           echo Host file not found; put it in C:\Windows\System32\drivers\etc\hosts with no extension
           pause
         )
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


    echo Removing all saved credentials

    ::Removed Saved Credentials
    cmdkey.exe /list > "%TEMP%\List.txt"
    findstr.exe Target "%TEMP%\List.txt" > "%TEMP%\tokensonly.txt"
    FOR /F "tokens=1,2 delims= " %%G IN (%TEMP%\tokensonly.txt) DO cmdkey.exe /delete:%%H
    del "%TEMP%\*.*" /s /f /q

    echo Exiting Option 2.
    pause
    goto MENU


:end
endlocal
@echo on
@exit /B 0
