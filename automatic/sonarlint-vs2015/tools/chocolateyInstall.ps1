﻿$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$filePath = "$toolsPath\SonarLint.VSIX-4.35.0.32570-2015.vsix"

$vsixUrl =  "file://" + $filePath.Replace("\", "/")

$parameters = @{
    PackageName = "sonarlint-vs2015"
    VsixUrl = $vsixUrl
    VsVersion = 14 
}

Install-ChocolateyVsixPackage @parameters
