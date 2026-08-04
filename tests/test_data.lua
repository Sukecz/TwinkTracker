local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Data/Checklist.lua")
loadModule("Data/Bis.lua")
loadModule("Data/Consumables.lua")
loadModule("Data/Guide.lua")

assert(#ns.ChecklistData >= 8)
assert(#ns.BisData.classOrder == 9)
assert(#ns.ConsumablesData >= 5)
assert(#ns.GuideData == 8)
local alternativeCount = 0
for _, classToken in ipairs(ns.BisData.classOrder) do
    local profile = assert(ns.BisData.classes[classToken])
    assert(type(profile.name) == "string")
    assert(#profile.slotOrder >= 13)
    local hasOneHand = false
    local hasTwoHand = false
    for _, slot in ipairs(profile.slotOrder) do
        assert(slot ~= "WEAPON", classToken .. " still uses the combined weapon slot")
        if slot == "ONE_HAND" then hasOneHand = true end
        if slot == "TWO_HAND" then hasTwoHand = true end
        assert(type(profile.slots[slot]) == "table", classToken .. " missing slot " .. slot)
        for _, tier in ipairs({ "S", "A", "B" }) do
            local choices = profile.slots[slot][tier]
            assert(type(choices) == "table" and #choices >= 1 and #choices <= 2, classToken .. " " .. slot .. " invalid tier " .. tier)
            alternativeCount = alternativeCount + #choices - 1
            for _, item in ipairs(choices) do
                assert(type(item) == "table", classToken .. " " .. slot .. " missing tier " .. tier)
                if item.id ~= nil then
                    assert(type(item.id) == "number" and item.id > 0)
                end
                assert(type(item.name) == "string" and item.name ~= "")
                assert(item.faction == nil or item.faction == "ALLIANCE" or item.faction == "HORDE")
            end
        end
    end
    assert(hasOneHand, classToken .. " missing 1H weapon tiers")
    assert(hasTwoHand == (classToken ~= "ROGUE"), classToken .. " has incorrect 2H weapon support")
end

assert(ns.BisData.classes.DRUID.slots.NECK.S[1].faction == "ALLIANCE")
assert(ns.BisData.classes.DRUID.slots.NECK.A[1].faction == "HORDE")
assert(ns.BisData.classes.WARRIOR.slots.WRISTS.A[1].faction == "HORDE")
assert(ns.BisData.classes.WARRIOR.slots.WRISTS.B[1].faction == "ALLIANCE")
assert(ns.BisData.classes.WARRIOR.slots.RANGED.S[2].id == 6469)
assert(ns.BisData.classes.MAGE.slots.OFF_HAND.A[1].id == 5183)
assert(ns.BisData.classes.MAGE.slots.OFF_HAND.B[1].id == 2879)
assert(ns.BisData.classes.MAGE.slots.RANGED.A[1].id == 12984)
assert(alternativeCount >= 30)

print("test_data.lua: ok")
