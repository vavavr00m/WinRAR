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

====================================
:64BIT
====================================
set bit=x64
set notbit=x86
ECHO.
ECHO This is a %bit% operating system
set "winrarpath=%PROGRAMFILES%\WinRAR"
goto :SETTEMPDIR

====================================
:32BIT
====================================
set bit=x86
set notbit=x64
ECHO.
ECHO This is a %bit% operating system
ECHO.
set "winrarpath=%PROGRAMFILES(X86)%\WinRAR"
goto :SETTEMPDIR

====================================
:SETTEMPDIR
====================================
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

====================================
:CHECKIFINSTALLED
====================================
ECHO.
IF EXIST "%winrarpath%\winrar.exe" ( ECHO WinRAR is installed. && goto :PREREGISTRATION ) ELSE ( ECHO WinRAR undetected. && goto :SELECTLANGUAGE )
EXIT b\

====================================
:CHECKINSTALLER
====================================
ECHO.
ECHO Checking installer..
ECHO.
IF EXIST "%savepath%\winrar-%bit%-*.exe" ( ECHO Successfully downloaded. && goto :CHECKINSTALLERFILEPATH ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

====================================
:CHECKINSTALLERFILEPATH
====================================
ECHO.
FOR %%f IN ( "%savepath%\winrar-%bit%-*.exe" ) do set "installerpath=%%f"
IF EXIST "%installerpath%" ( ECHO "%installerpath%" exists && goto :STARTINSTALL ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

====================================
:ASKINSTALLERFILEPATH
====================================
ECHO.
set /p "installerpath=What is the full path to the installer? "
IF [%installerpath%] EQU [] ( goto :ASKINSTALLERFILEPATH ) ELSE ( goto :STARTINSTALL )
EXIT /b

====================================
:STARTINSTALL
====================================
ECHO.
ECHO Installing..
start "" /wait "%installerpath%" /S && goto :CHECKIFINSTALLED
EXIT /b

====================================
:PREREGISTRATION
====================================
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

====================================
:BUILDFROMSRC
====================================
ECHO.
ECHO "This is just a placeholder for future improvement. Silently detect/download/install requirements of MSbuild and kg project to be able to compile from source seamlessly"
set /p "QUERYBUILD=Do you want to compile from source [y/n]? "
IF /i "%QUERYBUILD%"=="" goto :BUILDFROMSRC
IF /i "%QUERYBUILD%"=="y" call :COMPILE
IF /i "%QUERYBUILD%"=="n" goto :REGISTRATION 
EXIT /b

====================================
:REGISTRATION
====================================
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

====================================
:Beginoffile
====================================
COLOR 1F

xcopy /s /x /y "%kgroot%\rarreg.key" "%winrarpath%\"

start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%\WinRAR.exe"
start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%"

GOTO :leftovers
EXIT /b

====================================
:leftovers
====================================
ECHO.
echo Deleting leftovers..
REM adding double quotes fail deletion if files are in desktop -- need investigation
ECHO.
IF EXIST "%temppath%" ( ECHO Temp folder exists. Deleting.. && RMDIR /S /Q "%temppath%" ) ELSE ( ECHO Temp folder does not exist. )
goto :final
EXIT /b

====================================
:final
====================================
ECHO.
ECHO In WinRAR window, choose HELP, select ABOUT WinRAR and check active status. If unsuccessful, please try again or report to https://github.com/vavavr00m/WinRAR.
ECHO.
PAUSE>nul
EXIT /b

====================================
:SELECTLANGUAGE
====================================
ECHO.
ECHO Select WinRAR language:
ECHO.
ECHO [1] English
ECHO [2] Arabic
ECHO [3] Armenian
ECHO [4] Azerbaijani
ECHO [5] Belarusian
ECHO [6] Bulgarian
ECHO [7] Catalan
ECHO [8] Chinese Simplified
ECHO [9] Chinese Traditional
ECHO [10] Croatian
ECHO [11] Czech
ECHO [12] Danish
ECHO [13] Dutch
ECHO [14] Estonian
ECHO [15] Finnish
ECHO [16] French
ECHO [17] German
ECHO [18] Greek
ECHO [19] Hebrew
ECHO [20] Hungarian
ECHO [21] Indonesian
ECHO [22] Italian
ECHO [23] Japanese
ECHO [24] Korean
ECHO [25] Lithuanian
ECHO [26] Macedonian
ECHO [27] Norwegian
ECHO [28] Persian
ECHO [29] Polish
ECHO [30] Portuguese
ECHO [31] Portuguese Brazilian
ECHO [32] Romanian
ECHO [33] Russian
ECHO [34] Serbian Cyrillic
ECHO [35] Serbian Latin
ECHO [36] Slovak
ECHO [37] Slovenian
ECHO [38] Spanish
ECHO [39] Swedish
ECHO [40] Thai
ECHO [41] Turkish
ECHO [42] Ukrainian
ECHO [43] Uzbek
ECHO [44] Valencian
ECHO [45] Vietnamese
ECHO.

set /p "langchoice=Enter language number: "

set "langsuffix="

if "%langchoice%"=="1"  set "langsuffix="
if "%langchoice%"=="2"  set "langsuffix=ar"
if "%langchoice%"=="3"  set "langsuffix=am"
if "%langchoice%"=="4"  set "langsuffix=az"
if "%langchoice%"=="5"  set "langsuffix=by"
if "%langchoice%"=="6"  set "langsuffix=bg"
if "%langchoice%"=="7"  set "langsuffix=ca"
if "%langchoice%"=="8"  set "langsuffix=cn"
if "%langchoice%"=="9"  set "langsuffix=ct"
if "%langchoice%"=="10" set "langsuffix=hr"
if "%langchoice%"=="11" set "langsuffix=cz"
if "%langchoice%"=="12" set "langsuffix=dk"
if "%langchoice%"=="13" set "langsuffix=nl"
if "%langchoice%"=="14" set "langsuffix=ee"
if "%langchoice%"=="15" set "langsuffix=fi"
if "%langchoice%"=="16" set "langsuffix=fr"
if "%langchoice%"=="17" set "langsuffix=de"
if "%langchoice%"=="18" set "langsuffix=gr"
if "%langchoice%"=="19" set "langsuffix=he"
if "%langchoice%"=="20" set "langsuffix=hu"
if "%langchoice%"=="21" set "langsuffix=id"
if "%langchoice%"=="22" set "langsuffix=it"
if "%langchoice%"=="23" set "langsuffix=jp"
if "%langchoice%"=="24" set "langsuffix=kr"
if "%langchoice%"=="25" set "langsuffix=lt"
if "%langchoice%"=="26" set "langsuffix=mk"
if "%langchoice%"=="27" set "langsuffix=no"
if "%langchoice%"=="28" set "langsuffix=ir"
if "%langchoice%"=="29" set "langsuffix=pl"
if "%langchoice%"=="30" set "langsuffix=pt"
if "%langchoice%"=="31" set "langsuffix=br"
if "%langchoice%"=="32" set "langsuffix=ro"
if "%langchoice%"=="33" set "langsuffix=ru"
if "%langchoice%"=="34" set "langsuffix=sc"
if "%langchoice%"=="35" set "langsuffix=sl"
if "%langchoice%"=="36" set "langsuffix=sk"
if "%langchoice%"=="37" set "langsuffix=si"
if "%langchoice%"=="38" set "langsuffix=es"
if "%langchoice%"=="39" set "langsuffix=se"
if "%langchoice%"=="40" set "langsuffix=th"
if "%langchoice%"=="41" set "langsuffix=tr"
if "%langchoice%"=="42" set "langsuffix=uk"
if "%langchoice%"=="43" set "langsuffix=uz"
if "%langchoice%"=="44" set "langsuffix=va"
if "%langchoice%"=="45" set "langsuffix=vn"

if "%langchoice%"=="" (
    goto :SELECTLANGUAGE
) else (
    goto :DOWNLOADER
)

====================================
:DOWNLOADER
====================================
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
        exit /b 1
    )
)

