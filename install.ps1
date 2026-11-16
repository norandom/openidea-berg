# Install the Berg theme plugin into OpenIDEA (Windows).
# Usage: .\install.ps1            (override the target with $env:OPENIDEA_DATA_DIR)
$ErrorActionPreference = 'Stop'

$id = 'theme-berg'
$src = $PSScriptRoot
$data = if ($env:OPENIDEA_DATA_DIR) { $env:OPENIDEA_DATA_DIR } else { Join-Path $env:APPDATA 'ai.l0ng.openidea' }

$plugins = Join-Path $data 'plugins'
$target = Join-Path $plugins $id
$staging = Join-Path $plugins ".install-$id"

New-Item -ItemType Directory -Force -Path $plugins | Out-Null
if (Test-Path $staging) { Remove-Item -Recurse -Force $staging }
New-Item -ItemType Directory -Force -Path (Join-Path $staging 'themes') | Out-Null
Copy-Item (Join-Path $src 'plugin.toml'), (Join-Path $src 'LICENSE') $staging
Copy-Item (Join-Path $src 'themes\berg.theme.json'), (Join-Path $src 'themes\berg.scheme.json') (Join-Path $staging 'themes')
if (Test-Path $target) { Remove-Item -Recurse -Force $target }
Move-Item $staging $target

Write-Host "Installed Berg into $target"
Write-Host "Restart OpenIDEA, then press Apply next to 'Berg Theme' in Settings > Plugins."
