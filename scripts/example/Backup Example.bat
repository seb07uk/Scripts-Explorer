:: Created by Sebastian Januchowski
:: polsoft.its@fastservice.com
:: https://github.com/seb07uk
@echo off
Title Backup Example
REM Creates a folder with the current date and saves the date to a text file

set folderName=Backup_%date:~6,4%-%date:~3,2%-%date:~0,2%
mkdir %folderName%

echo Date of creation: %date% > %folderName%\info.txt

echo Folder "%folderName%" was created.
pause