﻿$packageName = 'flashplayeractivex'
$version = '31.0.0.108'
$majorVersion = '31'
$registry = ( Get-UninstallRegistryKey -SoftwareName "Adobe Flash Player $majorVersion ActiveX" ).DisplayVersion
$checking = ( $registry -eq $version )
$alreadyInstalled = @{$true = "Adobe Flash Player ActiveX for IE $version is already installed."; $false = "Adobe Flash Player ActiveX for IE $version is not already installed."}[ $checking ]

$allRight = $true

if ([System.Environment]::OSVersion.Version -ge '6.2') {
  $allRight = $false
  Write-Output $packageName $('Your Windows version is not ' +
    'suitable for this package. This package is only for Windows XP to Windows 7')
}

if (Get-Process iexplore -ErrorAction SilentlyContinue) {
  $allRight = $false
  Write-Output $packageName 'Internet Explorer is running. ' +
    'The installation will fail an 1603 error. ' +
    'Close Internet Explorer and reinstall this package.'
}

if ( $checking ) {
  $allRight = $false
  Write-Output $alreadyInstalled
}

if ($allRight) {
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/31.0.0.108/install_flash_player_31_active_x.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Adobe Flash Player ActiveX'
  checksum      = '1e841338f0b7fc5e01b1e432a2730186e5ef42ae0c931f5f95b823eeadfcdcc1'
  checksumType  = 'sha256'
}
  Install-ChocolateyPackage @packageArgs
}
