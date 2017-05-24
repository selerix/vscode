@echo off
title VSCode Dev Monaco Editor Distro

pushd %~dp0..

echo Working Dir:
echo %~dp0..

:: Node modules
if not exist node_modules call .\scripts\npm.bat install

:: Get electron
node .\node_modules\gulp\bin\gulp.js electron

:: Cleanup Build folders
if exist .\obj rmdir .\obj /s /q
if exist .\out rmdir .\out /s /q
if exist .\out-build rmdir .\out-build /s /q
if exist .\out-editor rmdir .\out-editor /s /q
if exist .\out-editor-min .\out-editor-min /s /q

:: Build
if not exist out node .\node_modules\gulp\bin\gulp.js compile

:: Cleanup Editor Distro folders
if exist ..\Monaco-Editor rmdir ..\Monaco-Editor /s /q
if exist ..\Monaco-Editor-Min rmdir ..\Monaco-Editor-Min /s /q
if exist ..\Monaco-Editor-Min-SourceMaps rmdir ..\Monaco-Editor-Min-SourceMaps /s /q
if exist out-build rmdir out-build /s /q
if exist out-editor rmdir out-editor /s /q
if exist out-editor-min rmdir out-editor-min /s /q

:: Make Editor Distro
node .\node_modules\gulp\bin\gulp.js editor-distro

:: Deploy to the main Project location
if exist ..\..\..\src\SystemFrameworks\Forms\Web\Monaco rmdir ..\..\..\src\SystemFrameworks\Forms\Web\Monaco /s /q
xcopy ..\Monaco-Editor ..\..\..\src\SystemFrameworks\Forms\Web\Monaco /s /h /i /Y
