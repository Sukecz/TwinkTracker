[CmdletBinding()]
param(
    [string]$Server = "minipc",
    [string]$ProjectsRoot = "/home/msminipc/projects",
    [string]$WowAddOnsPath = "C:\Games\World of Warcraft\_classic_era_\Interface\AddOns",
    [switch]$NoPause
)

$ErrorActionPreference = "Stop"
$stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("wow-addons-deploy-" + [guid]::NewGuid().ToString("N"))
$exitCode = 0
$versions = @{}

$addons = @(
    [pscustomobject]@{ DisplayName="Simple Scrolling Loot"; ProjectDirectory="ssl"; AddonName="SimpleScrollingLoot"; PrimaryToc="SimpleScrollingLoot.toc"; Directories=@("Locales","assets"); RequiredFiles=@("SimpleScrollingLoot.toc","SimpleScrollingLoot_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\ssl.png") },
    [pscustomobject]@{ DisplayName="Better Loot Rolls"; ProjectDirectory="blr"; AddonName="BetterLootRolls"; PrimaryToc="BetterLootRolls.toc"; Directories=@("Locales","assets"); RequiredFiles=@("BetterLootRolls.toc","BetterLootRolls_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\logo.png") },
    [pscustomobject]@{ DisplayName="Simple Arsenal Swap"; ProjectDirectory="sas"; AddonName="SimpleArsenalSwap"; PrimaryToc="SimpleArsenalSwap.toc"; Directories=@("Locales","assets"); RequiredFiles=@("SimpleArsenalSwap.toc","SimpleArsenalSwap_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\logo.png") },
    [pscustomobject]@{ DisplayName="TwinkTracker"; ProjectDirectory="twinktracker"; AddonName="TwinkTracker"; PrimaryToc="TwinkTracker.toc"; Directories=@("Locales","Data","assets"); RequiredFiles=@("TwinkTracker.toc","Core.lua","MainWindow.lua","XPTracker.lua","Locales\enUS.lua","Data\Bis.lua","assets\logo.png") }
)

function Invoke-NativeCommand {
    param([string]$Executable, [string[]]$Arguments, [string]$FailureMessage)
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$FailureMessage (exit code $LASTEXITCODE)" }
}

try {
    $ssh = (Get-Command "ssh.exe" -ErrorAction Stop).Source
    $scp = (Get-Command "scp.exe" -ErrorAction Stop).Source
    $robocopy = (Get-Command "robocopy.exe" -ErrorAction Stop).Source
    if (-not (Test-Path -LiteralPath $WowAddOnsPath -PathType Container)) { throw "WoW AddOns folder does not exist: $WowAddOnsPath" }

    Write-Host "1/3 Testing all addons on MINIPC..." -ForegroundColor Cyan
    foreach ($addon in $addons) {
        $project = "$ProjectsRoot/$($addon.ProjectDirectory)"
        Write-Host "  Testing $($addon.DisplayName)..." -ForegroundColor DarkCyan
        Invoke-NativeCommand $ssh @($Server, "cd '$project' && bash tests/run.sh") "$($addon.DisplayName) tests failed. Nothing was copied."
    }

    Write-Host "2/3 Downloading and validating runtime files..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $stageRoot -Force | Out-Null
    foreach ($addon in $addons) {
        $project = "$ProjectsRoot/$($addon.ProjectDirectory)"
        $stageAddon = Join-Path $stageRoot $addon.AddonName
        New-Item -ItemType Directory -Path $stageAddon -Force | Out-Null
        Invoke-NativeCommand $scp @("$Server`:$project/*.lua", "$Server`:$project/*.toc", $stageAddon) "Could not download $($addon.DisplayName) Lua or TOC files."
        foreach ($directory in $addon.Directories) {
            Invoke-NativeCommand $scp @("-r", "$Server`:$project/$directory", $stageAddon) "Could not download $directory for $($addon.DisplayName)."
        }
        foreach ($relativePath in $addon.RequiredFiles) {
            if (-not (Test-Path -LiteralPath (Join-Path $stageAddon $relativePath) -PathType Leaf)) { throw "$($addon.DisplayName) download is incomplete. Missing: $relativePath" }
        }
        $toc = Get-Content -LiteralPath (Join-Path $stageAddon $addon.PrimaryToc) -Raw
        $match = [regex]::Match($toc, '(?m)^## Version:[ \t]*(.+?)[ \t]*$')
        if (-not $match.Success) { throw "$($addon.DisplayName) TOC does not contain a readable version." }
        $versions[$addon.AddonName] = $match.Groups[1].Value.Trim()
    }

    Write-Host "3/3 Synchronizing all addon folders..." -ForegroundColor Cyan
    foreach ($addon in $addons) {
        $source = Join-Path $stageRoot $addon.AddonName
        $destination = Join-Path $WowAddOnsPath $addon.AddonName
        New-Item -ItemType Directory -Path $destination -Force | Out-Null
        Write-Host "  Updating $($addon.DisplayName) $($versions[$addon.AddonName])..." -ForegroundColor DarkCyan
        & $robocopy $source $destination /MIR /R:2 /W:1 /NFL /NDL /NJH /NJS /NP
        if ($LASTEXITCODE -ge 8) { throw "Robocopy failed while updating $destination (exit code $LASTEXITCODE)" }
    }
    Write-Host "All four addons are up to date. Enter /reload in WoW." -ForegroundColor Green
}
catch { $exitCode = 1; Write-Host ""; Write-Host "Deployment failed: $($_.Exception.Message)" -ForegroundColor Red }
finally { if (Test-Path -LiteralPath $stageRoot) { Remove-Item -LiteralPath $stageRoot -Recurse -Force } }
if (-not $NoPause -and $exitCode -ne 0) { Write-Host ""; Read-Host "Deployment failed. Press Enter to close" }
exit $exitCode
