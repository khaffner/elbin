class Temperature {
    [datetime]$timestamp
    [string]$temp
}
digitemp_DS9097 -i -s /dev/ttyUSB0 -c /etc/digitemp.conf
while($true) {
    $raw = digitemp_DS9097 -a -q -c /etc/digitemp.conf

    $obj = New-Object Temperature
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.temp = $raw.Split(": ")[-2].Replace(" F","")

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