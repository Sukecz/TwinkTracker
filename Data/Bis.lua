local addonName, ns = ...

local WOWHEAD_CLASSIC_ITEM_URL = "https://www.wowhead.com/classic/item="

local function item(id, name, note, faction)
    if not faction and note then
        local alliance = string.find(note, "Alliance", 1, true)
        local horde = string.find(note, "Horde", 1, true)
        if alliance and not horde then faction = "ALLIANCE" end
        if horde and not alliance then faction = "HORDE" end
    end
    return { id = id, name = name, note = note, faction = faction, wowhead = id and WOWHEAD_CLASSIC_ITEM_URL .. id or nil }
end

local function tiers(s, a, b)
    local function choices(value)
        if value[1] then
            local result = {}
            for index, entry in ipairs(value) do result[index] = entry end
            return result
        end
        return { value }
    end
    return { S = choices(s), A = choices(a), B = choices(b) }
end

local function copySlots(source)
    local result = {}
    for slot, values in pairs(source) do
        result[slot] = tiers(values.S, values.A, values.B)
    end
    return result
end

local function profile(name, role, base, overrides, extraSlots)
    local slots = copySlots(base)
    for slot, values in pairs(overrides or {}) do slots[slot] = values end
    assert(slots.FINGER_1 and slots.FINGER_2, name .. " requires explicit ring-slot tiers")
    assert(slots.TRINKET_1 and slots.TRINKET_2, name .. " requires explicit trinket-slot tiers")
    slots.FINGER = nil
    slots.TRINKET = nil
    local order = {
        "HEAD", "NECK", "SHOULDERS", "BACK", "CHEST", "WRISTS", "HANDS",
        "WAIST", "LEGS", "FEET", "FINGER_1", "FINGER_2", "TRINKET_1", "TRINKET_2",
    }
    for _, slot in ipairs(extraSlots or {}) do order[#order + 1] = slot end
    return { name = name, role = role, slotOrder = order, slots = slots }
end

-- Bracket-specific gear files reuse the same constructors so faction inference,
-- Wowhead URLs and the explicit two-ring / two-trinket contract cannot drift.
ns.BisHelpers = {
    item = item,
    tiers = tiers,
    profile = profile,
}

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
    WAIST = tiers(item(6468, "Deviate Scale Belt", "Leatherworking staple"), item(16987, "Screecher Belt", "Horde physical quest alternative", "HORDE"), item(2911, "Keller's Girdle", "Hybrid alternative")),
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
    WRISTS = tiers(item(9811, "Fortified Bracers of Strength", "Strength suffix"), item(4534, "Steel-clasped Bracers", "Horde quest alternative"), item(7003, "Beetle Clasps", "Alliance quest alternative")),
    HANDS = tiers(item(12994, "Thorbia's Gauntlets", "Physical staple"), item(6467, "Deviate Scale Gloves", "Leatherworking alternative"), item(6586, "Scouting Gloves of the Monkey", "Agility alternative")),
    WAIST = tiers(item(6460, "Cobrahn's Grasp", "Physical staple"), item(6468, "Deviate Scale Belt", "Leather alternative"), item(16987, "Screecher Belt", "Horde attack-power quest alternative", "HORDE")),
    LEGS = tiers(item(6087, "Chausses of Westfall", "Alliance physical option"), item(10410, "Leggings of the Fang", "Leather alternative"), item(15511, "Grunt's Legguards of the Bear", "Random-suffix option")),
    FINGER = tiers(item(20439, "Protector's Band", "Alliance WSG physical ring"), item(2933, "Seal of Wrynn", "Alliance quest ring"), item(6414, "Seal of Sylvanas", "Horde quest ring")),
}

local staffWeapons = tiers(item(890, "Twisted Chanter's Staff", "Balanced caster weapon"), item(2271, "Staff of the Blessed Seer", "Caster alternative"), item(3415, "Staff of the Friar", "Spirit alternative"))
local physicalOneHand = tiers(item(1482, "Shadowfang", "Premium one-hand"), item(5191, "Cruel Barb", "Dungeon alternative"), item(1935, "Assassin's Blade", "Dagger alternative"))
local casterOneHand = tiers(item(935, "Night Watch Shortsword", "Caster one-hand"), item(2567, "Evocator's Blade", "Caster alternative"), item(3184, "Hook Dagger", "Dagger alternative"))
local physicalTwoHand = tiers(item(5815, "Glacial Stone", "Alliance quest two-hand", "ALLIANCE"), item(1318, "Night Reaver", "Two-hand alternative"), item(3822, "Runic Darkblade", "Horde quest two-hand", "HORDE"))
local shields = tiers(item(12997, "Redbeard Crest", "Premium shield"), item(7002, "Arctic Buckler", "Neutral BFD quest shield"), item(3761, "Deadskull Shield", "Horde quest shield", "HORDE"))
local casterWands = tiers(item(7001, "Gravestone Scepter", "Best damage wand"), item(12984, "Skycaller", "BoE wand alternative"), item(5198, "Cookie's Stirring Rod", "Dungeon wand alternative"))
local casterOffHands = tiers(item(16768, "Furbolg Medicine Pouch", "Premium survival off-hand"), item(5183, "Pulsating Hydra Heart", "Fire damage off-hand"), item(2879, "Antipodean Rod", "Fire / frost off-hand"))
local function noVerified(label)
    return item(nil, "No verified Era " .. label, "No lower recommendation is promoted without Era evidence")
end

