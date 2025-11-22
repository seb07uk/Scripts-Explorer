:: Created by Sebastian Januchowski
:: polsoft.ITS London
:: polsoft.its@fastservice.com
@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
Title System Image Repair (S.I.R)
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo.
echo  [33m System Image Repair Starting...[0m [36m
DISM /Online /Cleanup-Image /RestoreHealth
echo. [0m
echo [32mTask 1/2 Completed...[0m
timeout /t 5 >nul
cls
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo.
echo    [33mPreparation System File Scanning...[0m 
timeout /t 5 >nul
cls
echo   [2;3mCreated by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
echo.
echo.
echo [33mSystem file scanning...[0m[36m
sfc /scannow
echo.[0m
echo [32mTask 2/2 Completed...[0m
timeout /t 5 >nul
exit