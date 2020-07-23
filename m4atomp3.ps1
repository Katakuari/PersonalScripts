# 22.07.2020
# Powershell script to convert m4a files to mp3 using FFMPEG
# Please add FFMPEG to your PATH for this to work

$parentdir = Get-Location
$outdir = "$HOME\Desktop\MP3CONVOUT" # Set Output destination
MKDIR -Path "$outdir" -Force # Force creation of Output directory

function fileConv {
    $srcdir = Read-Host -Prompt "Source directory path" # Let user put in directory containing files to convert WITHOUT QUOTATION MARKS
    Set-Location "$srcdir"
    
    if (Get-ChildItem -Directory) {
        $subfol = Read-Host -Prompt "Include files in subfolders? [Y/N]" # Ask if files in subfolders should be included
        switch ($subfol) {
            Y { $files2conv = Get-ChildItem -File -Filter *.m4a -Name -Recurse } # If yes, search for .m4a files recursively
            N { $files2conv = Get-ChildItem -File -Filter *.m4a -Name } # If no, stay in current directory; also default case
            Default { $files2conv = Get-ChildItem -File -Filter *.m4a -Name }
        }
    }
    else {
        $files2conv = Get-ChildItem -File -Filter *.m4a -Name
    }
    
    FOREACH ($i in $files2conv) {
        Write-Host ""
        Write-Host "Current file: $i" -ForegroundColor green # Write current file being converted in green text
        ffmpeg -hide_banner -loglevel panic -i "$srcdir\$i" -ar 44100 -ac 2 -ab 256k -f mp3 "$i.mp3" -n # FFMPEG command
        try {
            Move-Item -Path "$srcdir\$i.mp3" -Destination "$outdir" -Force # Move the converted .mp3 file to Output directory
            Write-Host "[ OKAY ] File moved to $outdir"
        }
        catch {
            Write-Host "[ FAIL ] Failed to move file"
        }
    }

    Set-Location "$outdir"
    Get-ChildItem -Filter *.mp3 | Rename-Item -NewName { $_.name -replace ".m4a", "" } # Cut out .m4a in file names

    Write-Host ""
    $again = Read-Host -Prompt "Convert another directory? [Y/N]"
    switch ($again) {
        Y { fileConv }
        N { break }
        Default { break }
    }
}

fileConv

Set-Location "$parentdir"
Exit