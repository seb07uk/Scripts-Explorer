:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: Ping-er
@echo off
color a
title Ping-er By sebo7uk
echo =====-Ping-er By sebo7uk-=====
set /p IP="Host: "
:top
PING -n 1 %IP% | FIND "TTL="
IF ERRORLEVEL 1 (SET in=0b & echo No host specified...)
color %in%
ping -t 2 0 10 127.0.0.1 >nul
GoTo top