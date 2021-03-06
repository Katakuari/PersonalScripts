# 18.05.2021

$dest = "$env:USERPROFILE\Desktop\lockscreencache"
$source = "$env:LOCALAPPDATA\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

MKDIR $dest -ErrorAction SilentlyContinue | Out-Null
Robocopy.exe "$source" "$dest" /S /NJH /NJS /NC

$images = Get-ChildItem $dest -Recurse -Force
foreach ($img in $images) {
	if (Test-Path "$dest\$img.jpg") {
		break
	}
	else {
		Rename-Item "$dest\$img" "$dest\$img.jpg" -Verbose
	}
}

pause