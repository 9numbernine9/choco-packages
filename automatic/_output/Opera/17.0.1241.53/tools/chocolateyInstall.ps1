﻿$packageName = 'Opera'
$fileType = 'exe'
$silentArgs = '/install /silent /launchopera 0 /quicklaunchshortcut 0 /setdefaultbrowser 0'
$url = 'http://get.geo.opera.com/pub/opera/desktop/17.0.1241.53/win/Opera_17.0.1241.53_Setup.exe'

try {
	$tempDir = "$env:TEMP\chocolatey\$packageName"
	if (!(Test-Path $tempDir)) {New-Item $tempDir -ItemType directory -Force}
	$fileFullPath = "$tempDir\${packageName}Install.exe"

	Get-ChocolateyWebFile $packageName $fileFullPath $url

	$extractDir = "$tempDir\${packageName}Install"

	Start-Process '7za' -ArgumentList "x -o`"$extractDir`" -y `"$fileFullPath`"" -Wait

	$file = "$extractDir\launcher.exe"

	Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

	Remove-Item $extractDir -Force -Recurse
}	catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}