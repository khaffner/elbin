function Write-Log {
    param (
        [string]$SensorName,
        [string]$Text
    )
    $FolderPath = "/logs/$SensorName"
    $FileName = Get-Date -Format "yyyy-MM-dd"
    $FilePath = "$FolderPath/$FileName.json"
    if(!(Test-Path $FolderPath)) {
        New-Item $FolderPath -ItemType Directory
    }
    $Text | Out-File -Append -FilePath $FilePath
    Write-Host $Text
}