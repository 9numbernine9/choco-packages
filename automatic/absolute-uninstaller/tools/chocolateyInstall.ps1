﻿$ErrorActionPreference = 'STOP'

$packageArgs = @{
  packageName    = 'absolute-uninstaller'
  url            = 'https://download.glarysoft.com/ausetup.exe'
  fileType       = 'exe'
  softwareName   = 'Absolute Uninstaller*'
  checksum       = 'ff5080b22d51c9842254edfaef369843f5b72f707d740ba6cbffc59b14020aa7'
  checksumType   = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs

# Remove MaiaGames
Remove-Item -Force -ea 0 "$Env:Public/Desktop/Maiagames.lnk"
Remove-Item -Force -Recurse -ea 0 "$Env:ProgramData/GlarySoft/Maiagames"
