local addonName, ns = ...

local TBC = ns.TBCData
local item = TBC.item
local tiers = TBC.tiers

local wowheadDruid19 = "https://www.wowhead.com/tbc/guide/tbc-classic-level-19-twink-druid-bis-guide-14166"
local xpoffHunter19 = "https://xpoff.com/threads/tbc-19-hunter-checklist.96778/"
local wowheadHunter19 = "https://www.wowhead.com/tbc/guide/hunter-classic-level-19-twink"
local wowheadMage19 = "https://www.wowhead.com/classic/guide/mage-classic-level-19-twink"
local wowheadTBCItems = "https://www.wowhead.com/tbc/items"
local xpoff39Audit = "https://xpoff.com/threads/working-on-a-39-tbc-bis-list.95784/"

TBC:AuditClass(19, "DRUID", {
    sources = {
        wowheadDruid19,
        "https://www.wowhead.com/tbc/item=6319/girdle-of-the-blindwatcher",
        "https://www.wowhead.com/tbc/item=5970/serpent-gloves",
        "https://www.wowhead.com/tbc/item=22984/dawnblade",
        "https://www.wowhead.com/tbc/item=5187/rhahkzors-hammer",
    },
    note = "All Era S/A/B choices were checked against the TBC 2.5.6 guide and TBC item tooltips. TBC dungeon-item upgrades and new Ghostlands access materially change five slots; leg and weapon enchants are audited separately.",
    slots = {
        BACK = tiers(
            { item(5444, "Miner's Cape", "TBC 2.3 stamina upgrade; neutral dungeon survival option"), item(2059, "Sentry Cloak", "Agility and stamina alternative") },
            { item(6667, "Engineer's Cloak", "Flag-carrier stamina / mana"), item(22990, "Tranquillien Champion's Cloak", "Horde-only Exalted Tranquillien survival cloak; plan Ghostlands reputation XP", "HORDE") },
            item(12979, "Firebane Cloak", "Situational fire resistance")
        ),
        HANDS = tiers(
            { item(5970, "Serpent Gloves", "TBC 2.3 caster upgrade; intellect and spell damage"), item(5195, "Gold-flecked Gloves", "Alliance Deadmines caster equivalent") },
            { item(10654, "Jutebraid Gloves", "Alliance quest caster alternative", "ALLIANCE"), item(12977, "Magefist Gloves", "Balanced Restoration stats") },
            item(6586, "Scouting Gloves of the Eagle", "Feral / flag-carrier intellect and stamina suffix")
        ),
        WAIST = tiers(
            item(6319, "Girdle of the Blindwatcher", "TBC 2.3 upgrade; level-19 leather belt with stamina and intellect"),
            { item(6468, "Deviate Scale Belt", "Feral physical alternative"), item(2911, "Keller's Girdle", "Cloth mana alternative") },
            item(10412, "Belt of the Fang", "Accessible physical fallback")
        ),
        ONE_HAND = tiers(
            { item(1483, "Face Smasher", "Flag-carrier stat stick"), item(22984, "Dawnblade", "Horde Ghostlands stamina weapon; strong Mighty Intellect swap", "HORDE") },
            { item(2567, "Evocator's Blade", "Caster mana alternative"), item(15223, "Jagged Star of Healing", "Healing random suffix") },
            item(6472, "Stinging Viper", "Melee mace fallback")
        ),
        TWO_HAND = tiers(
            { item(5187, "Rhahk'Zor's Hammer", "TBC 2.3 upgrade; high-stamina Feral / flag-carrier weapon"), item(890, "Twisted Chanter's Staff", "Mighty Intellect swap") },
            { item(2271, "Staff of the Blessed Seer", "Healing Power swap"), item(3415, "Staff of the Friar", "Spirit regeneration swap") },
            item(5201, "Emberstone Staff", "Alliance caster quest fallback", "ALLIANCE")
        ),
    },
})

