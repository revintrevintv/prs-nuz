param(
  [string]$RomPath = "C:\Users\User\Documents\PokemonRSNuz\base_patched.gba",
  [string]$Armips = "armips.exe"
)
$ErrorActionPreference = "Stop"

$config = Get-Content "$PSScriptRoot\..\config\target.json" | ConvertFrom-Json
if (!(Test-Path $RomPath)) { throw "ROM not found: $RomPath" }
$sha1 = (Get-FileHash $RomPath -Algorithm SHA1).Hash.ToLower()
if ($sha1 -ne $config.sha1.ToLower()) { throw "SHA1 mismatch. Expected $($config.sha1), got $sha1" }

$root = Resolve-Path "$PSScriptRoot\.."
$dist = Join-Path $root "dist"
New-Item -ItemType Directory -Force -Path $dist | Out-Null
Copy-Item $RomPath (Join-Path $dist "base.gba") -Force

$asm = Join-Path $root "patch\patch.asm"
& $Armips $asm /root $root

Write-Host "Built: $dist\base+prs-nuz.gba"
