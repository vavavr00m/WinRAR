:: batch script portion

::CREDITS
::@bitcookies - KG - https://github.com/bitcookies/winrar-keygen
::@Matt - Auto-elevate Batch script - https://stackoverflow.com/a/12264592
::@NaeemBolchhi - PowerShell script to download & execute a batch script - https://github.com/NaeemBolchhi/WinRAR-Activator
::@The Answerer - Create the specified folder if it does not exist - https://stackoverflow.com/a/20688004
::@StevenCuong70 / Nguyen Manh Cuong - KG auto downloader, generation, & registration batch script - https://github.com/StevenCuong70/Keygen-Winrar
::@Jerry - Move files - https://stackoverflow.com/a/16244577
::@user3319853, @mtb, & @yu-yang-Jian - Delete a folder, a file or all subfolders - https://stackoverflow.com/a/21833668
::@ModByPiash - Repo readme.md format - https://github.com/lstprjct/IDM-Activation-Script
::@dbenham - Make a batch delete itself - https://stackoverflow.com/a/20333575/21996598
::@Tux 528 - GH download specific release - https://nsaneforums.com/profile/105674-tux-528/
::@rojo - Download & install latest WinRAR from batch - https://stackoverflow.com/a/15777517/21996598
::@vavavr00m (me) - https://github.com/vavavr00m/WinRAR - EN translation & some fixes (added a Batch download method and another PowerShell option that works with my system, delete leftovers script, change absolute paths to relative and/or variable, merge the external batch script)

@echo off
CLS

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 8
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 
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
  whoami /groups /nh | find "S-1-16-12288" > nul
  if '%errorlevel%' == '0' ( goto checkPrivileges2 ) else ( goto getPrivileges )


:checkPrivileges2
  net session 1>nul 2>NUL
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

COLOR 1F

CLS

IF EXIST "%PROGRAMFILES(X86)%" ( GOTO :64BIT ) ELSE ( GOTO :32BIT )

:: ====================================
:64BIT
:: ====================================
set bit=x64
set notbit=x86
ECHO.
ECHO This is a %bit% operating system
set "winrarpath=%PROGRAMFILES%\WinRAR"
goto :SETTEMPDIR

:: ====================================
:32BIT
:: ====================================
set bit=x86
set notbit=x64
ECHO.
ECHO This is a %bit% operating system
ECHO.
set "winrarpath=%PROGRAMFILES(X86)%\WinRAR"
goto :SETTEMPDIR

:: ====================================
:SETTEMPDIR
:: ====================================
ECHO.

cd /d "%USERPROFILE%\Downloads\"

set /p "temppath=Where do you want to save temporary files? "

if "%temppath%"=="" set "temppath=%~dp0WRA"

rem Remove trailing backslash, except for drive roots such as C:\
if not "%temppath:~1,2%"==":\" if "%temppath:~-1%"=="\" set "temppath=%temppath:~0,-1%"

echo Temp path: "%temppath%"

if not exist "%temppath%" (
    mkdir "%temppath%"
    
    if exist "%temppath%" (
        echo Temp folder created.
    ) else (
        echo ERROR: Failed to create temp folder.
        exit /b 1
    )
) else (
    echo Temp folder already exists.
)

goto :CHECKIFINSTALLED
EXIT /b

:: ====================================
:CHECKIFINSTALLED
:: ====================================
ECHO.
IF EXIST "%winrarpath%\winrar.exe" ( ECHO WinRAR is installed. && goto :PREREGISTRATION ) ELSE ( ECHO WinRAR undetected. && goto :DOWNLOADER )
EXIT /b

