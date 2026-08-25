@if (@a==@b) @end /*

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
::@rojo - Download & install latest WinRAR from batch - https://stackoverflow.com/a/15777517/21996598 | modified using ChatGPT
::@vavavr00m (me) - https://github.com/vavavr00m/WinRAR - EN translation & some fixes (added a Batch download method and another PowerShell option that works with my system, delete leftovers script, change absolute paths to relative and/or variable, merge the external batch script)

@echo off
CLS
 
@echo off
REM :::::::::::::::::::::::::::::::::::::::::
REM Elevate.cmd - Version 9
REM Automatically check & get admin rights
REM see "https://stackoverflow.com/a/12264592/1016343" for description
REM :::::::::::::::::::::::::::::::::::::::::
 
 CLS
 ECHO/
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal EnableExtensions DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~f0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  %SystemRoot%\System32\whoami.exe /groups /nh | %SystemRoot%\System32\find.exe "S-1-16-12288" 1>nul
  if errorlevel 1 goto getPrivileges

:checkPrivileges2
  %SystemRoot%\System32\net.exe session 1>nul 2>NUL
  if not errorlevel 1 goto gotPrivileges

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO/
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
 setlocal & cd /d "%~dp0"
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 REM :::::::::::::::::::::::::
 REM START
 REM :::::::::::::::::::::::::

COLOR 1F

CLS

IF EXIST "%PROGRAMFILES(X86)%" ( GOTO :64BIT ) ELSE ( GOTO :32BIT )

REM ====================================
:64BIT
REM ====================================
set bit=x64
set notbit=x86
ECHO.
ECHO This is a %bit% operating system
set "winrarpath=%PROGRAMFILES%\WinRAR"
goto :SETTEMPDIR

REM ====================================
:32BIT
REM ====================================
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

REM ====================================
:CHECKIFINSTALLED
REM ====================================
ECHO.
IF EXIST "%winrarpath%\winrar.exe" ( ECHO WinRAR is installed. && goto :PREREGISTRATION ) ELSE ( ECHO WinRAR undetected. && goto :DOWNLOADER )
EXIT /b

REM ====================================
:CHECKINSTALLER
REM ====================================
ECHO.
ECHO Checking installer..
ECHO.
IF EXIST "%savepath%\winrar-%bit%-*.exe" ( ECHO Successfully downloaded. && goto :CHECKINSTALLERFILEPATH ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

REM ====================================
:CHECKINSTALLERFILEPATH
REM ====================================
ECHO.
FOR %%f IN ( "%savepath%\winrar-%bit%-*.exe" ) do set "installerpath=%%f"
IF EXIST "%installerpath%" ( ECHO "%installerpath%" exists && goto :STARTINSTALL ) ELSE ( ECHO Unable to locate WinRAR installer. && goto :ASKINSTALLERFILEPATH )
pause>nul
EXIT /b

REM ====================================
:ASKINSTALLERFILEPATH
REM ====================================
ECHO.
set /p "installerpath=What is the full path to the installer? "
IF [%installerpath%] EQU [] ( goto :ASKINSTALLERFILEPATH ) ELSE ( goto :STARTINSTALL )
EXIT /b

REM ====================================
:STARTINSTALL
REM ====================================
ECHO.
ECHO Installing..
start "" /wait "%installerpath%" /S && goto :CHECKIFINSTALLED
EXIT /b

REM ====================================
:PREREGISTRATION
REM ====================================

ECHO.
ECHO How do you want to obtain the medicine?
ECHO [a] Auto-download from source repository
ECHO [b] Manually download from source repository (WARNING: Not recommended if you don't know where to get it from)
ECHO [c] Build from source (WARNING: This is the recommended method but it might take up a lot of space)
set /p "QUERYPREREG= Please select from the choices above: "
IF /i "%QUERYPREREG%"=="a" GOTO :AUTODLFROMSRC
IF /i "%QUERYPREREG%"=="b" GOTO :MANUALDL
IF /i "%QUERYPREREG%"=="c" GOTO :AUTOBUILDFROMSRC

ECHO.
ECHO Input invalid.
GOTO :PREREGISTRATION

EXIT /b

REM ====================================
:AUTODLFROMSRC
REM ====================================

ECHO.
ECHO Downloading medicine..
SET "URL=https://github.com/bitcookies/winrar-keygen"

FOR /F "tokens=3,4 delims=/" %%A IN ("%URL%") DO SET "API_URL=https://api.github.com/repos/%%A/%%B/releases/latest"
FOR /F "usebackq tokens=2" %%A IN (`curl -L -s --ssl-no-revoke %API_URL% ^| FINDSTR /R /I /C:"browser_download_url.*[/]winrar-keygen-%bit%\.exe" 2^>NUL`) DO SET "download_link=%%~A"

ECHO.
ECHO Download link found.. 
ECHO;
ECHO Downloading the latest file...

for %%F in ("%download_link%") do set "filename=%%~nxF"
curl -kL -o "%savepath%\%filename%" "%download_link%"

ECHO.
IF EXIST "%savepath%\winrar-keygen-%bit%.exe" ( ECHO Medicine found && MOVE "%savepath%\winrar-keygen-%bit%.exe" "%temppath%" && goto :REGISTRATION ) ELSE ( ECHO Medicine not found. && goto :PREREGISTRATION )

EXIT /b

REM ====================================
:MANUALDL
REM ====================================
ECHO.
ECHO The script expects a file named winrar-keygen-%bit%.exe in "%temppath%". Ensure existence of the medicine in the specified folder before proceeding...
>nul pause
IF EXIST "%temppath%\winrar-keygen-%bit%.exe" ( ECHO Medicine found && goto :REGISTRATION ) ELSE ( ECHO. && ECHO Medicine not found. && goto :PREREGISTRATION )
EXIT /b

REM ====================================
:AUTOBUILDFROMSRC
REM ====================================
ECHO.
ECHO This is just a placeholder for future improvement. Silently detect/download/install requirements of MSbuild and kg project to be able to compile from source seamlessly
>nul pause
IF EXIST "%savepath%\winrar-keygen-%bit%.exe" ( ECHO Medicine found && MOVE "%savepath%\winrar-keygen-%bit%.exe" "%temppath%" && goto :REGISTRATION ) ELSE ( ECHO Medicine not found. && goto :PREREGISTRATION )
EXIT /b

REM ====================================
:REGISTRATION
REM ====================================
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
SETLOCAL DisableDelayedExpansion

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

REM ====================================
:Beginoffile
REM ====================================
COLOR 1F

xcopy /s /x /y "%kgroot%\rarreg.key" "%winrarpath%\"

start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%\WinRAR.exe"
start /min /wait "" %SystemRoot%\explorer.exe "%winrarpath%"

GOTO :leftovers
EXIT /b

REM ====================================
:leftovers
REM ====================================
ECHO.
echo Deleting leftovers..
REM adding double quotes fail deletion if files are in desktop -- need investigation
ECHO.
IF EXIST "%temppath%" ( ECHO Temp folder exists. Deleting.. && RMDIR /S /Q "%temppath%" ) ELSE ( ECHO Temp folder does not exist. )
goto :final
EXIT /b

REM ====================================
:final
REM ====================================
ECHO.
ECHO In WinRAR window, choose HELP, select ABOUT WinRAR and check active status. If unsuccessful, please try again or report to https://github.com/vavavr00m/WinRAR.
ECHO.
PAUSE>nul
EXIT /b

REM ====================================
:DOWNLOADER
REM ====================================
@echo off

echo.
echo =============================
echo WinRAR Downloader
echo =============================
echo.

set /p "savepath=Where do you want to download WinRAR? (Default: %temppath%) "

if "%savepath%"=="" set "savepath=%temppath%"

echo.
echo Download directory:
echo "%savepath%"
echo.

if not exist "%savepath%" (
    mkdir "%savepath%" 2>nul
    echo The folder "%savepath%" was created.
    if errorlevel 1 (
        echo ERROR: Unable to create "%savepath%"
        pause
        exit /b 1
    )
)

@echo off
setlocal

set "url=https://www.rarlab.com/download.htm"

cscript /nologo /e:jscript "%~f0" "%url%" "%savepath%"

goto :CHECKINSTALLER

// JScript portion */

