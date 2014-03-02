﻿$packageName = 'avidemux'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/avidemux/files/avidemux/2.6.6/avidemux_2.6.6_win32.exe/download'
$url64bit = 'http://sourceforge.net/projects/avidemux/files/avidemux/2.6.6/avidemux_2.6.6_win64.exe/download'
$validExitCodes = @(0,1223)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit -validExitCodes $validExitCodes