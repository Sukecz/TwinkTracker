local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/Basics.lua", "Data/Bis.lua", "Data/Enchants.lua",
    "Data/Consumables.lua", "Data/Guides.lua", "Data/ClassTiers.lua", "Data/PvPEvents.lua", "Data/Exploration.lua",
    "Data/BracketRegistry.lua", "Data/Bracket29/Bis.lua", "Data/Bracket29/Enchants.lua",
    "Data/Bracket29/Consumables.lua", "Data/Bracket39/Bis.lua",
    "Data/Bracket39/BisDruidHunterMage.lua", "Data/Bracket39/BisPaladinPriestRogue.lua",
    "Data/Bracket39/BisShamanWarlockWarrior.lua", "Data/Bracket39/Enchants.lua",
    "Data/Bracket39/Consumables.lua", "Data/Bracket39/Basics.lua", "Data/Bracket39/Guides.lua",
    "Data/Bracket39/ClassTiers.lua", "Data/Bracket39/Exploration.lua", "Data/Bracket39/Register.lua",
}) do loadModule(path) end

local data = assert(ns.Brackets:GetData(39))
local forbiddenGear = {
    [9905]=true, [10018]=true, [10025]=true, [10030]=true, [10074]=true,
    [10787]=true, [12014]=true, [13085]=true, [14237]=true, [14254]=true,
    [15276]=true, [15376]=true, [15609]=true, [15937]=true, [4046]=true,
    [7712]=true, [9922]=true, [9923]=true,
}
assert(ns.Brackets.profiles[39].available)
assert(data.level == 39 and #data.bis.classOrder == 9)
assert(#data.basics == 7 and #data.guides.order == 3)
assert(#data.classTiers.classOrder == 9)
assert(data.pvp.level == 39 and #data.pvp.events == 0)
assert(#data.exploration.HORDE == 18 and #data.exploration.ALLIANCE == 18)

local function findGear(classToken, slot, itemID, expectedName)
    local profile = assert(data.bis.classes[classToken])
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, entry in ipairs(profile.slots[slot][tier]) do
            if entry.id == itemID and (not expectedName or entry.name == expectedName) then return entry, tier end
        end
    end
    error(classToken .. " " .. slot .. " missing audited item " .. itemID)
end

findGear("PALADIN", "WAIST", 10768, "Boar Champion's Belt")
findGear("PALADIN", "FINGER_1", 7686, "Ironspine's Eye")
findGear("PALADIN", "FINGER_2", 7686, "Ironspine's Eye")
findGear("PRIEST", "NECK", 7888, "Jarkal's Enhancing Necklace")
findGear("PRIEST", "LEGS", 9407, "Stoneweaver Leggings")
findGear("PRIEST", "FEET", 10578, "Thoughtcast Boots")
findGear("ROGUE", "FINGER_1", 7686, "Ironspine's Eye")
findGear("ROGUE", "FINGER_2", 7686, "Ironspine's Eye")
for _, tier in ipairs({ "S", "A", "B" }) do
    for _, entry in ipairs(data.bis.classes.PRIEST.slots.ONE_HAND[tier]) do
        assert(entry.id ~= 13033, "Priests cannot equip swords in Classic Era")
    end
end

for _, classToken in ipairs(data.bis.classOrder) do
    local profile = assert(data.bis.classes[classToken], "missing bracket-39 class " .. classToken)
    local hasOneHand, hasTwoHand = false, false
    for _, slot in ipairs(profile.slotOrder) do
        if slot == "ONE_HAND" then hasOneHand = true end
        if slot == "TWO_HAND" then hasTwoHand = true end
        local slotData = assert(profile.slots[slot], classToken .. " missing " .. slot)
        for _, tier in ipairs({ "S", "A", "B" }) do
            local choices = assert(slotData[tier], classToken .. " " .. slot .. " missing " .. tier)
            assert(#choices >= 1 and #choices <= 3, classToken .. " " .. slot .. " " .. tier .. " invalid choice count")
            for _, entry in ipairs(choices) do
                assert(type(entry.name) == "string" and entry.name ~= "")
                if entry.id then
                    assert(entry.id > 0 and not forbiddenGear[entry.id], classToken .. " includes audited invalid gear " .. entry.id)
                    assert(entry.wowhead == data.bis.wowheadClassicItemURL .. entry.id)
                else
                    assert(entry.wowhead == nil)
                end
                if string.find(entry.note or "", "level-38 WSG", 1, true) or string.find(entry.note or "", "level-38 AB", 1, true) or string.find(entry.note or "", "PvP trinket", 1, true) then
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
            assert(data.enchants.catalog[recommendation.key])
        end
    end

    local consumableProfile = assert(data.consumables.classes[classToken])
    assert(consumableProfile.categories.BANDAGES[1].itemID == 14530)
    for _, category in ipairs(consumableProfile.categoryOrder) do
        for _, recommendation in ipairs(consumableProfile.categories[category]) do
            assert(data.consumables.catalog[recommendation.itemID], classToken .. " references unknown consumable " .. recommendation.itemID)
        end
    end
end

-- Independent SHAMAN/WARLOCK/WARRIOR audit invariants. These catch factual
-- regressions found by comparing the bracket guide lists with Classic item
-- tooltips rather than treating every guide ordering as authoritative.
for _, slot in ipairs({ "HEAD", "SHOULDERS", "CHEST", "WRISTS", "HANDS", "LEGS", "FEET" }) do
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, entry in ipairs(data.bis.classes.SHAMAN.slots[slot][tier]) do
            assert(not ({ [7719]=true, [10328]=true, [10330]=true, [10332]=true, [7724]=true, [7726]=true })[entry.id],
                "level-39 Shaman cannot equip mail: " .. entry.name)
        end
    end
end
for _, tier in ipairs({ "S", "A", "B" }) do
    for _, entry in ipairs(data.bis.classes.SHAMAN.slots.TWO_HAND[tier]) do
        if entry.id == 9425 or entry.id == 6975 or entry.id == 7717 then
            assert(string.find(entry.note, "Two-Handed Axes and Maces talent", 1, true), "Shaman 2H weapon lost its talent gate")
        end
    end
end
for _, slot in ipairs({ "ONE_HAND", "TWO_HAND", "OFF_HAND" }) do
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, entry in ipairs(data.bis.classes.SHAMAN.slots[slot][tier]) do
            assert(entry.id ~= 7714, "Classic Shaman cannot equip Hypnotic Blade daggers")
            assert(entry.id ~= 13029, "Umbral Crystal only increases Shadow damage and is irrelevant to Shaman")
        end
    end
end
findGear("SHAMAN", "ONE_HAND", 7687, "Ironspine's Fist")
local nightsky = findGear("WARLOCK", "OFF_HAND", 15929, "Nightsky Orb")
assert(not string.find(nightsky.note, "exact live / AH roll", 1, true), "Nightsky Orb has fixed stats")
findGear("WARLOCK", "WAIST", 4329, "Star Belt")
findGear("WARLOCK", "TWO_HAND", 15106, "Staff of Dar'Orahil")
findGear("WARLOCK", "RANGED", 13064, "Jaina's Firestarter")
local ironspine = findGear("WARRIOR", "FINGER_2", 7686, "Ironspine's Eye")
assert(ironspine.faction == nil, "neutral Scarlet Monastery loot must not be Alliance-locked")
findGear("WARRIOR", "ONE_HAND", 868, "Ardent Custodian")
findGear("WARRIOR", "FEET", 20129, "Highlander's Plate Greaves")
findGear("WARRIOR", "FEET", 20210, "Defiler's Plate Greaves")

local function classHasItem(classToken, itemID)
    for _, slot in pairs(data.bis.classes[classToken].slots) do
        for _, tier in ipairs({ "S", "A", "B" }) do
            for _, entry in ipairs(slot[tier]) do
                if entry.id == itemID then return true end
            end
        end
    end
    return false
end

assert(not classHasItem("DRUID", 7714), "Druid cannot equip the Hypnotic Blade dagger in Classic Era")
for _, itemID in ipairs({ 868, 7375, 10710, 9393, 7685 }) do
    assert(classHasItem("DRUID", itemID), "Druid audit is missing guide-backed item " .. itemID)
end
assert(not classHasItem("MAGE", 10777), "Mage cannot equip the leather Arachnid Gloves")
assert(not classHasItem("MAGE", 10721), "Mage cannot equip the leather Gnomish Harm Prevention Belt")
assert(not classHasItem("HUNTER", 21566), "Rune of Perfection is restricted to the caster-class group")

for itemID, entry in pairs(data.consumables.catalog) do
    assert(entry.itemID == itemID)
    assert(entry.wowhead == "https://www.wowhead.com/classic/item=" .. itemID)
    assert(not entry.requiredLevel or entry.requiredLevel <= 39, entry.name .. " exceeds level 39")
end
for _, requiredID in ipairs({ 3928,6149,9030,9172,9187,9206,4422,4419,15993,16005,16040,18637,20746,12404,12643,3465,8069,9399 }) do
    assert(data.consumables.catalog[requiredID], "missing bracket-39 consumable " .. requiredID)
end
assert(data.consumables.catalog[3465].requiredLevel == nil and data.consumables.catalog[3465].effect == "9.5 ranged damage per second")
assert(data.consumables.catalog[5513].requiredLevel == 38)
assert(data.consumables.catalog[5510].requiredLevel == 36 and data.consumables.catalog[5510].effect == "Restores 800 health")
assert(data.consumables.catalog[19010].effect == "Restores 880 health")
assert(data.consumables.catalog[19011].effect == "Restores 960 health")
assert(data.consumables.catalog[19006].name == "Lesser Healthstone" and data.consumables.catalog[19006].requiredLevel == 12)
assert(data.consumables.catalog[19007].name == "Lesser Healthstone" and data.consumables.catalog[19007].requiredLevel == 12)
assert(not data.consumables.catalog[19008] and not data.consumables.catalog[19009])

local function profileHasConsumable(classToken, category, itemID)
    for _, recommendation in ipairs(data.consumables.classes[classToken].categories[category]) do
        if recommendation.itemID == itemID then return true end
    end
    return false
end
assert(profileHasConsumable("HUNTER", "POTIONS", 6149), "Hunter lacks a level-39 mana potion")
assert(profileHasConsumable("DRUID", "FOOD_DRINK", 13928), "Feral Druid lacks Grilled Squid")
assert(profileHasConsumable("DRUID", "FOOD_DRINK", 12217), "Feral Druid lacks Dragonbreath Chili")
assert(profileHasConsumable("MAGE", "FOOD_DRINK", 12217), "Mage lacks guide-supported Dragonbreath Chili")

for _, classToken in ipairs(data.bis.classOrder) do
    for _, category in ipairs(data.consumables.classes[classToken].categoryOrder) do
        for _, recommendation in ipairs(data.consumables.classes[classToken].categories[category]) do
            local isHealthstone = recommendation.itemID == 5510 or recommendation.itemID == 19010 or recommendation.itemID == 19011
            assert(not isHealthstone or classToken == "WARLOCK", classToken .. " incorrectly recommends a Warlock-created Healthstone")
        end
    end
end

for _, guideKey in ipairs(data.guides.order) do
    local guide = assert(data.guides.sections[guideKey])
    assert(#guide.steps >= 3 and #guide.items >= 3)
    local itemIDs = {}
    local hasShoppingList = false
    for _, entry in ipairs(guide.items) do
        assert(entry.wowhead == "https://www.wowhead.com/classic/item=" .. entry.id)
        itemIDs[entry.id] = true
    end
    for _, guideStep in ipairs(guide.steps) do
        if string.find(guideStep.title, "SHOPPING LIST", 1, true) then hasShoppingList = true end
        for _, guideLine in ipairs(guideStep.lines) do
            assert(not string.find(string.lower(guideLine.text), "follow the bracket", 1, true))
            assert(not string.find(string.lower(guideLine.text), "follow the early route", 1, true))
            for _, itemID in ipairs(guideLine.itemIDs) do assert(itemIDs[itemID], guideKey .. " omits related item " .. itemID) end
        end
    end
    assert(hasShoppingList, guideKey .. " is missing a shopping list")
end

local function guideHasStep(guide, title)
    for _, guideStep in ipairs(guide.steps) do
        if guideStep.title == title then return true end
    end
    return false
end
for _, title in ipairs({ "SKILL 1-125", "SKILL 125-225", "SKILL 225-300" }) do
    assert(guideHasStep(data.guides.sections.FIRST_AID, title), "level-39 First Aid is missing " .. title)
end
for _, title in ipairs({ "SKILL 1-75", "SKILL 75-125", "SKILL 125-175", "SKILL 175-225", "SKILL 225-250", "SKILL 250-275", "SKILL 275-300" }) do
    assert(guideHasStep(data.guides.sections.FISHING, title), "level-39 Fishing is missing " .. title)
end
for _, title in ipairs({ "SKILL 1-75", "SKILL 75-150", "SKILL 150-200", "SKILL 200-225", "SKILL 225-300" }) do
    assert(guideHasStep(data.guides.sections.ENGINEERING, title), "level-39 Engineering is missing " .. title)
end

print("test_bracket39.lua: ok")
