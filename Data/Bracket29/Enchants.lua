local addonName, ns = ...

local function deepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[deepCopy(key)] = deepCopy(entry) end
    return result
end

local data = deepCopy(ns.EnchantsData)
data.version = "2026-08-11"

local function addItem(key, name, effect, itemID, restrictions)
    data.catalog[key] = {
        name = name,
        effect = effect,
        itemID = itemID,
        restrictions = restrictions,
        wowhead = "https://www.wowhead.com/classic/item=" .. itemID,
    }
end

addItem("deadlyScope", "Deadly Scope", "5 ranged weapon damage", 10546,
    "BOW/GUN only; target item level 30+; use a level-30+ applicator through the trade window and verify the exact weapon live")
addItem("sniperScope", "Sniper Scope", "7 ranged weapon damage", 10548,
    "BOW/GUN only; target item level 40+; use a level-40+ applicator through the trade window and verify the exact weapon live")
addItem("steelWeaponChain", "Steel Weapon Chain", "Immune to Disarm", 6041,
    "Permanent weapon enhancement; a Blacksmithing 190 applier uses it through the trade window; replaces an enchant or counterweight")
addItem("ironCounterweight", "Iron Counterweight", "3% faster attacks", 6043,
    "TWO-HAND sword, mace, axe or polearm; Blacksmithing 165 applier; replaces an enchant or weapon chain; works in Feral forms")
addItem("thoriumShieldSpike", "Thorium Shield Spike", "20-30 damage on each block", 12645,
    "SHIELD; Blacksmithing 250 applier through the trade window; replaces a shield enchant; verify application to the exact target live")

local function recommendation(key, priority, roles, note)
    return { key=key, priority=priority, roles=roles, note=note }
end

local function setSlot(classToken, slot, recommendations)
    assert(#recommendations <= 4, classToken .. " " .. slot .. " has more than four enchant recommendations")
    local profile = data.classes[classToken]
    profile.slots[slot] = recommendations
    local found = false
    for _, existing in ipairs(profile.slotOrder) do
        if existing == slot then found = true break end
    end
    if not found then profile.slotOrder[#profile.slotOrder + 1] = slot end
end

for _, classToken in ipairs({ "HUNTER", "ROGUE", "WARRIOR" }) do
    setSlot(classToken, "RANGED", {
        recommendation("sniperScope", "PRIMARY", "item-level 40+ bow / gun"),
        recommendation("deadlyScope", "PRIMARY", "item-level 30-39 bow / gun"),
        recommendation("accurateScope", "ALTERNATIVE", "item-level 20-29 bow / gun"),
        recommendation("standardScope", "ALTERNATIVE", "item-level 10-19 bow / gun"),
    })
end

setSlot("DRUID", "TWO_HAND", {
    recommendation("ironCounterweight", "PRIMARY", "Feral / Manual Crowd Pummeler"),
    recommendation("twoHandAgility", "PRIMARY", "physical / avoidance"),
    recommendation("weaponHealing", "PRIMARY", "Restoration"),
    recommendation("weaponSpell", "PRIMARY", "Balance"),
})

setSlot("PALADIN", "ONE_HAND", {
    recommendation("weaponHealing", "PRIMARY", "Holy healer"),
    recommendation("weaponIntellect", "PRIMARY", "healer mana"),
    recommendation("crusader", "PRIMARY", "melee"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "anti-Disarm melee swap"),
})
setSlot("PALADIN", "TWO_HAND", {
    recommendation("crusader", "PRIMARY", "melee burst"),
    recommendation("twoHandAgility", "PRIMARY", "reliable melee"),
    recommendation("ironCounterweight", "ALTERNATIVE", "attack-speed set"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "anti-Disarm set"),
})
setSlot("PALADIN", "OFF_HAND", {
    recommendation("shieldStamina", "PRIMARY", "survival"),
    recommendation("shieldSpirit", "ALTERNATIVE", "healer sustain"),
    recommendation("shieldBlock", "ALTERNATIVE", "block set"),
    recommendation("thoriumShieldSpike", "ALTERNATIVE", "block pressure"),
})

setSlot("ROGUE", "ONE_HAND", {
    recommendation("weaponAgility", "PRIMARY", "reliable MH / OH"),
    recommendation("lifestealing", "PRIMARY", "main-hand sustain proc"),
    recommendation("crusader", "ALTERNATIVE", "high-variance burst"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "anti-Disarm weapon"),
})

setSlot("SHAMAN", "ONE_HAND", {
    recommendation("weaponHealing", "PRIMARY", "Restoration"),
    recommendation("weaponSpell", "PRIMARY", "Elemental"),
    recommendation("weaponIntellect", "PRIMARY", "caster mana"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "Enhancement anti-Disarm swap"),
})
setSlot("SHAMAN", "TWO_HAND", {
    recommendation("weaponHealing", "PRIMARY", "Restoration"),
    recommendation("weaponSpell", "PRIMARY", "Elemental"),
    recommendation("twoHandAgility", "PRIMARY", "Enhancement"),
    recommendation("ironCounterweight", "ALTERNATIVE", "Enhancement attack-speed set"),
})
setSlot("SHAMAN", "OFF_HAND", {
    recommendation("shieldStamina", "PRIMARY", "survival"),
    recommendation("shieldSpirit", "ALTERNATIVE", "healer sustain"),
    recommendation("shieldBlock", "ALTERNATIVE", "block set"),
    recommendation("thoriumShieldSpike", "ALTERNATIVE", "block pressure"),
})

setSlot("WARRIOR", "ONE_HAND", {
    recommendation("lifestealing", "PRIMARY", "pressure / sustain"),
    recommendation("crusader", "PRIMARY", "high-variance Strength burst"),
    recommendation("weaponAgility", "PRIMARY", "reliable damage / defense"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "anti-Disarm weapon"),
})
setSlot("WARRIOR", "TWO_HAND", {
    recommendation("crusader", "PRIMARY", "burst"),
    recommendation("lifestealing", "PRIMARY", "pressure / sustain"),
    recommendation("steelWeaponChain", "ALTERNATIVE", "anti-Disarm set"),
    recommendation("ironCounterweight", "ALTERNATIVE", "attack-speed set"),
})
setSlot("WARRIOR", "OFF_HAND", {
    recommendation("shieldStamina", "PRIMARY", "shield survival"),
    recommendation("shieldBlock", "ALTERNATIVE", "block set"),
    recommendation("thoriumShieldSpike", "ALTERNATIVE", "block pressure"),
})

ns.Bracket29EnchantsData = data
