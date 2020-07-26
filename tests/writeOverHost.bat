@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

SET fileName=%~nx0
SET location=%~dp0

goto comment
./writeOverHost.bat
:comment

net session >nul 2>&1
if %errorlevel%==0 (
    echo Administrator rights detected.
    echo Follow instructions of writeOverHost line 16
    :: Run copy /v /y *homeReplacement address* (in flash drive) "%WinDir%\system32\drivers\etc\hosts" in Administrator CMD; include quotes
    pause
    echo Check the file contents of hosts are the same as hostReplacement
    pause
    echo Exiting
    goto end

) else (
    echo Enable Administrator rights. Exiting script.
    pause
    exit
)

:end
