$startupPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\randomcursor.lnk"
if(-not (Test-Path -Path $startupPath)){
	$cmdPath = Get-Location
	$WshShell = New-Object -ComObject WScript.Shell
	$lnk = $WshShell.CreateShortcut($startupPath)
	$lnk.TargetPath = "$($cmdPath)\startup.cmd"
	$lnk.WorkingDirectory = "$($cmdPath)"
	$lnk.Save()
	Write-Host "Random cursor on startup is now enabled"
} else {
	Remove-Item $startupPath
	Write-Host "Random cursor on startup is now disabled"
}
