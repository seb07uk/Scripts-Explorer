:: Sebastian Januchowski
:: polsotf.ITS London
:: polsoft.its@fastservice.com
@echo off
title Disk (D) Defrag by polsoft.ITS
openfiles >nul 2>&1
if %errorlevel% neq 0 (
	echo   [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
	echo.
    echo                                      [1;3;31mThis script requires administrator privileges.[0m
    echo                                          [3;1;31mPlease run Script as an administrator.[0m
	echo.
	echo                                                [5mPress any key to continue.[0m
	pause >nul
    exit
)
setlocal EnableExtensions DisableDelayedExpansion
	echo  [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
echo Defragmenting hard disks D: ...
echo.[33m
ping localhost -n 3 >nul
defrag d: -v
echo.[0m
echo Disk D: defragmentation completed successfully !!!
echo.
echo.
echo Press any key to exit. . .
echo.
echo   [44m[3mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com[0m
pause >nul