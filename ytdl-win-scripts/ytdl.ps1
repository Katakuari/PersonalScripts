# Last edit: 11.09.2020
# Author: Katakuari - https://github.com/Katakuari

New-Variable -Name parentdir -Value (Get-Location -PSProvider FileSystem) -Option ReadOnly # Get parent directory of script
New-Variable -Name WC -Value (New-Object System.Net.WebClient) -Option ReadOnly # Create WebClient and set links in case ffmpeg and/or ytdl are not found
New-Variable -Name ffmpeglink -Value "https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-4.3-win64-static.zip" -Option ReadOnly
New-Variable -Name ytdllink -Value "https://youtube-dl.org/downloads/latest/youtube-dl.exe" -Option ReadOnly
$outdir = "$HOME\Downloads" # Destination for video download

Write-Host "[ INFO ] Please make sure you have your txt configs in the same directory as this script." -ForegroundColor Cyan
Write-Host "[ INFO ] Download destination: $outdir" -ForegroundColor Cyan

function ytdl ([string]$fileformat) {
    # Get file format from selection
    Write-Host "Chosen file format: $fileformat"
    Write-Host ""
    
    $config = Get-ChildItem -Path $parentdir -File -Filter *$fileformat*.txt # Search for a txt config with file format in name
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

    if ($null -eq (Get-ChildItem -Path $parentdir -File -Filter "youtube-dl.exe")) {
        # Check for ytdl, and download if missing
        reqCheck("ytdlcheck")
    }

    try {
        # Try running FFMPEG from PATH, and if found, use it 
        ffmpeg -hide_banner -loglevel panic
        & $parentdir\youtube-dl.exe --config-location $parentdir\$config $vidlink
    }
    catch {
        # If FFMPEG not working from PATH, check if FFMPEG\ exists in parent directory
        if ($null -eq (Get-ChildItem -Path $parentdir -Directory -Filter *ffmpeg*)) {
            reqCheck("ffmpegcheck")
        }
        $ffmpegdir = Get-ChildItem -Path $parentdir -Directory -Filter *ffmpeg*

        & $parentdir\youtube-dl.exe --ffmpeg-location $parentdir\$ffmpegdir\bin --config-location $parentdir\$config $vidlink
    }

    $again = Read-Host -Prompt "Download another video or playlist? [Y/N]"
    switch ($again) {
        Y { ytdl($fileformat) }
        N { break }
        Default { break }
    }
}

function reqCheck ([string]$req) {
    switch ($req) {
        ytdlcheck {
            Write-Host "[ WARNING ] youtube-dl.exe not found!" -ForegroundColor Yellow
            $ytdlmiss = Read-Host "Do you wish to download it now? [Y/N]"
            switch ($ytdlmiss) {
                Y {
                    try {
                        $WC.DownloadFile($ytdllink, "$parentdir\youtube-dl.exe")
                        Write-Host "[ INFO ] Done! Continuing..." -ForegroundColor Cyan
                        Write-Host ""
                        break
                    }
                    catch {
                        Write-Host "[ ERROR ] Could not download file! Check link in script!" -ForegroundColor Red
                        Pause
                        Exit
                    }
                }
                N { Exit }
                Default { Exit }
            }
        }

        ffmpegcheck {
            Write-Host "[ WARNING ] No FFMPEG folder found!" -ForegroundColor Yellow
            $ffmpegmiss = Read-Host "Do you wish to download FFMPEG now? [Y/N]"
            switch ($ffmpegmiss) {
                Y {
                    try {
                        $WC.DownloadFile($ffmpeglink, "$parentdir\ffmpeg.zip")
                        Expand-Archive -Path "$parentdir\ffmpeg.zip" -DestinationPath "$parentdir"
                        Remove-Item -Path "$parentdir\ffmpeg.zip" -Force
                        Write-Host "[ INFO ] Done! Continuing..." -ForegroundColor Cyan
                        Write-Host ""
                        break
                    }                 
                    catch {
                        Write-Host "[ ERROR ] Could not download or extract file! Check link in script and parent folder!" -ForegroundColor Red
                        Pause
                        Exit
                    } 
                }
                N { Exit }
                Default { Exit }
            }
        }
        Default { break }
    }
}

function selection {
    Write-Host "Available download formats: 1 - mp4 (default) | 2 - m4a | 3 - mp3 | 4 - custom"
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
        Default { ytdl("mp4") }
    }
}

selection

explorer.exe "$outdir"
Set-Location $parentdir
Exit