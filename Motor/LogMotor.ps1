# Configure CAN adapter
# http://pascal-walter.blogspot.com/2015/08/installing-lawicel-canusb-on-linux.html
Write-Host "Configuring can0"
slcand -o -c -f -s8 /dev/serial/by-id/usb-Silicon_Labs_CP2102_USB_to_UART_Bridge_Controller_0001-if00-port0 can0
Start-Sleep -Seconds 2
Write-Host "Bringing up can0"
ifconfig can0 up

# Sample data until I have the hardware working
$SampleArray = @(
    "can0 1DFF6773 [8] 00 0B 3B 9F 03 02 04 5A",
    "can0 1DFF6773 [6] 01 A1 12 19 09 09",
    "can0 0DF010A0 [8] FF FF A9 3F 18 A8 C6 28",
    "can0 15FD0773 [8] 00 C0 53 7A FF 7F FF FF",
    "can0 09F503A0 [8] FF FF FF 60 01 FF FF FF",
    "can0 11F80E2B [8] 00 1B 01 E0 53 7F 10 3F"
)

class CANFrame {
    [datetime]$TimeStamp
    [string]$ID
    [string]$IDFriendlyName
    [string]$DataRaw
    [string]$DataUnit
    [string]$DataValue
}

$SampleArray | ForEach-Object {
    $Split = $PSItem.Split()

    $Frame = New-Object CANFrame
    $Frame.TimeStamp = Get-Date -Format "o" # ISO 8601
    $Frame.ID = $Split[1]
    $DLC = $Split[2].Replace('[','').Replace(']','')
    $Frame.DataRaw = ($Split | Select-Object -Last $DLC) -join ''

    # Translations of ID and data
    if($Frame.ID -eq "09F503A0") {
        $Frame.IDFriendlyName = "Test1" # example
        $Frame.DataUnit = "RPM" # example
        $Frame.DataValue = "test" #example
    }

    # Use IDFriendlyName as folder name if possible, use ID as fallback
    $FolderName = $Frame.IDFriendlyName ? $Frame.IDFriendlyName : $Frame.ID
    
    Write-Log -SensorName $FolderName -String ($Frame | ConvertTo-Json -Compress)
}