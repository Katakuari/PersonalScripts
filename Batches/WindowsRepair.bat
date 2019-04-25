SFC /SCANNOW
PAUSE

dism /Online /Cleanup-Image /ScanHealth
PAUSE

dism /online /cleanup-image /restorehealth /source:wim:DRIVE:\sources\install.wim:1 /limitaccess
PAUSE
