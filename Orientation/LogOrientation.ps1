class Orientation {
    [datetime]$timestamp
    [int]$pitch
    [int]$yaw
    [int]$roll
    [string]$rollDirection
    [string]$pitchDirection
}

while($true) {
    $src = python /app/Orientation.py | ConvertFrom-Json

    $obj = New-Object Orientation
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.pitch = $src.pitch
    $obj.yaw = $src.yaw #Compass
    $obj.roll = $src.roll

    # Friendlier values for roll (sideways)
    if ($obj.roll -lt 180) {
        $obj.rollDirection = "right"
    }

    if($obj.roll -eq 0) {
        $obj.rollDirection = "level"
    }
    
    if($obj.roll -gt 180) {
        $obj.rollDirection = "left"
        $obj.roll = 360 - $obj.roll #Mirrored
    }

    # Friendlier values for pitch (bow up/down)
    if ($obj.pitch -lt 180) {
        $obj.pitchDirection = "down"
    }

    if($obj.pitch -eq 0) {
        $obj.pitchDirection = "level"
    }
    
    if($obj.pitch -gt 180) {
        $obj.pitchDirection = "up"
        $obj.pitch = 360 - $obj.pitch #Flipped
    }

    Write-Log -SensorName "orientation" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 1
}