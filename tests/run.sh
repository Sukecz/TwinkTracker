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
for bracket in 19 29 39; do
    test -f "assets/bracket-${bracket}-source.png"
    test -f "assets/bracket-${bracket}.tga"
    file "assets/bracket-${bracket}.tga" | grep -q '256 x 256 x 24'
done
file assets/logo.tga | grep -q '1024 x 512 x 32'
file assets/minimap-icon.tga | grep -q '256 x 256 x 32'
grep -q 'AddonName="TwinkTracker"' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'Data\Brackets.lua' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'assets\bracket-19.tga' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'one runtime bundle' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'tar -czf' tools/windows/Deploy-WoW-Addons.ps1
grep -Fq 'Interface\\AddOns\\TwinkTracker\\assets\\logo.tga' MainWindow.lua
grep -Fq 'for index,level in ipairs(ns.Brackets.order) do self:CreateBracketButton(root,level,index) end' MainWindow.lua
grep -Fq 'assets\\bracket-"..level..".tga' MainWindow.lua
grep -Fq 'value.icon:SetDesaturated(not value.available)' MainWindow.lua
grep -Fq 'GameTooltip:AddLine("Coming soon"' MainWindow.lua
grep -Fq 'selectedBracket = 19' Defaults.lua
grep -Fq '[29] = { level = 29, available = false }' Data/Brackets.lua
grep -Fq '[39] = { level = 39, available = false }' Data/Brackets.lua
grep -Fq 'Interface\\AddOns\\TwinkTracker\\assets\\minimap-icon.tga' MinimapButton.lua
grep -Fq 'showMinimapIcon = true' Defaults.lua
grep -Fq '"Show minimap icon"' MainWindow.lua
grep -Fq 'ns.MinimapButton:SetShown(shown)' MainWindow.lua
grep -Fq 'settings:SetSize(16,16)' MainWindow.lua
grep -Fq 'Interface\\Buttons\\UI-OptionsButton' MainWindow.lua
grep -Fq 'cell.alternative.state:SetColorTexture' MainWindow.lua
grep -Fq 'cell.thirdAlternative.state:SetColorTexture' MainWindow.lua
grep -Fq 'MULTI_ROW_HEIGHT+(choiceCount-2)*46' MainWindow.lua
grep -Fq 'value:SetSize(42,42)' MainWindow.lua
grep -Fq 'value:SetPoint("TOP",parent,"TOP",(index-5)*64,-7)' MainWindow.lua
grep -Fq 'classes:SetPoint("TOPRIGHT")' MainWindow.lua
grep -Fq 'gear:SetPoint("TOPLEFT",classes,"BOTTOMLEFT",0,-8)' MainWindow.lua
grep -Fq 'root:SetResizeBounds(880,620,1500,950)' MainWindow.lua
grep -Fq 'root:SetMinResize(880,620)' MainWindow.lua
grep -Fq '"GEAR","GEAR","TOPLEFT",16,88' MainWindow.lua
grep -Fq '"BASICS","TWINK BASICS","TOPLEFT",112,88' MainWindow.lua
grep -Fq '"GUIDES","GUIDES","TOPLEFT",208,88' MainWindow.lua
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
grep -Fq 'HandleModifiedItemClick(itemLink)' MainWindow.lua
grep -Fq 'elseif ChatEdit_InsertLink then' MainWindow.lua
grep -Fq 'assets\\twinkortreat.tga' MainWindow.lua
test -s assets/twinkortreat.tga
grep -Fq '"TWINK FACTORY"' MainWindow.lua
grep -Fq 'Whisper Sparre for an invite.' MainWindow.lua
grep -Fqx '## IconTexture: Interface\AddOns\TwinkTracker\assets\addon-icon.tga' TwinkTracker.toc
file assets/addon-icon.tga | grep -q '256 x 256 x 32'
grep -qx 'manual-changelog: CHANGELOG.md' .pkgmeta
grep -qx '  - CURSEFORGE_DESCRIPTION.md' .pkgmeta
grep -qx '  - assets/minimap-icon-source.png' .pkgmeta
test -f CURSEFORGE_DESCRIPTION.md
test -f .github/workflows/ci.yml
test -f .github/workflows/release.yml

echo "All TwinkTracker Lua 5.1 and TOC checks passed."
