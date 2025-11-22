:: Created by Sebastian Januchowski
:: polsoft.ITS London
:: polsoft.its@fastservice.com
@echo off
CLS
:MENU
echo   [13;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
ECHO.
echo                            [1;3;5;32m--- iNfO'diag ---[0m
ECHO.
ECHO      1 [36mComputer[0m          4 [36mCPU[0m            7 [36mNet Adapter[0m
ECHO      2 [36mSystem[0m            5 [36mRAM[0m            8 [36mDrive and Volume[0m
ECHO      3 [36mBIOS[0m              6 [36mVideo[0m          9 [36mInstalled Drivers[0m
ECHO.
CHOICE /C:123456789e >nul
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
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;36m--- Computer iNfO ---[0m[32;1;3m
powershell -Command "& {Get-ComputerInfo}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Computer iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU
:02
CLS
title System iNfO
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;36m--- System iNfO ---[0m[1;3;32m
echo.[0m
systeminfo 
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'The System iNfO is ready!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU
:03
CLS
echo    [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.[0m
echo [1;3;5;36m--- BIOS iNfO ---[0m[1;3;32m
powershell -Command "& {Get-Date; Get-CimInstance Win32_BIOS}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'BIOS iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
pause
CLS
GOTO MENU
:04
CLS
echo    [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- CPU iNfO ---[0m[1;3;32m
powershell -Command "& {Get-Date; Get-CimInstance Win32_Processor}"
powershell -Command "& {Get-CimInstance Win32_Processor}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'CPU iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
pause
CLS
GOTO MENU
:05
CLS
echo    [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- RAM Channel iNfO ---[0m
echo.[1;3;5;32m
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo [1;3;5;36m--- RAM iNfO ---[0m[32;1;3m
powershell -Command "& {Get-CimInstance Win32_PhysicalMemory}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'RAM iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU
:06
CLS
echo    [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- Video Controller iNfO ---[0m[1;3;32m
powershell -Command "& {Get-CimInstance Win32_VideoController}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Video Controller iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo    [3;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU
:07
CLS
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- Net Adapter iNfO ---[0m[1;3;32m
powershell -Command "& {Get-NetAdapter}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Net Adapter iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
pause
CLS
GOTO MENU
:08
CLS
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- Drive and Volume iNfO ---[0m[1;3;32m
powershell -Command "& {Get-Volume; Get-CimInstance Win32_DiskDrive}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Drive and Volume iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU
:09
CLS
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;36m--- List of Installed Drivers ---[0m[1;3;32m
driverquery
echo.[0m
echo    [5;2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul
CLS
GOTO MENU