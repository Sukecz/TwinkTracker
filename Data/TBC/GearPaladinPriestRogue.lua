local addonName, ns = ...

local TBC = ns.TBCData
local item = TBC.item
local tiers = TBC.tiers

local paladin19Sources = {
    "https://xpoff.com/threads/tbc-19-paladin-checklist.96404/",
    "https://www.wowhead.com/tbc/item=22990/tranquillien-champions-cloak",
    "https://www.wowhead.com/tbc/item=22995/sindorei-warblade",
    "https://www.wowhead.com/tbc/item=4534/steel-clasped-bracers",
    "https://www.wowhead.com/tbc/item=29592/insignia-of-the-horde",
}

TBC:AuditClass(19, "PALADIN", {
    sources = paladin19Sources,
    note = "Every Era tier was checked against the TBC Paladin checklist and TBC item tooltips. Blood Elf Paladins make the Horde reputation, quest, WSG and PvP-trinket routes class-legal; the Ghostlands reputation chain needs deliberate XP planning.",
    role = "Holy Support / Protection / Retribution / Flag Defense; Alliance or Blood Elf Horde",
    slots = {
        NECK = tiers(
            { item(20442, "Scout's Medallion", "Horde WSG neck", "HORDE"), item(20444, "Sentinel's Medallion", "Alliance WSG neck", "ALLIANCE") },
            item(16009, "Voice Amplification Modulator", "Situational silence-resistance utility"),
            item(21933, "Thick Bronze Necklace", "Accessible stamina fallback")
        ),
        BACK = tiers(
            { item(22990, "Tranquillien Champion's Cloak", "Blood Elf-friendly Exalted Tranquillien stamina cloak; plan Ghostlands XP", "HORDE"), item(20428, "Caretaker's Cape", "Alliance WSG Holy cloak", "ALLIANCE"), item(2059, "Sentry Cloak", "Retribution balance") },
            { item(6667, "Engineer's Cloak", "Hybrid survival"), item(6449, "Glowing Lizardscale Cloak", "TBC agility and stamina version") },
            { item(6632, "Feyscale Cloak", "TBC caster fallback"), item(12979, "Firebane Cloak", "Situational fire resistance") }
        ),
        WRISTS = tiers(
            { item(4534, "Steel-clasped Bracers", "Horde SFK quest; maximum fixed stamina", "HORDE"), item(7003, "Beetle Clasps", "Alliance BFD quest survival", "ALLIANCE"), item(14147, "Cavedweller Bracers", "RFC strength / stamina alternative") },
            { item(9811, "Fortified Bracers of the Eagle", "Holy random suffix"), item(9811, "Fortified Bracers of the Bear", "Retribution random suffix") },
            item(15331, "Wrangler's Wristbands of Stamina", "Leather survival fallback")
        ),
        FINGER_1 = tiers(
            { item(6414, "Seal of Sylvanas", "Horde quest survival ring", "HORDE"), item(2933, "Seal of Wrynn", "Alliance quest hybrid ring", "ALLIANCE") },
            { item(20426, "Advisor's Ring", "Horde WSG caster ring", "HORDE"), item(20431, "Lorekeeper's Ring", "Alliance WSG caster ring", "ALLIANCE") },
            { item(20429, "Legionnaire's Band", "Horde WSG physical ring", "HORDE"), item(20439, "Protector's Band", "Alliance WSG physical ring", "ALLIANCE") }
        ),
        FINGER_2 = tiers(
            { item(20426, "Advisor's Ring", "Horde WSG caster ring", "HORDE"), item(20431, "Lorekeeper's Ring", "Alliance WSG caster ring", "ALLIANCE") },
            { item(6414, "Seal of Sylvanas", "Horde quest ring; use when Ring 1 differs", "HORDE"), item(2933, "Seal of Wrynn", "Alliance quest ring; use when Ring 1 differs", "ALLIANCE") },
            { item(1156, "Lavishly Jeweled Ring", "TBC intellect and spell-hit alternative"), item(4998, "Blood Ring", "Stamina fallback") }
        ),
        TRINKET_1 = tiers(
            item(19024, "Arena Grand Master", "Survival shield"),
            { item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE") },
            item(4381, "Minor Recombobulator", "Engineering utility")
        ),
        TRINKET_2 = tiers(
            { item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE") },
            item(19024, "Arena Grand Master", "Survival shield"),
            item(4381, "Minor Recombobulator", "Engineering utility")
        ),
        TWO_HAND = tiers(
            { item(5815, "Glacial Stone", "Alliance quest burst weapon", "ALLIANCE"), item(3822, "Runic Darkblade", "Horde quest Shadow-proc weapon", "HORDE"), item(22995, "Sin'dorei Warblade", "Horde Ghostlands strength / stamina weapon; significant chain XP", "HORDE") },
            { item(7230, "Smite's Mighty Hammer", "High-stat dungeon alternative"), item(1318, "Night Reaver", "Shadow-proc world drop") },
            item(12992, "Searing Blade", "Fire-proc fallback")
        ),
    },
})

local priest19Sources = {
    "https://www.wowhead.com/classic/guide/priest-classic-level-19-twink",
    "https://www.wowhead.com/tbc/item=6465/robe-of-the-moccasin",
    "https://www.wowhead.com/tbc/item=6282/sacred-burial-trousers",
    "https://www.wowhead.com/tbc/item=6341/eerie-stable-lantern",
    "https://www.wowhead.com/tbc/item=22990/tranquillien-champions-cloak",
}

TBC:AuditClass(19, "PRIEST", {
    sources = priest19Sources,
    note = "The complete Era list was checked against the contemporary Priest guide and TBC tooltips. TBC converts several weak physical stats into stamina or spell power; the Horde Tranquillien cloak is a real new route, while the underlying healer and Shadow sets otherwise remain stable.",
    slots = {
        BACK = tiers(
            { item(22990, "Tranquillien Champion's Cloak", "Horde Exalted Tranquillien maximum-stamina cloak; plan Ghostlands XP", "HORDE"), item(20427, "Battle Healer's Cloak", "Horde WSG healing cloak", "HORDE"), item(20428, "Caretaker's Cape", "Alliance WSG healing cloak", "ALLIANCE") },
            { item(6667, "Engineer's Cloak", "Survival / mana"), item(6632, "Feyscale Cloak", "TBC caster alternative") },
            item(12979, "Firebane Cloak", "Situational fire resistance")
        ),
        CHEST = tiers(
            { item(1486, "Tree Bark Jacket", "Healing / survival"), item(6465, "Robe of the Moccasin", "TBC version replaces Strength with stamina") },
            item(14127, "Ritual Shroud of Shadow Wrath", "Shadow-pressure suffix"),
            item(2231, "Inferno Robe", "Horde high-item-level enchant base; Fire-only damage and substantial quest XP", "HORDE")
        ),
        LEGS = tiers(
            { item(12987, "Darkweave Breeches", "Balanced healer stats"), item(10043, "Pious Legwraps", "Alliance healing quest", "ALLIANCE") },
            { item(6282, "Sacred Burial Trousers", "TBC version gains general spell power; Horde quest chain with XP", "HORDE"), item(6568, "Shimmering Trousers of the Eagle", "Balanced suffix") },
            item(14125, "Ritual Leggings of Healing", "Healing fallback suffix")
        ),
        OFF_HAND = tiers(
            { item(6341, "Eerie Stable Lantern", "TBC version gains stamina and general spell power"), item(16768, "Furbolg Medicine Pouch", "Maximum-stamina swap; reputation XP risk") },
            item(2879, "Antipodean Rod", "Fire / Frost pressure"),
            item(1131, "Totem of Infliction", "Alliance armor / retaliation quest", "ALLIANCE")
        ),
    },
})

local rogue19Sources = {
    "https://www.wowhead.com/classic/guide/rogue-classic-level-19-twink",
    "https://www.wowhead.com/tbc/item=5404/serpents-shoulders",
    "https://www.wowhead.com/tbc/item=5192/thiefs-blade",
    "https://www.wowhead.com/tbc/item=29584/throat-piercers",
    "https://www.reddit.com/r/classicwow/comments/o5umfs/19_twink_rogue_build_alliance_tbc_classic/",
}

TBC:AuditClass(19, "ROGUE", {
    sources = rogue19Sources,
    note = "All tiers were checked against the Rogue guide, TBC tooltips and a TBC Classic build discussion. Serpent's Shoulders become a +9 Agility BoP, Thief's Blade rises from +3 to +7 Agility, and Keen Throwing Knife becomes Broken and is removed.",
    slots = {
        SHOULDERS = tiers(
            item(5404, "Serpent's Shoulders", "TBC +9 Agility BoP; newly dominant obtainable shoulder"),
            { item(10657, "Talbar Mantle", "Stamina / mana survival option"), item(15313, "Feral Shoulder Pads", "Armor fallback; only grandfathered pre-TBC enchants change its value") },
            item(4315, "Reinforced Woolen Shoulders", "Tradeable legacy-enchant base only")
        ),
        BACK = tiers(
            { item(2059, "Sentry Cloak", "Agility and stamina"), item(6449, "Glowing Lizardscale Cloak", "TBC version replaces Spirit with stamina") },
            { item(6667, "Engineer's Cloak", "Stamina fallback"), item(12979, "Firebane Cloak", "Resistance fallback") },
            item(22990, "Tranquillien Champion's Cloak", "Horde maximum-stamina fallback; reputation XP", "HORDE")
        ),
        OFF_HAND = tiers(
            { item(5192, "Thief's Blade", "TBC upgrade to +7 Agility; prime fast off hand"), item(5191, "Cruel Barb", "Attack-power off hand") },
            { item(20441, "Scout's Blade", "Horde WSG agility off hand", "HORDE"), item(20443, "Sentinel's Blade", "Alliance WSG agility off hand", "ALLIANCE") },
            { item(1935, "Assassin's Blade", "Fast stat dagger"), item(1482, "Shadowfang", "Dual-sword proc alternative") }
        ),
        RANGED = tiers(
            item(29584, "Throat Piercers", "TBC BoE thrown stat stick with +2 Agility"),
            { item(20437, "Outrider's Bow", "Horde WSG bow", "HORDE"), item(20438, "Outrunner's Bow", "Alliance WSG bow", "ALLIANCE") },
            { item(6469, "Venomstrike", "Situational ranged poison proc"), item(13136, "Lil Timmy's Peashooter", "Neutral gun fallback") }
        ),
    },
})

local bracket29Sources = {
    "https://www.reddit.com/r/classicwow/comments/ntyzz9/29_twink_gear_for_tbc_classic/",
    "https://www.wowhead.com/tbc/items/min-req-level:20/max-req-level:29",
}

TBC:AuditClass(29, "PALADIN", {
    sources = {
        bracket29Sources[1],
        bracket29Sources[2],
        "https://www.youtube.com/watch?v=OX5O693m8bM",
        "https://www.wowhead.com/tbc/item=29592/insignia-of-the-horde",
    },
    note = "Every tier was checked against TBC item pages and a Horde Blood Elf Holy Paladin gear reference. Existing neutral gear remains valid; Horde WSG, AB and class-trinket equivalents replace the Era Alliance-only assumptions.",
    role = "Holy / Support / Retribution / Flag Defense; Alliance or Blood Elf Horde",
    slots = {
        NECK = tiers(
            { item(19537, "Scout's Medallion", "Horde level-28 WSG physical neck", "HORDE"), item(19541, "Sentinel's Medallion", "Alliance level-28 WSG physical neck", "ALLIANCE"), item(13087, "River Pride Choker", "Neutral melee / defense") },
            { item(5003, "Crystal Starfire Medallion", "Holy hybrid"), item(6695, "Stygian Bone Amulet", "Regeneration / defense") },
            item(20444, "Sentinel's Medallion", "Lower-bracket Alliance fallback", "ALLIANCE")
        ),
        BACK = tiers(
            { item(19529, "Battle Healer's Cloak", "Horde level-28 WSG healing cloak", "HORDE"), item(19533, "Caretaker's Cape", "Alliance level-28 WSG healing cloak", "ALLIANCE"), item(13108, "Tigerstrike Mantle", "Melee / flag-defense balance") },
            { item(10518, "Parachute Cloak", "TBC-enchantable Engineering agility cloak"), item(2953, "Watch Master's Cloak", "TBC +7 Agility Alliance quest cloak", "ALLIANCE") },
            item(4716, "Combat Cloak", "Stamina fallback")
        ),
        WAIST = tiers(
            { item(20108, "Highlander's Lamellar Girdle", "Alliance level-28 AB hybrid mail belt", "ALLIANCE"), item(20126, "Highlander's Plate Girdle", "Alliance level-28 AB physical mail belt", "ALLIANCE") },
            { item(9405, "Girdle of Golem Strength", "Retribution / defense"), item(15554, "Pillager's Girdle of Healing", "Holy healing suffix"), item(15554, "Pillager's Girdle of the Eagle", "Holy intellect / stamina suffix") },
            { item(15554, "Pillager's Girdle of the Bear", "Melee strength / stamina suffix"), item(6911, "Moss Cinch", "Holy stamina / intellect"), item(4717, "Mail Combat Belt", "Fixed physical fallback") }
        ),
        FEET = tiers(
            { item(9510, "Caverndeep Trudgers", "Flag-defense all-round mail"), item(20111, "Highlander's Lamellar Greaves", "Alliance level-28 AB hybrid mail boots with run speed", "ALLIANCE") },
            { item(20129, "Highlander's Plate Greaves", "Alliance level-28 AB physical mail boots with run speed", "ALLIANCE"), item(9454, "Acidic Walkers", "Holy caster alternative") },
            item(9450, "Gnomebot Operating Boots", "Stamina fallback")
        ),
        FINGER_1 = tiers(
            { item(19513, "Legionnaire's Band", "Horde level-28 WSG physical ring", "HORDE"), item(19517, "Protector's Band", "Alliance level-28 WSG physical ring", "ALLIANCE"), item(2039, "Plains Ring", "Defense / Holy ring") },
            { item(19521, "Advisor's Ring", "Horde level-28 WSG caster ring", "HORDE"), item(19525, "Lorekeeper's Ring", "Alliance level-28 WSG caster ring", "ALLIANCE") },
            { item(6414, "Seal of Sylvanas", "Horde quest ring", "HORDE"), item(2933, "Seal of Wrynn", "Alliance quest ring", "ALLIANCE") }
        ),
        FINGER_2 = tiers(
            { item(6414, "Seal of Sylvanas", "Horde hybrid quest ring", "HORDE"), item(2933, "Seal of Wrynn", "Alliance hybrid quest ring", "ALLIANCE") },
            { item(19521, "Advisor's Ring", "Horde WSG caster ring", "HORDE"), item(19525, "Lorekeeper's Ring", "Alliance WSG caster ring", "ALLIANCE") },
            { item(2043, "Ring of Forlorn Spirits", "TBC upgrade to stamina and mana regeneration"), item(6321, "Silverlaine's Family Seal", "Physical fallback") }
        ),
        TRINKET_1 = tiers(
            { item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE"), item(19024, "Arena Grand Master", "Survival shield") },
            { item(4381, "Minor Recombobulator", "Engineering utility"), item(4397, "Gnomish Cloaking Device", "Situational invisibility") },
            item(21120, "Defiler's Talisman", "Horde AB absorb alternative", "HORDE")
        ),
        TRINKET_2 = tiers(
            { item(19024, "Arena Grand Master", "Survival shield"), item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE") },
            { item(21120, "Defiler's Talisman", "Horde AB absorb", "HORDE"), item(21119, "Talisman of Arathor", "Alliance AB absorb", "ALLIANCE") },
            item(4381, "Minor Recombobulator", "Engineering utility")
        ),
    },
})

TBC:AuditClass(29, "PRIEST", {
    sources = {
        bracket29Sources[1],
        bracket29Sources[2],
        "https://www.warcrafttavern.com/wow-classic/guides/29-priest-twink/",
    },
    note = "All S/A/B choices were checked against the TBC item catalog and the established level-29 Priest guide. TBC spell/healing text conversions do not displace the current multi-set items; high-item-level enchant eligibility is handled by the TBC enchant audit.",
})

TBC:AuditClass(29, "ROGUE", {
    sources = {
        bracket29Sources[1],
        bracket29Sources[2],
        "https://www.wowhead.com/tbc/item=7682/torturing-poker",
        "https://www.wowhead.com/tbc/item=3078/naga-heartpiercer",
        "https://www.wowhead.com/tbc/item=9624/triprunner-dungarees",
    },
    note = "Every tier was checked against TBC tooltips and bracket discussions. TBC 2.3 upgrades Watch Master's Cloak and Naga Heartpiercer; Torturing Poker is a top dagger, while BoE leg choices are retained because TBC armor-kit application differs from BoP quest legs and needs live-rule validation.",
    slots = {
        SHOULDERS = tiers(
            { item(2264, "Mantle of Thieves", "Balanced agility / stamina"), item(2278, "Forest Tracker Epaulets", "Glass agility / strength") },
            { item(5404, "Serpent's Shoulders", "TBC +9 Agility BoP alternative"), item(7727, "Watchman Pauldrons", "Survival stamina") },
            item(15140, "Cutthroat's Mantle of the Monkey", "Random-suffix fallback")
        ),
        BACK = tiers(
            { item(10518, "Parachute Cloak", "Item-level 45 Engineering cloak; supports TBC agility enchant"), item(13108, "Tigerstrike Mantle", "Best unenchanted fixed balance") },
            { item(2953, "Watch Master's Cloak", "TBC 2.3 version gains +7 Agility", "ALLIANCE"), item(2059, "Sentry Cloak", "Balanced agility / stamina") },
            item(6449, "Glowing Lizardscale Cloak", "Lower-bracket agility / stamina fallback")
        ),
        LEGS = tiers(
            { item(9509, "Petrolspill Leggings", "BoE TBC armor-kit candidate; verify current application rule live"), item(9624, "Triprunner Dungarees", "Best raw-stat BoP alternative") },
            { item(13114, "Troll's Bane Leggings", "BoE agility / critical-rating armor-kit candidate"), item(5963, "Barbaric Leggings", "Crafted balanced alternative") },
            item(15344, "Pathfinder Pants of the Monkey", "BoE suffix fallback for a trade-applied leg kit")
        ),
        ONE_HAND = tiers(
            { item(7682, "Torturing Poker", "TBC high-DPS dagger / Backstab main hand"), item(13033, "Zealot Blade", "Slow Hemorrhage sword"), item(8226, "The Butcher", "Slow balanced sword") },
            { item(2912, "Claw of the Shadowmancer", "Dagger opener / Shadow proc"), item(9453, "Toxic Revenger", "AoE poison; crowd-control risk") },
            item(2941, "Prison Shank", "Agility / stamina dagger fallback")
        ),
        OFF_HAND = tiers(
            { item(776, "Vendetta", "TBC best fast agility / poison off hand"), item(7682, "Torturing Poker", "Sustained Fire-damage off hand") },
            { item(19545, "Scout's Blade", "Horde level-28 WSG dagger", "HORDE"), item(19549, "Sentinel's Blade", "Alliance level-28 WSG dagger", "ALLIANCE") },
            { item(9453, "Toxic Revenger", "AoE poison alternative"), item(6904, "Bite of Serra'kis", "Fast poison-proc fallback") }
        ),
        RANGED = tiers(
            item(3078, "Naga Heartpiercer", "TBC 2.3 upgrade to +5 Agility; top Rogue stat stick"),
            { item(6696, "Nightstalker Bow", "Dungeon +3 Agility alternative"), item(19561, "Outrider's Bow", "Horde level-28 WSG bow", "HORDE"), item(19565, "Outrunner's Bow", "Alliance level-28 WSG bow", "ALLIANCE") },
            { item(13019, "Harpyclaw Short Bow", "Neutral BoE fallback"), item(17042, "Nail Spitter", "Horde quest gun with substantial chain XP", "HORDE") }
        ),
    },
})

local bracket39Sources = {
    "https://xpoff.com/threads/39-rogue-guide.470/",
    "https://www.wowhead.com/tbc/items/min-req-level:30/max-req-level:39",
    "https://www.reddit.com/r/classicwow/comments/jjajv1/2939_twink_changes_with_tbc/",
}

TBC:AuditClass(39, "PALADIN", {
    sources = {
        bracket39Sources[2],
        bracket39Sources[3],
        "https://www.wowhead.com/tbc/item=4508/blood-tinged-armor",
        "https://www.wowhead.com/tbc/item=9375/expert-goldminers-helmet",
        "https://www.wowhead.com/tbc/item=29592/insignia-of-the-horde",
    },
    note = "Every tier was checked against the TBC catalog and bracket discussion. Blood Elf Paladins remove the Alliance-only product assumption; patch 2.3 Blood-tinged Armor is a major Horde quest upgrade with a very large XP budget, and item-level-35 enchant bases matter throughout.",
    role = "Holy Support / Protection / Retribution; Alliance or Blood Elf Horde",
    slots = {
        HEAD = tiers(
            { item(10504, "Green Lens of Healing", "Holy throughput; Engineering 245"), item(9375, "Expert Goldminer's Helmet", "TBC expertise-rating Retribution option; rare Uldaman spawn") },
            { item(7719, "Raging Berserker's Helm", "Retribution burst"), item(13127, "Frostreaver Crown", "Protection stamina") },
            item(7720, "Whitemane's Chapeau", "Holy stat fallback")
        ),
        CHEST = tiers(
            { item(4508, "Blood-tinged Armor", "Horde TBC 2.3 strength / stamina chest; extreme Arathi quest XP", "HORDE"), item(10762, "Robes of the Lich", "Holy survival stat set") },
            { item(1715, "Polished Jazeraint Armor", "Neutral BoE item-level-42 enchant base"), item(10328, "Scarlet Chestpiece", "Physical mail alternative") },
            { item(7759, "Archon Chestpiece", "Retribution strength fallback"), item(15546, "Thick Scale Breastplate of the Eagle", "Holy suffix fallback") }
        ),
        NECK = tiers(
            { item(1714, "Necklace of Calisea", "Holy mana / regeneration"), item(13088, "Gazlowe's Charm", "Physical stamina"), item(4743, "Pulsating Crystalline Shard", "TBC 2.3 caster / survival reward; extreme quest XP") },
            { item(19536, "Scout's Medallion", "Horde level-38 WSG physical neck", "HORDE"), item(19540, "Sentinel's Medallion", "Alliance level-38 WSG physical neck", "ALLIANCE") },
            item(5003, "Crystal Starfire Medallion", "Holy fallback")
        ),
        TRINKET_1 = tiers(
            { item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE"), item(19024, "Arena Grand Master", "Survival shield") },
            { item(1404, "Tidal Charm", "Rare-spawn stun"), item(2820, "Nifty Stopwatch", "Sprint; quest XP") },
            item(10720, "Gnomish Net-o-Matic Projector", "Engineering control with backfire risk")
        ),
        TRINKET_2 = tiers(
            { item(19024, "Arena Grand Master", "Survival shield"), item(1404, "Tidal Charm", "Rare-spawn stun"), item(2820, "Nifty Stopwatch", "Sprint; quest XP") },
            { item(29592, "Insignia of the Horde", "TBC Paladin PvP trinket", "HORDE"), item(18864, "Insignia of the Alliance", "Paladin PvP trinket", "ALLIANCE") },
            item(17774, "Mark of the Chosen", "Passive proc; quest begins at 39 and needs XP planning")
        ),
    },
})

TBC:AuditClass(39, "PRIEST", {
    sources = {
        bracket39Sources[2],
        "https://www.wowhead.com/tbc/forums/topic/39-shadow-priest-twink-98122",
        "https://www.wowhead.com/tbc/item=4743/pulsating-crystalline-shard",
        "https://www.wowhead.com/tbc/item=11469/bloodband-bracers",
        "https://www.wowhead.com/tbc/item=10581/deaths-head-vestment",
    },
    note = "All tiers were checked against a contemporary 39 Shadow Priest list and TBC tooltips. Patch 2.3 makes Pulsating Crystalline Shard a premier caster neck; Bloodband Bracers and Death's Head Vestment are high-item-level TBC enchant bases but their quest and dungeon routes carry material XP exposure.",
    slots = {
        NECK = tiers(
            item(4743, "Pulsating Crystalline Shard", "TBC 2.3 stamina / spirit / spell-power reward; extreme Arathi quest XP"),
            { item(1714, "Necklace of Calisea", "Balanced caster / survival"), item(7722, "Triune Amulet", "Scarlet Monastery caster alternative") },
            item(5003, "Crystal Starfire Medallion", "Fixed-stat fallback")
        ),
        CHEST = tiers(
            { item(10762, "Robes of the Lich", "Shadow / healing dungeon robe"), item(10581, "Death's Head Vestment", "Rare BoE balanced-stat and TBC-enchantable chest") },
            { item(1716, "Robe of the Magi", "Spell-power BoE enchant base"), item(10004, "Shadoweave Robe", "Crafted Shadow pressure") },
            item(7728, "Beguiler Robes", "Lower-level balanced fallback")
        ),
        WRISTS = tiers(
            { item(11469, "Bloodband Bracers", "Item-level 46 quest bracers; TBC spell-power / stamina enchant base and major XP risk"), item(14260, "Bloodwoven Bracers of Healing", "Healing suffix with TBC enchant eligibility"), item(14260, "Bloodwoven Bracers of Shadow Wrath", "Shadow suffix with TBC enchant eligibility") },
            item(4045, "Mistscape Bracers", "Fixed caster fallback"),
            item(9909, "Royal Bands of the Owl", "Regeneration fallback")
        ),
    },
})

TBC:AuditClass(39, "ROGUE", {
    sources = {
        bracket39Sources[1],
        bracket39Sources[2],
        "https://www.wowhead.com/tbc/item=9375/expert-goldminers-helmet",
        "https://www.wowhead.com/tbc/item=10518/parachute-cloak",
    },
    note = "Every tier was checked against the detailed TBC-era 39 Rogue guide and TBC tooltips. Expertise replaces axe skill on Expert Goldminer's Helmet, and Parachute Cloak becomes the leading practical cloak once its item-level-45 TBC agility-enchant eligibility is included.",
    slots = {
        HEAD = tiers(
            { item(9375, "Expert Goldminer's Helmet", "TBC expertise-rating physical helm; rare Uldaman spawn"), item(15156, "Nocturnal Cap of the Monkey", "Agility / stamina suffix") },
            { item(9420, "Adventurer's Pith Helmet", "Fixed agility / stamina"), item(10588, "Goblin Rocket Helmet", "Engineering control swap") },
            item(10501, "Catseye Ultra Goggles", "Stealth-detection swap")
        ),
        BACK = tiers(
            item(10518, "Parachute Cloak", "Item-level 45 Engineering cloak; TBC +12 Agility enchant base"),
            { item(13108, "Tigerstrike Mantle", "Best unenchanted agility / stamina cloak"), item(5257, "Dark Hooded Cape", "Attack-power alternative") },
            { item(7533, "Cabalist Cloak of the Monkey", "Balanced suffix fallback"), item(13121, "Wing of the Whelpling", "Stamina fallback") }
        ),
    },
})
