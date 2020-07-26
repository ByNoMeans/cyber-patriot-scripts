@echo off
setlocal enabledelayedexpansion
setlocal enableextensions

set me=%~n0
set location=%~dp0

set visitedOne=false
set visitedTwo=false
set visitedThree=false
set visitedThree=false
set visitedFour=false
set visitedFive=false
set visitedSix=false
set visitedSeven=false
set visitedEighte=false
set visitedNine=false


goto comment
RUN BY CMD WITH ADMINISRATOR PERMISSIONS
./test.bat
:comment


:end
endlocal
@echo on
@exit /B 0
