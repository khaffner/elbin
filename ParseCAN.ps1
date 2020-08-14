# Sample data until I have the hardware
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
    [string]$Data
    [string]$DataUnit
    [string]$DataValue
}

$SampleArray | ForEach-Object {
    $Split = $PSItem.Split()

    $Frame = New-Object CANFrame
    $Frame.TimeStamp = Get-Date -Format "o" # ISO 8601
    $Frame.ID = $Split[1]
    $DLC = $Split[2].Replace('[','').Replace(']','')
    $Frame.Data = ($Split | Select-Object -Last $DLC) -join ''

    # Use IDFriendlyName as filename if possible, use ID as fallback
    $FileName = $Frame.IDFriendlyName ? $Frame.IDFriendlyName : $Frame.ID
    $Frame | ConvertTo-Json -Compress | Out-File -Append -FilePath "/can-data/$FileName.json"
}