::CREDITS
::@bitcookies - KG - https://github.com/bitcookies/winrar-keygen
::@Matt - Auto-elevate Batch script - https://stackoverflow.com/a/12264592
::@NaeemBolchhi - PowerShell script to download & execute a batch script - https://github.com/NaeemBolchhi/WinRAR-Activator
::@The Answerer - Create the specified folder if it does not exist - https://stackoverflow.com/a/20688004
::@StevenCuong70 / Nguyen Manh Cuong - KG auto downloader, generation, & registration batch script - https://github.com/StevenCuong70/Keygen-Winrar
::@SomethingDark - Download latest release from Github - https://stackoverflow.com/a/69244131
::@Jerry - Move files - https://stackoverflow.com/a/16244577
::@user3319853, @mtb, & @yu-yang-Jian - Delete a folder, a file or all subfolders - https://stackoverflow.com/a/21833668
::@ModByPiash - Repo readme.md format - https://github.com/lstprjct/IDM-Activation-Script
::@vavavr00m (me) - https://github.com/vavavr00m/WinRAR - EN translation & some fixes (added a Batch download method and another PowerShell option that works with my system, delete leftovers script, change absolute paths to relative and/or variable, merge the external batch script)

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 @echo off
 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::

@Echo off
COLOR 1F
set /p input="What is the name to be registered? "
echo The name you just entered is: %input%

CLS

IF NOT EXIST "%~dp0\bin" mkdir "%~dp0\bin"
IF EXIST "bin\rarreg.key" del /f /s /q  "bin\rarreg.key"
IF EXIST "bin\Winrar_keygen.exe" del /f /s /q  "bin\Winrar_keygen.exe"

call :ColorText 0a "[Downloading WinRAR KG..]"

IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
Echo This is a 64bit operating system
set bit=x64
set notbit=x86
set winrarpath=%PROGRAMFILES%\WinRAR
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/bitcookies/winrar-keygen/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

::works with w10 - powershell -command "Invoke-WebRequest -OutFile bin\Winrar_keygen.exe https://github.com/bitcookies/winrar-keygen/releases/download/v2.1.2/winrar-keygen-x64.exe"
::original - powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/bitcookies/winrar-keygen/releases/download/v2.1.2/winrar-keygen-x64.exe', 'bin\Winrar_keygen.exe')"

move winrar-keygen-%bit%.exe "%~dp0\bin"
goto Registration

:32BIT
call :ColorText 0a "This is a 32bit operating system"
set bit=x86
set notbit=x64
set winrarpath=%PROGRAMFILES(X86)%\WinRAR
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/bitcookies/winrar-keygen/releases/latest ^| find "browser_download_url"') do (
    curl -kOL %%B
)

::works with w10 - powershell -command "Invoke-WebRequest -OutFile bin\Winrar_keygen.exe https://github.com/bitcookies/winrar-keygen/releases/download/v2.1.2/winrar-keygen-x86.exe"
::original - powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/bitcookies/winrar-keygen/releases/download/v2.1.2/winrar-keygen-x86.exe', 'bin\Winrar_keygen.exe')"

move winrar-keygen-%bit%.exe "%~dp0\bin"
goto Registration

:REGISTRATION

call :ColorText 0a "[Creating rarreg.key..]"

bin\winrar-keygen-%bit%.exe "%input%" "License" >> bin\rarreg.key
start %SystemRoot%\explorer.exe "C:\Program Files\WinRAR"

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)

GOTO :Beginoffile

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
GOTO :EOF

:Beginoffile

@echo off

COLOR 1F

SET mypath=%~dp0bin\rarreg.key"
xcopy /s /x /y "%mypath:~0,-1%" "%winrarpath%\"
start %SystemRoot%\explorer.exe "%winrarpath%\WinRAR.EXE"
echo(
GOTO :leftovers

:leftovers
echo.
echo Deleting leftovers..
RMDIR /S /Q "bin"
IF EXIST winrar-keygen-%notbit%.exe del /f /s /q winrar-keygen-%notbit%.exe
GOTO :final

:final
echo.
echo In WinRAR window, choose HELP, select ABOUT WinRAR and check active status. If unsuccessful, please try again or report to https://github.com/vavavr00m/WinRAR.
echo.
PAUSE

EXIT
