:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
title Drive and Volume iNfO
echo    [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo [1;3;5;34m--- Drive and Volume iNfO ---[0m
echo.[1;3;5;33m
powershell -Command "& {Get-Volume; Get-CimInstance Win32_DiskDrive}"
echo.[0m
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Drive and Volume iNfO is Ready...!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
pause