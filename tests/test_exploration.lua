local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Data/Exploration.lua")

assert(#ns.ExplorationData.HORDE == 16)
assert(#ns.ExplorationData.ALLIANCE == 15)
assert(ns.ExplorationData.HORDE[9].name == "Redridge Mountains")
assert(ns.ExplorationData.HORDE[11].name == "Swamp of Sorrows")

print("test_exploration.lua: ok")
