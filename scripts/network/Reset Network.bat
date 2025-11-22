:: Created by Sebastian Januchowski
:: polsoft.ITS London
:: polsoft.its@fastservice.com
@echo off
Title Reset Network
openfiles >nul 2>&1
if %errorlevel% neq 0 (
	echo    [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
echo.
echo                                                     [41mReset Network[0m
echo.
echo                                      [1;3;31mThis script requires administrator privileges.[0m
echo                                          [3;1;31mPlease run Script as an administrator.[0m
echo.
echo                                                [5mPress any key to continue.[0m
	pause >nul
    exit
)
setlocal EnableExtensions DisableDelayedExpansion
	echo   [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
echo [1;3;31m--- Resetting Network ---[0m
echo.[31m
ipconfig /flushdns
ipconfig /release
ipconfig /renew
echo.[0m
echo Your network settings have been reset and your computer will restart shortly.
ping localhost -n 7 >nul
shutdown /r /t 0
