local addonName, ns = ...

-- Shared metadata is defined once. Class profiles only add priority and role
-- context, preventing names, effects and Wowhead links from drifting.
local catalog = {
    arcanumConstitution = { name="Lesser Arcanum of Constitution", effect="100 Health", itemID=11642, restrictions="HEAD/LEGS; high-level Libram quest and application through another character; verify on Firemaw" },
    arcanumVoracityStrength = { name="Lesser Arcanum of Voracity - Strength", effect="8 Strength", itemID=11646, restrictions="HEAD/LEGS; choose Strength at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumVoracityAgility = { name="Lesser Arcanum of Voracity - Agility", effect="8 Agility", itemID=11646, restrictions="HEAD/LEGS; choose Agility at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumVoracityIntellect = { name="Lesser Arcanum of Voracity - Intellect", effect="8 Intellect", itemID=11646, restrictions="HEAD/LEGS; choose Intellect at the high-level Libram turn-in; verify application on Firemaw" },
    arcanumFocus = { name="Arcanum of Focus", effect="8 healing and spell damage", itemID=18330, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
    arcanumProtection = { name="Arcanum of Protection", effect="1% Dodge", itemID=18331, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
    arcanumRapidity = { name="Arcanum of Rapidity", effect="1% Haste", itemID=18329, restrictions="HEAD/LEGS; high-level Dire Maul Libram turn-in; verify application on Firemaw" },
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
    legsArmor = { name="Medium Armor Kit", effect="16 Armor", itemID=2313, restrictions="Requires level 5" },
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
    version = "2026-08-08",
    slotOrder = { "HEAD", "BACK", "CHEST", "WRISTS", "HANDS", "LEGS", "FEET", "ONE_HAND", "TWO_HAND", "OFF_HAND", "RANGED" },
    catalog = catalog,
    classes = {},
}

local function recommendation(key, priority, roles, note)
    return { key=key, priority=priority, roles=roles, note=note }
end

local libramProfiles = {
    DRUID={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","physical / bear"),recommendation("arcanumFocus","PRIMARY","caster / healer")},
    HUNTER={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","ranged damage"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
    MAGE={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","spell damage"),recommendation("arcanumVoracityIntellect","PRIMARY","mana")},
    PALADIN={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Holy"),recommendation("arcanumVoracityStrength","PRIMARY","melee")},
    PRIEST={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Shadow"),recommendation("arcanumVoracityIntellect","PRIMARY","mana")},
    ROGUE={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityAgility","PRIMARY","damage"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
    SHAMAN={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumFocus","PRIMARY","healer / Elemental"),recommendation("arcanumVoracityStrength","PRIMARY","Enhancement")},
    WARLOCK={recommendation("arcanumConstitution","PRIMARY","survival / Life Tap"),recommendation("arcanumFocus","PRIMARY","spell damage"),recommendation("arcanumVoracityIntellect","PRIMARY","opening mana")},
    WARRIOR={recommendation("arcanumConstitution","PRIMARY","survival"),recommendation("arcanumVoracityStrength","PRIMARY","burst"),recommendation("arcanumRapidity","ALTERNATIVE","attack speed")},
}

local function addProfile(classToken, slots)
    slots.HEAD = libramProfiles[classToken]
    slots.LEGS = libramProfiles[classToken]
    local order = {}
    for _, slot in ipairs(ns.EnchantsData.slotOrder) do
        if slots[slot] and #slots[slot] > 0 then
            local top = {}
            for index=1,math.min(3,#slots[slot]) do top[index] = slots[slot][index] end
            slots[slot] = top
            order[#order+1] = slot
        end
    end
    ns.EnchantsData.classes[classToken] = { slotOrder=order, slots=slots }
end

addProfile("DRUID", {
    BACK={recommendation("cloakResistance","PRIMARY","survival / healer"),recommendation("cloakDodge","ALTERNATIVE","bear / survival"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakAgility","ALTERNATIVE","physical")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","ALTERNATIVE","survival"),recommendation("chestMana","ALTERNATIVE","healer / caster")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStamina","ALTERNATIVE","survival / bear"),recommendation("bracerIntellect","ALTERNATIVE","mana"),recommendation("bracerSpirit","ALTERNATIVE","regeneration")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesAgility","PRIMARY","physical / bear"),recommendation("glovesAgilityBudget","ALTERNATIVE","budget physical")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","physical"),recommendation("bootsSpirit","ALTERNATIVE","healer regeneration")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponIntellect","PRIMARY","mana / hybrid"),recommendation("weaponSpell","ALTERNATIVE","caster pressure")},
    TWO_HAND={recommendation("twoHandAgility","PRIMARY","physical stat stick"),recommendation("weaponIntellect","PRIMARY","mana / healer"),recommendation("weaponHealing","ALTERNATIVE","healer")},
})

addProfile("HUNTER", {
    BACK={recommendation("cloakAgility","PRIMARY","ranged damage"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDodge","ALTERNATIVE","avoidance"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival"),recommendation("chestMana","ALTERNATIVE","mana")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerIntellect","ALTERNATIVE","mana"),recommendation("bracerStrength","ALTERNATIVE","melee set")},
    HANDS={recommendation("glovesAgility","PRIMARY","ranged damage"),recommendation("glovesAgilityBudget","ALTERNATIVE","budget damage")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","kiting / world PvP"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","ranged damage")},
    ONE_HAND={recommendation("weaponAgility","PRIMARY","ranged stat stick"),recommendation("crusader","ALTERNATIVE","melee set")},
    TWO_HAND={recommendation("twoHandAgility","PRIMARY","ranged stat stick"),recommendation("weaponIntellect","ALTERNATIVE","mana set"),recommendation("crusader","ALTERNATIVE","melee set")},
    RANGED={recommendation("standardScope","PRIMARY","bow / gun damage","Accurate and Sniper scopes exceed the clean level-19 requirement")},
})

addProfile("MAGE", {
    BACK={recommendation("cloakResistance","PRIMARY","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakDodge","ALTERNATIVE","avoidance")},
    CHEST={recommendation("chestMana","PRIMARY","mana"),recommendation("chestHealth","ALTERNATIVE","survival"),recommendation("chestStats","ALTERNATIVE","balanced")},
    WRISTS={recommendation("bracerIntellect","PRIMARY","mana"),recommendation("bracerMana","ALTERNATIVE","sustain"),recommendation("bracerStamina","ALTERNATIVE","survival"),recommendation("bracerSpirit","ALTERNATIVE","regeneration")},
    HANDS={recommendation("glovesFrost","PRIMARY","Frost"),recommendation("glovesFire","ALTERNATIVE","Fire")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","control / mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","mana"),recommendation("wintersMight","ALTERNATIVE","Frost budget"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
    TWO_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","mana"),recommendation("twoHandIntellect","ALTERNATIVE","budget mana"),recommendation("wintersMight","ALTERNATIVE","Frost budget")},
})

addProfile("PALADIN", {
    BACK={recommendation("cloakDodge","PRIMARY","shield / survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakAgility","ALTERNATIVE","melee")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","healer")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStrength","PRIMARY","melee"),recommendation("bracerStamina","ALTERNATIVE","survival"),recommendation("bracerIntellect","ALTERNATIVE","mana")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesStrength","PRIMARY","melee"),recommendation("glovesAgility","ALTERNATIVE","melee / avoidance")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","support / melee"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","melee")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponIntellect","PRIMARY","healer mana"),recommendation("crusader","PRIMARY","melee"),recommendation("fiery","ALTERNATIVE","frequent proc burst")},
    TWO_HAND={recommendation("crusader","PRIMARY","melee burst"),recommendation("fiery","PRIMARY","proc burst"),recommendation("twoHandImpact","ALTERNATIVE","deterministic melee damage"),recommendation("weaponIntellect","ALTERNATIVE","healer mana")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","survival"),recommendation("shieldSpirit","ALTERNATIVE","healer sustain"),recommendation("shieldBlock","ALTERNATIVE","block set")},
})

addProfile("PRIEST", {
    BACK={recommendation("cloakResistance","PRIMARY","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakDodge","ALTERNATIVE","avoidance")},
    CHEST={recommendation("chestMana","PRIMARY","healer / support"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestStats","ALTERNATIVE","balanced")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerIntellect","ALTERNATIVE","mana"),recommendation("bracerMana","ALTERNATIVE","sustain")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesShadow","ALTERNATIVE","Shadow")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","mobility"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Shadow"),recommendation("weaponIntellect","ALTERNATIVE","mana"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
    TWO_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Shadow"),recommendation("weaponIntellect","ALTERNATIVE","mana / support"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
})

addProfile("ROGUE", {
    BACK={recommendation("cloakAgility","PRIMARY","damage"),recommendation("cloakDodge","ALTERNATIVE","survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival"),recommendation("bracerStrength","ALTERNATIVE","burst")},
    HANDS={recommendation("glovesAgility","PRIMARY","damage"),recommendation("glovesStrength","ALTERNATIVE","budget burst")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / mobility"),recommendation("bootsAgility","ALTERNATIVE","damage"),recommendation("bootsStamina","ALTERNATIVE","survival")},
    ONE_HAND={recommendation("weaponAgility","PRIMARY","reliable MH / OH"),recommendation("superiorStriking","PRIMARY","main-hand weapon attacks"),recommendation("lifestealing","ALTERNATIVE","main-hand sustain proc"),recommendation("fiery","ALTERNATIVE","main-hand burst proc"),recommendation("crusader","ALTERNATIVE","high-variance burst")},
    RANGED={recommendation("standardScope","PRIMARY","bow / gun damage")},
})

addProfile("SHAMAN", {
    BACK={recommendation("cloakDodge","PRIMARY","shield / survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakAgility","ALTERNATIVE","Enhancement")},
    CHEST={recommendation("chestStats","PRIMARY","hybrid"),recommendation("chestHealth","PRIMARY","survival"),recommendation("chestMana","ALTERNATIVE","healer / caster")},
    WRISTS={recommendation("bracerHealing","PRIMARY","healer"),recommendation("bracerStrength","PRIMARY","Enhancement"),recommendation("bracerStamina","ALTERNATIVE","survival"),recommendation("bracerIntellect","ALTERNATIVE","caster")},
    HANDS={recommendation("glovesHealing","PRIMARY","healer"),recommendation("glovesAgility","PRIMARY","Enhancement"),recommendation("glovesStrength","ALTERNATIVE","Enhancement")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","support / world PvP"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","Enhancement"),recommendation("bootsSpirit","ALTERNATIVE","healer sustain")},
    ONE_HAND={recommendation("weaponHealing","PRIMARY","healer"),recommendation("weaponSpell","PRIMARY","Elemental"),recommendation("weaponIntellect","ALTERNATIVE","caster mana"),recommendation("crusader","ALTERNATIVE","Enhancement"),recommendation("fiery","ALTERNATIVE","Enhancement burst")},
    TWO_HAND={recommendation("weaponIntellect","PRIMARY","caster / healer"),recommendation("twoHandAgility","PRIMARY","Enhancement staff","Level 19 cannot train two-hand axes or maces"),recommendation("weaponHealing","ALTERNATIVE","healer"),recommendation("twoHandImpact","ALTERNATIVE","staff melee")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","survival"),recommendation("shieldSpirit","ALTERNATIVE","healer sustain"),recommendation("shieldBlock","ALTERNATIVE","block set")},
})

addProfile("WARLOCK", {
    BACK={recommendation("cloakResistance","PRIMARY","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival"),recommendation("cloakDodge","ALTERNATIVE","avoidance")},
    CHEST={recommendation("chestHealth","PRIMARY","survival / Life Tap"),recommendation("chestStats","PRIMARY","balanced"),recommendation("chestMana","ALTERNATIVE","opening mana")},
    WRISTS={recommendation("bracerStamina","PRIMARY","survival / Life Tap"),recommendation("bracerIntellect","ALTERNATIVE","opening mana"),recommendation("bracerMana","ALTERNATIVE","sustain")},
    HANDS={recommendation("glovesShadow","PRIMARY","Affliction / Shadow"),recommendation("glovesFire","ALTERNATIVE","Destruction / Fire")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","Fear spacing / mobility"),recommendation("bootsStamina","PRIMARY","survival"),recommendation("bootsSpirit","ALTERNATIVE","regeneration")},
    ONE_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","opening mana"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
    TWO_HAND={recommendation("weaponSpell","PRIMARY","spell pressure"),recommendation("weaponIntellect","PRIMARY","opening mana"),recommendation("twoHandIntellect","ALTERNATIVE","budget mana"),recommendation("weaponSpirit","ALTERNATIVE","regeneration")},
})

addProfile("WARRIOR", {
    BACK={recommendation("cloakAgility","PRIMARY","damage / defense"),recommendation("cloakDodge","ALTERNATIVE","survival"),recommendation("cloakResistance","ALTERNATIVE","anti-caster"),recommendation("cloakDefense","ALTERNATIVE","physical survival")},
    CHEST={recommendation("chestStats","PRIMARY","damage / survival"),recommendation("chestHealth","ALTERNATIVE","survival")},
    WRISTS={recommendation("bracerStrength","PRIMARY","burst"),recommendation("bracerStamina","ALTERNATIVE","survival")},
    HANDS={recommendation("glovesAgility","PRIMARY","crit / armor / dodge"),recommendation("glovesStrength","ALTERNATIVE","burst")},
    LEGS={recommendation("legsArmor","ALTERNATIVE","reproducible armor option")},
    FEET={recommendation("bootsSpeed","PRIMARY","world PvP / control"),recommendation("bootsStamina","ALTERNATIVE","survival"),recommendation("bootsAgility","ALTERNATIVE","damage / defense")},
    ONE_HAND={recommendation("lifestealing","PRIMARY","overall pressure / sustain"),recommendation("fiery","PRIMARY","frequent Fire burst proc"),recommendation("crusader","ALTERNATIVE","high-variance Strength proc"),recommendation("superiorStriking","ALTERNATIVE","deterministic weapon damage"),recommendation("weaponAgility","ALTERNATIVE","reliable crit / defense"),recommendation("icyChill","ALTERNATIVE","control proc")},
    TWO_HAND={recommendation("fiery","PRIMARY","proc burst; commonly paired with level-19 slow weapons"),recommendation("crusader","PRIMARY","high-variance Strength proc"),recommendation("twoHandImpact","ALTERNATIVE","deterministic slow-weapon burst"),recommendation("twoHandAgility","ALTERNATIVE","reliable crit / defense"),recommendation("lifestealing","ALTERNATIVE","pressure / sustain"),recommendation("icyChill","ALTERNATIVE","control proc")},
    OFF_HAND={recommendation("shieldStamina","PRIMARY","shield survival"),recommendation("shieldBlock","ALTERNATIVE","block set"),recommendation("shieldSpirit","ALTERNATIVE","regeneration")},
    RANGED={recommendation("standardScope","PRIMARY","bow / gun damage")},
})
