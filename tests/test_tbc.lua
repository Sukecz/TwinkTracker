local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/Basics.lua", "Data/Bis.lua", "Data/Enchants.lua",
    "Data/Consumables.lua", "Data/Guides.lua", "Data/ClassTiers.lua", "Data/PvPEvents.lua",
    "Data/Events.lua", "Data/Exploration.lua", "Data/BracketRegistry.lua",
    "Data/Bracket29/Bis.lua", "Data/Bracket29/Enchants.lua", "Data/Bracket29/Consumables.lua",
    "Data/Bracket29/Basics.lua", "Data/Bracket29/Guides.lua", "Data/Bracket29/ClassTiers.lua",
    "Data/Bracket29/Exploration.lua", "Data/Bracket29/Register.lua",
    "Data/Bracket39/Bis.lua", "Data/Bracket39/BisDruidHunterMage.lua",
    "Data/Bracket39/BisPaladinPriestRogue.lua", "Data/Bracket39/BisShamanWarlockWarrior.lua",
    "Data/Bracket39/Enchants.lua", "Data/Bracket39/Consumables.lua", "Data/Bracket39/Basics.lua",
    "Data/Bracket39/Guides.lua", "Data/Bracket39/ClassTiers.lua", "Data/Bracket39/Exploration.lua",
    "Data/Bracket39/Register.lua", "Data/TBC/Base.lua", "Data/TBC/Systems.lua", "Data/TBC/Events.lua",
    "Data/TBC/GearDruidHunterMage.lua", "Data/TBC/GearPaladinPriestRogue.lua",
    "Data/TBC/GearShamanWarlockWarrior.lua", "Data/TBC/ClassTiers.lua", "Data/TBC/Register.lua",
}) do loadModule(path) end

local changedCount = 0
local hasAllianceShaman = false
local hasHordePaladin = false

