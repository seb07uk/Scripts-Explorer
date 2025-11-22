
:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
Title Multi-Tools CleanUp by seb07uk
:MENU
echo   [2;3mCreated by Sebastian Januchowski
ECHO.
echo    [1;3;34mMulti-Tools CleanUp[0m
ECHO.
ECHO [2m1 -[0m [1;3;33mEmpty Recycle Bin[0m
ECHO [2m2 -[0m [1;3;33mClean Temporary Files[0m
ECHO [2m3 -[0m [1;3;33mDisk Clean-up[0m
ECHO [2m4 -[0m [1;3;33mAll in One[0m
ECHO.
ECHO [2m5 -[0m [1;31mEXIT[0m
ECHO.
CHOICE /C:12345
IF ERRORLEVEL 1 SET M=1
IF ERRORLEVEL 2 SET M=2
IF ERRORLEVEL 3 SET M=3
IF ERRORLEVEL 4 SET M=4
IF ERRORLEVEL 5 SET M=5
IF %M%==1 GOTO erb
IF %M%==2 GOTO ctf
IF %M%==3 GOTO dcu
IF %M%==4 GOTO aio
IF %M%==5 GOTO EOF
:EOF
EXIT
:aio
CLS
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;36mTask 1/3 Starting...[0m
echo.
echo [1;3;33m--- Emptying Recycle Bin ---[0m
PowerShell -ExecutionPolicy Unrestricted -Command "$bin = (New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | ForEach {; Write-Host "^""Deleting $($_.Name) from Recycle Bin"^""; Remove-Item $_.Path -Recurse -Force; }"
ECHO.
ECHO [1;3;32mEmpty Recycle Bin Completed![0m
echo.
echo [1;36mTask 2/3 Starting...[0m
ECHO.
echo [1;3;33m--- Deleting Temp files ---[0m
echo.[1;31m
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch
echo.[0m
ECHO [1;3;32mClean Temporary Files Completed!![0m
echo.
echo [1;36mTask 3/3 Starting...[0m
ECHO.
echo [1;3;33m--- Running Disk Clean-up ---[0m
cleanmgr /verylowdisk /sagerun:5
echo.
echo [1;3;32mDisk Clean-up Completed!!![0m
echo [5mPress any key to return to the menu.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'All Task Completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
pause >nul
CLS
GOTO MENU
:dcu
CLS
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;33m--- Running Disk Clean-up ---[0m
cleanmgr /verylowdisk /sagerun:5
echo.
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Disk Clean-up Completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo [1;3;32mDisk Clean-up Completed![0m
echo [5mPress any key to return to the menu.[0m
pause >nul
CLS
GOTO MENU
:ctf
CLS
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;33m--- Deleting Temp files ---[0m
echo.[1;31m
del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Temporary files have been deleted.', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
ECHO [1;3;32mTemporary files have been deleted![0m
echo [5mPress any key to return to the menu.[0m
pause >nul
CLS
GOTO MENU
:erb
CLS
echo   [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
echo [1;3;33m--- Emptying Recycle Bin ---[0m[31m
PowerShell -ExecutionPolicy Unrestricted -Command "$bin = (New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | ForEach {; Write-Host "^""Deleting $($_.Name) from Recycle Bin"^""; Remove-Item $_.Path -Recurse -Force; }"
ECHO.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Recycle Bin is empty!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
ECHO [1;3;32mRecycle Bin is empty![0m
echo [5mPress any key to return to the menu.[0m
pause >nul
taskkill /f /im explorer.exe & start explorer
CLS
GOTO MENU
