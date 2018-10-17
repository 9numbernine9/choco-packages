﻿import-module au

$releases = 'http://www.partition-tool.com/easeus-partition-manager/history.htm'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  if ($download_page.Content -match 'EaseUS Partition Master Free ([0-9\.]+)') {
    $version = $matches[1]
  }
  $url = "http://download.easeus.com/free/epm.exe"

  @{
    Version = $version
    URL32   = $url
  }
}

update -ChecksumFor 32