echo Retrieving available WinRAR languages...
echo.

setlocal EnableDelayedExpansion

rem ============================================================
rem Retrieve language|URL pairs from RARLAB.
rem The parser looks specifically at the localized WinRAR x64
rem table instead of maintaining our own language/suffix list.
rem ============================================================

set "langfile=%temp%\winrar_languages_%RANDOM%.txt"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop';" ^
    "$html = (Invoke-WebRequest -UseBasicParsing '%url%').Content;" ^
    "$m = [regex]::Match($html, '(?is)Localized WinRAR x64 versions.*?</table>');" ^
    "if (!$m.Success) { throw 'Could not locate Localized WinRAR x64 versions table.' };" ^
    "$table = $m.Value;" ^
    "$rows = [regex]::Matches($table, '(?is)<tr[^>]*>(.*?)</tr>');" ^
    "foreach ($row in $rows) {" ^
    "  $cells = [regex]::Matches($row.Groups[1].Value, '(?is)<td[^>]*>(.*?)</td>');" ^
    "  if ($cells.Count -ge 2) {" ^
    "    $link = [regex]::Match($cells[0].Groups[1].Value, '(?is)<a[^>]+href\s*=\s*[""']([^""']+)[""'][^>]*>(.*?)</a>');" ^
    "    if ($link.Success) {" ^
    "      $lang = [regex]::Replace($link.Groups[2].Value, '<[^>]+>', '').Trim();" ^
    "      $href = $link.Groups[1].Value.Trim();" ^
    "      if ($href.StartsWith('/')) { $href = 'https://www.rarlab.com' + $href }" ^
    "      elseif ($href -notmatch '^https?://') { $href = 'https://www.rarlab.com/' + $href.TrimStart('/') }" ^
    "      Write-Output ($lang + '|' + $href);" ^
    "    }" ^
    "  }" ^
    "}" > "%langfile%"

