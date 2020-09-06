class Orientation {
    [datetime]$timestamp
    [int]$pitch
    [int]$yaw
    [int]$roll
    [int]$rollFriendly
    [string]$rollDirection = "Centered"
}

while($true) {
    $src = python /app/Orientation.py | ConvertFrom-Json

    $obj = New-Object Orientation
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.pitch = $src.pitch
    $obj.yaw = $src.yaw #Compass
    $obj.roll = $src.roll
    $obj.rollFriendly = $src.roll

    if ($obj.rollFriendly -lt 180) {
        $obj.rollDirection = "Right"
    }
    
    if($obj.rollFriendly -gt 180) {
        $obj.rollDirection = "Left"
        $obj.rollFriendly = 360 - $obj.roll #Flipped
    }

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 1
}