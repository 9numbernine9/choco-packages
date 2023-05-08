﻿$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.18-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.18-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.18-1.win64-install.exe'
  checksum       = '530f92597781bc632d22d58bc30b8a6fa6281949d65ae13831a4f7d1078dd741'
  checksum64     = 'bde4d2194e0bb29173370535d1e8ddce21436fbbbe4ea87b3b4b84d97fb17781'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Write-Output "Running Autohotkey installer"
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
Autohotkey.exe $toolsPath\$packageName.ahk $packageArgs.fileFullPath

$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
