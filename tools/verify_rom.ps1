param(
  [Parameter(Mandatory=$true)][string]$RomPath
)
if (!(Test-Path $RomPath)) { Write-Error "Not found: $RomPath"; exit 1 }
$sha1 = (Get-FileHash $RomPath -Algorithm SHA1).Hash.ToLower()
$md5  = (Get-FileHash $RomPath -Algorithm MD5).Hash.ToLower()
Write-Host "SHA1: $sha1"
Write-Host "MD5 : $md5"