// ------------------------------------------------------------
// HTTP GET
// ------------------------------------------------------------

function fetch(url) {
    var xObj = new ActiveXObject("Microsoft.XMLHTTP");

    xObj.open("GET", url, true);
    xObj.setRequestHeader("User-Agent", "XMLHTTP/1.0");
    xObj.send("");

    while (xObj.readyState != 4)
        WSH.Sleep(50);

    return xObj;
}


// ------------------------------------------------------------
// Save binary response
// ------------------------------------------------------------

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


// ------------------------------------------------------------
// HTML entity decoding
// ------------------------------------------------------------

function htmlDecode(s) {

    return s
        .replace(/&amp;/gi, "&")
        .replace(/&quot;/gi, '"')
        .replace(/&#39;/gi, "'")
        .replace(/&lt;/gi, "<")
        .replace(/&gt;/gi, ">");
}


// ------------------------------------------------------------
// Remove HTML tags and normalize whitespace
// ------------------------------------------------------------

function stripTags(s) {

    return htmlDecode(
        s.replace(/<[^>]+>/g, " ")
    )
    .replace(/\s+/g, " ")
    .replace(/^\s+|\s+$/g, "");
}


// ------------------------------------------------------------
// Fetch RARLAB download page
// ------------------------------------------------------------

var pageUrl = WSH.Arguments(0);
var savepath = WSH.Arguments(1);

var x = fetch(pageUrl);

if (x.status < 200 || x.status >= 300) {

    WSH.Echo(
        "HTTP error " +
        x.status +
        " while fetching " +
        pageUrl
    );

    WSH.Quit(1);
}

var html = x.responseText;


// ------------------------------------------------------------
// Determine OS architecture
// ------------------------------------------------------------

var os = GetObject("winmgmts:").ExecQuery(
    "select OSArchitecture from Win32_OperatingSystem"
);

var osArch =
    new Enumerator(os).item().OSArchitecture;

var arch = /\d+/.exec(osArch) * 1;


// ------------------------------------------------------------
// Parse the RARLAB download table
// ------------------------------------------------------------
//
// We don't maintain a language list.
//
// RARLAB's page is the source of truth:
//
//     language name -> executable href
//
// Only WinRAR x64 EXE links are considered.
//

var languages = [];

var rows = html.match(
    /<tr\b[^>]*>[\s\S]*?<\/tr>/gi
);

if (!rows) {

    WSH.Echo(
        "Could not find download table on RARLAB."
    );

    WSH.Quit(1);
}


for (var i = 0; i < rows.length; i++) {

    var row = rows[i];

    // We only want rows containing an executable.
    if (!/\.exe["']/i.test(row))
        continue;


    // --------------------------------------------------------
    // Find executable links in this row.
    // --------------------------------------------------------

    var linkMatches =
        row.match(
            /href\s*=\s*["'][^"']+\.exe["']/gi
        );

    if (!linkMatches)
        continue;


    for (var j = 0; j < linkMatches.length; j++) {

        var hrefMatch =
            /href\s*=\s*["']([^"']+\.exe)["']/i.exec(
                linkMatches[j]
            );

        if (!hrefMatch)
            continue;


        var href = hrefMatch[1];


        // Only WinRAR links.
        if (!/winrar/i.test(href))
            continue;


        // ----------------------------------------------------
        // Only select the x64 installer.
        // ----------------------------------------------------

        if (arch == 64) {

            if (!/winrar-x64-[^\/]+\.exe$/i.test(href))
                continue;

        } else {

            // If the system is 32-bit, look for x86/x32.
            if (
                !/winrar-(x86|x32)-[^\/]+\.exe$/i.test(href)
            )
                continue;
        }


        // ----------------------------------------------------
        // Extract the language from the anchor containing
        // this executable.
        // ----------------------------------------------------

        var escapedHref =
            href.replace(
                /[.*+?^${}()|[\]\\]/g,
                "\\$&"
            );


        var anchorRegex = new RegExp(
            "<a\\b[^>]*href\\s*=\\s*[\"']" +
            escapedHref +
            "[\"'][^>]*>([\\s\\S]*?)<\\/a>",
            "i"
        );


        var anchorMatch =
            anchorRegex.exec(row);


        if (!anchorMatch)
            continue;


        var name =
			stripTags(anchorMatch[1]);


		// Skip the generic WinRAR x64/x86 download entry.
		// We only want localized versions.
		if (/^WinRAR\b/i.test(name))
			continue;


		if (name == "")
			continue;


        // Avoid duplicate language entries.
        var duplicate = false;

        for (var k = 0; k < languages.length; k++) {

            if (
                languages[k].name.toLowerCase() ==
                name.toLowerCase()
            ) {
                duplicate = true;
                break;
            }
        }

        if (duplicate)
            continue;


        languages.push({
            name: name,
            href: href
        });
    }
}


// ------------------------------------------------------------
// Verify that we found languages.
// ------------------------------------------------------------

if (languages.length == 0) {

    WSH.Echo(
        "Could not find any localized WinRAR " +
        arch +
        "-bit installers."
    );

    WSH.Quit(1);
}


// ------------------------------------------------------------
// Sort alphabetically
// ------------------------------------------------------------

languages.sort(function(a, b) {

    var aa = a.name.toLowerCase();
    var bb = b.name.toLowerCase();

    if (aa < bb)
        return -1;

    if (aa > bb)
        return 1;

    return 0;
});


// ------------------------------------------------------------
// Display language selection
// ------------------------------------------------------------

WSH.StdOut.Write("\r\n");

WSH.StdOut.Write(
    "Available WinRAR " +
    arch +
    "-bit languages:\r\n"
);

WSH.StdOut.Write(
    "----------------------------------------\r\n"
);


for (var i = 0; i < languages.length; i++) {

    WSH.StdOut.Write(
        (i + 1) +
        ". " +
        languages[i].name +
        "\r\n"
    );
}


WSH.StdOut.Write("\r\n");

WSH.StdOut.Write(
    "Select language [1-" +
    languages.length +
    "]: "
);


// ------------------------------------------------------------
// Read user selection
// ------------------------------------------------------------

var input =
    WSH.StdIn.ReadLine();

var selected =
    parseInt(input, 10) - 1;


if (
    isNaN(selected) ||
    selected < 0 ||
    selected >= languages.length
) {

    WSH.Echo("");
    WSH.Echo("Invalid language selection.");

    WSH.Quit(1);
}


// ------------------------------------------------------------
// Get selected download
// ------------------------------------------------------------

var selectedLanguage =
    languages[selected].name;

var dl =
    languages[selected].href;

// ------------------------------------------------------------
// Extract locale from selected download filename
// ------------------------------------------------------------

var filenameMatch =
    /[^\/]+$/.exec(dl);

if (!filenameMatch) {

    WSH.Echo(
        "Could not determine filename from " +
        dl
    );

    WSH.Quit(1);
}

var filename =
    filenameMatch[0];

var localeMatch =
    /^winrar-(?:x64|x86|x32)-\d+([^.\/]*)\.exe$/i.exec(
        filename
    );

var locale =
    localeMatch ? localeMatch[1].toLowerCase() : "";

// ------------------------------------------------------------
// Convert relative URL to absolute URL
// ------------------------------------------------------------

if (!/^https?:\/\//i.test(dl)) {

    var domain =
        /^https?:\/\/[^\/]+/i.exec(pageUrl);

    if (!domain) {

        WSH.Echo(
            "Could not determine domain from " +
            pageUrl
        );

        WSH.Quit(1);
    }


    if (dl.charAt(0) != "/")
        dl = "/" + dl;


    dl =
        domain[0] + dl;
}


// ------------------------------------------------------------
// Determine target filename
// ------------------------------------------------------------

var target =
    savepath + "\\" + filename;

// ------------------------------------------------------------
// Display selection
// ------------------------------------------------------------

WSH.StdOut.Write("\r\n");

WSH.StdOut.Write(
    "Selected language: " +
    selectedLanguage +
    "\r\n"
);

WSH.StdOut.Write(
    "Architecture: " +
    arch +
    "-bit\r\n"
);

WSH.StdOut.Write(
    "Download: " +
    dl +
    "\r\n"
);

WSH.StdOut.Write(
    "Saving " +
    target +
    "... "
);


// ------------------------------------------------------------
// Download installer
// ------------------------------------------------------------

var installer =
    fetch(dl);


if (
    installer.status < 200 ||
    installer.status >= 300
) {

    WSH.Echo("");

    WSH.Echo(
        "HTTP error " +
        installer.status +
        " while downloading installer."
    );

    WSH.Quit(1);
}


save(installer, target);

WSH.Echo("Done.");
