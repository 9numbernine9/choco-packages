﻿$packageName = 'prey'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://s3.amazonaws.com/prey-releases/bash-client/0.6.2/prey-0.6.2-win.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url