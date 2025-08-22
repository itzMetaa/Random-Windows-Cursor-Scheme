$regPath = "HKCU:\Control Panel\Cursors"
$saveFolder = "Cursors"

if(-not (Test-Path -Path $saveFolder)){
	Write-Host "There aren't any cursors saved yet."
	return
}

$files = Get-ChildItem -Path $saveFolder -Filter *.json

if ($files.Count -eq 0) {
    Write-Host "There aren't any cursors saved yet."
    return
}

$randomFile = Get-Random -InputObject $files
$scheme = Get-Content $randomFile.FullName | ConvertFrom-Json
$name = ""

foreach ($item in $scheme.PSObject.Properties) {
	Write-Host $item.Name
	Write-Host $item.Value
    if ($item.Name -ne "Name") {
        Set-ItemProperty -Path $regPath -Name $item.Name -Value $item.Value
    } else {
		$name = $item.Value
		Set-ItemProperty -Path $regPath -Name "(default)" -Value $item.Value
	}
}

# Inline c# needed to refresh the cursor
$CSharpSig = @"
using System.Runtime.InteropServices;
public class CursorRefresher {
    [DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
    public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);
}
"@

Add-Type -TypeDefinition $CSharpSig
[CursorRefresher]::SystemParametersInfo(0x57, 0, 0, 0) | Out-Null

Write-Host "Random scheme loaded: '$name'"
