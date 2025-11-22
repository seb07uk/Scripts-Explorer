:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
Title ps1 launcher
if not exist "script.ps1" (
    echo --- Error: The script "script.ps1" was not found in the current directory ---
    echo Please ensure the PowerShell script is in the same folder as this batch file. This batch file just launches the script.
	echo.
	echo Press any key to exit...
	pause > nul
)
powershell -NoProfile -ExecutionPolicy Bypass -File "script.ps1"