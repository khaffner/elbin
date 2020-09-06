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

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 10
}