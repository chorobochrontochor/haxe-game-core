@echo off

REM Set variables
set FOLDER_OUT_SWF=out-swf
set FOLDER_OUT_SWF_FILE=out-swf\TheProject.swf

set FOLDER_OUT_SWC=out-swc
set FOLDER_OUT_SWC_FILE=out-swc\TheProject.swc

set FDB_TXT=fdb.txt
set MAIN_CLASS=src\Main.as

set HXML_BUILD_SWC=build_swc.hxml
set HXML_BUILD_SWF=build_swf.hxml


REM Cleaning
del %FOLDER_OUT_SWF%\*.* /q
del %FOLDER_OUT_SWC%\*.* /q
echo Project cleaned (%FOLDER_OUT_SWF% and %FOLDER_OUT_SWC% folders).
echo.


REM Building
echo Building SWF (%FOLDER_OUT_SWF_FILE%)...
haxe %HXML_BUILD_SWF%
if errorlevel 1 goto fail
if errorlevel 0 echo ...done
echo.


REM Open SWF
echo.
echo Starting SWF (%FOLDER_OUT_SWF_FILE%)...
start %FOLDER_OUT_SWF_FILE%
if errorlevel 1 goto fail
if errorlevel 0 echo ...done
echo.


REM Creating SWC
echo.
echo Building SWC (%FOLDER_OUT_SWC_FILE%)...
haxe %HXML_BUILD_SWC%
if errorlevel 1 goto fail
if errorlevel 0 echo ...done
echo.


pause