@ECHO OFF

SETLOCAL
::Set maximum size of files to 280KB (for filtering)
SET maxsize=280000

::Create directory on desktop and change location to it
MKDIR "%userprofile%\Desktop\lscache"
CD "%userprofile%\Desktop\lscache"

::Copy all files from cache to new directory on desktop
COPY "%userprofile%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*.*" .

::Delete files below 280KB
FOR /F "tokens=*" %%G IN ('DIR . /B') DO (
IF %%~zG LSS %maxsize% del %%G
)

::Change extensions of all filtered files to .jpg
REN *.* *.jpg
