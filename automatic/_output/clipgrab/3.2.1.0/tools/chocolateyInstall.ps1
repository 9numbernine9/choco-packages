﻿$packageName = 'clipgrab'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://clipgrab.de/download/clipgrab-3.2.1.0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url