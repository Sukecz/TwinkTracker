$ErrorActionPreference = 'Stop'

$deployScript = Join-Path $PSScriptRoot 'Deploy-WoW-Addons.ps1'

if (-not (Test-Path -LiteralPath $deployScript -PathType Leaf)) {
    Write-Error "Deploy script does not exist: $deployScript"
    exit 1
}

& $deployScript -NoPause
exit $LASTEXITCODE
