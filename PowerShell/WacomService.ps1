
$SerStat = Read-Host -Prompt 'Wacom Tablet Service - 0 = Exit, 1 = Start, 2 = Stop, 3 = Restart, 4 = Status'

IF($SerStat -match '1'){
Write-Host ''
Write-Host 'Starting...'
Start-Service -Name WTabletServicePro
}

IF($SerStat -match '2'){
Write-Host ''
Write-Host 'Stopping...'
Stop-Service -Name WTabletServicePro
}

IF($SerStat -match '3'){
Write-Host ''
Write-Host 'Restarting...'
Restart-Service -Name WTabletServicePro
}

IF($SerStat -match '4'){
Write-Host ''
Write-Host ''
Write-Host 'Requesting Status...'
Get-Service -Name WTabletServicePro
Write-Host ''
Write-Host ''
}

IF($SerStat -match '0'){
Write-Host ''
Write-Host 'Exiting script.'
exit
}
