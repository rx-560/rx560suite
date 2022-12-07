@echo off
rem ↓ (SuiteLauncher Code)
:start
cls
title rx560 Suite Launcher v1.1
echo Welcome to rx560 Suite
echo Choose a program to run
echo [f]ilereader
echo [i]odc
echo [m]akefile
echo [d]ownloader
echo ----
echo [r]eadme
echo [e]xit
set /p wantedProgramStart=   
goto parseAnswer


:parseAnswer
if %wantedProgramStart%==f (
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
if %wantedProgramStart%==r (
   goto readme
   )
if %wantedProgramStart%==e (
   goto exitScript
   )
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

:readme
cls
title Suite Launcher ReadMe
(
echo Thank you for using rx560 Suite!
echo This launcher is in no way malware.
echo I am not responsible for what people decide to do with this.
echo -rx560
echo -------------
echo Changelogs:
echo v1.1: Added readme + file downloader
echo v1.0: Initial release
)>"%dp0%readme.txt"
start readme.txt
timeout /t 1 >nul
del readme.txt
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