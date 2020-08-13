# 13.08.2020

Write-Host "Please make sure you have youtube-dl.exe and ffmpeg\bin\ in the same directory as this script." -ForegroundColor Red
$parentdir = Get-Location # Get parent directory of script
$outdir = "$HOME\Downloads"

function videoDownload {
    $vidlink = Read-Host -Prompt "Video link"
    Write-Host "Download destination: $outdir" -ForegroundColor Cyan
    Set-Location $outdir

    try { # Check if ffmpeg is in PATH by executing it, and choose method depending on it
        ffmpeg -hide_banner -loglevel panic
        & $parentdir\youtube-dl.exe --config-location $parentdir\viddl.txt $vidlink
    }
    catch { # If ffmpeg isn't in PATH, look for ffmpeg folder in current directory
        $ffmpegdir = Get-ChildItem -Directory -Path $parentdir -Filter *ffmpeg*
        & $parentdir\youtube-dl.exe --ffmpeg-location $parentdir\$ffmpegdir\bin --config-location $parentdir\viddl.txt $vidlink
    }

    $again = Read-Host -Prompt "Download another video? [Y/N]"
    switch ($again) {
        Y { videoDownload }
        N { break }
        Default { break }
    }
}


function musicDownloadm4a {
    $vidlink = Read-Host -Prompt "Video or playlist link"
    Write-Host "Download destination: $outdir" -ForegroundColor Cyan
    Set-Location $outdir

    try {
        ffmpeg -hide_banner -loglevel panic
        & $parentdir\youtube-dl.exe --config-location $parentdir\configm4a.txt $vidlink
    }
    catch {
        $ffmpegdir = Get-ChildItem -Directory -Path $parentdir -Filter *ffmpeg*
        & $parentdir\youtube-dl.exe --ffmpeg-location $parentdir\$ffmpegdir\bin --config-location $parentdir\configm4a.txt $vidlink
    }

    $again = Read-Host -Prompt "Download another video or playlist? [Y/N]"
    switch ($again) {
        Y { musicDownloadm4a }
        N { break }
        Default { break }
    }
}


function musicDownloadmp3 {
    Write-Host ""
    $vidlink = Read-Host -Prompt "Video or playlist link"
    Write-Host "Download destination: $outdir" -ForegroundColor Cyan
    Set-Location $outdir

    try {
        ffmpeg -hide_banner -loglevel panic
        & $parentdir\youtube-dl.exe --config-location $parentdir\configmp3.txt $vidlink
    }
    catch {
        $ffmpegdir = Get-ChildItem -Directory -Path $parentdir -Filter *ffmpeg*
        & $parentdir\youtube-dl.exe --ffmpeg-location $parentdir\$ffmpegdir\bin --config-location $parentdir\configmp3.txt $vidlink
    }

    $again = Read-Host -Prompt "Download another video or playlist? [Y/N]"
    switch ($again) {
        Y { musicDownloadmp3 }
        N { break }
        Default { break }
    }
}


function selection {
    Write-Host "Available download formats: 1 - mp4 | 2 - m4a | 3 - mp3"
    Write-Host "Press Enter to break"
    Write-Host ""
    $modesel = Read-Host -Prompt "Enter selection"
    switch ($modesel) {
        1 { videoDownload }
        2 { musicDownloadm4a }
        3 { musicDownloadmp3 }
        Default { Exit }
    }
}
selection


explorer.exe "$outdir"
Set-Location $parentdir

Exit