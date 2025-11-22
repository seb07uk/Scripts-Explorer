@echo off
CLS
:MENU
echo   [3;2mWritten by Sebastian Januchowski                  polsoft.ITS                   e-mail: polsoft.its@fastservice.com 
echo. [0m
ECHO.
echo SYSTEM
ECHO.
ECHO 1 - About System 
ECHO 2 - Open Calculator
ECHO 3 - Open Notepad AND Calculator
ECHO 4 - EXIT
ECHO.
CHOICE /C:1234
IF ERRORLEVEL 1 SET M=1
IF ERRORLEVEL 2 SET M=2
IF ERRORLEVEL 3 SET M=3
IF ERRORLEVEL 4 SET M=4
IF %M%==1 GOTO 01
IF %M%==2 GOTO CALC
IF %M%==3 GOTO BOTH
IF %M%==4 GOTO EOF
:NOTE
cd %windir%\system32\notepad.exe
start notepad.exe
CLS
GOTO MENU
:CALC
cd %windir%\system32\calc.exe
start calc.exe
CLS
GOTO MENU
:01
%SystemRoot%\explorer.exe ms-settings:about
CLS
GOTO MENU