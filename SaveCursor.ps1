$regPath = "HKCU:\Control Panel\Cursors"
$saveFolder = "Cursors"
$cursorRoles = @(
    "Arrow", "Help", "AppStarting", "Wait", "Crosshair", "IBeam", "NWPen",
    "No", "SizeAll", "SizeNESW", "SizeNS", "SizeNWSE", "SizeWE", "UpArrow", "Hand"
)

New-Item -ItemType Directory -Path $saveFolder -Force | Out-Null

$scheme = @{}
foreach ($role in $cursorRoles) {
    $scheme[$role] = Get-ItemPropertyValue -Path $regPath -Name $role
}
$scheme["Name"] = Get-ItemPropertyValue -Path $regPath -Name "(default)"

$schemeFile = Join-Path $saveFolder "$($scheme["Name"]).json"

if (-not (Test-Path $schemeFile)) {
    $scheme | ConvertTo-Json | Out-File $schemeFile
    Write-Host "Saved: $($scheme["Name"])"
} else {
    Write-Host "'$($scheme["Name"])' has already been saved."
}