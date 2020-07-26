@echo off

title Enable Firewall

REM command to enable firewall for all user accounts
netsh advfirewall set allprofiles state on

pause


