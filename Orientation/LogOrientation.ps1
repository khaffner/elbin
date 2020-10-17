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
    if($obj.pitch -eq 360) {$obj.pitch = 0}
    $obj.pitchFriendly = $obj.pitch
    
    $obj.roll = $src.roll
    if($obj.roll -eq 360) {$obj.roll = 0}
    $obj.rollFriendly = $obj.roll

    # Friendlier values for roll (sideways)
    if ($obj.roll -in 0..179) {
        $obj.rollDirection = "right"
    }
    if($obj.roll -in 180..359) {
        $obj.rollDirection = "left"
        $obj.rollFriendly = 360 - $obj.roll #Mirrored
    }

    # Friendlier values for pitch (bow up/down)
    if ($obj.pitch -in 0..179) {
        $obj.pitchDirection = "up"
    }
    if($obj.pitch -in 180..359) {
        $obj.pitchDirection = "down"
        $obj.pitchFriendly = 360 - $obj.pitch #Flipped
    }

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 1
}