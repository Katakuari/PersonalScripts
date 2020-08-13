@echo off
SETLOCAL
set parent=%~dp0

for /f %%i in ('dir /B /A:D %parent%\*ffmpeg*') do set ffmpeg=%%i

cd %userprofile%\OneDrive


:ytdl

set /p vidlink="Playlist or video link: "
set vidlink="%vidlink%"

%parent%\youtube-dl.exe --ffmpeg-location %parent%\%ffmpeg%\bin --config-location %parent%\configm4a.txt %vidlink%



set /p c="Download another video or playlist [Y/N]? "
if /I "%c%" EQU "Y" goto :ytdl
if /I "%c%" EQU "N" OR "" exit