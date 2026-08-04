local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Data/Checklist.lua")
loadModule("Data/Bis.lua")
loadModule("Data/Consumables.lua")

assert(#ns.ChecklistData >= 8)
assert(#ns.BisData.classOrder == 9)
assert(#ns.ConsumablesData >= 5)
for _, classToken in ipairs(ns.BisData.classOrder) do
    local profile = assert(ns.BisData.classes[classToken])
    assert(type(profile.name) == "string")
    for _, tier in ipairs({ "S", "A", "B" }) do
        assert(type(profile.tiers[tier]) == "table")
        assert(#profile.tiers[tier] >= 3)
        for _, item in ipairs(profile.tiers[tier]) do
            assert(type(item.id) == "number" and item.id > 0)
            assert(type(item.name) == "string" and item.name ~= "")
            assert(type(item.slot) == "string" and item.slot ~= "")
        end
    end
end

print("test_data.lua: ok")