TBC:AuditClass(19, "HUNTER", {
    sources = {
        xpoffHunter19,
        wowheadHunter19,
        "https://www.wowhead.com/tbc/item=22990/tranquillien-champions-cloak",
        "https://www.wowhead.com/tbc/item=3742/bow-of-plunder",
        "https://www.wowhead.com/tbc/item=6319/girdle-of-the-blindwatcher",
    },
    note = "Every tier was checked against the TBC hunter checklist, the contemporary Wowhead guide and TBC tooltips. Pet training adds a hunter-specific XP budget; Ghostlands reputation and Hillsbrad quest rewards are therefore explicitly flagged.",
    slots = {
        BACK = tiers(
            { item(2059, "Sentry Cloak", "Agility and stamina"), item(22990, "Tranquillien Champion's Cloak", "Horde-only Exalted Tranquillien maximum-stamina option; budget Ghostlands XP", "HORDE") },
            { item(6449, "Glowing Lizardscale Cloak", "Agility pressure"), item(6667, "Engineer's Cloak", "Stamina / mana") },
            item(5444, "Miner's Cape", "TBC 2.3 neutral stamina fallback")
        ),
        WAIST = tiers(
            { item(6468, "Deviate Scale Belt", "Ranged-pressure survival"), item(6319, "Girdle of the Blindwatcher", "TBC 2.3 maximum stamina / mana alternative") },
            item(16987, "Screecher Belt", "Horde attack power / mana quest", "HORDE"),
            item(10412, "Belt of the Fang", "Dungeon physical fallback")
        ),
        FEET = tiers(
            item(19969, "Nat Pagle's Extreme Anglin' Boots", "Maximum stamina and eligible TBC boot-enchant base"),
            { item(10411, "Footpads of the Fang", "TBC-updated balanced physical option"), item(1121, "Feet of the Lynx", "Agility pressure") },
            { item(10653, "Trailblazer Boots", "Horde agility / stamina quest", "HORDE"), item(6335, "Grizzled Boots", "Horde stamina quest", "HORDE") }
        ),
        ONE_HAND = tiers(
            { item(20441, "Scout's Blade", "Horde WSG agility weapon", "HORDE"), item(20443, "Sentinel's Blade", "Alliance WSG agility weapon", "ALLIANCE") },
            { item(6504, "Wingblade", "Horde agility quest weapon", "HORDE"), item(22984, "Dawnblade", "Horde Ghostlands stamina / weapon-enchant swap", "HORDE") },
            item(5191, "Cruel Barb", "Neutral attack-power alternative")
        ),
        RANGED = tiers(
            { item(6469, "Venomstrike", "Poison-proc pressure"), item(3742, "Bow of Plunder", "Horde Hillsbrad high-top-end bow; extreme quest and pet-XP planning", "HORDE") },
            { item(20437, "Outrider's Bow", "Horde WSG ranged option", "HORDE"), item(20438, "Outrunner's Bow", "Alliance WSG ranged option", "ALLIANCE") },
            { item(13136, "Lil Timmy's Peashooter", "Neutral ranged fallback"), item(4372, "Lovingly Crafted Boomstick", "Crafted gun fallback") }
        ),
    },
})

TBC:AuditClass(19, "MAGE", {
    sources = {
        wowheadMage19,
        "https://www.wowhead.com/tbc/item=2231/inferno-robe",
        "https://www.wowhead.com/tbc/item=31264/silvermoon-robes",
        "https://www.wowhead.com/tbc/item=5970/serpent-gloves",
        "https://www.wowhead.com/tbc/item=22990/tranquillien-champions-cloak",
    },
    note = "Every Era tier was cross-checked with TBC item pages and historical twink comments. TBC 2.3 caster-item upgrades, Bloodmyst suffix gear and the Horde Ghostlands reputation route create real alternatives; Inferno Robe remains a Horde quest route with substantial XP risk.",
    slots = {
        BACK = tiers(
            { item(22990, "Tranquillien Champion's Cloak", "Horde-only Exalted Tranquillien maximum-stamina cloak; plan Ghostlands XP", "HORDE"), item(6667, "Engineer's Cloak", "Neutral control / survival") },
            { item(5444, "Miner's Cape", "TBC 2.3 neutral stamina alternative"), item(20427, "Battle Healer's Cloak", "Horde WSG caster cloak", "HORDE"), item(20428, "Caretaker's Cape", "Alliance WSG caster cloak", "ALLIANCE") },
            { item(14179, "Watcher's Cape of Frozen Wrath", "Frost-damage suffix"), item(14179, "Watcher's Cape of Fiery Wrath", "Fire-damage suffix") }
        ),
        CHEST = tiers(
            { item(1486, "Tree Bark Jacket", "Balanced control / survival"), item(2231, "Inferno Robe", "Horde Fire-pressure quest reward; high item level but substantial Hillsbrad XP risk", "HORDE") },
            { item(31264, "Silvermoon Robes of the Sun", "TBC Bloodmyst BoE Fire / general spell-damage suffix"), item(6465, "Robe of the Moccasin", "Mana / survival alternative") },
            { item(31264, "Silvermoon Robes of the Moon", "TBC Bloodmyst BoE intellect / stamina / spirit suffix"), item(14127, "Ritual Shroud of Frozen Wrath", "Frost-damage suffix") }
        ),
        HANDS = tiers(
            { item(5970, "Serpent Gloves", "TBC 2.3 intellect and general spell-damage upgrade"), item(5195, "Gold-flecked Gloves", "Alliance Deadmines caster equivalent") },
            { item(12977, "Magefist Gloves", "Balanced caster stats"), item(892, "Gnoll Casting Gloves", "General spell-damage BoE alternative") },
            item(14162, "Pagan Mitts of Fiery Wrath", "Fire-damage random suffix")
        ),
        ONE_HAND = tiers(
            { item(935, "Night Watch Shortsword", "Neutral stamina control weapon"), item(22984, "Dawnblade", "Horde Ghostlands stamina weapon; Mighty Intellect swap", "HORDE") },
            { item(3184, "Hook Dagger of Frozen Wrath", "Frost-damage suffix"), item(3184, "Hook Dagger of Fiery Wrath", "Fire-damage suffix") },
            item(2567, "Evocator's Blade", "Mana fallback")
        ),
    },
})