if errorlevel 1 (
    echo ERROR: Unable to retrieve the WinRAR language list.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

if not exist "%langfile%" (
    echo ERROR: Language list was not created.
    endlocal
    exit /b 1
)

rem ============================================================
rem Display languages dynamically retrieved from RARLAB
rem ============================================================

set "count=0"

for /f "usebackq tokens=1,* delims=|" %%A in ("%langfile%") do (
    set /a count+=1
    set "lang[!count!]=%%A"
    set "url[!count!]=%%B"
    echo [!count!] %%A
)

if "!count!"=="0" (
    echo.
    echo ERROR: No languages were found.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

echo.
set /p "langchoice=Select a language [1-!count!]: "

rem ============================================================
rem Validate selection
rem ============================================================

if not defined langchoice (
    echo.
    echo No language selected.
    del "%langfile%" >nul 2>&1
    endlocal
    goto :DOWNLOADER
)

set "selectedlanguage=!lang[%langchoice%]!"
set "download_link=!url[%langchoice%]!"

if not defined selectedlanguage (
    echo.
    echo Invalid language selection.
    del "%langfile%" >nul 2>&1
    endlocal
    goto :DOWNLOADER
)

if not defined download_link (
    echo.
    echo ERROR: No download URL was found for the selected language.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

echo.
echo Selected language: !selectedlanguage!
echo Download URL: !download_link!
echo.

rem ============================================================
rem Extract filename from URL
rem ============================================================

for %%F in ("!download_link!") do set "filename=%%~nxF"

if not defined filename (
    echo ERROR: Could not determine installer filename.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

echo Downloading:
echo !filename!
echo.

curl -kL --fail -o "%savepath%\!filename!" "!download_link!"

if errorlevel 1 (
    echo.
    echo ERROR: Download failed.
    del "%langfile%" >nul 2>&1
    endlocal
    exit /b 1
)

echo.
echo Successfully downloaded:
echo "%savepath%\!filename!"
echo.

del "%langfile%" >nul 2>&1

endlocal

goto :CHECKINSTALLER
EXIT /b
