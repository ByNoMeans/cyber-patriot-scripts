@echo off
:: CHANGE THIS BACK TO CORRECT ADDRESS
REM if exist C:\Windows\System32\drivers\etc\hosts (
if exist C:\Users\barre\Dropbox\CyberPatriot\testHost (
  :: CHANGE THIS BACK TO D:\
  REM if exist D:\hostReplacement (
  if exist C:\Users\barre\Dropbox\CyberPatriot\hostReplacement (
    type hostReplacement > C:\Users\barre\Dropbox\CyberPatriot\testHost
    echo Contents of host file overridden. Double checking contents are equal.
    fc C:\Users\barre\Dropbox\CyberPatriot\testHost hostReplacement
    pause
  ) else (
    echo Check hostReplacement file name; must be in D:\hostReplacement with no extension
  )
) else (
  echo Host file not found; put it in System32, drivers, etc, hosts with no extension
)
