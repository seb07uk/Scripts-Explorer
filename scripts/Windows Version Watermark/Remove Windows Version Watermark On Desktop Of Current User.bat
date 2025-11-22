:: Created by Sebastian Januchowski
:: polsoft.ITS London
:: polsoft.its@fastservice.com
@echo off
echo   Created by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com
echo.
REG ADD "HKCU\Control Panel\Desktop" /V PaintDesktopVersion /T REG_DWORD /D 0 /F
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'The task has been completed!', 'polsoft.ITS London', [System.Windows.Forms.ToolTipIcon]::None)}"
taskkill /f /im explorer.exe
start explorer.exe