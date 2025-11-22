:: Created by Sebastian Januchowski
:: polsoft.ITS London
:: polsoft.its@fastservice.com
@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
title DISM and SFC All in One
title DISM and SFC Tools
CLS
:MENU
echo         [13;2mWritten by Sebastian Januchowski          GitHub: https://github.com/seb07uk[0m
echo.
echo.
echo                               [1;3;5;32m--- DISM and SFC Tools ---[0m 
ECHO.
ECHO 1 [36mAnalyze Component Store[0m         4 [36mSystem Component Cleanup[0m       7 [36mHealth Check[0m
ECHO 2 [36mSystem Files Verification[0m       5 [36mHealth Restore[0m                 8 [36mSystem Reset Base[0m
ECHO 3 [36mSystem File Checker[0m             6 [36mHealth Scan[0m                    9 [36mExit[0m
ECHO.
CHOICE /C:123456789 >nul
IF ERRORLEVEL 1 SET M=1
IF ERRORLEVEL 2 SET M=2
IF ERRORLEVEL 3 SET M=3
IF ERRORLEVEL 4 SET M=4
IF ERRORLEVEL 5 SET M=5
IF ERRORLEVEL 6 SET M=6
IF ERRORLEVEL 7 SET M=7
IF ERRORLEVEL 8 SET M=8
IF ERRORLEVEL 9 SET M=9
IF %M%==1 GOTO 01
IF %M%==2 GOTO 02
IF %M%==3 GOTO 03
IF %M%==4 GOTO 04
IF %M%==5 GOTO 05
IF %M%==6 GOTO 06
IF %M%==7 GOTO 07
IF %M%==8 GOTO 08
IF %M%==9 GOTO 09
:01
CLS
echo         [13;2mWritten by Sebastian Januchowski          GitHub: https://github.com/seb07uk[0m
echo.
echo [1;3;32m--- Analyze Component Store (DISM) ---[0m
Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Analyze Component Store is is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
timeout /t 3 >nul
CLS
GOTO MENU
:02
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- System Files Verification (SFC) ---[0m
sfc /verifyonly
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System Files Verification (SFC) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
cls
GOTO MENU
:03
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- System File Checker (SFC) ---[0m
sfc /scannow
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System File Checker (SFC) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
CLS
GOTO MENU
:04
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- System Component Cleanup (DISM) ---[0m
Dism.exe /online /Cleanup-Image /StartComponentCleanup
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System Component Cleanup (DISM) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
CLS
GOTO MENU
:05
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- Health Restore ---[0m
DISM /online /cleanup-image /restorehealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Restore (DISM) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
CLS
GOTO MENU
:06
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- Health Scan (DISM) ---[0m
DISM /online /cleanup-image /scanhealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Scan (DISM) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 3 >nul
CLS
GOTO MENU
:07
CLS
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- Health Check (DISM) ---[0m
DISM /online /cleanup-image /checkhealth
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Health Check (DISM) is Complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 5 >nul
CLS
GOTO MENU
:08
cls
echo   [13;2mWritten by Sebastian Januchowski[0m
echo.
echo [1;3;32m--- System Reset Base (DISM) ---[0m
Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'System Reset Base (DISM) complete!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
timeout /t 5 >nul
CLS
GOTO MENU
:09
exit