local function factionChoices(hordeID, hordeName, allianceID, allianceName, note)
    local choices = {}
    if hordeID then choices[#choices + 1] = item(hordeID, hordeName, "Horde " .. note, "HORDE") end
    if allianceID then choices[#choices + 1] = item(allianceID, allianceName, "Alliance " .. note, "ALLIANCE") end
    return choices
end

local function factionNeck(hordeID, allianceID)
    return tiers(
        factionChoices(hordeID, "Scout's Medallion", allianceID, "Sentinel's Medallion", "WSG neck"),
        item(16009, "Voice Amplification Modulator", "Situational silence-resistance utility"),
        noVerified("neck alternative")
    )
end

local function trinkets(hordeInsigniaID, allianceInsigniaID)
    local insignias = factionChoices(hordeInsigniaID, "Insignia of the Horde", allianceInsigniaID, "Insignia of the Alliance", "class-specific PvP trinket")
    return tiers(
        item(19024, "Arena Grand Master", "Survival trinket"),
        insignias,
        item(4381, "Minor Recombobulator", "Engineering utility")
    )
end

local function secondTrinkets(hordeInsigniaID, allianceInsigniaID)
    return tiers(
        factionChoices(hordeInsigniaID, "Insignia of the Horde", allianceInsigniaID, "Insignia of the Alliance", "class-specific PvP trinket"),
        item(19024, "Arena Grand Master", "Survival trinket"),
        item(4381, "Minor Recombobulator", "Engineering utility")
    )
end

local physicalRingOne = tiers(
    factionChoices(20429, "Legionnaire's Band", 20439, "Protector's Band", "WSG physical ring"),
    factionChoices(6414, "Seal of Sylvanas", 2933, "Seal of Wrynn", "quest ring"),
    { item(4998, "Blood Ring", "Stamina alternative"), item(12006, "Meadow Ring", "Physical random-suffix alternative") }
)
local physicalRingTwo = tiers(physicalRingOne.A, physicalRingOne.S, physicalRingOne.B)
local casterRingOne = tiers(
    factionChoices(20426, "Advisor's Ring", 20431, "Lorekeeper's Ring", "WSG caster ring"),
    factionChoices(6414, "Seal of Sylvanas", 2933, "Seal of Wrynn", "quest ring"),
    { item(1156, "Lavishly Jeweled Ring", "Mana alternative"), item(4998, "Blood Ring", "Stamina alternative") }
)
local casterRingTwo = tiers(casterRingOne.A, casterRingOne.S, casterRingOne.B)

local warriorRings = tiers(
    {
        item(20439, "Protector's Band", "Alliance WSG physical ring", "ALLIANCE"),
        item(20429, "Legionnaire's Band", "Horde WSG physical ring", "HORDE"),
    },
    {
        item(2933, "Seal of Wrynn", "Alliance quest ring", "ALLIANCE"),
        item(6414, "Seal of Sylvanas", "Horde quest ring", "HORDE"),
    },
    { item(4998, "Blood Ring", "Faction-neutral stamina alternative"), item(12006, "Meadow Ring", "Physical random-suffix alternative") }
)

local warriorTwoHand = tiers(
    {
        item(5815, "Glacial Stone", "Alliance quest two-hand", "ALLIANCE"),
        item(3822, "Runic Darkblade", "Horde quest two-hand", "HORDE"),
    },
    {
        item(7230, "Smite's Mighty Hammer", "Era-source-verified high-stat dungeon two-hand"),
        item(1318, "Night Reaver", "Shadow-proc world-drop option"),
    },
    { item(12992, "Searing Blade", "Fire-proc world-drop option"), noVerified("two-hand alternative") }
)

local warriorRanged = tiers(
    {
        item(20437, "Outrider's Bow", "Horde WSG ranged option", "HORDE"),
        item(20438, "Outrunner's Bow", "Alliance WSG ranged option", "ALLIANCE"),
    },
    item(6469, "Venomstrike", "Wailing Caverns bow with poison proc"),
    item(3107, "Keen Throwing Knife", "Faction-neutral thrown fallback")
)

ns.BisData = {
    wowheadClassicItemURL = WOWHEAD_CLASSIC_ITEM_URL,
    slotNames = { HEAD="Head", NECK="Neck", SHOULDERS="Shoulders", BACK="Back", CHEST="Chest", WRISTS="Wrists", HANDS="Hands", WAIST="Waist", LEGS="Legs", FEET="Feet", FINGER_1="Ring 1", FINGER_2="Ring 2", TRINKET_1="Trinket 1", TRINKET_2="Trinket 2", ONE_HAND="1H Weapon", TWO_HAND="2H Weapon", OFF_HAND="Off Hand", RANGED="Ranged / Wand" },
    classOrder = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" },
    classes = {
        DRUID = profile("Druid", "Flag Carrier / Midfield / Healer", leather, {
            NECK = factionNeck(20442,20444),
            SHOULDERS = tiers({item(10657,"Talbar Mantle","Hybrid stamina / mana option"),item(15313,"Feral Shoulder Pads","Bear armor option")},item(5404,"Serpent's Shoulders","Bear armor alternative"),{item(4315,"Reinforced Woolen Shoulders","Crafted armor fallback"),item(4314,"Double-stitched Woolen Shoulders","Budget armor fallback")}),
            BACK = tiers({item(6667,"Engineer's Cloak","Flag-carrier stamina / mana"),item(2059,"Sentry Cloak","Physical all-round option")},factionChoices(20427,"Battle Healer's Cloak",20428,"Caretaker's Cape","WSG healing cloak"),item(12979,"Firebane Cloak","Situational fire resistance")),
            CHEST = tiers({item(10399,"Blackened Defias Armor","Bear / physical survival"),item(1486,"Tree Bark Jacket","Healing / caster survival")},{item(2041,"Tunic of Westfall","Alliance physical quest option","ALLIANCE"),item(14127,"Ritual Shroud of the Eagle","Caster random suffix")},item(6465,"Robe of the Moccasin","Healing fallback")),
            WRISTS = tiers({item(15331,"Wrangler's Wristbands of Stamina","Flag-carrier suffix"),item(15331,"Wrangler's Wristbands of the Eagle","Hybrid suffix")},{item(9768,"Greenweave Bracers of Stamina","Caster survival suffix"),item(9768,"Greenweave Bracers of the Eagle","Caster hybrid suffix")},item(1974,"Mindthrust Bracers","Mana option with stamina penalty")),
            HANDS = tiers({item(6586,"Scouting Gloves of the Eagle","Hybrid suffix"),item(12977,"Magefist Gloves","Healing / caster option")},{item(6586,"Scouting Gloves of the Monkey","Physical survival suffix"),item(14572,"Bristlebark Gloves","Fixed physical stats")},item(14162,"Pagan Mitts of the Eagle","Caster fallback")),
            WAIST = tiers({item(6468,"Deviate Scale Belt","Physical survival"),item(2911,"Keller's Girdle","Caster mana")},item(10412,"Belt of the Fang","Physical fallback"),noVerified("waist alternative")),
            LEGS = tiers({item(6587,"Scouting Trousers of the Eagle","Hybrid suffix"),item(10410,"Leggings of the Fang","Physical survival")},{item(12987,"Darkweave Breeches","Caster survival"),item(10043,"Pious Legwraps","Alliance healing / survival quest","ALLIANCE")},{item(6568,"Shimmering Trousers of the Eagle","Caster fallback"),item(6587,"Scouting Trousers of the Monkey","Physical survival suffix")}),
            FEET = tiers({item(19969,"Nat Pagle's Extreme Anglin' Boots","Flag-carrier stamina"),item(1121,"Feet of the Lynx","Physical mobility")},{item(6335,"Grizzled Boots","Horde stamina quest","HORDE"),item(6582,"Scouting Boots of the Eagle","Flag-carrier intellect / stamina suffix")},{item(6582,"Scouting Boots of Stamina","Maximum-stamina random suffix"),item(6668,"Draftsman Boots","Neutral physical quest"),item(14374,"Sanguine Sandals","Caster stats")}),
            FINGER_1 = tiers(factionChoices(6414,"Seal of Sylvanas",2933,"Seal of Wrynn","quest ring"),{item(4998,"Blood Ring","Flag-carrier stamina"),item(11982,"Viridian Band of the Eagle","Balanced random suffix"),item(1156,"Lavishly Jeweled Ring","Caster mana")},factionChoices(20429,"Legionnaire's Band",20439,"Protector's Band","WSG physical ring")),
            FINGER_2 = tiers(factionChoices(20426,"Advisor's Ring",20431,"Lorekeeper's Ring","WSG caster ring"),{item(4998,"Blood Ring","Flag-carrier stamina"),item(11982,"Viridian Band of the Eagle","Balanced random suffix"),item(1156,"Lavishly Jeweled Ring","Caster mana")},factionChoices(20429,"Legionnaire's Band",20439,"Protector's Band","WSG physical ring")),
            TRINKET_1 = trinkets(18853,18863), TRINKET_2 = secondTrinkets(18853,18863),
            ONE_HAND = tiers({item(1483,"Face Smasher","Flag-carrier stat stick"),item(15223,"Jagged Star of Healing","Healing random suffix")},item(6472,"Stinging Viper","Melee mace"),noVerified("one-hand alternative")),
            TWO_HAND = tiers(factionChoices(20425,"Advisor's Gnarled Staff",20434,"Lorekeeper's Staff","WSG hybrid staff"),{item(890,"Twisted Chanter's Staff","Caster hybrid staff"),item(2271,"Staff of the Blessed Seer","Healing staff")},{item(5201,"Emberstone Staff","Alliance caster quest","ALLIANCE"),item(3415,"Staff of the Friar","Spirit fallback")}),
            OFF_HAND = tiers(item(16768,"Furbolg Medicine Pouch","Flag-carrier stamina off-hand"),item(6341,"Eerie Stable Lantern","Stamina fallback"),noVerified("off-hand alternative")),
        }, { "ONE_HAND", "TWO_HAND", "OFF_HAND" }),
        HUNTER = profile("Hunter", "Ranged Pressure / Defense / Midfield", leather, {
            NECK=factionNeck(20442,20444),
            SHOULDERS=tiers(item(10657,"Talbar Mantle","Stamina / mana option"),item(15313,"Feral Shoulder Pads","Armor-only alternative"),item(5404,"Serpent's Shoulders","Armor-only fallback")),
            BACK=tiers(item(2059,"Sentry Cloak","Agility and stamina"),{item(6449,"Glowing Lizardscale Cloak","Agility pressure"),item(6667,"Engineer's Cloak","Stamina / mana")},item(12979,"Firebane Cloak","Situational fire resistance")),
            CHEST=tiers({item(2041,"Tunic of Westfall","Alliance ranged-pressure quest","ALLIANCE"),item(10399,"Blackened Defias Armor","Neutral stamina alternative")},item(1486,"Tree Bark Jacket","Stamina / mana fallback"),noVerified("chest alternative")),
            WRISTS=tiers({item(15331,"Wrangler's Wristbands of the Monkey","Agility / stamina suffix"),item(15331,"Wrangler's Wristbands of the Falcon","Agility / intellect suffix")},{item(3202,"Forest Leather Bracers","Fixed agility"),item(15331,"Wrangler's Wristbands of Stamina","Stamina suffix")},{item(15331,"Wrangler's Wristbands of Agility","Pure agility suffix"),item(15331,"Wrangler's Wristbands of the Eagle","Stamina / intellect suffix")}),
            HANDS=tiers({item(6586,"Scouting Gloves of the Monkey","Agility / stamina suffix"),item(6586,"Scouting Gloves of the Falcon","Agility / intellect suffix")},{item(15115,"Rigid Gloves of the Monkey","Budget agility / stamina suffix"),item(14572,"Bristlebark Gloves","Fixed physical stats")},item(15115,"Rigid Gloves of the Falcon","Budget agility / intellect suffix")),
            WAIST=tiers(item(6468,"Deviate Scale Belt","Ranged-pressure survival"),item(16987,"Screecher Belt","Horde attack power / mana quest","HORDE"),item(2911,"Keller's Girdle","Mana fallback")),
            LEGS=tiers(item(10410,"Leggings of the Fang","Agility / stamina"),{item(6587,"Scouting Trousers of the Monkey","Agility / stamina suffix"),item(6587,"Scouting Trousers of the Falcon","Agility / intellect suffix")},item(12987,"Darkweave Breeches","Stamina / mana fallback")),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(1121,"Feet of the Lynx","Agility pressure"),item(10653,"Trailblazer Boots","Horde agility / stamina quest","HORDE")},{item(6335,"Grizzled Boots","Horde stamina quest","HORDE"),item(6668,"Draftsman Boots","Neutral physical quest")}),
            FINGER_1=tiers({item(12006,"Meadow Ring of the Monkey","Agility / stamina random suffix"),item(12006,"Meadow Ring of the Falcon","Agility / intellect random suffix")},factionChoices(20429,"Legionnaire's Band",20439,"Protector's Band","WSG physical ring"),{item(4998,"Blood Ring","Stamina alternative"),item(1156,"Lavishly Jeweled Ring","Mana alternative")}),FINGER_2=physicalRingTwo,
            TRINKET_1=trinkets(18846,18856),TRINKET_2=secondTrinkets(18846,18856),
            ONE_HAND=tiers(factionChoices(20441,"Scout's Blade",20443,"Sentinel's Blade","WSG agility weapon"),{item(6504,"Wingblade","Horde agility quest weapon","HORDE"),item(5191,"Cruel Barb","Attack-power alternative")},item(1935,"Assassin's Blade","Dagger fallback")),
            TWO_HAND=tiers(item(890,"Twisted Chanter's Staff","Primary agility-enchant stat stick"),item(15269,"Massive Battle Axe of the Monkey","Physical random-suffix stat stick"),{item(3415,"Staff of the Friar","Spirit fallback"),item(1318,"Night Reaver","Melee proc fallback")}),
            OFF_HAND=tiers(item(16768,"Furbolg Medicine Pouch","Stamina off-hand"),item(6341,"Eerie Stable Lantern","Stamina fallback"),noVerified("off-hand alternative")),
            RANGED=tiers({item(6469,"Venomstrike","Poison-proc pressure"),item(3742,"Bow of Plunder","Horde shot-pressure quest bow","HORDE")},factionChoices(20437,"Outrider's Bow",20438,"Outrunner's Bow","WSG bow"),{item(13136,"Lil Timmy's Peashooter","Neutral ranged fallback"),item(4372,"Lovingly Crafted Boomstick","Crafted gun fallback")}),
        }, { "ONE_HAND", "TWO_HAND", "OFF_HAND", "RANGED" }),
        MAGE = profile("Mage", "Control / Midfield / Burst", caster, {
            NECK=factionNeck(20442,20444),
            SHOULDERS=tiers(item(10657,"Talbar Mantle","Stamina and mana"),item(4315,"Reinforced Woolen Shoulders","Crafted mana alternative"),item(4314,"Double-stitched Woolen Shoulders","Budget crafted fallback")),
            BACK=tiers(item(6667,"Engineer's Cloak","Control / survival"),factionChoices(20427,"Battle Healer's Cloak",20428,"Caretaker's Cape","WSG caster cloak"),{item(14179,"Watcher's Cape of Frozen Wrath","Frost-damage suffix"),item(14179,"Watcher's Cape of Fiery Wrath","Fire-damage suffix")}),
            CHEST=tiers(item(1486,"Tree Bark Jacket","Control / survival"),item(6465,"Robe of the Moccasin","Mana / survival alternative"),{item(14127,"Ritual Shroud of Frozen Wrath","Frost-damage suffix"),item(14127,"Ritual Shroud of Stamina","Survival suffix")}),
            WRISTS=tiers({item(1974,"Mindthrust Bracers","Maximum mana with stamina penalty"),item(9768,"Greenweave Bracers of the Eagle","Balanced control suffix")},{item(9768,"Greenweave Bracers of Frozen Wrath","Frost-damage suffix"),item(9768,"Greenweave Bracers of Fiery Wrath","Fire-damage suffix")},item(3647,"Bright Bracers","Budget mana fallback")),
            HANDS=tiers(item(12977,"Magefist Gloves","Balanced caster stats"),{item(892,"Gnoll Casting Gloves","General spell-damage alternative"),item(14162,"Pagan Mitts of Fiery Wrath","Fire-damage suffix")},item(14162,"Pagan Mitts of the Eagle","Balanced fallback suffix")),
            WAIST=tiers({item(2911,"Keller's Girdle","Mana / survival"),item(9766,"Greenweave Sash of the Eagle","Balanced control suffix")},item(9766,"Greenweave Sash of Fiery Wrath","Fire-damage suffix"),item(6539,"Willow Belt of the Eagle","Budget cloth suffix")),
            LEGS=tiers(item(12987,"Darkweave Breeches","Control / survival"),{item(6568,"Shimmering Trousers of Fiery Wrath","Fire-damage suffix"),item(6568,"Shimmering Trousers of the Eagle","Balanced suffix")},noVerified("leg alternative")),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(14374,"Sanguine Sandals","Balanced caster stats"),item(9767,"Greenweave Sandals of the Eagle","Balanced suffix")},item(9767,"Greenweave Sandals of Frozen Wrath","Frost-damage suffix")),
            FINGER_1=tiers(casterRingOne.S,casterRingOne.A,{item(11982,"Viridian Band of the Eagle","Balanced random suffix"),item(1156,"Lavishly Jeweled Ring","Mana alternative"),item(4998,"Blood Ring","Stamina alternative")}),FINGER_2=tiers(casterRingTwo.S,casterRingTwo.A,{item(11982,"Viridian Band of the Eagle","Balanced random suffix"),item(1156,"Lavishly Jeweled Ring","Mana alternative"),item(4998,"Blood Ring","Stamina alternative")}),
            TRINKET_1=trinkets(18850,18859),TRINKET_2=secondTrinkets(18850,18859),
            ONE_HAND=tiers({item(935,"Night Watch Shortsword","Stamina control weapon"),item(3184,"Hook Dagger of Frozen Wrath","Frost-damage suffix")},{item(2567,"Evocator's Blade","Mana alternative"),item(3184,"Hook Dagger of Fiery Wrath","Fire-damage suffix")},item(3184,"Hook Dagger of Stamina","Survival suffix fallback")),
            TWO_HAND=staffWeapons,
            OFF_HAND=tiers({item(16768,"Furbolg Medicine Pouch","Survival off-hand"),item(5183,"Pulsating Hydra Heart","Fire-damage off-hand")},item(2879,"Antipodean Rod","Fire / frost damage off-hand"),noVerified("off-hand for two-hand setup")),
            RANGED=tiers(item(7001,"Gravestone Scepter","Neutral BFD quest wand; Alliance and Horde quest routes"),{item(12984,"Skycaller","Neutral BoE wand"),item(5198,"Cookie's Stirring Rod","Neutral dungeon wand")},noVerified("wand alternative")),
        }, {"ONE_HAND","TWO_HAND","OFF_HAND","RANGED"}),
        PALADIN = profile("Paladin", "Support / Defense / Melee", melee, {
            NECK=factionNeck(nil,20444),
            SHOULDERS=tiers({item(10657,"Talbar Mantle","Healer / support stamina"),item(6579,"Defender Spaulders","Melee / shield armor")},item(15313,"Feral Shoulder Pads","Armor fallback"),{item(4315,"Reinforced Woolen Shoulders","Healer fallback"),item(5404,"Serpent's Shoulders","Melee fallback")}),
            BACK=tiers({item(20428,"Caretaker's Cape","Alliance WSG healer cloak","ALLIANCE"),item(2059,"Sentry Cloak","Melee survival")},{item(6667,"Engineer's Cloak","Hybrid survival"),item(6449,"Glowing Lizardscale Cloak","Melee agility")},item(12979,"Firebane Cloak","Situational fire resistance")),
            CHEST=tiers({item(10399,"Blackened Defias Armor","Melee stats"),item(1486,"Tree Bark Jacket","Healer survival")},{item(2041,"Tunic of Westfall","Alliance melee quest","ALLIANCE"),item(6465,"Robe of the Moccasin","Healer alternative")},item(6580,"Defender Tunic of the Eagle","Hybrid random suffix")),
            WRISTS=tiers({item(7003,"Beetle Clasps","Alliance survival quest","ALLIANCE"),item(1974,"Mindthrust Bracers","Healer mana")},{item(9811,"Fortified Bracers of the Eagle","Healer random suffix"),item(9811,"Fortified Bracers of the Bear","Melee random suffix")},item(15331,"Wrangler's Wristbands of Stamina","Survival fallback")),
            HANDS=tiers({item(6577,"Defender Gauntlets of the Eagle","Healer random suffix"),item(12994,"Thorbia's Gauntlets","Melee stats")},{item(12977,"Magefist Gloves","Healer alternative"),item(6467,"Deviate Scale Gloves","Melee alternative")},{item(6577,"Defender Gauntlets of the Bear","Melee survival suffix"),item(6586,"Scouting Gloves of the Monkey","Leather fallback")}),
            WAIST=tiers({item(9814,"Fortified Belt of the Eagle","Healer random suffix"),item(6460,"Cobrahn's Grasp","Melee damage")},{item(2911,"Keller's Girdle","Healer mana"),item(9814,"Fortified Belt of the Bear","Melee survival suffix")},item(6468,"Deviate Scale Belt","Physical fallback")),
            LEGS=tiers({item(15511,"Grunt's Legguards of the Eagle","Healer random suffix"),item(6087,"Chausses of Westfall","Alliance melee quest","ALLIANCE")},{item(12987,"Darkweave Breeches","Healer stats"),item(10410,"Leggings of the Fang","Melee survival")},{item(4800,"Mighty Chain Pants","Fixed mail fallback"),item(15511,"Grunt's Legguards of the Bear","Melee random suffix")}),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(12982,"Silver-linked Footguards","Melee survival"),item(14374,"Sanguine Sandals","Healer stats")},{item(6573,"Defender Boots of the Eagle","Healer random suffix"),item(6573,"Defender Boots of the Bear","Melee random suffix")}),
            FINGER_1=tiers({item(20431,"Lorekeeper's Ring","Alliance WSG caster ring","ALLIANCE"),item(20439,"Protector's Band","Alliance WSG physical ring","ALLIANCE")},item(2933,"Seal of Wrynn","Alliance quest ring","ALLIANCE"),{item(1156,"Lavishly Jeweled Ring","Healer mana"),item(4998,"Blood Ring","Survival")}),
            FINGER_2=tiers(item(2933,"Seal of Wrynn","Alliance quest ring","ALLIANCE"),{item(20431,"Lorekeeper's Ring","Alliance WSG caster ring","ALLIANCE"),item(20439,"Protector's Band","Alliance WSG physical ring","ALLIANCE")},{item(1156,"Lavishly Jeweled Ring","Healer mana"),item(4998,"Blood Ring","Survival")}),
            TRINKET_1=trinkets(nil,18864),TRINKET_2=secondTrinkets(nil,18864),
            ONE_HAND=tiers({item(790,"Forester's Axe of the Eagle","Healer random suffix; maximum roll needs live / AH validation"),item(1482,"Shadowfang","Melee proc weapon")},{item(935,"Night Watch Shortsword","Stamina healer weapon"),item(5191,"Cruel Barb","Melee alternative"),item(20440,"Protector's Sword","Alliance Revered WSG physical weapon","ALLIANCE")},item(1483,"Face Smasher","Melee survival fallback")),
            TWO_HAND=tiers({item(5815,"Glacial Stone","Alliance quest burst weapon","ALLIANCE"),item(7230,"Smite's Mighty Hammer","High-stat dungeon alternative")},{item(1318,"Night Reaver","Shadow-proc alternative"),item(12992,"Searing Blade","Fire-proc alternative")},noVerified("Alliance two-hand alternative")),
            OFF_HAND=tiers({item(7002,"Arctic Buckler","Neutral high-armor BFD quest"),item(12997,"Redbeard Crest","Damage / survival shield")},{item(13245,"Kresh's Back","Dungeon shield"),item(6572,"Defender Shield of Stamina","Random-suffix shield")},noVerified("shield alternative")),
        }, {"ONE_HAND","TWO_HAND","OFF_HAND"}),
        PRIEST = profile("Priest", "Healer / Support / Shadow", caster, {
            HEAD=tiers(item(19972,"Lucky Fishing Hat","Survival"),{item(4385,"Green Tinted Goggles","Survival Engineering"),item(4373,"Shadow Goggles","Healer Engineering")},noVerified("head alternative")),
            NECK=factionNeck(20442,20444),
            SHOULDERS=tiers(item(10657,"Talbar Mantle","Caster stamina / mana"),{item(3324,"Ghostly Mantle","Horde intellect / spirit quest option","HORDE"),item(4315,"Reinforced Woolen Shoulders","Crafted armor fallback")},item(4314,"Double-stitched Woolen Shoulders","Budget fallback")),
            BACK=tiers(factionChoices(20427,"Battle Healer's Cloak",20428,"Caretaker's Cape","WSG healing cloak"),item(6667,"Engineer's Cloak","Survival / mana"),item(12979,"Firebane Cloak","Situational fire resistance")),
            CHEST=tiers(item(1486,"Tree Bark Jacket","Healing / survival"),item(14127,"Ritual Shroud of Shadow Wrath","Shadow-damage suffix"),item(6465,"Robe of the Moccasin","Spirit fallback")),
            WRISTS=tiers({item(1974,"Mindthrust Bracers","Mana with stamina penalty"),item(9768,"Greenweave Bracers of the Eagle","Balanced support suffix")},item(9768,"Greenweave Bracers of Stamina","Survival suffix"),item(9768,"Greenweave Bracers of Shadow Wrath","Shadow-damage suffix")),
            HANDS=tiers({item(12977,"Magefist Gloves","Healer support"),item(892,"Gnoll Casting Gloves","General spell damage")},{item(10654,"Jutebraid Gloves","Horde intellect-focused quest option","HORDE"),item(14162,"Pagan Mitts of the Eagle","Balanced support suffix")},item(14162,"Pagan Mitts of Healing","Healing-power suffix")),
            WAIST=tiers(item(2911,"Keller's Girdle","Healer mana"),{item(9766,"Greenweave Sash of the Eagle","Balanced support suffix"),item(9766,"Greenweave Sash of Healing","Healing-power suffix")},{item(14173,"Buccaneer's Cord of the Eagle","Budget caster suffix"),item(14131,"Ritual Belt of Healing","Healing-power suffix")}),
            LEGS=tiers({item(12987,"Darkweave Breeches","Healer support"),item(10043,"Pious Legwraps","Alliance healing quest","ALLIANCE")},{item(6568,"Shimmering Trousers of the Eagle","Balanced support suffix"),item(6568,"Shimmering Trousers of Healing","Healing-power suffix")},{item(6282,"Sacred Burial Trousers","Horde level-19 quest-chain spirit set; plan XP before turn-ins","HORDE"),item(14125,"Ritual Leggings of the Eagle","Budget support suffix"),item(14125,"Ritual Leggings of Healing","Healing-power fallback")}),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(14374,"Sanguine Sandals","Balanced support"),item(9767,"Greenweave Sandals of the Eagle","Balanced suffix")},{item(9767,"Greenweave Sandals of Stamina","Survival suffix"),item(9767,"Greenweave Sandals of Shadow Wrath","Shadow-damage suffix")}),
            FINGER_1=casterRingOne,FINGER_2=casterRingTwo,
            TRINKET_1=trinkets(18851,18862),TRINKET_2=secondTrinkets(18851,18862),
            ONE_HAND=tiers({item(2567,"Evocator's Blade","Mana support"),item(15223,"Jagged Star of Healing","Healing random suffix")},{item(3184,"Hook Dagger of Stamina","Survival suffix"),item(3184,"Hook Dagger of Healing","Healing-power suffix")},noVerified("one-hand alternative")),
            TWO_HAND=tiers({item(2271,"Staff of the Blessed Seer","Healing staff"),item(890,"Twisted Chanter's Staff","Survival / mana staff")},{item(6505,"Crescent Staff","Horde balanced stamina / intellect / spirit quest staff","HORDE"),item(20425,"Advisor's Gnarled Staff","Horde WSG caster staff","HORDE"),item(20434,"Lorekeeper's Staff","Alliance WSG caster staff","ALLIANCE")},{item(3415,"Staff of the Friar","Spirit fallback"),item(5201,"Emberstone Staff","Alliance caster quest","ALLIANCE")}),
            OFF_HAND=tiers(item(16768,"Furbolg Medicine Pouch","Survival off-hand"),item(6341,"Eerie Stable Lantern","Stamina fallback"),item(1131,"Totem of Infliction","Alliance armor / retaliation quest","ALLIANCE")),
            RANGED=tiers(item(7001,"Gravestone Scepter","Neutral BFD shadow wand"),item(5198,"Cookie's Stirring Rod","Dungeon wand alternative"),item(12984,"Skycaller","BoE wand fallback")),
        }, {"ONE_HAND","TWO_HAND","OFF_HAND","RANGED"}),
        ROGUE = profile("Rogue", "Burst / Flag Return / Defense", leather, {
            NECK=factionNeck(20442,20444),
            SHOULDERS=tiers({item(15313,"Feral Shoulder Pads","Best-armor white tradeable base for a Naxx shoulder enchant"),item(5404,"Serpent's Shoulders","White tradeable Wailing Caverns base for a Naxx shoulder enchant")},item(10657,"Talbar Mantle","Best no-Naxx stamina option; BoP prevents trade-applied Naxx enchants"),noVerified("shoulder fallback without a Naxx enchant")),
            BACK=tiers(item(2059,"Sentry Cloak","Agility and stamina"),{item(6449,"Glowing Lizardscale Cloak","Pure agility"),item(6667,"Engineer's Cloak","Stamina fallback")},item(12979,"Firebane Cloak","Situational fire resistance")),
            CHEST=tiers({item(2041,"Tunic of Westfall","Alliance burst quest","ALLIANCE"),item(10399,"Blackened Defias Armor","Neutral stamina alternative")},item(1486,"Tree Bark Jacket","Stamina fallback"),noVerified("chest alternative")),
            WRISTS=tiers({item(15331,"Wrangler's Wristbands of the Monkey","Agility / stamina suffix"),item(3202,"Forest Leather Bracers","Fixed agility")},{item(15331,"Wrangler's Wristbands of Stamina","Stamina suffix"),item(15331,"Wrangler's Wristbands of Agility","Agility suffix")},noVerified("wrist alternative")),
            HANDS=tiers({item(6586,"Scouting Gloves of the Monkey","Agility / stamina suffix"),item(14572,"Bristlebark Gloves","Fixed physical stats")},{item(15115,"Rigid Gloves of the Monkey","Budget agility / stamina"),item(6586,"Scouting Gloves of Agility","Pure agility suffix")},item(15115,"Rigid Gloves of Agility","Budget agility suffix")),
            WAIST=tiers(item(6468,"Deviate Scale Belt","Burst / survival"),{item(14567,"Bristlebark Belt","Agility / stamina"),item(16987,"Screecher Belt","Horde attack power / stamina quest","HORDE")},{item(10412,"Belt of the Fang","Balanced fallback"),item(10403,"Blackened Defias Belt","Strength / set fallback")}),
            LEGS=tiers(item(10410,"Leggings of the Fang","Agility / stamina"),{item(6587,"Scouting Trousers of the Monkey","Agility / stamina suffix"),item(6587,"Scouting Trousers of Agility","Pure agility suffix")},noVerified("leg alternative")),
            FEET=tiers({item(1121,"Feet of the Lynx","Burst: 3 Strength and 8 Agility"),item(19969,"Nat Pagle's Extreme Anglin' Boots","Flag carrier: 12 Stamina"),item(10653,"Trailblazer Boots","Horde balanced: 7 Agility and 3 Stamina","HORDE")},{item(6335,"Grizzled Boots","Horde stamina quest","HORDE"),item(6668,"Draftsman Boots","Neutral physical quest")},item(6582,"Scouting Boots of the Monkey","Budget suffix")),
            FINGER_1=physicalRingOne,FINGER_2=physicalRingTwo,
            TRINKET_1=trinkets(18849,18857),TRINKET_2=secondTrinkets(18849,18857),
            ONE_HAND=tiers({item(1482,"Shadowfang","Sword burst / proc"),item(1935,"Assassin's Blade","Dagger ambush / backstab")},{item(5191,"Cruel Barb","Slow sword / attack power"),item(6472,"Stinging Viper","Proc alternative")},{item(6504,"Wingblade","Horde balanced quest sword","HORDE"),item(935,"Night Watch Shortsword","Stamina sword")}),
            OFF_HAND=tiers({item(5191,"Cruel Barb","Attack-power off-hand"),item(1935,"Assassin's Blade","Fast stat dagger")},factionChoices(20441,"Scout's Blade",20443,"Sentinel's Blade","WSG agility off-hand"),{item(5192,"Thief's Blade","Fast budget off-hand"),item(1482,"Shadowfang","Dual-sword proc option")}),
            RANGED=tiers(factionChoices(20437,"Outrider's Bow",20438,"Outrunner's Bow","Best Rogue ranged DPS; WSG faction equivalent"),{item(6469,"Venomstrike","Lower base DPS with a situational ranged poison proc"),item(13136,"Lil Timmy's Peashooter","Reliable BoE gun alternative")},{item(3107,"Keen Throwing Knife","Accessible thrown fallback"),item(4372,"Lovingly Crafted Boomstick","Crafted gun fallback")}),
        }, {"ONE_HAND","OFF_HAND","RANGED"}),
        SHAMAN = profile("Shaman", "Melee / Healer / Elemental Support", leather, {
            NECK=factionNeck(20442,nil),
            SHOULDERS=tiers({item(10657,"Talbar Mantle","Healer / elemental stamina"),item(15313,"Feral Shoulder Pads","Melee armor")},item(5404,"Serpent's Shoulders","Melee armor fallback"),{item(4315,"Reinforced Woolen Shoulders","Caster fallback"),item(4314,"Double-stitched Woolen Shoulders","Budget fallback")}),
            BACK=tiers({item(20427,"Battle Healer's Cloak","Horde WSG healer cloak","HORDE"),item(2059,"Sentry Cloak","Melee survival")},{item(6667,"Engineer's Cloak","Hybrid survival"),item(14179,"Watcher's Cape of the Eagle","Balanced elemental suffix; maximum roll needs live / AH validation")},{item(14179,"Watcher's Cape of Healing","Healing-power suffix; maximum roll needs live / AH validation"),item(12979,"Firebane Cloak","Situational resistance")}),
            CHEST=tiers({item(1486,"Tree Bark Jacket","Healer / elemental survival"),item(10399,"Blackened Defias Armor","Melee stats")},item(6465,"Robe of the Moccasin","Caster alternative"),{item(14127,"Ritual Shroud of the Eagle","Balanced elemental / healer suffix; maximum roll needs live / AH validation"),item(14562,"Prospector's Chestpiece","Fixed agility / stamina melee fallback")}),
            WRISTS=tiers({item(15331,"Wrangler's Wristbands of the Eagle","Healer / elemental suffix"),item(15331,"Wrangler's Wristbands of Stamina","Survival suffix")},{item(1974,"Mindthrust Bracers","Mana with stamina penalty"),item(15331,"Wrangler's Wristbands of Nature's Wrath","Nature-damage suffix; maximum roll needs live / AH validation")},{item(15331,"Wrangler's Wristbands of the Monkey","Melee suffix"),item(9768,"Greenweave Bracers of the Eagle","Caster fallback")}),
            HANDS=tiers({item(6586,"Scouting Gloves of the Eagle","Healer / elemental suffix"),item(14572,"Bristlebark Gloves","Melee stats")},{item(12977,"Magefist Gloves","Caster alternative"),item(6586,"Scouting Gloves of the Monkey","Melee survival suffix")},{item(6586,"Scouting Gloves of Healing","Healing-power suffix; maximum roll needs live / AH validation"),item(6467,"Deviate Scale Gloves","Melee fallback")}),
            WAIST=tiers({item(2911,"Keller's Girdle","Caster mana"),item(6468,"Deviate Scale Belt","Melee survival")},{item(9766,"Greenweave Sash of Healing","Healing-power suffix; maximum roll needs live / AH validation"),item(15329,"Wrangler's Belt of the Eagle","Leather hybrid suffix")},{item(16987,"Screecher Belt","Horde attack power / stamina quest","HORDE"),item(6460,"Cobrahn's Grasp","Melee damage")}),
            LEGS=tiers({item(6587,"Scouting Trousers of the Eagle","Healer / elemental suffix"),item(10410,"Leggings of the Fang","Melee survival")},{item(12987,"Darkweave Breeches","Caster stats"),item(6587,"Scouting Trousers of the Monkey","Melee suffix")},item(6587,"Scouting Trousers of Healing","Healing-power suffix; maximum roll needs live / AH validation")),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(1121,"Feet of the Lynx","Melee agility"),item(14374,"Sanguine Sandals","Caster stats")},{item(9767,"Greenweave Sandals of the Eagle","Caster suffix"),item(6335,"Grizzled Boots","Horde stamina quest","HORDE")}),
            FINGER_1=tiers({item(20426,"Advisor's Ring","Horde WSG caster ring","HORDE"),item(20429,"Legionnaire's Band","Horde WSG physical ring","HORDE")},item(6414,"Seal of Sylvanas","Horde survival quest ring","HORDE"),{item(1156,"Lavishly Jeweled Ring","Caster mana"),item(4998,"Blood Ring","Survival")}),
            FINGER_2=tiers(item(6414,"Seal of Sylvanas","Horde survival quest ring","HORDE"),{item(20426,"Advisor's Ring","Horde WSG caster ring","HORDE"),item(20429,"Legionnaire's Band","Horde WSG physical ring","HORDE")},{item(1156,"Lavishly Jeweled Ring","Caster mana"),item(4998,"Blood Ring","Survival")}),
            TRINKET_1=trinkets(18845,nil),TRINKET_2=secondTrinkets(18845,nil),
            ONE_HAND=tiers({item(15223,"Jagged Star of Healing","Healing random suffix"),item(2567,"Evocator's Blade","Elemental mana dagger")},{item(6472,"Stinging Viper","Melee mace"),item(790,"Forester's Axe of the Eagle","Elemental random suffix")},{item(1483,"Face Smasher","Melee survival"),item(790,"Forester's Axe of the Bear","Melee random suffix")}),
            TWO_HAND=tiers({item(2271,"Staff of the Blessed Seer","Healing staff"),item(890,"Twisted Chanter's Staff","Balanced caster staff")},{item(3415,"Staff of the Friar","Spirit staff"),item(6505,"Crescent Staff","Horde hybrid quest staff","HORDE")},noVerified("staff alternative; level 19 cannot train two-hand axes or maces")),
            OFF_HAND=tiers({item(3761,"Deadskull Shield","Horde survival quest shield","HORDE"),item(16768,"Furbolg Medicine Pouch","Caster survival off-hand")},{item(12997,"Redbeard Crest","Melee shield"),item(2879,"Antipodean Rod","Elemental fire / frost off-hand")},{item(5183,"Pulsating Hydra Heart","Fire-damage off-hand"),item(13245,"Kresh's Back","Budget shield")}),
        }, {"ONE_HAND","TWO_HAND","OFF_HAND"}),
        WARLOCK = profile("Warlock", "Survival / Shadow Pressure / Control", caster, {
            HEAD=tiers(item(19972,"Lucky Fishing Hat","Stamina survival"),{item(4385,"Green Tinted Goggles","Stamina Engineering"),item(4373,"Shadow Goggles","Mana Engineering")},noVerified("head alternative")),
            NECK=factionNeck(20442,20444),
            SHOULDERS=tiers(item(10657,"Talbar Mantle","Stamina / mana"),item(4315,"Reinforced Woolen Shoulders","Crafted armor fallback"),item(4314,"Double-stitched Woolen Shoulders","Budget fallback")),
            BACK=tiers({item(6667,"Engineer's Cloak","Survival / mana"),item(14179,"Watcher's Cape of Shadow Wrath","Shadow-damage suffix; maximum roll needs live / AH validation")},item(12979,"Firebane Cloak","Situational fire resistance"),item(5444,"Miner's Cape","Guide-supported accessible stamina fallback")),
            CHEST=tiers({item(1486,"Tree Bark Jacket","Stamina / mana"),item(14127,"Ritual Shroud of Shadow Wrath","Shadow-damage suffix")},{item(14127,"Ritual Shroud of Stamina","Survival suffix"),item(14127,"Ritual Shroud of the Eagle","Balanced suffix")},item(6465,"Robe of the Moccasin","Spirit fallback")),
            WRISTS=tiers({item(9768,"Greenweave Bracers of Stamina","Survival suffix"),item(9768,"Greenweave Bracers of Shadow Wrath","Shadow-damage suffix")},{item(9768,"Greenweave Bracers of the Eagle","Balanced suffix"),item(1974,"Mindthrust Bracers","Mana with stamina penalty")},noVerified("wrist alternative")),
            HANDS=tiers({item(12977,"Magefist Gloves","Survival / mana"),item(892,"Gnoll Casting Gloves","General spell damage")},{item(14162,"Pagan Mitts of the Eagle","Balanced suffix; maximum roll needs live / AH validation"),item(14162,"Pagan Mitts of Fiery Wrath","Fire-pressure suffix; maximum roll needs live / AH validation")},noVerified("glove fallback")),
            WAIST=tiers(item(2911,"Keller's Girdle","Survival / mana"),{item(9766,"Greenweave Sash of the Eagle","Balanced suffix; maximum roll needs live / AH validation"),item(9766,"Greenweave Sash of the Whale","Stamina / spirit suffix; maximum roll needs live / AH validation")},item(14173,"Buccaneer's Cord of the Eagle","Budget balanced suffix; maximum roll needs live / AH validation")),
            LEGS=tiers({item(12987,"Darkweave Breeches","Stamina / mana"),item(10043,"Pious Legwraps","Alliance survival quest","ALLIANCE")},{item(6568,"Shimmering Trousers of the Eagle","Balanced suffix; maximum roll needs live / AH validation"),item(6568,"Shimmering Trousers of the Whale","Stamina / spirit suffix; maximum roll needs live / AH validation")},item(14125,"Ritual Leggings of the Eagle","Budget balanced suffix; maximum roll needs live / AH validation")),
            FEET=tiers(item(19969,"Nat Pagle's Extreme Anglin' Boots","Maximum stamina"),{item(14374,"Sanguine Sandals","Balanced caster stats"),item(9767,"Greenweave Sandals of Stamina","Survival suffix")},{item(9767,"Greenweave Sandals of Shadow Wrath","Shadow-damage suffix"),item(9767,"Greenweave Sandals of the Eagle","Mana suffix")}),
            FINGER_1=casterRingOne,FINGER_2=casterRingTwo,
            TRINKET_1=trinkets(18852,18858),TRINKET_2=secondTrinkets(18852,18858),
            ONE_HAND=tiers(item(935,"Night Watch Shortsword","Stamina weapon"),{item(2567,"Evocator's Blade","Mana weapon"),item(3184,"Hook Dagger of Stamina","Survival suffix; maximum roll needs live / AH validation")},noVerified("one-hand fallback")),
            TWO_HAND=tiers({item(1484,"Witching Stave","Shadow-damage staff"),item(890,"Twisted Chanter's Staff","Stamina / mana staff")},item(3415,"Staff of the Friar","Spirit staff"),noVerified("two-hand alternative")),
            OFF_HAND=tiers(item(16768,"Furbolg Medicine Pouch","Maximum stamina off-hand"),{item(6341,"Eerie Stable Lantern","Stamina fallback"),item(5183,"Pulsating Hydra Heart","Fire-damage niche")},item(1131,"Totem of Infliction","Alliance armor / retaliation quest","ALLIANCE")),
            RANGED=tiers(item(7001,"Gravestone Scepter","Neutral BFD shadow wand"),item(5198,"Cookie's Stirring Rod","Dungeon wand alternative"),item(12984,"Skycaller","BoE wand fallback")),
        }, {"ONE_HAND","TWO_HAND","OFF_HAND","RANGED"}),
        WARRIOR = profile("Warrior", "Frontline / Defense / Flag Carrier", melee, {
            NECK = tiers(
                {
                    item(20444, "Sentinel's Medallion", "Alliance WSG neck", "ALLIANCE"),
                    item(20442, "Scout's Medallion", "Horde WSG neck", "HORDE"),
                },
                item(nil, "No verified Era Tier A neck", "The faction WSG medallion is the competitive level-19 choice"),
                item(nil, "No verified Era Tier B neck", "No lower recommendation is promoted without Era evidence")
            ),
            SHOULDERS = tiers(
                {
                    item(6579, "Defender Spaulders", "High-armor world-drop option"),
                    item(10657, "Talbar Mantle", "Stamina and utility quest option"),
                },
                item(6189, "Durable Chain Shoulders", "Alliance high-armor quest option", "ALLIANCE"),
                item(3480, "Rough Bronze Shoulders", "Crafted mail fallback")
            ),
            BACK = tiers(
                item(2059, "Sentry Cloak", "Agility and stamina all-round option"),
                {
                    item(15526, "Sentry's Cape of Strength", "Damage-focused random suffix"),
                    item(6449, "Glowing Lizardscale Cloak", "Agility-focused dungeon option"),
                },
                item(12979, "Firebane Cloak", "Fire-resistance situational option")
            ),
            WRISTS = tiers(
                {
                    item(7003, "Beetle Clasps", "Alliance agility and stamina quest bracers", "ALLIANCE"),
                    item(4534, "Steel-clasped Bracers", "Horde stamina quest bracers", "HORDE"),
                },
                item(9811, "Fortified Bracers of Strength", "Damage-focused random suffix"),
                item(9811, "Fortified Bracers of the Bear", "Strength and stamina random suffix")
            ),
            WAIST = tiers(
                {
                    item(6460, "Cobrahn's Grasp", "Damage-focused strength and agility option"),
                    item(9814, "Fortified Belt of the Bear", "Balanced strength and stamina option"),
                },
                item(6468, "Deviate Scale Belt", "Agility and stamina leather alternative"),
                item(16987, "Screecher Belt", "Horde attack power and stamina quest", "HORDE")
            ),
            LEGS = tiers(
                {
                    item(6087, "Chausses of Westfall", "Alliance strength and stamina quest legs", "ALLIANCE"),
                    item(15511, "Grunt's Legguards of the Bear", "Strength and stamina random suffix"),
                },
                {
                    item(4800, "Mighty Chain Pants", "Fixed strength and stamina mail option"),
                    item(10410, "Leggings of the Fang", "Agility and stamina leather option"),
                },
                item(15511, "Grunt's Legguards of Strength", "Damage-focused random suffix")
            ),
            FEET = tiers(
                {
                    item(19969, "Nat Pagle's Extreme Anglin' Boots", "Maximum-stamina fishing reward"),
                    item(12982, "Silver-linked Footguards", "Strength and stamina mail option"),
                },
                item(1121, "Feet of the Lynx", "Strength and agility world drop"),
                item(6668, "Draftsman Boots", "Neutral accessible quest alternative")
            ),
            FINGER_1 = warriorRings,
            FINGER_2 = tiers(warriorRings.A, warriorRings.S, warriorRings.B),
            TRINKET_1 = trinkets(18834,18854),
            TRINKET_2 = secondTrinkets(18834,18854),
            ONE_HAND = tiers(
                item(1482, "Shadowfang", "Highest-value one-hand proc weapon"),
                item(5191, "Cruel Barb", "Strong Deadmines sword alternative"),
                item(1483, "Face Smasher", "Slow mace fallback")
            ),
            TWO_HAND = warriorTwoHand,
            OFF_HAND = tiers(
                {
                    item(12997, "Redbeard Crest", "Damage and survival shield"),
                    item(7002, "Arctic Buckler", "Neutral high-armor BFD quest shield"),
                },
                {
                    item(3761, "Deadskull Shield", "Horde stamina quest shield", "HORDE"),
                    item(13245, "Kresh's Back", "Dungeon defense shield"),
                },
                noVerified("shield alternative")
            ),
            RANGED = warriorRanged,
        }, {"ONE_HAND","TWO_HAND","OFF_HAND","RANGED"}),
    },
    sources = {
        "Supplied Horde/Alliance Classic Era workbook", "Wowhead Classic level-19 class guides",
        "Jamesb's 19 Vanilla Gearing Guide (XPOff)", "Warcraft Tavern Classic level-19 class guides",
    },
}
