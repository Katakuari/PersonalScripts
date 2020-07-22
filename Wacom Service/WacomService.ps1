Write-Host "PLEASE MAKE SURE YOU ARE RUNNING POWERSHELL AS ADMINISTRATOR" -ForegroundColor Red
Write-Host "Use batch file  to add 'Run as Admin' in your drop-down menu for PowerShell files"
Write-Host ""
Write-Host "Available options: 1 - Start | 2 - Stop | 3 - Restart | 4 - Status | Enter - Exit"

function wacomSvc {
    Write-Host ""
    $serstat = Read-Host -Prompt "Enter number"

    switch ($serstat) {
        1 {
            Write-Host ""
            Write-Host "Starting service..."
            Start-Service -Name WTabletServicePro 
            wacomSvc
        }
        2 {
            Write-Host ""
            Write-Host "Stopping service..."
            Stop-Service -Name WTabletServicePro
            wacomSvc
        }
        3 {
            Write-Host ""
            Write-Host "Restarting service..."
            Restart-Service -Name WTabletServicePro
            wacomSvc
        }
        4 {
            Write-Host ""
            Write-Host "Requesting service status..."
            Get-Service -Name WTabletServicePro
            wacomSvc
        }
        Default { Exit }
    }
}
wacomSvc