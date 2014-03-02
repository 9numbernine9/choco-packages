﻿try {

    $packageName = 'ontopreplica'
    $silentArgs = '/S'
    $uninstaller = Join-Path $env:LOCALAPPDATA 'OnTopReplica\OnTopReplica-Uninstall.exe'

    Start-Process $uninstaller -ArgumentList $silentArgs -Wait
    Write-Output "$packageName uninstalled successfully."

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}