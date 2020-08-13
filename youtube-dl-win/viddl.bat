@echo off
SETLOCAL
set parent=%~dp0

for /f %%i in ('dir /B /A:D %parent%\*ffmpeg*') do set ffmpeg=%%i

cd %userprofile%\OneDrive


:ytdl

set /p vidlink="Video link: "
set vidlink="%vidlink%"

%parent%\youtube-dl.exe --ffmpeg-location %parent%\%ffmpeg%\bin --config-location %parent%\viddl.txt %vidlink%



set /p c="Download another video [Y/N]? "
if /I "%c%" EQU "Y" goto :ytdl
if /I "%c%" EQU "N" OR "" exit