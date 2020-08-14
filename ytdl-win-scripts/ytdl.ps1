# 14.08.2020

$parentdir = Get-Location # Get parent directory of script
$outdir = "$HOME\Downloads" # Destination for download

Write-Host "[ INFO ] Please make sure you have your txt configs, the youtube-dl.exe and the FFMPEG directory in the same directory as this script." -ForegroundColor Cyan
Write-Host "[ INFO ] Download destination: $outdir" -ForegroundColor Cyan

function ytdl ([string]$fileformat) {
    # Get file format from selection
    Write-Host ""
    Write-Host "Chosen file format: $fileformat"

    $config = Get-ChildItem -Path $parentdir -File -Filter "*$fileformat*.txt" # Search for a txt config with file format in name
    if ($null -eq $config) {
        # If no config found, show error and ask if script should continue
        Write-Host "[ ERROR ] No txt config found for chosen format. Please create a txt config for $fileformat." -ForegroundColor Red
        $continue = Read-Host -Prompt "Continue anyway? [Y/N]"
        switch ($continue) {
            Y { break }
            N { Exit }
            Default { Exit }
        }
    }

    $vidlink = Read-Host -Prompt "Video or playlist link"
    Set-Location $outdir

    try {
        # Try running FFMPEG from PATH var, and if found, use it 
        ffmpeg -hide_banner -loglevel panic
        & $parentdir\youtube-dl.exe --config-location $parentdir\$config $vidlink
    }
    catch {
        # If FFMPEG not working from PATH, check if FFMPEG\bin exists in parent directory
        $ffmpegdir = Get-ChildItem -Path $parentdir -Directory -Filter *ffmpeg*
        if ($null -eq $ffmpegdir) {
            # If FFMPEG directory does not exist, exit
            Write-Host "[ ERROR ] No FFMPEG folder found. Exiting..." -ForegroundColor Red
            Exit
        }
        & $parentdir\youtube-dl.exe --ffmpeg-location $parentdir\$ffmpegdir\bin --config-location $parentdir\$config $vidlink
    }

    $again = Read-Host -Prompt "Download another video or playlist? [Y/N]"
    switch ($again) {
        Y { ytdl($fileformat) }
        N { break }
        Default { break }
    }
}


function selection {
    Write-Host "Available download formats: 1 - mp4 | 2 - m4a | 3 - mp3 | 4 - custom"
    Write-Host "Press Enter to Exit."
    Write-Host ""
    $modesel = Read-Host -Prompt "Enter selection"
    switch ($modesel) {
        1 { ytdl("mp4") }
        2 { ytdl("m4a") }
        3 { ytdl("mp3") }
        4 {
            Write-Host "[ WARNING ] Please make sure a txt config for the format exists before you continue!" -ForegroundColor Yellow
            $custfileformat = Read-Host -Prompt "Custom file format"
            ytdl("$custfileformat")
        }
        Default { Exit }
    }
}
selection

explorer.exe "$outdir"
Set-Location $parentdir
Exit