local addonName, ns = ...

-- Shared metadata is defined once. Class profiles only add priority and role
-- context, preventing names, effects and Wowhead links from drifting.
local catalog = {
    arcanumConstitution = { name="Lesser Arcanum of Constitution", effect="100 Health", itemID=11642, restrictions="HEAD/LEGS; high-level Libram quest and application through another character; verify on Firemaw" },
    arcanumRumination = { name="Lesser Arcanum of Rumination", effect="150 Mana", itemID=11622, restrictions="HEAD/LEGS; high-level Libram quest and application through another character; verify on Firemaw" },
    arcanumVoracityStrength = { name="Lesser Arcanum of Voracity - Strength", effect="8 Strength", itemID=11645, restrictions="HEAD/LEGS; choose Strength at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumVoracityAgility = { name="Lesser Arcanum of Voracity - Agility", effect="8 Agility", itemID=11647, restrictions="HEAD/LEGS; choose Agility at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumVoracityIntellect = { name="Lesser Arcanum of Voracity - Intellect", effect="8 Intellect", itemID=11648, restrictions="HEAD/LEGS; choose Intellect at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumFocus = { name="Arcanum of Focus", effect="8 healing and spell damage", itemID=18330, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
    arcanumProtection = { name="Arcanum of Protection", effect="1% Dodge", itemID=18331, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
    arcanumRapidity = { name="Arcanum of Rapidity", effect="1% Haste", itemID=18329, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
    scourgePower = { name="Power of the Scourge", effect="15 healing and spell damage; 1% spell critical strike", itemID=23545, restrictions="SHOULDERS; level-60 owner applies only to white, non-binding tradeable shoulders before transfer; green/blue BoE and BoP trade-window application are unverified on Firemaw" },
    scourgeResilience = { name="Resilience of the Scourge", effect="31 Healing; 5 mana every 5 sec", itemID=23547, restrictions="SHOULDERS; level-60 owner applies only to white, non-binding tradeable shoulders before transfer; green/blue BoE and BoP trade-window application are unverified on Firemaw" },
    scourgeMight = { name="Might of the Scourge", effect="26 Attack Power; 1% critical strike", itemID=23548, restrictions="SHOULDERS; level-60 owner applies only to white, non-binding tradeable shoulders before transfer; green/blue BoE and BoP trade-window application are unverified on Firemaw" },
    scourgeFortitude = { name="Fortitude of the Scourge", effect="16 Stamina; 100 Armor", itemID=23549, restrictions="SHOULDERS; level-60 owner applies only to white, non-binding tradeable shoulders before transfer; green/blue BoE and BoP trade-window application are unverified on Firemaw" },
    cloakDodge = { name="Enchant Cloak - Dodge", effect="1% Dodge", spellID=25086 },
    cloakDefense = { name="Enchant Cloak - Superior Defense", effect="70 Armor", spellID=20015 },
    cloakResistance = { name="Enchant Cloak - Greater Resistance", effect="5 to all resistances", spellID=20014 },
    cloakAgility = { name="Enchant Cloak - Lesser Agility", effect="3 Agility", spellID=13882 },
    chestStats = { name="Enchant Chest - Greater Stats", effect="4 to all stats", spellID=20025 },
    chestHealth = { name="Enchant Chest - Major Health", effect="100 Health", spellID=20026 },
    chestMana = { name="Enchant Chest - Major Mana", effect="100 Mana", spellID=20028 },
    bracerStamina = { name="Enchant Bracer - Superior Stamina", effect="9 Stamina", spellID=20011 },
    bracerStrength = { name="Enchant Bracer - Superior Strength", effect="9 Strength", spellID=20010 },
    bracerIntellect = { name="Enchant Bracer - Greater Intellect", effect="7 Intellect", spellID=20008 },
    bracerSpirit = { name="Enchant Bracer - Superior Spirit", effect="9 Spirit", spellID=20009 },
    bracerMana = { name="Enchant Bracer - Mana Regeneration", effect="4 mana every 5 sec", spellID=23801 },
    bracerHealing = { name="Enchant Bracer - Healing Power", effect="24 Healing", spellID=23802 },
    glovesAgility = { name="Enchant Gloves - Superior Agility", effect="15 Agility", spellID=25080 },
    glovesAgilityBudget = { name="Enchant Gloves - Greater Agility", effect="7 Agility", spellID=20012 },
    glovesStrength = { name="Enchant Gloves - Greater Strength", effect="7 Strength", spellID=20013 },
    glovesHealing = { name="Enchant Gloves - Healing Power", effect="30 Healing", spellID=25079 },
    glovesShadow = { name="Enchant Gloves - Shadow Power", effect="20 Shadow damage", spellID=25073 },
    glovesFrost = { name="Enchant Gloves - Frost Power", effect="20 Frost damage", spellID=25074 },
    glovesFire = { name="Enchant Gloves - Fire Power", effect="20 Fire damage", spellID=25078 },
    bootsSpeed = { name="Enchant Boots - Minor Speed", effect="Minor movement speed", spellID=13890, restrictions="Does not stack with equivalent passive speed bonuses; verify live" },
    bootsStamina = { name="Enchant Boots - Greater Stamina", effect="7 Stamina", spellID=20020 },
    bootsAgility = { name="Enchant Boots - Greater Agility", effect="7 Agility", spellID=20023 },
    bootsSpirit = { name="Enchant Boots - Spirit", effect="5 Spirit", spellID=20024 },
    weaponAgility = { name="Enchant Weapon - Agility", effect="15 Agility", spellID=23800 },
    weaponSpell = { name="Enchant Weapon - Spell Power", effect="30 spell damage", spellID=22749, restrictions="Low-rank spell benefit should be verified live" },
    weaponHealing = { name="Enchant Weapon - Healing Power", effect="55 Healing", spellID=22750, restrictions="Low-rank spell benefit should be verified live" },
    weaponIntellect = { name="Enchant Weapon - Mighty Intellect", effect="22 Intellect", spellID=23804 },
    weaponSpirit = { name="Enchant Weapon - Mighty Spirit", effect="20 Spirit", spellID=23803 },
    twoHandAgility = { name="Enchant 2H Weapon - Agility", effect="25 Agility", spellID=27837 },
    twoHandIntellect = { name="Enchant 2H Weapon - Major Intellect", effect="9 Intellect", spellID=20036 },
    twoHandSpirit = { name="Enchant 2H Weapon - Major Spirit", effect="9 Spirit", spellID=20035 },
    wintersMight = { name="Enchant Weapon - Winter's Might", effect="7 Frost spell damage", spellID=21931 },
    crusader = { name="Enchant Weapon - Crusader", effect="Proc: heal 75-125 and gain 100 Strength for 15 sec", spellID=20034, restrictions="Proc rate and class interactions need live verification" },
    fiery = { name="Enchant Weapon - Fiery Weapon", effect="Proc: 40 Fire damage", spellID=13898, restrictions="Proc rate needs live verification" },
    icyChill = { name="Enchant Weapon - Icy Chill", effect="Proc: reduces target movement and attack speed", spellID=20029, restrictions="Proc rate and slow behavior need live verification" },
    superiorStriking = { name="Enchant Weapon - Superior Striking", effect="5 weapon damage", spellID=20031 },
    lifestealing = { name="Enchant Weapon - Lifestealing", effect="Proc: deal 30 Shadow damage and heal 30", spellID=20032, restrictions="Proc rate needs live verification" },
    twoHandImpact = { name="Enchant 2H Weapon - Superior Impact", effect="9 weapon damage", spellID=20030 },
    shieldStamina = { name="Enchant Shield - Greater Stamina", effect="7 Stamina", spellID=20017 },
    shieldSpirit = { name="Enchant Shield - Superior Spirit", effect="9 Spirit", spellID=20016 },
    shieldBlock = { name="Enchant Shield - Lesser Block", effect="2% Block", spellID=13689 },
    accurateScope = { name="Accurate Scope", effect="3 ranged weapon damage", itemID=4407, restrictions="Requires a level-20 applier and a ranged weapon with item level 20+; apply through the trade window and verify the exact weapon on Firemaw" },
    standardScope = { name="Standard Scope", effect="2 ranged weapon damage", itemID=4406, restrictions="Requires level 10" },
}

for _, entry in pairs(catalog) do
    if entry.spellID then
        entry.wowhead = "https://www.wowhead.com/classic/spell=" .. entry.spellID
    else
        entry.wowhead = "https://www.wowhead.com/classic/item=" .. entry.itemID
    end
end

ns.EnchantsData = {
    version = "2026-08-09",
    slotOrder = { "HEAD", "SHOULDERS", "BACK", "CHEST", "WRISTS", "HANDS", "LEGS", "FEET", "ONE_HAND", "TWO_HAND", "OFF_HAND", "RANGED" },
    catalog = catalog,
    classes = {},
}

local function recommendation(key, priority, roles, note)
    return { key=key, priority=priority, roles=roles, note=note }
end

local libramProfiles = {
    DRUID={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","physical / bear"),recommendation("arcanumFocus","PRIMARY","caster / healer"),recommendation("arcanumRumination","ALTERNATIVE","mana")},
    HUNTER={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","ranged damage"),recommendation("arcanumRumination","ALTERNATIVE","mana"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
    MAGE={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","spell damage"),recommendation("arcanumRumination","PRIMARY","mana")},
    PALADIN={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Holy"),recommendation("arcanumVoracityStrength","PRIMARY","melee"),recommendation("arcanumRumination","ALTERNATIVE","healer mana")},
    PRIEST={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Shadow"),recommendation("arcanumRumination","PRIMARY","mana")},
    ROGUE={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","damage"),recommendation("arcanumProtection","ALTERNATIVE","avoidance"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
    SHAMAN={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Elemental"),recommendation("arcanumVoracityStrength","PRIMARY","Enhancement"),recommendation("arcanumRumination","ALTERNATIVE","caster / healer mana")},
    WARLOCK={recommendation("arcanumConstitution","PRIMARY","survival / Life Tap"),recommendation("arcanumFocus","PRIMARY","spell damage"),recommendation("arcanumRumination","PRIMARY","opening mana")},
    WARRIOR={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityStrength","PRIMARY","burst"),recommendation("arcanumProtection","ALTERNATIVE","avoidance"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
}

local function addProfile(classToken, slots)
    slots.HEAD = libramProfiles[classToken]
    slots.LEGS = libramProfiles[classToken]
    local order = {}
    for _, slot in ipairs(ns.EnchantsData.slotOrder) do
        if slots[slot] and #slots[slot] > 0 then
            assert(#slots[slot] <= 4, classToken .. " " .. slot .. " has more than four enchant recommendations")
            order[#order+1] = slot
        end
    end
    ns.EnchantsData.classes[classToken] = { slotOrder=order, slots=slots }
end

addProfile("DRUID", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival / bear"),recommendation("scourgeResilience","PRIMARY","healer"),recommendation("scourgeMight","PRIMARY","physical"),recommendation("scourgePower","PRIMARY","Balance")},
    BACK={recommendation("cloakDodge","PRIMARY","bear / survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakAgility","ALTERNATIVE","physical")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","ALTERNATIVE","survival"),recommendation("chestMana","ALTERNATIVE","healer / caster")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStamina","ALTERNATIVE","survival / bear"),recommendation("bracerIntellect","ALTERNATIVE","mana")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesAgility","PRIMARY","physical / bear"),recommendation("glovesAgilityBudget","ALTERNATIVE","budget physical")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","physical")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponIntellect","PRIMARY","mana / hybrid"),recommendation("weaponSpell","PRIMARY","caster pressure"),recommendation("weaponAgility","PRIMARY","physical stat stick")},
    TWO_HAND={recommendation("twoHandAgility","PRIMARY","physical stat stick"),recommendation("weaponIntellect","PRIMARY","mana / healer"),recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","caster pressure")},
})

addProfile("HUNTER", {
    SHOULDERS={recommendation("scourgeMight","PRIMARY","ranged / melee damage"),recommendation("scourgeFortitude","PRIMARY","survival")},
    BACK={recommendation("cloakAgility","PRIMARY","ranged damage"),recommendation("cloakDodge","ALTERNATIVE","avoidance"),recommendation("cloakResistance","ALTERNATIVE","anti-caster")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival"),recommendation("chestMana","ALTERNATIVE","mana")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerIntellect","ALTERNATIVE","mana"),recommendation("bracerMana","ALTERNATIVE","sustain")},
    HANDS={recommendation("glovesAgility","PRIMARY","ranged damage"),recommendation("glovesAgilityBudget","ALTERNATIVE","budget damage")},
    FEET={recommendation("bootsSpeed","PRIMARY","kiting / world PvP"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","ranged damage")},
    ONE_HAND={recommendation("weaponAgility","PRIMARY","ranged stat stick"),recommendation("crusader","ALTERNATIVE","melee set")},
    TWO_HAND={recommendation("twoHandAgility","PRIMARY","ranged stat stick"),recommendation("weaponIntellect","ALTERNATIVE","mana set"),recommendation("crusader","ALTERNATIVE","melee set")},
    RANGED={recommendation("accurateScope","PRIMARY","item-level 20+ bow / gun damage"),recommendation("standardScope","ALTERNATIVE","lower-item-level bow / gun damage")},
})

addProfile("MAGE", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival"),recommendation("scourgePower","PRIMARY","spell damage")},
    BACK={recommendation("cloakDodge","PRIMARY","avoidance"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","balanced"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","mana")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerIntellect","PRIMARY","mana"),recommendation("bracerMana","ALTERNATIVE","sustain")},
    HANDS={recommendation("glovesFrost","PRIMARY","Frost"),recommendation("glovesFire","ALTERNATIVE","Fire")},
    FEET={recommendation("bootsSpeed","PRIMARY","control / mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponIntellect","PRIMARY","mana"),recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
    TWO_HAND={recommendation("weaponIntellect","PRIMARY","mana"),recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
})

addProfile("PALADIN", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival"),recommendation("scourgeResilience","PRIMARY","Holy healer"),recommendation("scourgeMight","PRIMARY","Retribution"),recommendation("scourgePower","ALTERNATIVE","spell damage")},
    BACK={recommendation("cloakDodge","PRIMARY","shield / survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakAgility","ALTERNATIVE","melee")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","healer")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerStrength","PRIMARY","melee")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesStrength","PRIMARY","melee"),recommendation("glovesAgility","ALTERNATIVE","melee / avoidance")},
    FEET={recommendation("bootsSpeed","PRIMARY","support / melee"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","melee")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponIntellect","PRIMARY","healer mana"),recommendation("crusader","PRIMARY","melee")},
    TWO_HAND={recommendation("crusader","PRIMARY","melee burst"),recommendation("twoHandAgility","PRIMARY","reliable melee"),recommendation("weaponHealing","PRIMARY","healer")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","survival"),recommendation("shieldSpirit","ALTERNATIVE","healer sustain"),recommendation("shieldBlock","ALTERNATIVE","block set")},
})

addProfile("PRIEST", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival"),recommendation("scourgeResilience","PRIMARY","healer"),recommendation("scourgePower","PRIMARY","Shadow")},
    BACK={recommendation("cloakDodge","PRIMARY","avoidance"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","balanced"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","healer / support")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerIntellect","ALTERNATIVE","mana")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesShadow","ALTERNATIVE","Shadow")},
    FEET={recommendation("bootsSpeed","PRIMARY","mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Shadow"),recommendation("weaponIntellect","ALTERNATIVE","mana")},
    TWO_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Shadow"),recommendation("weaponIntellect","ALTERNATIVE","mana / support")},
})

addProfile("ROGUE", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival"),recommendation("scourgeMight","PRIMARY","damage")},
    BACK={recommendation("cloakDodge","PRIMARY","survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakAgility","PRIMARY","damage")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerStrength","ALTERNATIVE","burst")},
    HANDS={recommendation("glovesAgility","PRIMARY","damage"),recommendation("glovesStrength","ALTERNATIVE","budget burst")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / mobility"),recommendation("bootsAgility","ALTERNATIVE","damage"),recommendation("bootsStamina","ALTERNATIVE","survival")},
    ONE_HAND={recommendation("weaponAgility","PRIMARY","reliable MH / OH"),recommendation("lifestealing","PRIMARY","main-hand sustain proc"),recommendation("fiery","PRIMARY","main-hand burst proc"),recommendation("crusader","ALTERNATIVE","high-variance burst")},
    RANGED={recommendation("accurateScope","PRIMARY","item-level 20+ bow / gun damage"),recommendation("standardScope","ALTERNATIVE","lower-item-level bow / gun damage")},
})

addProfile("SHAMAN", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival"),recommendation("scourgeResilience","PRIMARY","healer"),recommendation("scourgePower","PRIMARY","Elemental"),recommendation("scourgeMight","PRIMARY","Enhancement")},
    BACK={recommendation("cloakDodge","PRIMARY","shield / survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","healer / caster")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStrength","PRIMARY","Enhancement")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesAgility","PRIMARY","Enhancement"),recommendation("glovesStrength","ALTERNATIVE","Enhancement")},
    FEET={recommendation("bootsSpeed","PRIMARY","support / world PvP"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","Enhancement")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Elemental"),recommendation("weaponIntellect","PRIMARY","caster mana"),recommendation("crusader","PRIMARY","Enhancement")},
    TWO_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Elemental"),recommendation("weaponIntellect","PRIMARY","caster mana"),recommendation("twoHandAgility","PRIMARY","Enhancement staff","Level 19 cannot train two-hand axes or maces")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","survival"),recommendation("shieldSpirit","ALTERNATIVE","healer sustain"),recommendation("shieldBlock","ALTERNATIVE","block set")},
})

addProfile("WARLOCK", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival / Life Tap"),recommendation("scourgePower","PRIMARY","spell damage")},
    BACK={recommendation("cloakDodge","PRIMARY","avoidance"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","balanced"),recommendation("chestHealth","PRIMARY","survival / Life Tap"),recommendation("chestMana","ALTERNATIVE","opening mana")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival / Life Tap"),recommendation("bracerIntellect","ALTERNATIVE","opening mana"),recommendation("bracerMana","ALTERNATIVE","sustain")},
    HANDS={recommendation("glovesShadow","PRIMARY","Affliction / Shadow"),recommendation("glovesFire","ALTERNATIVE","Destruction / Fire")},
    FEET={recommendation("bootsSpeed","PRIMARY","Fear spacing / mobility"),recommendation("bootsStamina","PRIMARY","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","opening mana"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
    TWO_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","opening mana"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
})

addProfile("WARRIOR", {
    SHOULDERS={recommendation("scourgeFortitude","PRIMARY","survival / shield"),recommendation("scourgeMight","PRIMARY","damage")},
    BACK={recommendation("cloakDodge","PRIMARY","survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakAgility","PRIMARY","damage / defense")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival")},
    WRISTS={recommendation("bracerStrength","PRIMARY","burst"),recommendation("bracerStamina","ALTERNATIVE","survival")},
    HANDS={recommendation("glovesAgility","PRIMARY","crit / armor / dodge"),recommendation("glovesStrength","ALTERNATIVE","burst")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / control"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","damage / defense")},
    ONE_HAND={recommendation("lifestealing","PRIMARY","overall pressure / sustain"),recommendation("fiery","PRIMARY","frequent Fire burst proc"),recommendation("crusader","ALTERNATIVE","high-variance Strength proc"),recommendation("superiorStriking","ALTERNATIVE","deterministic weapon damage")},
    TWO_HAND={recommendation("lifestealing","PRIMARY","overall pressure / sustain"),recommendation("fiery","PRIMARY","proc burst; commonly paired with level-19 slow weapons"),recommendation("crusader","PRIMARY","high-variance Strength proc"),recommendation("twoHandImpact","ALTERNATIVE","deterministic slow-weapon burst")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","shield survival"),recommendation("shieldBlock","ALTERNATIVE","block set")},
    RANGED={recommendation("accurateScope","PRIMARY","item-level 20+ bow / gun damage"),recommendation("standardScope","ALTERNATIVE","lower-item-level bow / gun damage")},
})