:: ====================================
:CHECKINSTALLER
:: ====================================
ECHO.
ECHO Checking installer..
ECHO.
IF EXIST "%savepath%\winrar-%bit%-*.exe" ( ECHO Successfully downloaded. && goto :CHECKINSTALLERFILEPATH ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

:: ====================================
:CHECKINSTALLERFILEPATH
:: ====================================
ECHO.
FOR %%f IN ( "%savepath%\winrar-%bit%-*.exe" ) do set "installerpath=%%f"
IF EXIST "%installerpath%" ( ECHO "%installerpath%" exists && goto :STARTINSTALL ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

:: ====================================
:ASKINSTALLERFILEPATH
:: ====================================
ECHO.
set /p "installerpath=What is the full path to the installer? "
IF [%installerpath%] EQU [] ( goto :ASKINSTALLERFILEPATH ) ELSE ( goto :STARTINSTALL )
EXIT /b

:: ====================================
:STARTINSTALL
:: ====================================
ECHO.
ECHO Installing..
start "" /wait "%installerpath%" /S && goto :CHECKIFINSTALLED
EXIT /b

:: ====================================
:PREREGISTRATION
:: ====================================
ECHO.
ECHO Downloading medicine..
SET "URL=https://github.com/bitcookies/winrar-keygen"

FOR /F "tokens=3,4 delims=/" %%A IN ("%URL%") DO SET "API_URL=https://api.github.com/repos/%%A/%%B/releases/latest"
FOR /F "usebackq tokens=2" %%A IN (`curl -L -s --ssl-no-revoke %API_URL% ^| FINDSTR /R /I /C:"browser_download_url.*/winrar-keygen-%bit%\.exe" 2^>NUL`) DO SET "download_link=%%~A"

ECHO.
ECHO Download link found.. 
ECHO;
ECHO Downloading the latest file...

for %%F in ("%download_link%") do set "filename=%%~nxF"
curl -kL -o "%savepath%\%filename%" "%download_link%"

ECHO.
IF EXIST "%savepath%\winrar-keygen-%bit%.exe" ( ECHO Medicine found && MOVE "%savepath%\winrar-keygen-%bit%.exe" "%temppath%" && goto :REGISTRATION ) ELSE ( ECHO Medicine not found. && goto :BUILDFROMSRC )

EXIT /b

:: ====================================
:BUILDFROMSRC
:: ====================================
ECHO.
ECHO "This is just a placeholder for future improvement. Silently detect/download/install requirements of MSbuild and kg project to be able to compile from source seamlessly"
set /p "QUERYBUILD=Do you want to compile from source [y/n]? "
IF /i "%QUERYBUILD%"=="" goto :BUILDFROMSRC
IF /i "%QUERYBUILD%"=="y" call :COMPILE
IF /i "%QUERYBUILD%"=="n" goto :REGISTRATION 
EXIT /b

:: ====================================
:REGISTRATION
:: ====================================
ECHO.

set /p "input=What is the name to be registered? "
IF NOT DEFINED input set "input=ABCDEFG"

ECHO.
ECHO The name you just entered is: %input%
ECHO.
ECHO Checking for paths...

ECHO savepath=[%savepath%]
ECHO temppath=[%temppath%]
ECHO bit=[%bit%]
ECHO.

IF EXIST "%savepath%\winrar-keygen-%bit%.exe" (
    ECHO Found executable in savepath:
    ECHO "%savepath%\winrar-keygen-%bit%.exe"
    set "kgpath=%savepath%\winrar-keygen-%bit%.exe"
) ELSE IF EXIST "%temppath%\winrar-keygen-%bit%.exe" (
    ECHO Found executable in temppath:
    ECHO "%temppath%\winrar-keygen-%bit%.exe"
    set "kgpath=%temppath%\winrar-keygen-%bit%.exe"
) ELSE (
    ECHO ERROR: Could not find the executable.
    ECHO.
    ECHO Checked:
    ECHO "%savepath%\winrar-keygen-%bit%.exe"
    ECHO "%temppath%\winrar-keygen-%bit%.exe"
    EXIT /B 1
)

for %%A in ("%kgpath%") do set "kgroot=%%~dpA"

ECHO.
ECHO KG root: "%kgroot%"
ECHO KG path: "%kgpath%"

ECHO.
ECHO Creating rarreg.key...

"%kgpath%" "%input%" "License" >> "%kgroot%\rarreg.key"

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)
ENDLOCAL

ECHO.
IF EXIST "%kgroot%\rarreg.key" (
    ECHO rarreg.key exists
) ELSE (
    ECHO rarreg.key not found. Exiting...
    PAUSE
    EXIT /b
)

GOTO :Beginoffile
EXIT /b

:: ====================================
:Beginoffile
:: ====================================
COLOR 1F

xcopy /s /x /y "%kgroot%\rarreg.key" "%winrarpath%\"

start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%\WinRAR.exe"
start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%"

GOTO :leftovers
EXIT /b

:: ====================================
:leftovers
:: ====================================
ECHO.
echo Deleting leftovers..
REM adding double quotes fail deletion if files are in desktop -- need investigation
ECHO.
IF EXIST "%temppath%" ( ECHO Temp folder exists. Deleting.. && RMDIR /S /Q "%temppath%" ) ELSE ( ECHO Temp folder does not exist. )
goto :final
EXIT /b

:: ====================================
:final
:: ====================================
ECHO.
ECHO In WinRAR window, choose HELP, select ABOUT WinRAR and check active status. If unsuccessful, please try again or report to https://github.com/vavavr00m/WinRAR.
ECHO.
PAUSE>nul
EXIT /b

:: ====================================
:DOWNLOADER
:: ====================================
@echo off
ECHO.
ECHO =============================
ECHO WinRAR Downloader
ECHO =============================
ECHO.

set "url=https://www.rarlab.com/download.htm"

set /p "savepath=Where do you want to download the latest WinRAR installer (Default: %temppath%)? "

if "%savepath%"=="" set "savepath=%temppath%"

echo.
echo You selected: "%savepath%"
echo.

if not exist "%savepath%" (
    mkdir "%savepath%"
    if errorlevel 1 (
        echo ERROR: Unable to create "%savepath%"
        pause
        exit /b 1
    )
)

echo Retrieving available WinRAR languages...
echo.
set "langfile=%temp%\winrar_languages_%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference='Stop';" ^
    "try {" ^
    "  $html=(Invoke-WebRequest -UseBasicParsing '%url%').Content;" ^
    "  $rows=[regex]::Matches($html,'(?is)<tr[^>]*>.*?</tr>');" ^
    "  if ($rows.Count -eq 0) { throw 'No <tr> rows matched on the RARLAB download page - the page markup has likely changed and the scraper regex needs updating.' };" ^
    "  $matched=0;" ^
    "  foreach($row in $rows) {" ^
    "    $text=$row.Value;" ^
    "    $link=[regex]::Match($text,'(?is)href\s*=\s*[""'' ]?([^""'' >]*winrar-%bit%-[^""'' >]*\.exe)');" ^
    "    if(!$link.Success) { continue };" ^
    "    $name=[regex]::Match($text,'(?is)<a[^>]*href\s*=\s*[""'' ]?[^""'' >]*winrar-%bit%-[^""'' >]*\.exe[^""'' >]*[""'' ]?[^>]*>\s*(.*?)\s*</a>');" ^
    "    if(!$name.Success) { continue };" ^
    "    $lang=[regex]::Replace($name.Groups[1].Value,'<[^>]+>','').Trim();" ^
    "    if(!$lang) { continue };" ^
    "    $href=$link.Groups[1].Value;" ^
    "    if($href.StartsWith('/')) { $href='https://www.rarlab.com'+$href } elseif($href -notmatch '^https?://') { $href='https://www.rarlab.com/'+$href.TrimStart('/') } ^
    "    elseif($href -notmatch '^https?://') { $href='https://www.rarlab.com/'+$href.TrimStart('/') };" ^
    "    Write-Output ($lang+'|'+$href);" ^
    "    $matched++;" ^
    "  };" ^
    "  if ($matched -eq 0) { throw ('Parsed ' + $rows.Count + ' table rows but found no winrar-%bit%- download links in any of them - RARLAB markup may have changed, or no %bit% build is currently listed.') };" ^
    "} catch {" ^
    "  Write-Error $_.Exception.Message;" ^
    "  exit 1;" ^
    "}" > "%langfile%"
if errorlevel 1 (
    echo.
    echo ERROR: Failed to parse the RARLAB download page - see message above.
    echo ^(This usually means RARLAB changed the page's HTML layout and the scraper regex needs updating.^)
    echo.
    del "%langfile%" >nul 2>&1
    pause
    exit /b 1
)

if not exist "%langfile%" (
    echo.
    echo ERROR: Language list was not created.
    pause
    exit /b 1
)

echo Available languages:
echo =====================

setlocal EnableDelayedExpansion

set "count=0"

for /f "usebackq tokens=1,* delims=|" %%A in ("%langfile%") do (
    set /a count+=1
    set "lang[!count!]=%%A"
    set "url[!count!]=%%B"
    echo [!count!] %%A
)

echo.

if "!count!"=="0" (
    echo ERROR: No WinRAR languages were found.
    echo.
    pause
    endlocal
    del "%langfile%" >nul 2>&1
    exit /b 1
)

set /p "langchoice=Select a language [1-!count!]: "

if not defined langchoice (
    echo.
    echo No language selected.
    endlocal
    del "%langfile%" >nul 2>&1
    goto :DOWNLOADER
)

set "selectedlanguage=!lang[%langchoice%]!"
set "download_link=!url[%langchoice%]!"

if not defined selectedlanguage (
    echo.
    echo Invalid selection.
    echo.
    endlocal
    del "%langfile%" >nul 2>&1
    goto :DOWNLOADER
)

if not defined download_link (
    echo.
    echo ERROR: No download URL associated with that language.
    echo.
    endlocal
    del "%langfile%" >nul 2>&1
    exit /b 1
)

echo.
echo =============================
echo Selected language:
echo !selectedlanguage!
echo.
echo Download URL:
echo !download_link!
echo =============================
echo.

for %%F in ("!download_link!") do set "filename=%%~nxF"

echo Downloading !filename!...
echo.

curl -kL --fail -o "%savepath%\!filename!" "!download_link!"

if errorlevel 1 (
    echo.
    echo ERROR: Download failed.
    echo.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

echo.
echo Download complete:
echo "%savepath%\!filename!"
echo.

del "%langfile%" >nul 2>&1

endlocal

goto :CHECKINSTALLER
