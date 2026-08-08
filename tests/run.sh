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
grep -qx '## Version: 0.1.0' TwinkTracker.toc
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
grep -Fqx '## IconTexture: Interface\AddOns\TwinkTracker\assets\logo.tga' TwinkTracker.toc
grep -qx 'manual-changelog: CHANGELOG.md' .pkgmeta
grep -qx '  - CURSEFORGE_DESCRIPTION.md' .pkgmeta
grep -qx '  - assets/minimap-icon-source.png' .pkgmeta
test -f CURSEFORGE_DESCRIPTION.md
test -f .github/workflows/ci.yml
test -f .github/workflows/release.yml

echo "All TwinkTracker Lua 5.1 and TOC checks passed."
