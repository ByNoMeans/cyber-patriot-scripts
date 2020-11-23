@echo off
setlocal enabledelayedexpansion
setlocal enableextensions
set fileName=%~nx0
set location=%~dp0

set visitedOne=false

:MENU
choice /c 12 /m "Enter an option: "
if errorlevel 1 goto Uno
if errorlevel 2 goto Dos

:Uno
echo visited: %visitedOne%
if NOT "%visitedOne%"=="false" (
  choice /c YN /m "This task has already been done. Do it again?"
  if errorlevel 2 (
    echo Going to menu.
    goto MENU
  )
)
set visitedOne=true
echo going to menu
goto MENU
:Dos
echo in Dos
goto MENU

endlocal
