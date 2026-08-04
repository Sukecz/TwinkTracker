local addonName, ns = ...

local function item(id, name, note)
    return { id = id, name = name, note = note }
end

local function tiers(s, a, b)
    return { S = s, A = a, B = b }
end

local function copySlots(source)
    local result = {}
    for slot, values in pairs(source) do
        result[slot] = { S = values.S, A = values.A, B = values.B }
    end
    return result
end

local function profile(name, role, base, overrides, extraSlots)
    local slots = copySlots(base)
    for slot, values in pairs(overrides or {}) do slots[slot] = values end
    slots.FINGER_1 = slots.FINGER
    slots.FINGER_2 = tiers(slots.FINGER.A, slots.FINGER.B, slots.FINGER.S)
    slots.TRINKET_1 = slots.TRINKET
    slots.TRINKET_2 = tiers(slots.TRINKET.A, slots.TRINKET.B, slots.TRINKET.S)
    slots.FINGER = nil
    slots.TRINKET = nil
    local order = {
        "HEAD", "NECK", "SHOULDERS", "BACK", "CHEST", "WRISTS", "HANDS",
        "WAIST", "LEGS", "FEET", "FINGER_1", "FINGER_2", "TRINKET_1", "TRINKET_2", "WEAPON",
    }
    for _, slot in ipairs(extraSlots or {}) do order[#order + 1] = slot end
    return { name = name, role = role, slotOrder = order, slots = slots }
end

local common = {
    HEAD = tiers(
        item(19972, "Lucky Fishing Hat", "Best-in-slot fishing reward"),
        item(4385, "Green Tinted Goggles", "Engineering alternative"),
        item(4373, "Shadow Goggles", "Budget Engineering option")
    ),
    NECK = tiers(
        item(20444, "Sentinel's Medallion", "Alliance • Honored Warsong Gulch"),
        item(20442, "Scout's Medallion", "Horde • Honored Warsong Gulch"),
        item(nil, "No verified Era alternative", "The faction WSG medallion is the competitive level-19 choice")
    ),
    FEET = tiers(
        item(19969, "Nat Pagle's Extreme Anglin' Boots", "Fishing event reward"),
        item(1121, "Feet of the Lynx", "World-drop mobility option"),
        item(6668, "Draftsman Boots", "Accessible alternative")
    ),
    TRINKET = tiers(
        item(19024, "Arena Grand Master", "Premium survival trinket"),
        item(4381, "Minor Recombobulator", "Engineering utility"),
        item(nil, "PvP Insignia", "Use the class-specific Alliance or Horde insignia")
    ),
}

local leather = {
    HEAD = common.HEAD, NECK = common.NECK, FEET = common.FEET, TRINKET = common.TRINKET,
    SHOULDERS = tiers(item(15313, "Feral Shoulder Pads", "Stamina-focused leather"), item(10657, "Talbar Mantle", "Dungeon quest alternative"), item(5404, "Serpent's Shoulders", "Wailing Caverns alternative")),
    BACK = tiers(item(2059, "Sentry Cloak", "Strong all-round cloak"), item(6667, "Engineer's Cloak", "Engineering alternative"), item(12979, "Firebane Cloak", "Resistance alternative")),
    CHEST = tiers(item(10399, "Blackened Defias Armor", "Physical build staple"), item(2041, "Tunic of Westfall", "Alliance quest alternative"), item(1486, "Tree Bark Jacket", "Hybrid survival option")),
    WRISTS = tiers(item(15331, "Wrangler's Wristbands of the Monkey", "Agility / stamina suffix"), item(15331, "Wrangler's Wristbands of Stamina", "Maximum stamina suffix"), item(1974, "Mindthrust Bracers", "Hybrid alternative")),
    HANDS = tiers(item(6586, "Scouting Gloves of the Monkey", "Agility / stamina suffix"), item(14572, "Bristlebark Gloves", "Strong fixed-stat alternative"), item(6586, "Scouting Gloves of the Eagle", "Hybrid suffix")),
    WAIST = tiers(item(6468, "Deviate Scale Belt", "Leatherworking staple"), item(16987, "Screecher Belt", "Physical alternative"), item(2911, "Keller's Girdle", "Hybrid alternative")),
    LEGS = tiers(item(10410, "Leggings of the Fang", "Physical leather staple"), item(6587, "Scouting Trousers of the Monkey", "Random-suffix alternative"), item(12987, "Darkweave Breeches", "Hybrid alternative")),
    FINGER = tiers(item(20429, "Legionnaire's Band", "Horde WSG physical ring"), item(2933, "Seal of Wrynn", "Alliance quest ring"), item(6414, "Seal of Sylvanas", "Horde quest ring")),
}

local caster = {
    HEAD = common.HEAD, NECK = common.NECK, FEET = common.FEET, TRINKET = common.TRINKET,
    SHOULDERS = tiers(item(4315, "Reinforced Woolen Shoulders", "Crafted cloth staple"), item(10657, "Talbar Mantle", "Dungeon quest alternative"), item(4314, "Double-stitched Woolen Shoulders", "Budget crafted option")),
    BACK = tiers(item(20427, "Battle Healer's Cloak", "WSG healing / stamina option"), item(6667, "Engineer's Cloak", "Engineering alternative"), item(12979, "Firebane Cloak", "Survival / resistance option")),
    CHEST = tiers(item(1486, "Tree Bark Jacket", "Caster survival staple"), item(14127, "Ritual Shroud of Shadow Wrath", "Damage suffix option"), item(6465, "Robe of the Moccasin", "Dungeon alternative")),
    WRISTS = tiers(item(1974, "Mindthrust Bracers", "Caster staple"), item(9768, "Greenweave Bracers of Stamina", "Survival suffix"), item(9768, "Greenweave Bracers of the Eagle", "Intellect / stamina suffix")),
    HANDS = tiers(item(12977, "Magefist Gloves", "Caster staple"), item(892, "Gnoll Casting Gloves", "Spell-focused alternative"), item(14162, "Pagan Mitts of the Eagle", "Random-suffix alternative")),
    WAIST = tiers(item(2911, "Keller's Girdle", "Caster staple"), item(6460, "Cobrahn's Grasp", "Hybrid alternative"), item(6468, "Deviate Scale Belt", "Survival alternative")),
    LEGS = tiers(item(12987, "Darkweave Breeches", "Caster staple"), item(10043, "Pious Legwraps", "Healing / survival option"), item(6568, "Shimmering Trousers of the Eagle", "Random-suffix alternative")),
    FINGER = tiers(item(20426, "Advisor's Ring", "Horde WSG caster ring"), item(20431, "Lorekeeper's Ring", "Alliance WSG caster ring"), item(2933, "Seal of Wrynn", "Alliance quest alternative")),
}

local melee = {
    HEAD = common.HEAD, NECK = common.NECK, FEET = common.FEET, TRINKET = common.TRINKET,
    SHOULDERS = tiers(item(6579, "Defender Spaulders", "Mail physical staple"), item(5404, "Serpent's Shoulders", "Leather alternative"), item(10657, "Talbar Mantle", "Quest alternative")),
    BACK = tiers(item(15526, "Sentry's Cape of Strength", "Strength suffix"), item(2059, "Sentry Cloak", "All-round alternative"), item(12979, "Firebane Cloak", "Survival alternative")),
    CHEST = tiers(item(10399, "Blackened Defias Armor", "Physical build staple"), item(2041, "Tunic of Westfall", "Alliance quest alternative"), item(1486, "Tree Bark Jacket", "Survival alternative")),
    WRISTS = tiers(item(9811, "Fortified Bracers of Strength", "Strength suffix"), item(4534, "Steel-clasped Bracers", "Fixed-stat alternative"), item(7003, "Beetle Clasps", "Quest alternative")),
    HANDS = tiers(item(12994, "Thorbia's Gauntlets", "Physical staple"), item(6467, "Deviate Scale Gloves", "Leatherworking alternative"), item(6586, "Scouting Gloves of the Monkey", "Agility alternative")),
    WAIST = tiers(item(6460, "Cobrahn's Grasp", "Physical staple"), item(6468, "Deviate Scale Belt", "Leather alternative"), item(16987, "Screecher Belt", "Agility alternative")),
    LEGS = tiers(item(6087, "Chausses of Westfall", "Alliance physical option"), item(10410, "Leggings of the Fang", "Leather alternative"), item(15511, "Grunt's Legguards of the Bear", "Random-suffix option")),
    FINGER = tiers(item(20439, "Protector's Band", "Alliance WSG physical ring"), item(2933, "Seal of Wrynn", "Alliance quest ring"), item(6414, "Seal of Sylvanas", "Horde quest ring")),
}

local staffWeapons = tiers(item(890, "Twisted Chanter's Staff", "Balanced caster weapon"), item(2271, "Staff of the Blessed Seer", "Caster alternative"), item(3415, "Staff of the Friar", "Spirit alternative"))
local physicalOneHand = tiers(item(1482, "Shadowfang", "Premium one-hand"), item(5191, "Cruel Barb", "Dungeon alternative"), item(1935, "Assassin's Blade", "Dagger alternative"))
local shields = tiers(item(12997, "Redbeard Crest", "Premium shield"), item(7002, "Arctic Buckler", "Quest shield"), item(3761, "Deadskull Shield", "Horde quest shield"))
local function trinkets(insigniaID, faction)
    return tiers(item(19024, "Arena Grand Master", "Premium survival trinket"), item(4381, "Minor Recombobulator", "Engineering utility"), item(insigniaID, "Insignia of the " .. faction, faction .. " class-specific PvP trinket"))
end

ns.BisData = {
    slotNames = { HEAD="Head", NECK="Neck", SHOULDERS="Shoulders", BACK="Back", CHEST="Chest", WRISTS="Wrists", HANDS="Hands", WAIST="Waist", LEGS="Legs", FEET="Feet", FINGER_1="Ring 1", FINGER_2="Ring 2", TRINKET_1="Trinket 1", TRINKET_2="Trinket 2", WEAPON="Weapon", OFF_HAND="Off Hand", RANGED="Ranged / Wand" },
    classOrder = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" },
    classes = {
        DRUID = profile("Druid", "Flag Carrier / Midfield / Healer", leather, {
            TRINKET = trinkets(18853, "Horde"),
            BACK = tiers(item(12979, "Firebane Cloak", "Flag carrier survival"), item(20427, "Battle Healer's Cloak", "Healing alternative"), item(2059, "Sentry Cloak", "Physical alternative")),
            WEAPON = tiers(item(1483, "Face Smasher", "Flag carrier one-hand"), item(890, "Twisted Chanter's Staff", "Midfield caster option"), item(2271, "Staff of the Blessed Seer", "Healing option")),
            OFF_HAND = tiers(item(16768, "Furbolg Medicine Pouch", "Premium survival off-hand"), item(7001, "Gravestone Scepter", "Caster utility option"), item(nil, "Two-hand weapon setup", "No off-hand equipped")),
        }, { "OFF_HAND" }),
        HUNTER = profile("Hunter", "Ranged Pressure / Defense / Midfield", leather, {
            TRINKET = trinkets(18846, "Horde"),
            WEAPON = tiers(item(890, "Twisted Chanter's Staff", "Balanced melee stat stick"), item(3415, "Staff of the Friar", "Spirit alternative"), item(6504, "Wingblade", "One-hand alternative")),
            RANGED = tiers(item(6469, "Venomstrike", "Wailing Caverns ranged staple"), item(2825, "Bow of Searing Arrows", "World-drop alternative"), item(3021, "Ranger Bow", "Budget ranged option")),
        }, { "RANGED" }),
        MAGE = profile("Mage", "Control / Midfield / Burst", caster, { TRINKET=trinkets(18850,"Horde"), WEAPON=staffWeapons, RANGED=tiers(item(7001,"Gravestone Scepter","Wand staple"),item(5183,"Antipodean Rod","Elemental alternative"),item(2567,"Evocator's Blade","One-hand swap option")) }, {"RANGED"}),
        PALADIN = profile("Paladin", "Support / Defense / Melee", melee, { TRINKET=trinkets(18864,"Alliance"), WEAPON=tiers(item(1482,"Shadowfang","One-hand support setup"),item(5815,"Glacial Stone","Two-hand damage option"),item(1318,"Night Reaver","Two-hand alternative")), OFF_HAND=shields }, {"OFF_HAND"}),
        PRIEST = profile("Priest", "Healer / Support / Shadow", caster, { TRINKET=trinkets(18851,"Horde"), WEAPON=tiers(item(15223,"Jagged Star of Healing","Healing one-hand"),item(890,"Twisted Chanter's Staff","Balanced staff"),item(2271,"Staff of the Blessed Seer","Caster alternative")), OFF_HAND=tiers(item(16768,"Furbolg Medicine Pouch","Survival off-hand"),item(7001,"Gravestone Scepter","Caster alternative"),item(nil,"Two-hand weapon setup","No off-hand equipped")), RANGED=tiers(item(7001,"Gravestone Scepter","Wand staple"),item(2567,"Evocator's Blade","Weapon swap alternative"),item(3415,"Staff of the Friar","Spirit swap")) }, {"OFF_HAND","RANGED"}),
        ROGUE = profile("Rogue", "Burst / Flag Return / Defense", leather, { TRINKET=trinkets(18849,"Horde"), WEAPON=physicalOneHand, OFF_HAND=tiers(item(1935,"Assassin's Blade","Premium off-hand dagger"),item(5191,"Cruel Barb","Sword alternative"),item(1482,"Shadowfang","Premium dual-sword option")), RANGED=tiers(item(3107,"Keen Throwing Knife","Thrown weapon staple"),item(20437,"Outrider's Bow","Horde WSG alternative"),item(20438,"Outrunner's Bow","Alliance WSG alternative")) }, {"OFF_HAND","RANGED"}),
        SHAMAN = profile("Shaman", "Midfield / Support / Melee", leather, { TRINKET=trinkets(18845,"Horde"), WEAPON=tiers(item(2567,"Evocator's Blade","Caster one-hand"),item(1482,"Shadowfang","Physical one-hand"),item(890,"Twisted Chanter's Staff","Two-hand caster option")), OFF_HAND=shields }, {"OFF_HAND"}),
        WARLOCK = profile("Warlock", "Survival / Shadow Pressure / Control", caster, { TRINKET=trinkets(18852,"Horde"), WEAPON=tiers(item(890,"Twisted Chanter's Staff","Balanced caster weapon"),item(1484,"Witching Stave","Shadow-focused alternative"),item(3415,"Staff of the Friar","Spirit alternative")), RANGED=tiers(item(7001,"Gravestone Scepter","Wand staple"),item(5183,"Antipodean Rod","Damage alternative"),item(2567,"Evocator's Blade","Weapon swap alternative")) }, {"RANGED"}),
        WARRIOR = profile("Warrior", "Frontline / Defense / Flag Carrier", melee, { TRINKET=trinkets(18834,"Horde"), WEAPON=tiers(item(5815,"Glacial Stone","Two-hand pressure"),item(1318,"Night Reaver","Two-hand alternative"),item(1482,"Shadowfang","One-hand setup")), OFF_HAND=shields, RANGED=tiers(item(3107,"Keen Throwing Knife","Thrown weapon staple"),item(20437,"Outrider's Bow","Horde WSG alternative"),item(20438,"Outrunner's Bow","Alliance WSG alternative")) }, {"OFF_HAND","RANGED"}),
    },
    sources = {
        "Supplied Horde/Alliance Classic Era workbook", "Wowhead Classic level-19 class guides",
        "Jamesb's 19 Vanilla Gearing Guide (XPOff)", "Warcraft Tavern Classic level-19 class guides",
    },
}