local bracket29Sources = {
    "https://www.wowhead.com/tbc/gear-set/druid-29-tbc-twink-130267",
    "https://www.wowhead.com/tbc/items/min-req-level:20/max-req-level:29",
    "https://www.reddit.com/r/classicwow/comments/ntyzz9/29_twink_gear_for_tbc_classic/",
}

TBC:AuditClass(29, "DRUID", {
    sources = bracket29Sources,
    note = "Full S/A/B audit against the TBC gear set, filtered TBC item catalog and bracket discussion. The Era candidates remain valid; the material TBC difference is enchant eligibility by item level, handled by the TBC enchant audit.",
})

TBC:AuditClass(29, "HUNTER", {
    sources = bracket29Sources,
    note = "Full S/A/B audit against TBC item tooltips and bracket discussion, including ranged weapons, dual-wield proficiency and faction routes. Existing gear tiers remain valid; TBC leg-enchant eligibility is handled separately.",
})

TBC:AuditClass(29, "MAGE", {
    sources = bracket29Sources,
    note = "Full S/A/B audit against TBC item tooltips and bracket discussion, including school-damage suffixes and item-level enchant thresholds. No gear replacement was promoted without stronger TBC evidence.",
})

local bracket39Sources = {
    xpoff39Audit,
    "https://www.wowhead.com/tbc/items/min-req-level:30/max-req-level:39",
    "https://www.wowhead.com/classic/guide/classic-level-39-twink-overview-9789",
}

TBC:AuditClass(39, "DRUID", {
    sources = bracket39Sources,
    note = "All level-39 S/A/B items were checked against the TBC upgrade-list project and TBC item catalog. Existing choices remain obtainable and class-legal; TBC enchant and profession deltas are maintained outside the gear table.",
})

TBC:AuditClass(39, "HUNTER", {
    sources = bracket39Sources,
    note = "All level-39 S/A/B items, weapon proficiencies, faction routes and XP warnings were checked against the TBC upgrade-list project and TBC item catalog. Rogue/Druid-only AB leather rewards are excluded.",
    slots = {
        WAIST = tiers(
            item(13117, "Ogron's Sash", "Balanced high-stat BoE"),
            item(10721, "Gnomish Harm Prevention Belt", "Engineering 215 absorb swap"),
            item(nil, "No verified TBC belt fallback", "No lower recommendation is promoted without TBC evidence")
        ),
        FEET = tiers(
            item(2276, "Swampwalker Boots", "Agility / stamina BoE; legal replacement for class-restricted AB leather boots"),
            { item(10724, "Gnomish Rocket Boots", "Engineering 225 sprint swap"), item(7189, "Goblin Rocket Boots", "Goblin Engineering sprint swap; break risk") },
            item(nil, "No verified TBC boot fallback", "No lower recommendation is promoted without TBC evidence")
        ),
    },
})

TBC:AuditClass(39, "MAGE", {
    sources = bracket39Sources,
    note = "All level-39 S/A/B items and spell-school suffixes were checked against the TBC upgrade-list project and TBC item catalog. The Era gear set remains valid; TBC-specific enchants are audited separately.",
})
