class Temperature {
    [datetime]$timestamp
    [string]$temp
}

while($true) {
    $raw = & /app/utmp-cli -q # https://usbtemp.com/

    $obj = New-Object Temperature
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.temp = $raw.Split("C: ")[-1]

    # Save results
    $FolderPath = "/temperature-data"
    $FileName = Get-Date -Format "yyyy-MM-dd"
    $FilePath = "$FolderPath/$FileName.json"
    if(!(Test-Path $FolderPath)) {
        New-Item $FolderPath -ItemType Directory
    }
    $obj | ConvertTo-Json -Compress | Out-File -Append -FilePath $FilePath
    Start-Sleep -Seconds 59
}