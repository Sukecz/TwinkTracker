[CmdletBinding()]
param(
    [string]$Server = "minipc",
    [string]$ProjectsRoot = "/home/msminipc/projects",
    [string]$WowAddOnsPath = "C:\Games\World of Warcraft\_classic_era_\Interface\AddOns",
    [switch]$NoPause
)

$ErrorActionPreference = "Stop"
$deploymentId = [guid]::NewGuid().ToString("N")
$stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("wow-addons-deploy-" + $deploymentId)
$archiveName = "wow-addons-deploy-$deploymentId.tar.gz"
$localArchive = Join-Path $stageRoot $archiveName
$remoteArchive = "/tmp/$archiveName"
$exitCode = 0
$versions = @{}
$ssh = $null

$addons = @(
    [pscustomobject]@{ DisplayName="Simple Scrolling Loot"; ProjectDirectory="ssl"; AddonName="SimpleScrollingLoot"; PrimaryToc="SimpleScrollingLoot.toc"; Directories=@("Locales","assets"); RequiredFiles=@("SimpleScrollingLoot.toc","SimpleScrollingLoot_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\ssl.png") },
    [pscustomobject]@{ DisplayName="Better Loot Rolls"; ProjectDirectory="blr"; AddonName="BetterLootRolls"; PrimaryToc="BetterLootRolls.toc"; Directories=@("Locales","assets"); RequiredFiles=@("BetterLootRolls.toc","BetterLootRolls_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\logo.png") },
    [pscustomobject]@{ DisplayName="Simple Arsenal Swap"; ProjectDirectory="sas"; AddonName="SimpleArsenalSwap"; PrimaryToc="SimpleArsenalSwap.toc"; Directories=@("Locales","assets"); RequiredFiles=@("SimpleArsenalSwap.toc","SimpleArsenalSwap_TBC.toc","Core.lua","Options.lua","Locales\enUS.lua","assets\logo.png") },
    [pscustomobject]@{ DisplayName="TwinkTracker"; ProjectDirectory="twinktracker"; AddonName="TwinkTracker"; PrimaryToc="TwinkTracker.toc"; Directories=@("Locales","Data","assets"); RequiredFiles=@("TwinkTracker.toc","Core.lua","MainWindow.lua","MinimapButton.lua","XPTracker.lua","EventTimers.lua","Locales\enUS.lua","Data\Bis.lua","Data\ClassTiers.lua","Data\PvPEvents.lua","Data\Events.lua","Data\Brackets.lua","Data\BracketRegistry.lua","Data\Bracket29\ClassTiers.lua","Data\Bracket29\Register.lua","Data\Bracket39\ClassTiers.lua","Data\Bracket39\Register.lua","assets\logo.png","assets\logo.tga","assets\minimap-icon.tga","assets\bracket-19.tga","assets\bracket-29.tga","assets\bracket-39.tga") }
)

function Invoke-NativeCommand {
    param([string]$Executable, [string[]]$Arguments, [string]$FailureMessage)
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$FailureMessage (exit code $LASTEXITCODE)" }
}

try {
    $ssh = (Get-Command "ssh.exe" -ErrorAction Stop).Source
    $scp = (Get-Command "scp.exe" -ErrorAction Stop).Source
    $tar = (Get-Command "tar.exe" -ErrorAction Stop).Source
    $robocopy = (Get-Command "robocopy.exe" -ErrorAction Stop).Source
    if (-not (Test-Path -LiteralPath $WowAddOnsPath -PathType Container)) { throw "WoW AddOns folder does not exist: $WowAddOnsPath" }

    Write-Host "1/3 Testing and preparing all addons on MINIPC..." -ForegroundColor Cyan
    $testCommands = @()
    $archiveArguments = @()
    foreach ($addon in $addons) {
        $project = "$ProjectsRoot/$($addon.ProjectDirectory)"
        $testCommands += "echo 'Testing $($addon.DisplayName)...' && (cd '$project' && bash tests/run.sh)"
        $archiveArguments += "--transform='s,^$($addon.ProjectDirectory)/,$($addon.AddonName)/,'"
        $archiveArguments += "$($addon.ProjectDirectory)/*.lua"
        $archiveArguments += "$($addon.ProjectDirectory)/*.toc"
        foreach ($directory in $addon.Directories) { $archiveArguments += "$($addon.ProjectDirectory)/$directory" }
    }
    $remoteCommand = ($testCommands -join " && ") + " && cd '$ProjectsRoot' && tar -czf '$remoteArchive' " + ($archiveArguments -join " ")
    Invoke-NativeCommand $ssh @($Server, $remoteCommand) "Addon tests or runtime bundle preparation failed. Nothing was copied."

    Write-Host "2/3 Downloading and validating one runtime bundle..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $stageRoot -Force | Out-Null
    Invoke-NativeCommand $scp @("$Server`:$remoteArchive", $localArchive) "Could not download the addon runtime bundle."
    Invoke-NativeCommand $tar @("-xzf", $localArchive, "-C", $stageRoot) "Could not extract the addon runtime bundle."
    Remove-Item -LiteralPath $localArchive -Force
    foreach ($addon in $addons) {
        $stageAddon = Join-Path $stageRoot $addon.AddonName
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
finally {
    if ($ssh) { & $ssh $Server "rm -f '$remoteArchive'" 2>$null | Out-Null }
    if (Test-Path -LiteralPath $stageRoot) { Remove-Item -LiteralPath $stageRoot -Recurse -Force }
}
if (-not $NoPause -and $exitCode -ne 0) { Write-Host ""; Read-Host "Deployment failed. Press Enter to close" }
exit $exitCode
