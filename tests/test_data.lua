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
local linkedItemCount = 0
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
                    assert(item.wowhead == ns.BisData.wowheadClassicItemURL .. item.id, classToken .. " " .. slot .. " missing Wowhead link for " .. item.name)
                    linkedItemCount = linkedItemCount + 1
                else
                    assert(item.wowhead == nil, classToken .. " " .. slot .. " placeholder has a Wowhead link")
                end
                assert(type(item.name) == "string" and item.name ~= "")
                assert(item.faction == nil or item.faction == "ALLIANCE" or item.faction == "HORDE")
            end
        end
    end
    assert(hasOneHand, classToken .. " missing 1H weapon tiers")
    assert(hasTwoHand == (classToken ~= "ROGUE"), classToken .. " has incorrect 2H weapon support")
end

local expectedInsignias = {
    DRUID = { 18853, 18863 },
    HUNTER = { 18846, 18856 },
    MAGE = { 18850, 18859 },
    PALADIN = { 18864 },
    PRIEST = { 18851, 18862 },
    ROGUE = { 18849, 18857 },
    SHAMAN = { 18845 },
    WARLOCK = { 18852, 18858 },
    WARRIOR = { 18834, 18854 },
}

for classToken, expectedIDs in pairs(expectedInsignias) do
    local profile = ns.BisData.classes[classToken]
    for _, location in ipairs({ { "TRINKET_1", "A" }, { "TRINKET_2", "S" } }) do
        local choices = profile.slots[location[1]][location[2]]
        assert(#choices == #expectedIDs, classToken .. " insignia faction variants are split across tiers")
        for index, expectedID in ipairs(expectedIDs) do
            assert(choices[index].id == expectedID, classToken .. " has an incorrect class insignia")
        end
    end
end

assert(ns.BisData.classes.WARRIOR.slots.NECK.S[1].id == 20444)
assert(ns.BisData.classes.WARRIOR.slots.NECK.S[2].id == 20442)
assert(ns.BisData.classes.WARRIOR.slots.WRISTS.S[1].id == 7003)
assert(ns.BisData.classes.WARRIOR.slots.WRISTS.S[2].id == 4534)
assert(ns.BisData.classes.WARRIOR.slots.FINGER_1.S[1].id == 20439)
assert(ns.BisData.classes.WARRIOR.slots.FINGER_1.S[2].id == 20429)
assert(ns.BisData.classes.WARRIOR.slots.TWO_HAND.S[1].id == 5815)
assert(ns.BisData.classes.WARRIOR.slots.TWO_HAND.S[2].id == 3822)
assert(ns.BisData.classes.WARRIOR.slots.TWO_HAND.S[2].faction == "HORDE")
assert(ns.BisData.classes.WARRIOR.slots.TWO_HAND.A[1].id == 7230)
assert(ns.BisData.classes.WARRIOR.slots.RANGED.S[1].id == 20437)
assert(ns.BisData.classes.WARRIOR.slots.RANGED.S[2].id == 20438)
assert(ns.BisData.classes.WARRIOR.slots.RANGED.A[1].id == 6469)

local function profileHasItem(classToken, itemID)
    local profile = ns.BisData.classes[classToken]
    for _, slot in ipairs(profile.slotOrder) do
        for _, tier in ipairs({ "S", "A", "B" }) do
            for _, entry in ipairs(profile.slots[slot][tier]) do
                if entry.id == itemID then return true end
            end
        end
    end
    return false
end

assert(not profileHasItem("HUNTER", 2825), "Hunter contains a required-level 37 bow")
assert(not profileHasItem("HUNTER", 3021), "Hunter contains a required-level 20 bow")
assert(not profileHasItem("MAGE", 6460), "Mage contains a leather waist")
assert(not profileHasItem("MAGE", 6468), "Mage contains a leather waist")
assert(not profileHasItem("PRIEST", 6468), "Priest contains a leather waist")
assert(not profileHasItem("DRUID", 2567), "Druid contains an unusable dagger")
assert(not profileHasItem("DRUID", 3184), "Druid contains an unusable dagger")
assert(not profileHasItem("PALADIN", 6414), "Paladin contains a Horde quest ring")
assert(not profileHasItem("PALADIN", 3761), "Paladin contains a Horde quest shield")
assert(not profileHasItem("PALADIN", 3822), "Paladin contains a Horde quest two-hand")
assert(not profileHasItem("SHAMAN", 2933), "Shaman contains an Alliance quest ring")
assert(not profileHasItem("SHAMAN", 20444), "Shaman contains an Alliance WSG neck")
assert(not profileHasItem("SHAMAN", 5815), "Level-19 Shaman contains a two-hand mace")
assert(not profileHasItem("SHAMAN", 1318), "Level-19 Shaman contains a two-hand axe")
assert(ns.BisData.classes.WARRIOR.slots.OFF_HAND.S[2].id == 7002)
assert(ns.BisData.classes.WARRIOR.slots.OFF_HAND.S[2].faction == nil, "Arctic Buckler is not faction restricted")
for _, invalidItemID in ipairs({ 6630, 9772, 9799, 15336, 15337 }) do
    for _, classToken in ipairs(ns.BisData.classOrder) do
        assert(not profileHasItem(classToken, invalidItemID), classToken .. " contains an item requiring level 20 or higher")
    end
end
assert(ns.BisData.classes.MAGE.slots.OFF_HAND.S[2].id == 5183)
assert(ns.BisData.classes.MAGE.slots.OFF_HAND.A[1].id == 2879)
assert(ns.BisData.classes.MAGE.slots.RANGED.A[1].id == 12984)
assert(alternativeCount >= 30)
assert(linkedItemCount > 0)

print("test_data.lua: ok")
