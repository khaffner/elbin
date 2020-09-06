class Temperature {
    [datetime]$timestamp
    [string]$temp
}
digitemp_DS9097 -i -s /dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller-if00-port0 -c /etc/digitemp.conf
while($true) {
    $raw = digitemp_DS9097 -a -q -c /etc/digitemp.conf

    $obj = New-Object Temperature
    $obj.timestamp = Get-Date -Format "o" # ISO 8601
    $obj.temp = $raw.Split(": ")[-2].Replace(" F","")

    Write-Log -SensorName "temperature" -Text ($obj | ConvertTo-Json -Compress)
    Start-Sleep -Seconds 59
}