local function hasKeyPrefix(recommendations, prefix)
    for _, entry in ipairs(recommendations or {}) do
        if string.sub(entry.key or "", 1, #prefix) == prefix then return true end
    end
    return false
end

local function assertTBCEnchantFallback(profile, slot, context)
    local recommendations = assert(profile.slots[slot], context .. " missing " .. slot)
    assert(hasKeyPrefix(recommendations, "tbc"), context .. " " .. slot .. " has no TBC candidate")
    assert(not hasKeyPrefix(recommendations, "tbc") or (function()
        for _, entry in ipairs(recommendations) do
            if string.sub(entry.key or "", 1, 3) ~= "tbc" then return true end
        end
        return false
    end)(), context .. " " .. slot .. " lost its inherited Era fallback")
end

local function auditRuntimeText(value, location, seen)
    if type(value) == "string" then
        for _, forbidden in ipairs({ "Era only", "Era-only", "Era PvP only", "Era WSG only", "unavailable on Hardcore", "current Era" }) do
            assert(not string.find(value, forbidden, 1, true), location .. " retained TBC-invalid text: " .. forbidden)
        end
        return
    end
    if type(value) ~= "table" then return end
    seen = seen or {}
    if seen[value] then return end
    seen[value] = true
    for key, entry in pairs(value) do auditRuntimeText(entry, location .. "." .. tostring(key), seen) end
end

for _, level in ipairs({ 19, 29, 39 }) do
    local data = assert(ns.Brackets:GetData(level), "missing TBC bracket " .. level)
    assert(data.bis.wowheadClassicItemURL == "https://www.wowhead.com/tbc/item=")
    assert(#data.pvp.events == 0, "Era community events leaked into TBC bracket " .. level)
    assert(string.find(data.basicsIntro, "Burning Crusade Classic", 1, true))
    assert(data.enchants.sources and #data.enchants.sources >= 2)
    assert(data.enchants.catalog.tbcBoarsSpeed and data.enchants.catalog.tbcNethercleft)
    for _, guideKey in ipairs(data.guides.order) do
        local hasShoppingList = false
        for _, guideStep in ipairs(data.guides.sections[guideKey].steps) do
            if string.find(guideStep.title, "SHOPPING LIST", 1, true) then hasShoppingList = true end
        end
        assert(hasShoppingList, "TBC " .. level .. " " .. guideKey .. " is missing a shopping list")
    end

    if level == 19 then
        assertTBCEnchantFallback(data.enchants.classes.MAGE, "CHEST", "19 MAGE Inferno Robe")
        assertTBCEnchantFallback(data.enchants.classes.WARLOCK, "CHEST", "19 WARLOCK Inferno Robe")
    end

    for key, entry in pairs(data.enchants.catalog) do
        if string.sub(key, 1, 3) == "tbc" and entry.spellID then
            assert(entry.minTargetItemLevel == 35, key .. " must encode target item level 35")
            assert(entry.requirementType == "TARGET_ITEM_LEVEL", key .. " confused target item and character level")
            assert(string.find(entry.restrictions, "not a level-35 character requirement", 1, true), key .. " lacks explicit target-item wording")
        elseif string.sub(key, 1, 3) ~= "tbc" and entry.spellID then
            assert(entry.minTargetItemLevel == nil, key .. " inherited a false TBC item-level floor")
        end
    end
    for _, key in ipairs({ "tbcNethercleft", "tbcNethercobra", "tbcGoldenSpellthread", "tbcRunicSpellthread" }) do
        local entry = assert(data.enchants.catalog[key])
        assert(entry.applierMinimumLevel == 60 and entry.requiresTradeableTarget == true)
        assert(entry.requirementType == "APPLIER_CHARACTER_LEVEL" and entry.minTargetItemLevel == nil)
    end

    for _, token in ipairs(data.bis.classOrder) do
        local profile = assert(data.bis.classes[token], "missing TBC " .. token .. " at " .. level)
        local enchantProfile = assert(data.enchants.classes[token], "missing TBC enchant profile " .. level .. " " .. token)
        assertTBCEnchantFallback(enchantProfile, "FEET", level .. " " .. token)
        assertTBCEnchantFallback(enchantProfile, "LEGS", level .. " " .. token)
        if level >= 29 then
            for _, slot in ipairs({ "BACK", "CHEST", "WRISTS", "HANDS" }) do
                assertTBCEnchantFallback(enchantProfile, slot, level .. " " .. token)
            end
            if enchantProfile.slots.ONE_HAND then assertTBCEnchantFallback(enchantProfile, "ONE_HAND", level .. " " .. token) end
            if enchantProfile.slots.TWO_HAND then assertTBCEnchantFallback(enchantProfile, "TWO_HAND", level .. " " .. token) end
            if enchantProfile.slots.OFF_HAND and (token == "PALADIN" or token == "SHAMAN" or token == "WARRIOR") then
                assertTBCEnchantFallback(enchantProfile, "OFF_HAND", level .. " " .. token)
            end
        end
        local classAudit = assert(ns.TBCData.audit[level][token], "missing TBC audit " .. level .. " " .. token)
        assert(#classAudit.sources > 0)
        for _, source in ipairs(classAudit.sources) do assert(string.match(source, "^https://"), "invalid TBC audit source") end
        for _, slot in ipairs(profile.slotOrder) do
            local slotData = assert(profile.slots[slot], token .. " missing TBC slot " .. slot)
            local slotAudit = assert(classAudit.slots[slot], token .. " missing TBC audit slot " .. slot)
            for _, tier in ipairs({ "S", "A", "B" }) do
                local choices = assert(slotData[tier], token .. " missing TBC tier " .. slot .. " " .. tier)
                assert(#choices >= 1 and #choices <= 3, token .. " invalid TBC choice count " .. slot .. " " .. tier)
                assert(slotAudit[tier] == "KEEP" or slotAudit[tier] == "CHANGE")
                if slotAudit[tier] == "CHANGE" then changedCount = changedCount + 1 end
                for _, entry in ipairs(choices) do
                    if entry.id then assert(entry.wowhead == "https://www.wowhead.com/tbc/item=" .. entry.id) end
                    if token == "SHAMAN" and entry.faction == "ALLIANCE" then hasAllianceShaman = true end
                    if token == "PALADIN" and entry.faction == "HORDE" then hasHordePaladin = true end
                end
            end
        end
    end

    for itemID, entry in pairs(data.consumables.catalog) do
        assert(entry.wowhead == "https://www.wowhead.com/tbc/item=" .. itemID)
    end
    for _, entry in pairs(data.enchants.catalog) do
        if entry.spellID then
            assert(entry.wowhead == "https://www.wowhead.com/tbc/spell=" .. entry.spellID)
        else
            assert(entry.wowhead == "https://www.wowhead.com/tbc/item=" .. entry.itemID)
        end
    end
    auditRuntimeText(data, "bracket" .. level)
end

assert(changedCount > 0, "TBC audit contains no concrete gear changes")
assert(hasAllianceShaman, "TBC data has no Alliance Shaman route")
assert(hasHordePaladin, "TBC data has no Horde Paladin route")
assert(ns.EventTimersData.events.BATTLEGROUND.category == "PVP  •  BURNING CRUSADE CLASSIC")
assert(ns.EventTimersData.events.WSG == nil)

print("test_tbc.lua: ok")
