class Orientation {
    [datetime]$timestamp
    [int]$pitch
    [int]$yaw
    [int]$roll
    [int]$rollFriendly
    [int]$pitchFriendly
    [string]$rollDirection = "level"
    [string]$pitchDirection = "level"
}

while($true) {
    $src = python /app/Orientation.py | ConvertFrom-Json

    $obj = New-Object Orientation
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.yaw = $src.yaw #Compass
    $obj.pitch = $src.pitch
    $obj.pitchFriendly = $obj.pitch
    $obj.roll = $src.roll
    $obj.rollFriendly = $obj.roll

    # Friendlier values for roll (sideways)
    if ($obj.roll -in 3..180) {
        $obj.rollDirection = "right"
    }
    
    if($obj.roll -in 181..357) {
        $obj.rollDirection = "left"
        $obj.rollFriendly = 360 - $obj.roll #Mirrored
    }

    # Friendlier values for pitch (bow up/down)
    if ($obj.pitch -in 3..180) {
        $obj.pitchDirection = "up"
    }
    
    if($obj.pitch -in 181..357) {
        $obj.pitchDirection = "down"
        $obj.pitchFriendly = 360 - $obj.pitch #Flipped
    }

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 1
}