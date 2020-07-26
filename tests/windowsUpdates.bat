@echo off
start
title enableWindowsUpdates

REM changing registry keys
REM be careful, modifying may screw up system


REM Key for enabling automatic updates

REM reg (duh) + add a key + PATH OF KEY
REM the "/v" is enabling a certain switch to make it automatic
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 3 /f

pause