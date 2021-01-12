import-module au

$releases = 'https://github.com/cyd01/KiTTY/releases/latest'
$padVersionUnder = '0.71.1'

function global:au_SearchReplace {
  @{ }
}

function downloadFile($url, $filename) {
  if ($filename.EndsWith("_nocompress.exe")) {
    $filename = $filename -replace "_nocompress\.exe$", ".exe"
  }

  $filePath = "$PSScriptRoot\tools\$filename"
  Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $filePath | Out-Null
  return Get-FileHash $filePath -Algorithm SHA256 | % Hash
}

function global:au_BeforeUpdate {
  $text = Get-Content -Encoding UTF8 -Path "$PSScriptRoot\VERIFICATION_Source.txt" -Raw
  $sb = New-Object System.Text.StringBuilder($text)

  $Latest.GetEnumerator() | ? { $_.Key.StartsWith("URL") } | % {
    $fileName = $_.Key.Substring(3)
    $checksum = downloadFile $_.Value $fileName
    $value = [string]::Format("| {0,-20} | {1} | {2,-79} |", $fileName, $checksum, $_.Value)
    $sb.AppendLine($value) | Out-Null
  }
  $value = "".PadLeft(171, '-')
  $sb.Append("|$value|") | Out-Null

  $sb.ToString() | Out-file -Encoding utf8 -FilePath "$PSScriptRoot\legal\VERIFICATION.txt"
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  [array]$uncompressedFiles = $download_page.Links | ? { $_.href -match "_nocompress\.exe" } | % href
  $allFiles = ($download_page.Links | ? { $_.href -match "\.exe$" -and $_.href -notmatch "nocompress|portable" } | ? {
      $name = (Split-Path -Leaf $_.href) -replace "\.exe$", "_nocompress.exe"
      !($uncompressedFiles | ? { $_.EndsWith($name) })
    } | % href) + $uncompressedFiles

  #$allFiles = $download_page.Links | ? { $_.href -match "\.exe$" -and $_.href -NotMatch "nocompress|portable" } | % href

  $version = ($allFiles | select -First 1) -split "\/v?" | select -Last 1 -Skip 1

  $result = @{
    Version = Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder
  }

  $allFiles | % {
    $fileName = $_ -split "\/" | select -Last 1
    $result["URL" + $fileName] = New-Object uri([uri]$releases, $_)
  }

  return $result
}

update -ChecksumFor none
