local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Data/Exploration.lua")
loadModule("Data/ExplorationOverlays.lua")
loadModule("ExplorationProgress.lua")

assert(#ns.ExplorationData.HORDE == 17)
assert(#ns.ExplorationData.ALLIANCE == 16)
assert(#ns.ExplorationCategories.order == 3)

local function findZone(faction, mapID)
    for _, zone in ipairs(ns.ExplorationData[faction]) do
        if zone.mapID == mapID then return zone end
    end
end

assert(findZone("HORDE",1433).group == "WORLD_PVP")
assert(findZone("ALLIANCE",1413).group == "WORLD_PVP")
assert(findZone("ALLIANCE",1442).group == "WORLD_PVP")
assert(findZone("HORDE",1435).group == "TRAVEL")
assert(findZone("HORDE",1434).group == "TRAVEL")
assert(findZone("ALLIANCE",1434).group == "TRAVEL")
assert(findZone("ALLIANCE",1433).group == "TRAVEL")

local expectedGroupCounts = {
    HORDE = { STARTING=5, WORLD_PVP=4, TRAVEL=8 },
    ALLIANCE = { STARTING=6, WORLD_PVP=6, TRAVEL=4 },
}

local routeMaps = {}
for _, faction in ipairs({"HORDE", "ALLIANCE"}) do
    local factionMaps = {}
    local groupCounts = { STARTING=0, WORLD_PVP=0, TRAVEL=0 }
    for _, zone in ipairs(ns.ExplorationData[faction]) do
        assert(ns.ExplorationCategories.labels[zone.group])
        groupCounts[zone.group] = groupCounts[zone.group] + 1
        assert(not factionMaps[zone.mapID])
        factionMaps[zone.mapID] = true
        routeMaps[zone.mapID] = true
        assert(type(ns.ExplorationOverlayData[zone.mapID]) == "table")
        assert(#ns.ExplorationOverlayData[zone.mapID] > 0)
    end
    for groupKey, expectedCount in pairs(expectedGroupCounts[faction]) do
        assert(groupCounts[groupKey] == expectedCount)
    end
end

local mapCount = 0
for mapID, signatures in pairs(ns.ExplorationOverlayData) do
    assert(routeMaps[mapID])
    local names = ns.ExplorationOverlayNames[mapID]
    assert(type(names) == "table")
    assert(#names == #signatures)
    local seen = {}
    for index, signature in ipairs(signatures) do
        assert(signature:match("^%d+:%d+:%d+:%d+$"))
        assert(not seen[signature])
        seen[signature] = true
        assert(type(names[index]) == "string" and names[index] ~= "")
    end
    mapCount = mapCount + 1
end
assert(mapCount == 20)
assert(#ns.ExplorationOverlayData[1434] == 27)

C_MapExplorationInfo = {
    GetExploredMapTextures = function(mapID)
        if mapID ~= 1411 then return {} end
        return {
            { textureWidth=128, textureHeight=110, offsetX=464, offsetY=33 },
            { textureWidth=160, textureHeight=120, offsetX=413, offsetY=476 },
            { textureWidth=160, textureHeight=120, offsetX=413, offsetY=476 },
            { textureWidth=999, textureHeight=999, offsetX=0, offsetY=0 },
        }
    end,
}

local progress = ns.ExplorationProgress:GetZoneProgress(1411)
assert(progress.available)
assert(progress.explored == 2)
assert(progress.total == 11)
assert(progress.percent == 18)
assert(not progress.complete)
assert(#progress.missing == 9)
assert(progress.missing[1] == "Sen'jin Village")
assert(progress.missing[9] == "Orgrimmar")

local empty = ns.ExplorationProgress:GetZoneProgress(1412)
assert(empty.available and empty.explored == 0 and empty.total == 14 and empty.percent == 0)
assert(ns.ExplorationProgress:GetZoneProgress(9999) == nil)

C_MapExplorationInfo.GetExploredMapTextures = function() return nil end
local neverRevealed = ns.ExplorationProgress:GetZoneProgress(1411)
assert(neverRevealed.available and neverRevealed.explored == 0 and neverRevealed.total == 11 and neverRevealed.percent == 0)

C_MapExplorationInfo.GetExploredMapTextures = function(mapID)
    local overlays = {}
    for _, signature in ipairs(ns.ExplorationOverlayData[mapID] or {}) do
        local width, height, offsetX, offsetY = signature:match("^(%d+):(%d+):(%d+):(%d+)$")
        overlays[#overlays+1] = {
            textureWidth=tonumber(width), textureHeight=tonumber(height),
            offsetX=tonumber(offsetX), offsetY=tonumber(offsetY),
        }
    end
    return overlays
end
local complete = ns.ExplorationProgress:GetZoneProgress(1411)
assert(complete.complete and complete.explored == 11 and complete.percent == 100)
assert(#complete.missing == 0)

C_MapExplorationInfo = nil
local unavailable = ns.ExplorationProgress:GetZoneProgress(1411)
assert(not unavailable.available and unavailable.total == 11)

print("test_exploration.lua: ok")
