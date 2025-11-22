:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
title DISM and SFC All in One
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;32m--- DISM and SFC All in One ---[0m
echo.
timeout /t 2 >nul
echo [1;3;32m--- Analyze Component Store (DISM) ---[0m
Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Analyze Component Store (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- System Files Verification (SFC) ---[0m
sfc /verifyonly
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System Files Verification (SFC) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- System File Checker (SFC) ---[0m
sfc /scannow
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System File Checker (SFC) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- System Component Cleanup (DISM) ---[0m
Dism.exe /online /Cleanup-Image /StartComponentCleanup
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System Component Cleanup (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- Health Restore ---[0m
DISM /online /cleanup-image /restorehealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Restore (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- Health Scan (DISM) ---[0m
DISM /online /cleanup-image /scanhealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Scan (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
echo [1;3;32m--- Health Check (DISM) ---[0m
DISM /online /cleanup-image /checkhealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Check (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 5 >nul
endlocal
taskkill /f /im explorer.exe & start explorer & exit