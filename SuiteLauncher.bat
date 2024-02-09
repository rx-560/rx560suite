@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
rem ↓ (SuiteLauncher Code)
:start
cls
title rx560 Suite Launcher v1.3
echo Welcome to rx560 Suite
echo Choose a program to run
echo fi[l]ereader
echo [i]odc
echo [m]akefile
echo [d]ownloader
echo [f]ilecopy
echo [t]askkill
echo [u]pdater
echo [c]leaner
echo ----
echo [r]eadme
echo [e]xit
set /p wantedProgramStart=   
goto parseAnswer


:parseAnswer
if %wantedProgramStart%==l (
   goto fileReaderStart
   )
if %wantedProgramStart%==i (
   goto iodcStart
   )
if %wantedProgramStart%==m (
   goto makeFileStart
   )
if %wantedProgramStart%==d (
   goto filedownloader
   )
if %wantedProgramStart%==f (
   goto filecopy
   )
if %wantedProgramStart%==r (
   goto readme
   )
if %wantedProgramStart%==e (
   goto exitScript
   )
if %wantedProgramStart%==t (
   goto taskkill
   )
if %wantedProgramStart%==u (
   goto fileUpdater
   )
if %wantedProgramStart%==c (
   goto cleaner
   )
cls
echo Make sure to select one of the available functions!
pause
goto start
rem ↑ (SuiteLauncher Code)


rem ↓ (filereader code)
:fileReaderStart
set pathout=C:\Users\%username%\AppData\Local\Temp
goto fileReaderLoop
:fileReaderLoop
title filereader
cls
set /p input1=Enter exact file path to read (without file name): 
set /p input2=Enter file name you want to read: 
goto reading



:reading
cls
rem FOR /F %%i IN (%input1%\%input2%) DO echo %%i>%pathout%\outputReadFile.txt
type %input1%\%input2%
rem start %pathout%\outputReadFile.txt
pause
goto start
rem ↑ (filereader code)

rem ↓ (iodc code)
:iodcStart
title Ip Or Domain Checker v.1.0.0
Cls
set /a wantURL=0
set /a wantIP=0
set /p input=Enter IP Address or URL: 
    setlocal enableextensions disabledelayedexpansion

    for /f "tokens=* delims=0123456789" %%a in ("%input%") do (
        if not "%%a"=="%input%" goto IP
	) 
	else goto ERROR


:URL
cls
set /a wantURL=1
echo Look at your browser.
start https://www.virustotal.com/gui/domain/%input%
pause
Goto start

:IP
cls
set /a wantIP=1
echo Look at your browser.
start https://www.virustotal.com/gui/ip-address/%input%
pause
Goto start

:ERROR
cls
echo Make sure to enter a IP Address or a domain!
goto iodcStart
rem ↑ (iodc code)

rem ↓ (makefile code)
:makeFileStart
cls
title makefile
set /p input1=Enter file name: 
set /p input2=Enter file type: 
set /p filepath=Enter wanted exact file path: 
set /p filecontent=Enter file content: 
goto printingfile

:printingfile
title makefile;printingfile
cls
echo %filecontent%>%filepath%\%input1%.%input2%
cls
echo File Created at %filepath%!
pause
goto start
rem ↑ (makefile code)

:filedownloader
cls
title filedownloader
echo Make sure to enter a URL directly to the file!
set /p wantedDownload="> "
echo Enter a exact path where you want the file to be saved to (no file name).
set /p wantedFilePath="> "
echo Enter the file name you so desire.
set /p wantedFileName="> "
bitsadmin /transfer myDownloadJob /download /priority foreground %wantedDownload% %wantedFilePath%\%wantedFileName%
pause
goto start

:fileUpdater
cls
echo Do you want to only update [i]nstalled apps, install [w]indows Updates or [b]oth?
set /p wantedUpdates="> "
if %wantedUpdates%==i (
   cls
   title Updating apps...
   winget update --all --silent --recurse --force
   pause
   goto start
   )
if %wantedUpdates%==w (
   cls
   title Updating Windows.
   powershell wuauclt /detectnow /updatenow
   powershell UsoClient /StartScan
   echo Started Windows update scan.
   title Updating Windows..
   PING localhost -n 2 >NUL
   title Updating Windows...
   UsoClient /StartDownload
   echo Started Windows update download.
   PING localhost -n 3 >NUL
   UsoClient /StartInstall
   echo Started Windows update install.
   PING localhost -n 4 >NUL
   echo Finished installing Windows updates [Updates might still be installing!]
   pause
   goto start
   )
if %wantedUpdates%==b (
   cls
   title Updating apps...
   winget update --all --silent --recurse --force
   title Updating Windows.
   powershell wuauclt /detectnow /updatenow
   powershell UsoClient /StartScan
   echo Started Windows update scan.
   title Updating Windows..
   PING localhost -n 2 >NUL
   title Updating Windows...
   UsoClient /StartDownload
   echo Started Windows update download.
   PING localhost -n 3 >NUL
   UsoClient /StartInstall
   echo Started Windows update install.
   PING localhost -n 4 >NUL
   echo Finished installing Windows updates (Updates might still be installing!)
   pause
   goto start
   )

:filecopy
cls
echo Enter a file path to the source
set /p wantedCopySrc="> "
echo ----------------------
echo Enter a file path to the destination (TO A EXISTING FOLDER!)
set /p wantedCopyDest="> "
xcopy /e /v %wantedCopySrc% %wantedCopyDest%
goto start

:taskkill 
cls
tasklist
echo --------------
echo Which task do you want to end
set /p taskKill="> "
echo Type "/T" if you want to kill the the process and any processes created by it. Leave empty if you don't.
set /p wantKillChilds="> "
if %taskkill%==svchost.exe goto taskKillError
taskkill /f /im %wantKillChilds% %taskKill%
pause
goto start

:taskKillError
echo Are you sure you want to end this task? It will bluescreen your computer (if you ran this program as adminstrator.)
choice /C YN 
if %errorlevel%==1 taskkill /f /im %taskKill%
if %errorlevel%==2 goto taskKillError2
pause
goto start

:taskKillError2
echo Okay, you can change your mind :)
timeout 1 >nul
goto taskkill

:cleaner
Cls
echo If you didn't start SuiteLauncher as Adminstrator, this might not work properly.
title Counting Temporary Files
pushd %temp%
for /f %%A in ('dir /a-d-s-h /b ^| find /v /c ""') do set cnt=%%A
echo Amount of temporary files in %temp%: %cnt%
echo ------------------------------------------
pause
title Cleaning.
echo Cleaning right now!
echo Errors:
echo ----------------------------
rmdir /S /Q %temp%
echo ----------------------------
title Cleaning..
mkdir %username%\AppData\Local\Temp
title Cleaning..
echo Done cleaning!
title Cleaning done!
pause
popd
goto start

:readme
cls
title Suite Launcher ReadMe
echo Thank you for using rx560 Suite!
echo This launcher is in no way malware.
echo I am not responsible for what people decide to do with this.
echo -rx560
echo -------------
echo Changelogs:
echo v1.3: Added installed app + Windows updater
echo v1.2: Added /T to Taskkill
echo v1.1: Added readme + file downloader
echo v1.0: Initial release (Before github)
pause
goto start

:errorlevel
title errorlevel
echo An error occured in this script, edit this file to try and fix it.
echo  
rem echo Variable values:
rem echo filecontent: %filecontent%
rem echo filepath: %filepath%
rem echo input1: %input1%
rem echo input2: %input2%
pause
goto start

:exitScript
exit

:end
cmd /k
