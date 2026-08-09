#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

lua_bin="${LUA_BIN:-lua}"
luac_bin="${LUAC_BIN:-luac}"

mapfile -t lua_files < <(find . -type f -name '*.lua' -not -path './.git/*' -print | sort)
for file in "${lua_files[@]}"; do
    "$luac_bin" -p "$file"
done

for test_file in tests/test_*.lua; do
    "$lua_bin" "$test_file"
done

toc_files="$(sed -n '/^[^#[:space:]].*\.lua$/p' TwinkTracker.toc)"
while IFS= read -r toc_file; do
    source_file="${toc_file//\\//}"
    if [[ ! -f "$source_file" ]]; then
        echo "TOC references missing file: $source_file" >&2
        exit 1
    fi
done <<< "$toc_files"

grep -qx '## Interface: 11509' TwinkTracker.toc
grep -Eq '^## Version: [0-9]+\.[0-9]+\.[0-9]+$' TwinkTracker.toc
grep -qx '## X-Curse-Project-ID: 1644210' TwinkTracker.toc
grep -qx '## SavedVariablesPerCharacter: TwinkTrackerDB' TwinkTracker.toc
grep -qx '## X-Flavor: Vanilla' TwinkTracker.toc
grep -qx '## AllowLoadGameType: vanilla' TwinkTracker.toc
test -f tools/windows/Deploy-WoW-Addons.cmd
test -f tools/windows/Deploy-WoW-Addons.ps1
test -f assets/logo.png
test -f assets/logo.tga
test -f assets/minimap-icon-source.png
test -f assets/minimap-icon.tga
file assets/logo.tga | grep -q '1024 x 512 x 32'
file assets/minimap-icon.tga | grep -q '256 x 256 x 32'
grep -q 'AddonName="TwinkTracker"' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'Interface\\AddOns\\TwinkTracker\\assets\\logo.tga' MainWindow.lua
grep -Fq 'Interface\\AddOns\\TwinkTracker\\assets\\minimap-icon.tga' MinimapButton.lua
grep -Fq 'cell.alternative.state:SetColorTexture' MainWindow.lua
grep -Fq '"EXPLORATION","EXPLORATION","TOPRIGHT"' MainWindow.lua
grep -Fq '"H  HORDE ROUTES"' MainWindow.lua
grep -Fq '"A  ALLIANCE ROUTES"' MainWindow.lua
grep -Fq '"|cff5ca9ffA|r  ALLIANCE"' Data/Guides.lua
grep -Fq '"|cffff505cH|r  HORDE"' Data/Guides.lua
grep -Fq 'STARTING = "STARTING & CORE ZONES"' Data/Exploration.lua
grep -Fq 'WORLD_PVP = "WORLD PVP TARGETS"' Data/Exploration.lua
grep -Fq 'TRAVEL = "TRAVEL & TWINK EVENTS"' Data/Exploration.lua
grep -Fq 'CreateFrame("StatusBar",nil,row)' MainWindow.lua
grep -Fq 'getExplorationProgressColor(state.percent,true)' MainWindow.lua
grep -Fq 'string.format("0/%d  ·  0%%",total)' MainWindow.lua
grep -Fq 'string.format("0/%d  ·  0%%",initialTotal)' MainWindow.lua
if grep -Fq 'EXPLORATION_GROUP_COLORS' MainWindow.lua; then
    echo "Exploration categories still use separate semantic colors" >&2
    exit 1
fi
grep -Fq 'ns.ExplorationCategories.labels[groupKey],C.secondary' MainWindow.lua
if grep -Eq 'local (marker|stripe|line)=.*Exploration|EXPLORATION_SECTION_COLOR' MainWindow.lua; then
    echo "Exploration category headings still contain decorative color accents" >&2
    exit 1
fi
grep -Fq 'ns.ExplorationProgress:GetZoneProgress(row.zone.mapID)' MainWindow.lua
grep -Fq 'eventFrame:RegisterEvent("MAP_EXPLORATION_UPDATED")' Core.lua
if grep -Fq '"exploration:"..self.faction..":"..self.zone.mapID' MainWindow.lua; then
    echo "Exploration still contains a manual checklist key" >&2
    exit 1
fi
grep -Fq 'XP CANNOT BE LOCKED' Data/Basics.lua
grep -Fq '"GEAR","GEAR"' MainWindow.lua
grep -Fq '"ENCHANTS","ENCHANTS"' MainWindow.lua
grep -Fq '"CONSUMABLES","CONSUMABLES"' MainWindow.lua
grep -Fq 'section.key=="CONSUMABLES"' MainWindow.lua
grep -Fq 'GetItemInfoInstant(itemID)' MainWindow.lua
grep -Fq 'assets\\twinkortreat.tga' MainWindow.lua
test -s assets/twinkortreat.tga
grep -Fq '"TWINK FACTORY"' MainWindow.lua
grep -Fq 'Whisper Sparre for an invite.' MainWindow.lua
grep -Fqx '## IconTexture: Interface\AddOns\TwinkTracker\assets\logo.tga' TwinkTracker.toc
grep -qx 'manual-changelog: CHANGELOG.md' .pkgmeta
grep -qx '  - CURSEFORGE_DESCRIPTION.md' .pkgmeta
grep -qx '  - assets/minimap-icon-source.png' .pkgmeta
test -f CURSEFORGE_DESCRIPTION.md
test -f .github/workflows/ci.yml
test -f .github/workflows/release.yml

echo "All TwinkTracker Lua 5.1 and TOC checks passed."
