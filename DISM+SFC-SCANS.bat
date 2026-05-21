TITLE DISM + SFC SCANS

:ELEVATE
@echo off
setlocal enabledelayedexpansion

:: Check for Mandatory Label\High Mandatory Level
whoami /groups | find "S-1-16-12288" > nul
if "%errorlevel%"=="0" (
echo Running as elevated user. Continuing script.
) else (
CLS
COLOR 0C
echo Not running as elevated user.
ECHO.
echo Close and Right Click Run As Administrator
ECHO.
ECHO.
pause
exit
)


:AV
CLS
COLOR 4F
ECHO.
ECHO FULLY DISABLE ALL AV and MBAM
ECHO.
ECHO FULLY DISABLE ANY BACKUP OR FILE SYNC APPS (DROPBOX etc.)
ECHO.
ECHO PRESS ANY KEY ONCE THESE ARE DONE...
PAUSE > NUL

CLS
COLOR 0F
ECHO.
ECHO If DISM seems stuck, start PowerShell as ADMIN
ECHO.
ECHO then type; Get-Content C:\Windows\Logs\CBS\CBS.log -tail 10 -wait
ECHO.
ECHO DISM is truly finished at Ending TrustedInstaller finalization
ECHO.
ECHO.
ECHO RUNNING DISM Cleanup-image Restorehealth
ECHO.
DISM.exe /Online /Cleanup-image /Restorehealth

ECHO.
ECHO RUNNING SFC
sfc /scannow


:POST2
COLOR 4F
ECHO.
ECHO IF SFC ABOVE DID NOT RETURN:
ECHO Windows Resource Protection did not find any integrity violations.
ECHO Press 1 to RUN SFC AGAIN...
ECHO.
ECHO Otherwise Press 2 to exit...
Set /P _type=1 RUN SFC or 2 EXIT? || Set _type=NothingChosen
If "%_type%"=="NothingChosen" goto :sub_error
If /i "%_type%"=="1" goto sub_1
If /i "%_type%"=="2" goto sub_2
if not defined option goto :sub_error
goto:eof
ECHO.
PAUSE
DEL %0

:sub_1
CLS
COLOR 0F
ECHO.
ECHO RUNNING 2nd SFC SCAN
sfc /scannow
EXIT


:sub_2
EXIT


:sub_error
ECHO.
echo Nothing was chosen
ECHO.
PAUSE
GOTO POST2