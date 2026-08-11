local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/Basics.lua", "Data/Bis.lua", "Data/Enchants.lua",
    "Data/Consumables.lua", "Data/Guides.lua", "Data/ClassTiers.lua", "Data/PvPEvents.lua", "Data/Exploration.lua",
    "Data/BracketRegistry.lua", "Data/Bracket29/Bis.lua", "Data/Bracket29/Enchants.lua",
    "Data/Bracket29/Consumables.lua", "Data/Bracket29/Basics.lua",
    "Data/Bracket29/Guides.lua", "Data/Bracket29/ClassTiers.lua", "Data/Bracket29/Exploration.lua",
    "Data/Bracket29/Register.lua",
}) do
    loadModule(path)
end

local data = assert(ns.Brackets:GetData(29))
assert(ns.Brackets.profiles[29].available)
assert(data.level == 29)
assert(#data.bis.classOrder == 9)
assert(#data.basics == 7)
assert(#data.guides.order == 3)
assert(#data.classTiers.classOrder == 9)
assert(data.pvp.level == 29 and data.pvp.contact.character == "Lovepotion")
assert(#data.exploration.HORDE == 17 and #data.exploration.ALLIANCE == 16)

local forbiddenGear = { [9459]=true, [9461]=true, [10542]=true, [10545]=true, [34227]=true }
local rowCounts = {}
local uniqueIDs = {}
for _, classToken in ipairs(data.bis.classOrder) do
    local profile = assert(data.bis.classes[classToken])
    rowCounts[classToken] = 0
    uniqueIDs[classToken] = {}
    local hasOneHand, hasTwoHand = false, false
    for _, slot in ipairs(profile.slotOrder) do
        if slot == "ONE_HAND" then hasOneHand = true end
        if slot == "TWO_HAND" then hasTwoHand = true end
        local slotData = assert(profile.slots[slot], classToken .. " missing " .. slot)
        for _, tier in ipairs({ "S", "A", "B" }) do
            local choices = assert(slotData[tier], classToken .. " " .. slot .. " missing " .. tier)
            assert(#choices >= 1 and #choices <= 3, classToken .. " " .. slot .. " " .. tier .. " exceeds the tier limit")
            for _, entry in ipairs(choices) do
                assert(type(entry.name) == "string" and entry.name ~= "")
                if entry.id then
                    assert(entry.id > 0 and not forbiddenGear[entry.id], classToken .. " includes forbidden gear " .. entry.id)
                    assert(entry.wowhead == data.bis.wowheadClassicItemURL .. entry.id)
                    rowCounts[classToken] = rowCounts[classToken] + 1
                    uniqueIDs[classToken][entry.id] = true
                else
                    assert(entry.wowhead == nil)
                end
                if string.find(entry.note or "", "level-28 WSG", 1, true) or string.find(entry.note or "", "level-28 AB", 1, true) or string.find(entry.note or "", "PvP trinket", 1, true) then
                    assert(string.find(entry.note, "Era", 1, true), classToken .. " has an unscoped battleground reward: " .. entry.name)
                end
            end
        end
    end
    assert(hasOneHand)
    assert(hasTwoHand == (classToken ~= "ROGUE"))

    local enchantProfile = assert(data.enchants.classes[classToken])
    for _, slot in ipairs(enchantProfile.slotOrder) do
        assert(#enchantProfile.slots[slot] >= 1 and #enchantProfile.slots[slot] <= 4)
        for _, recommendation in ipairs(enchantProfile.slots[slot]) do
            assert(data.enchants.catalog[recommendation.key], classToken .. " references unknown enchant " .. recommendation.key)
        end
    end

    local consumableProfile = assert(data.consumables.classes[classToken])
    assert(consumableProfile.categories.BANDAGES[1].itemID == 14530)
    assert(consumableProfile.categories.BANDAGES[2].itemID == 14529)
    assert(consumableProfile.categories.BANDAGES[3].itemID == 8545)
    for _, category in ipairs(consumableProfile.categoryOrder) do
        for _, recommendation in ipairs(consumableProfile.categories[category]) do
            assert(data.consumables.catalog[recommendation.itemID], classToken .. " references unknown consumable " .. recommendation.itemID)
        end
    end
end

for itemID, entry in pairs(data.consumables.catalog) do
    assert(entry.itemID == itemID)
    assert(entry.wowhead == "https://www.wowhead.com/classic/item=" .. itemID)
    assert(not entry.requiredLevel or entry.requiredLevel <= 29, entry.name .. " exceeds level 29")
end
for _, forbiddenID in ipairs({ 3465, 8069, 20746 }) do
    assert(not data.consumables.catalog[forbiddenID], "level-29 catalog includes forbidden consumable " .. forbiddenID)
end
for _, requiredID in ipairs({ 8545, 5634, 3030, 3033, 3464, 20745, 7964, 7965, 10646 }) do
    assert(data.consumables.catalog[requiredID], "level-29 catalog is missing " .. requiredID)
end
for _, bandageID in ipairs({ 14530, 14529, 8545 }) do
    assert(string.find(data.consumables.catalog[bandageID].restrictions, "cannot craft", 1, true), "bandage lacks the level-29 crafting prohibition")
end

for key, itemID in pairs({ deadlyScope=10546, sniperScope=10548, steelWeaponChain=6041, ironCounterweight=6043, thoriumShieldSpike=12645 }) do
    assert(data.enchants.catalog[key].itemID == itemID)
end
for _, classToken in ipairs({ "HUNTER", "ROGUE", "WARRIOR" }) do
    local ranged = data.enchants.classes[classToken].slots.RANGED
    assert(ranged[1].key == "sniperScope" and ranged[2].key == "deadlyScope" and ranged[3].key == "accurateScope" and ranged[4].key == "standardScope")
end

for _, guideKey in ipairs(data.guides.order) do
    local guide = assert(data.guides.sections[guideKey])
    assert(#guide.steps >= 3 and #guide.items >= 3)
    local itemIDs = {}
    for _, entry in ipairs(guide.items) do
        assert(entry.wowhead == "https://www.wowhead.com/classic/item=" .. entry.id)
        itemIDs[entry.id] = true
    end
    for _, guideStep in ipairs(guide.steps) do
        for _, guideLine in ipairs(guideStep.lines) do
            for _, itemID in ipairs(guideLine.itemIDs) do assert(itemIDs[itemID]) end
        end
    end
end

print("test_bracket29.lua: ok")
