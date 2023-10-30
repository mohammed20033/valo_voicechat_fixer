@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

ECHO Starting Valorant Voip Routing 
set ip="IP Address"
rem set ip="IP Address"
for /f "tokens=3 delims=: " %%I in ('netsh interface IPv4 show addresses "vpn" ^| findstr /C:%ip%') do set ip_address=%%I
route add 188.0.0.0 mask 255.0.0.0 %ip_address%

ECHO ***********************DONE***********************
ECHO Valorant Voice by seveN
Pause
