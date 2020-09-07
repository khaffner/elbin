class Orientation {
    [datetime]$timestamp
    [int]$pitch
    [int]$yaw
    [int]$roll
    [string]$rollDirection
}

while($true) {
    $src = python /app/Orientation.py | ConvertFrom-Json

    $obj = New-Object Orientation
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.pitch = $src.pitch
    $obj.yaw = $src.yaw #Compass
    $obj.roll = $src.roll

    if ($obj.roll -lt 180) {
        $obj.rollDirection = "right"
    }

    if($obj.roll -eq 0) {
        $obj.rollDirection = "centered"
    }
    
    if($obj.roll -gt 180) {
        $obj.rollDirection = "left"
        $obj.roll = 360 - $obj.roll #Flipped
    }

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 1
}