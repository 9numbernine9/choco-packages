﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.64.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/5554b12acf27056905806867f251c859323ff7e9/VSCodeSetup-ia32-1.64.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/5554b12acf27056905806867f251c859323ff7e9/VSCodeSetup-x64-1.64.0.exe'

  softwareName   = "$softwareName"

  checksum       = '8c17e9df40e47ec1f6c42c13e77748c42387cf802af775efd26c2ceb140ce0e1'
  checksumType   = 'sha256'
  checksum64     = '6999b6031217b5e5817bbff3335713d6fa341720b517f81796860e03d89ea77e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
