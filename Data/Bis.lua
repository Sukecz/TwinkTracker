local addonName, ns = ...

local function item(id, name, slot, note)
    return { id = id, name = name, slot = slot, note = note }
end

local AGM = item(19024, "Arena Grand Master", "TRINKET", "Premium survival option")
local FISHING_HAT = item(19972, "Lucky Fishing Hat", "HEAD", "Fishing event reward")
local GOGGLES = item(4385, "Green Tinted Goggles", "HEAD", "Engineering option")
local SENTRY_CLOAK = item(2059, "Sentry Cloak", "BACK", "Strong all-round alternative")
local FEET_LYNX = item(1121, "Feet of the Lynx", "FEET", "Mobility-oriented leather")
local DEVIATE_BELT = item(6468, "Deviate Scale Belt", "WAIST", "Leather melee option")
local BLACKENED = item(10399, "Blackened Defias Armor", "CHEST", "Melee leather chest")
local TREE_BARK = item(1486, "Tree Bark Jacket", "CHEST", "Survival-oriented chest")

ns.BisData = {
    classOrder = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" },
    classes = {
        DRUID = { name = "Druid", role = "Flag Carrier / Midfield / Healer", tiers = {
            S = { item(1483, "Face Smasher", "MAIN HAND", "Flag carrier core"), FISHING_HAT, AGM },
            A = { item(6505, "Crescent Staff", "WEAPON", "Balanced alternative"), TREE_BARK, FEET_LYNX },
            B = { item(2271, "Staff of the Blessed Seer", "WEAPON", "Caster option"), GOGGLES, SENTRY_CLOAK },
        } },
        HUNTER = { name = "Hunter", role = "Ranged Pressure / Defense / Midfield", tiers = {
            S = { item(6469, "Venomstrike", "RANGED", "Premium ranged weapon"), FISHING_HAT, AGM },
            A = { item(2825, "Bow of Searing Arrows", "RANGED", "Damage alternative"), FEET_LYNX, BLACKENED },
            B = { GOGGLES, DEVIATE_BELT, SENTRY_CLOAK },
        } },
        MAGE = { name = "Mage", role = "Control / Midfield / Burst", tiers = {
            S = { item(890, "Twisted Chanter's Staff", "WEAPON", "Caster core"), FISHING_HAT, AGM },
            A = { item(2271, "Staff of the Blessed Seer", "WEAPON", "Balanced caster option"), TREE_BARK, SENTRY_CLOAK },
            B = { GOGGLES, item(12987, "Darkweave Breeches", "LEGS", "Caster alternative"), item(6463, "Deep Fathom Ring", "FINGER", "Mana option") },
        } },
        PALADIN = { name = "Paladin", role = "Support / Defense / Melee", tiers = {
            S = { item(1482, "Shadowfang", "MAIN HAND", "Premium one-hand"), FISHING_HAT, AGM },
            A = { item(5191, "Cruel Barb", "MAIN HAND", "Accessible damage option"), item(12997, "Redbeard Crest", "OFF HAND", "Shield option"), TREE_BARK },
            B = { GOGGLES, SENTRY_CLOAK, item(1955, "Dragonmaw Chain Boots", "FEET", "Mail alternative") },
        } },
        PRIEST = { name = "Priest", role = "Healer / Support / Shadow", tiers = {
            S = { item(890, "Twisted Chanter's Staff", "WEAPON", "Caster core"), FISHING_HAT, AGM },
            A = { item(2271, "Staff of the Blessed Seer", "WEAPON", "Healing alternative"), TREE_BARK, SENTRY_CLOAK },
            B = { GOGGLES, item(12987, "Darkweave Breeches", "LEGS", "Caster alternative"), item(6463, "Deep Fathom Ring", "FINGER", "Mana option") },
        } },
        ROGUE = { name = "Rogue", role = "Burst / Flag Return / Defense", tiers = {
            S = { item(1482, "Shadowfang", "MAIN HAND", "Premium main hand"), item(1935, "Assassin's Blade", "MAIN HAND", "Premium dagger"), AGM },
            A = { item(5191, "Cruel Barb", "WEAPON", "Strong alternative"), FEET_LYNX, FISHING_HAT },
            B = { BLACKENED, GOGGLES, DEVIATE_BELT },
        } },
        SHAMAN = { name = "Shaman", role = "Midfield / Support / Melee", tiers = {
            S = { item(1482, "Shadowfang", "MAIN HAND", "Premium one-hand"), FISHING_HAT, AGM },
            A = { item(6505, "Crescent Staff", "WEAPON", "Caster alternative"), item(12997, "Redbeard Crest", "OFF HAND", "Shield option"), TREE_BARK },
            B = { GOGGLES, SENTRY_CLOAK, DEVIATE_BELT },
        } },
        WARLOCK = { name = "Warlock", role = "Survival / Shadow Pressure / Control", tiers = {
            S = { item(890, "Twisted Chanter's Staff", "WEAPON", "Caster core"), FISHING_HAT, AGM },
            A = { item(2271, "Staff of the Blessed Seer", "WEAPON", "Balanced caster option"), TREE_BARK, SENTRY_CLOAK },
            B = { GOGGLES, item(12987, "Darkweave Breeches", "LEGS", "Caster alternative"), item(6463, "Deep Fathom Ring", "FINGER", "Mana option") },
        } },
        WARRIOR = { name = "Warrior", role = "Frontline / Defense / Flag Carrier", tiers = {
            S = { item(1482, "Shadowfang", "MAIN HAND", "Premium one-hand"), FISHING_HAT, AGM },
            A = { item(5191, "Cruel Barb", "WEAPON", "Strong alternative"), item(12997, "Redbeard Crest", "OFF HAND", "Shield option"), TREE_BARK },
            B = { GOGGLES, SENTRY_CLOAK, item(1955, "Dragonmaw Chain Boots", "FEET", "Mail alternative") },
        } },
    },
    enchants = {
        "Head — Lesser Arcanum by role", "Back — Greater Defense", "Chest — Major Health / Greater Stats",
        "Wrist — Greater Stamina", "Hands — Agility / Strength", "Feet — Minor Speed", "Weapon — build-specific",
    },
    sources = {
        "Pilot data derived from the supplied Classic Era research workbook and guide notes.",
        "Verify faction, level requirement and current Era availability before acquisition.",
    },
}
