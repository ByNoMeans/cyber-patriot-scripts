@echo off
echo Checking if script contains Administrative rights...
net sessions
if %errorlevel%==0 (
  echo Success!
) else (
  echo No admin, please run with Administrative rights...
  pausecmd
)

:MENU
echo Choose An option:

REM :MENU, exceptions, :ONE, reg, net (start, sessions, etc.) etc
REM what about UpNp?

REM echo Removing TelnetClient Test
REM dism /online /disable-feature /featurename:TelnetClient

REM echo Check it worked!

echo You are a great person?
