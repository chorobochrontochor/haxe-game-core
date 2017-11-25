@echo off

REM Set variables
set FOLDER_OUT_JS=out-js
set FOLDER_OUT_JS_FILE=out-js\TheProject.js

set MAIN_CLASS=src\Main.as

set HXML_BUILD_JS=build_js.hxml


REM Cleaning
del %FOLDER_OUT_JS_FILE% /q
echo JS file cleaned (%FOLDER_OUT_JS_FILE% file).
echo.


REM Building
echo Building JS (%FOLDER_OUT_JS%)...
haxe %HXML_BUILD_JS%
if errorlevel 1 goto fail
if errorlevel 0 echo ...done
echo.

pause