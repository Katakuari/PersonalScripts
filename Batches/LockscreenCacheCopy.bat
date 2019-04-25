@ECHO OFF

::Create directory on users desktop and switch into it
MKDIR "%userprofile%\Desktop\LockscreenCache"
CD "%userprofile%\Desktop\LockscreenCache"
ECHO Created directory 'LockscreenCache' on Desktop

::Switch to cache directory and copy all files to the newly created one on the desktop
COPY "%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*.*" "%userprofile%\Desktop\LockscreenCache"
ECHO Copied cache to created directory

::Rename all files to end with .png (changeable to .jpg)
REN *.* *.png
ECHO Renamed files to .png format

::Pause after completion
PAUSE
