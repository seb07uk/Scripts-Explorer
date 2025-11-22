:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
title Battery  iNfO
echo    [2;3mCreated by Sebastian Januchowski[0m
echo.
echo [1;3;5;36m--- Battery  iNfO ---[0m[1;3;32m
echo.
cd %windir%\System32\
powercfg/energy
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Power Efficiency Diagnostics Report is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo [6mpress any key to open raport . . .[0m
pause >nul
start energy-report.html
exit