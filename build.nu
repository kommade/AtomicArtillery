def main [] {
    # Build a single-line PowerShell command (escaped for nu.exe)
    let psCmd = "& { $changelog = 'AtomicArtillery2\\changelog.txt'; if(-not (Test-Path $changelog)) { Write-Error \"Changelog not found: $changelog\"; exit 1 }; $line = Get-Content $changelog | Select-String '^Version:' | Select-Object -First 1 | ForEach-Object { $_.Line }; if(-not $line) { Write-Error \"No Version found in $changelog\"; exit 2 }; $ver = ($line -replace '^Version:\\s*','').Trim(); $verClean = ($ver -replace '^[vV]','') -replace '[^0-9A-Za-z._-]','_'; $out = \"AtomicArtillery2_${verClean}.zip\"; Write-Host \"Creating archive: $out\"; 7z a $out AtomicArtillery2/* -r; Write-Host \"Archive created: $out\"; Write-Output $out }"

    # Execute PowerShell. On Windows 'powershell' should be available.
    let res = (powershell -NoProfile -NonInteractive -Command $psCmd)
    print $res
}