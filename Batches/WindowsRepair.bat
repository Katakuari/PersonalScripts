SFC /SCANNOW

dism /Online /Cleanup-Image /ScanHealth

dism /online /cleanup-image /restorehealth /source:wim:DRIVE:\sources\install.wim:1 /limitaccess
