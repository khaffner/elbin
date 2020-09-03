class Orientation {
    [datetime]$timestamp
    [float]$pitch
    [float]$yaw
    [float]$roll
}

while($true) {
    $src = python /app/Orientation.py | ConvertFrom-Json

    $obj = New-Object Orientation
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.pitch = $src.pitch
    $obj.yaw = $src.yaw #Compass
    $obj.roll = $src.roll

    # Save results
    $FolderPath = "/logs/orientation"
    $FileName = Get-Date -Format "yyyy-MM-dd"
    $FilePath = "$FolderPath/$FileName.json"
    if(!(Test-Path $FolderPath)) {
        New-Item $FolderPath -ItemType Directory
    }
    $json = $obj | ConvertTo-Json -Compress
    $json | Out-File -Append -FilePath $FilePath
    Write-Host $json
    Start-Sleep -Seconds 10
}