@if (@CodeSection == @Batch) @then

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
goto :CHECKIFINSTALLED

====================================
:32BIT
====================================
set bit=x86
set notbit=x64
ECHO.
ECHO This is a %bit% operating system
ECHO.
set "winrarpath=%PROGRAMFILES(X86)%\WinRAR"
goto :CHECKIFINSTALLED

====================================
:CHECKIFINSTALLED
====================================
ECHO.
set /p "temppath=Where do you want to save temporary files? "
IF [%temppath%] EQU [] SET "temppath=%~dp0WRA"
ECHO.
IF NOT EXIST "%temppath%" MKDIR "%temppath%" && ECHO Temp folder created.
ECHO.
IF EXIST "%winrarpath%\winrar.exe" ( ECHO WinRAR is installed. && goto :PREREGISTRATION ) ELSE ( ECHO WinRAR undetected. && goto :DOWNLOADER )

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
ECHO TESTING
ECHO.
FOR %%f IN ( "%savepath%\winrar-%bit%-*.exe" ) do set "installerpath=%%f"
IF EXIST "%installerpath%" ( ECHO "%installerpath%" exists && goto :STARTINSTALL ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
ECHO.
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
call :Auto-elevate && start "" /wait "%installerpath%" /S && goto :CHECKIFINSTALLED
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
curl -kOL %download_link%
ECHO.
IF EXIST "%~dp0winrar-keygen-%bit%.exe" ( ECHO Medicine found && MOVE "%~dp0winrar-keygen-%bit%.exe" "%temppath%" && goto :REGISTRATION ) ELSE ( ECHO Medicine not found. && goto :BUILDFROMSRC )

EXIT /b

====================================
:BUILDFROMSRC
====================================
ECHO.
ECHO This is just a placeholder for future improvement - silently detect/download/install requirements of MSbuild & kg project to be able to compile from source seamlessly
::set /p /i "QUERYBUILD=Do you want to compile from source [y/N]? "
IF [%QUERYBUILD%]==[] goto :BUILDFROMSRC
IF [%QUERYBUILD%]==[y] call :COMPILE
IF [%QUERYBUILD%]==[n] goto: REGISTRATION 
EXIT /b

====================================
:REGISTRATION
====================================
ECHO.
set /p input="What is the name to be registered? "
IF NOT DEFINED input set input=ABCDEFG
ECHO.
ECHO The name you just entered is: %input%
ECHO.
ECHO Creating rarreg.key..
ECHO.
"%temppath%\winrar-keygen-%bit%.exe" "%input%" "License" >> "%temppath%\rarreg.key"

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)

GOTO :Beginoffile
EXIT /b

====================================
:Beginoffile
====================================
COLOR 1F

REM Adding double quote before the variable mypath in the line set will fail the registration
SET mypath=%temppath%\rarreg.key"

xcopy /s /x /y "%mypath:~0,-1%" "%winrarpath%\"

start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%\WinRAR.exe"
start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%"

pause>nul

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
:DOWNLOADER
====================================
@echo off
set local
set "url=https://www.rarlab.com/download.htm"
set /p "savepath=Where do you want to download the latest WinRAR installer (Default: %temppath%)? "
IF "%savepath%"=="" set "savepath=%temppath%"
IF NOT EXIST "%savepath%" MKDIR "%savepath%" && ECHO "%savepath%"

cscript /nologo /e:jscript "%~f0" "%url%" "%savepath%"

goto :CHECKINSTALLER

@end

// JScript

// populate translation from locale identifier hex value to WinRAR language label
// http://msdn.microsoft.com/en-us/library/dd318693.aspx
var abbrev={}, a=function(arr,val){for(var i=0;i<arr.length;i++)abbrev[arr[i]]=val};
a(['1401','3c01','0c01','0801','2001','4001','2801','1c01','3801','2401'],'Arabic');
a(['042b'],'Armenian');
a(['082c','042c'],'Azerbaijani');
a(['0423'],'Belarusian');
a(['0402'],'Bulgarian');
a(['0403'],'Catalan');
a(['7c04'],'Chinese Traditional');
a(['0c04','1404','1004','0004'],'Chinese Simplified');
a(['101a'],'Croatian');
a(['0405'],'Czech');
a(['0406'],'Danish');
a(['0813','0413'],'Dutch');
a(['0425'],'Estonian');
a(['040b'],'Finnish');
a(['080c','0c0c','040c','140c','180c','100c'],'French');
a(['0437'],'Georgian');
a(['0c07','0407','1407','1007','0807'],'German');
a(['0408'],'Greek');
a(['040d'],'Hebrew');
a(['040e'],'Hungarian');
a(['0421'],'Indonesian');
a(['0410','0810'],'Italian');
a(['0411'],'Japanese');
a(['0412'],'Korean');
a(['0427'],'Lithuanian');
a(['042f'],'Macedonian');
a(['0414','0814'],'Norwegian');
a(['0429'],'Persian');
a(['0415'],'Polish');
a(['0816'],'Portuguese');
a(['0416'],'Portuguese Brazilian');
a(['0418'],'Romanian');
a(['0419'],'Russian');
a(['7c1a','1c1a','0c1a'],'Serbian Cyrillic');
a(['181a','081a'],'Serbian Latin');
a(['041b'],'Slovak');
a(['0424'],'Slovenian');
a(['2c0a','400a','340a','240a','140a','1c0a','300a','440a','100a','480a','080a','4c0a','180a','3c0a','280a','500a','0c0a','040a','540a','380a','200a'],'Spanish');
a(['081d','041d'],'Swedish');
a(['041e'],'Thai');
a(['041f'],'Turkish');
a(['0422'],'Ukranian');
a(['0843','0443'],'Uzbek');
a(['0803'],'Valencian');
a(['042a'],'Vietnamese');

function language() {
    var os = GetObject('winmgmts:').ExecQuery('select Locale from Win32_OperatingSystem');
    var locale = new Enumerator(os).item().Locale;

    // default to English if locale is not in abbrev{}
    return abbrev[locale.toLowerCase()] || 'English';
}

function fetch(url) {
    var xObj = new ActiveXObject("Microsoft.XMLHTTP");
    xObj.open("GET",url,true);
    xObj.setRequestHeader('User-Agent','XMLHTTP/1.0');
    xObj.send('');
    while (xObj.readyState != 4) WSH.Sleep(50);
    return(xObj);
}

function save(xObj, file) {
    var stream = new ActiveXObject("ADODB.Stream");
    with (stream) {
        type = 1; // binary
        open();
        write(xObj.responseBody);
        saveToFile(file, 2); // overwrite
        close();
    }
}

// fetch the initial web page
var x = fetch(WSH.Arguments(0));

// make HTML response all one line
var html = x.responseText.split(/\r?\n/).join('');

// create array of hrefs matching *.exe where the link text contains system language
var r = new RegExp('<a\\s*href="[^"]+\\.exe(?=[^\\/]+' + language() + ')', 'g');
var anchors = html.match(r)

// use only the first two
for (var i=0; i<2; i++) {

    // use only the stuff after the quotation mark to the end
    var dl = '' + /[^"]+$/.exec(anchors[i]);

    // if the location is a relative path, prepend the domain
    if (dl.substring(0,1) == '/') dl = /.+:\/\/[^\/]+/.exec(WSH.Arguments(0)) + dl;

    // target is path\filename
    var target=WSH.Arguments(1) + '\\' + /[^\/]+$/.exec(dl)

    // echo without a new line
    WSH.StdOut.Write('Saving ' + target + '... ');

    // fetch file and save it
    save(fetch(dl), target);

    WSH.Echo('Done.');
}
