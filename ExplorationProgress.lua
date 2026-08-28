local addonName, ns = ...

local ExplorationProgress = {}
ns.ExplorationProgress = ExplorationProgress

local expectedLookups = {}

local function getExpectedLookup(mapID, signatures)
    if expectedLookups[mapID] then
        return expectedLookups[mapID]
    end

    local lookup = {}
    for index, signature in ipairs(signatures) do
        lookup[signature] = index
    end
    expectedLookups[mapID] = lookup
    return lookup
end

local function getSignature(info)
    if type(info) ~= "table" or type(info.textureWidth) ~= "number" or type(info.textureHeight) ~= "number" or type(info.offsetX) ~= "number" or type(info.offsetY) ~= "number" then
        return nil
    end

    return string.format("%d:%d:%d:%d", info.textureWidth, info.textureHeight, info.offsetX, info.offsetY)
end

function ExplorationProgress:GetZoneProgress(mapID)
    local expected = ns.ExplorationOverlayData[mapID]
    if not expected then
        return nil
    end

    local total = #expected
    if not C_MapExplorationInfo or not C_MapExplorationInfo.GetExploredMapTextures then
        return { explored=0, total=total, percent=0, available=false, complete=false }
    end

    local ok, overlays = pcall(C_MapExplorationInfo.GetExploredMapTextures, mapID)
    if not ok then
        return { explored=0, total=total, percent=0, available=false, complete=false }
    end
    if overlays == nil then overlays = {} end
    if type(overlays) ~= "table" then
        return { explored=0, total=total, percent=0, available=false, complete=false }
    end

    local expectedLookup = getExpectedLookup(mapID, expected)
    local seen = {}
    local explored = 0
    for _, info in ipairs(overlays) do
        local signature = getSignature(info)
        if signature and expectedLookup[signature] and not seen[signature] then
            seen[signature] = true
            explored = explored + 1
        end
    end

    local names = ns.ExplorationOverlayNames[mapID] or {}
    local missing = {}
    for index, signature in ipairs(expected) do
        if not seen[signature] then
            missing[#missing+1] = names[index] or "Unknown map area"
        end
    end

    local percent = total > 0 and math.floor((explored * 100 / total) + 0.5) or 0
    return {
        explored=explored,
        total=total,
        percent=percent,
        missing=missing,
        available=true,
        complete=total > 0 and explored == total,
    }
end
