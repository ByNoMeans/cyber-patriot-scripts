@echo off


REM title for title window, unecessary

title Disable Guest Account


REM When changing accounts in any way, use net user

net user guest /active:no

REM guest disabled


