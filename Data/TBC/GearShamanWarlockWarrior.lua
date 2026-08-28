local addonName, ns = ...

local TBC = ns.TBCData
local item = TBC.item
local tiers = TBC.tiers

local sources = {
    tbcItems = "https://www.wowhead.com/tbc/items",
    tbcNineteenChart = "https://xpoff.com/threads/tbc-gearing-guide-bis-chart.96000/",
    shamanNineteen = "https://xpoff.com/threads/level-19-twink-shaman-guide.7937/",
    warriorNineteen = "https://xpoff.com/threads/tbc-19-warrior-checklist.96736/",
    shamanTwentyNine = "https://www.warcrafttavern.com/wow-classic/guides/29-twink-shaman/",
    warlockTwentyNine = "https://www.warcrafttavern.com/wow-classic/guides/29-warlock-twink/",
    warriorTwentyNine = "https://www.wowhead.com/tbc/forums/topic/29-twink-warrior-gear-enchants-13178",
    shamanThirtyNine = "https://www.warcrafttavern.com/wow-classic/guides/39-twink-restoration-shaman/",
    warlockThirtyNine = "https://www.warcrafttavern.com/wow-classic/guides/39-twink-warlock/",
    warriorThirtyNine = "https://www.warcrafttavern.com/wow-classic/guides/39-twink-warrior/",
}

local function copy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[key] = copy(entry) end
    return result
end

local function cleanTBCNote(note)
    if not note then return note end
    note = string.gsub(note, "Era PvP only", "TBC PvP reward")
    note = string.gsub(note, "Era WSG only", "TBC WSG reward")
    note = string.gsub(note, "Era%-only", "TBC Honor reward")
    note = string.gsub(note, "Era only", "TBC Honor reward")
    note = string.gsub(note, "current Era", "current TBC client")
    note = string.gsub(note, "; unavailable on Hardcore", "")
    note = string.gsub(note, "requires Two%-Handed Axes and Maces talent", "requires TBC weapon-master training")
    note = string.gsub(note, "Enhancement talent required", "TBC weapon%-master training required")
    return note
end

local function cleanEntry(entry, clearImplicitHorde)
    entry.note = cleanTBCNote(entry.note)
    if clearImplicitHorde and entry.faction == "HORDE"
        and not string.find(entry.note or "", "Horde", 1, true) then
        entry.faction = nil
    end
    return entry
end

local allianceEquivalent = {
    [20442] = item(20444, "Sentinel's Medallion", "Alliance level-18 WSG neck", "ALLIANCE"),
    [20426] = item(20431, "Lorekeeper's Ring", "Alliance level-18 WSG caster ring", "ALLIANCE"),
    [20429] = item(20439, "Protector's Band", "Alliance level-18 WSG physical ring", "ALLIANCE"),
    [18845] = item(29593, "Insignia of the Alliance", "Alliance Shaman PvP trinket", "ALLIANCE"),
    [19537] = item(19541, "Sentinel's Medallion", "Alliance level-28 WSG physical neck", "ALLIANCE"),
    [19529] = item(19533, "Caretaker's Cape", "Alliance level-28 WSG healing cloak", "ALLIANCE"),
    [20152] = item(20090, "Highlander's Padded Girdle", "Alliance level-28 AB physical leather belt", "ALLIANCE"),
    [20157] = item(20093, "Highlander's Padded Greaves", "Alliance level-28 AB physical leather boots", "ALLIANCE"),
    [19521] = item(19525, "Lorekeeper's Ring", "Alliance level-28 WSG caster ring", "ALLIANCE"),
    [19513] = item(19517, "Protector's Band", "Alliance level-28 WSG physical ring", "ALLIANCE"),
    [21120] = item(21119, "Talisman of Arathor", "Alliance level-28 AB physical absorb", "ALLIANCE"),
    [19520] = item(19524, "Lorekeeper's Ring", "Alliance level-38 WSG caster ring", "ALLIANCE"),
}

local function auditedShamanSlot(level, slot)
    local source = assert(TBC:GetBracket(level).bis.classes.SHAMAN.slots[slot])
    local result = { S = {}, A = {}, B = {} }
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, sourceEntry in ipairs(source[tier]) do
            local entry = cleanEntry(copy(sourceEntry), true)
            if #result[tier] < 3 then result[tier][#result[tier] + 1] = entry end
            local equivalent = entry.id and allianceEquivalent[entry.id]
            if equivalent and #result[tier] < 3 then
                result[tier][#result[tier] + 1] = copy(equivalent)
            end
        end
    end
    return result
end

local function auditedTBCSlot(level, token, slot)
    local source = assert(TBC:GetBracket(level).bis.classes[token].slots[slot])
    local result = copy(source)
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, entry in ipairs(result[tier]) do cleanEntry(entry, false) end
    end
    return result
end

local function pvpTrinketSlot(level, token, slot)
    local source = assert(TBC:GetBracket(level).bis.classes[token].slots[slot])
    local result = copy(source)
    for _, tier in ipairs({ "S", "A", "B" }) do
        for _, entry in ipairs(result[tier]) do cleanEntry(entry, false) end
    end
    return result
end

TBC:AuditClass(19, "SHAMAN", {
    sources = { sources.tbcItems, sources.tbcNineteenChart, sources.shamanNineteen },
    note = "TBC permits Alliance Draenei Shaman. All inherited slots were checked for required level and proficiency; faction-neutral gear is no longer incorrectly Horde-locked. Girdle of the Blindwatcher and the 2.3 caster-glove itemization are material upgrades. Quest, dungeon and reputation routes still carry XP risk.",
    role = "Enhancement / Elemental / Restoration / Draenei Support",
    slots = {
        HEAD = auditedShamanSlot(19, "HEAD"),
        NECK = tiers(
            { item(20442, "Scout's Medallion", "Horde WSG neck", "HORDE"), item(20444, "Sentinel's Medallion", "Alliance WSG neck", "ALLIANCE") },
            item(21933, "Thick Bronze Necklace", "TBC Jewelcrafting stamina alternative"),
            item(nil, "No verified TBC Tier B neck", "No lower recommendation is promoted without TBC evidence")
        ),
        HANDS = tiers(
            { item(10654, "Jutebraid Gloves", "Horde quest caster gloves; substantial quest XP", "HORDE"), item(5195, "Gold-flecked Gloves", "Neutral Deadmines caster gloves; dungeon XP") },
            { item(12977, "Magefist Gloves", "Stamina / intellect caster alternative"), item(6586, "Scouting Gloves of the Eagle", "Hybrid random-suffix alternative") },
            item(14572, "Bristlebark Gloves", "Enhancement fixed-stat fallback")
        ),
        WAIST = tiers(
            item(6319, "Girdle of the Blindwatcher", "TBC 2.3 stamina / intellect leather; Shadowfang Keep XP risk"),
            { item(2911, "Keller's Girdle", "Caster mana alternative"), item(6468, "Deviate Scale Belt", "Enhancement survival") },
            item(15329, "Wrangler's Belt of the Eagle", "Hybrid random-suffix fallback")
        ),
        FINGER_1 = auditedShamanSlot(19, "FINGER_1"),
        FINGER_2 = auditedShamanSlot(19, "FINGER_2"),
        TRINKET_1 = tiers(
            { item(18845, "Insignia of the Horde", "Horde Shaman PvP trinket", "HORDE"), item(29593, "Insignia of the Alliance", "Alliance Shaman PvP trinket", "ALLIANCE") },
            item(19024, "Arena Grand Master", "Survival shield; arena turn-ins require XP planning"),
            item(4381, "Minor Recombobulator", "Engineering utility")
        ),
        TRINKET_2 = tiers(
            item(19024, "Arena Grand Master", "Survival shield; Unique prevents duplicate equip in TBC"),
            { item(18845, "Insignia of the Horde", "Horde Shaman PvP trinket", "HORDE"), item(29593, "Insignia of the Alliance", "Alliance Shaman PvP trinket", "ALLIANCE") },
            item(4381, "Minor Recombobulator", "Engineering utility")
        ),
        ONE_HAND = auditedShamanSlot(19, "ONE_HAND"),
        TWO_HAND = tiers(
            { item(5815, "Glacial Stone", "Alliance quest two-hand mace; TBC weapon-master training and quest XP", "ALLIANCE"), item(5322, "Demolition Hammer", "Horde quest two-hand mace; TBC weapon-master training and quest XP", "HORDE") },
            { item(1318, "Night Reaver", "Neutral Shadow-proc axe; TBC weapon-master training"), item(2271, "Staff of the Blessed Seer", "Restoration staff") },
            item(890, "Twisted Chanter's Staff", "Balanced Elemental / Restoration staff")
        ),
        OFF_HAND = auditedShamanSlot(19, "OFF_HAND"),
        SHOULDERS = auditedShamanSlot(19, "SHOULDERS"), BACK = auditedShamanSlot(19, "BACK"),
        CHEST = auditedShamanSlot(19, "CHEST"), WRISTS = auditedShamanSlot(19, "WRISTS"),
        LEGS = auditedShamanSlot(19, "LEGS"), FEET = auditedShamanSlot(19, "FEET"),
    },
})

TBC:AuditClass(19, "WARLOCK", {
    sources = { sources.tbcItems, sources.tbcNineteenChart },
    note = "TBC 2.3 itemization promotes the Deadmines/Wailing Caverns caster gloves, while Blood Elves gain the stamina-heavy Tranquillien cloak. Other inherited slot tiers remain valid after required-level and cloth proficiency review.",
    slots = {
        BACK = tiers(
            { item(22990, "Tranquillien Champion's Cloak", "Horde-only 7 Stamina reputation cloak; reputation route has high XP risk", "HORDE"), item(14179, "Watcher's Cape of Shadow Wrath", "Shadow-damage random suffix") },
            { item(5444, "Miner's Cape", "Alliance-accessible stamina dungeon alternative"), item(6667, "Engineer's Cloak", "Balanced stamina / mana") },
            item(12979, "Firebane Cloak", "Situational Fire resistance")
        ),
        HANDS = tiers(
            { item(10654, "Jutebraid Gloves", "Horde quest equivalent with TBC 2.3 caster stats", "HORDE"), item(5195, "Gold-flecked Gloves", "Neutral Deadmines equivalent with TBC 2.3 caster stats") },
            { item(12977, "Magefist Gloves", "Stamina / intellect alternative"), item(892, "Gnoll Casting Gloves", "Neutral general spell-damage alternative") },
            item(14162, "Pagan Mitts of the Eagle", "Balanced random-suffix fallback")
        ),
        TRINKET_1 = pvpTrinketSlot(19, "WARLOCK", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(19, "WARLOCK", "TRINKET_2"),
        HEAD = auditedTBCSlot(19, "WARLOCK", "HEAD"), NECK = auditedTBCSlot(19, "WARLOCK", "NECK"),
        SHOULDERS = auditedTBCSlot(19, "WARLOCK", "SHOULDERS"), CHEST = auditedTBCSlot(19, "WARLOCK", "CHEST"),
        WRISTS = auditedTBCSlot(19, "WARLOCK", "WRISTS"), WAIST = auditedTBCSlot(19, "WARLOCK", "WAIST"),
        LEGS = auditedTBCSlot(19, "WARLOCK", "LEGS"), FEET = auditedTBCSlot(19, "WARLOCK", "FEET"),
        FINGER_1 = auditedTBCSlot(19, "WARLOCK", "FINGER_1"), FINGER_2 = auditedTBCSlot(19, "WARLOCK", "FINGER_2"),
        ONE_HAND = auditedTBCSlot(19, "WARLOCK", "ONE_HAND"), TWO_HAND = auditedTBCSlot(19, "WARLOCK", "TWO_HAND"),
        OFF_HAND = auditedTBCSlot(19, "WARLOCK", "OFF_HAND"), RANGED = auditedTBCSlot(19, "WARLOCK", "RANGED"),
    },
})

TBC:AuditClass(19, "WARRIOR", {
    sources = { sources.tbcItems, sources.tbcNineteenChart, sources.warriorNineteen },
    note = "TBC adds Blood Elf quest and Tranquillien-reputation options. The Sin'dorei Warblade is a Horde route rather than a universal winner; shield/one-hand and Vanilla burst alternatives remain explicit. High-item-level TBC enchants must be validated against the target item, not the character level alone.",
    slots = {
        BACK = tiers(
            { item(2059, "Sentry Cloak", "Agility / stamina pressure"), item(22990, "Tranquillien Champion's Cloak", "Horde stamina / flag-defense cloak; high XP reputation route", "HORDE") },
            item(6449, "Glowing Lizardscale Cloak", "Agility dungeon option"),
            item(12979, "Firebane Cloak", "Situational Fire resistance")
        ),
        TWO_HAND = tiers(
            { item(5815, "Glacial Stone", "Alliance quest two-hand", "ALLIANCE"), item(22995, "Sin'dorei Warblade", "Horde Blood Elf quest two-hand; long Ghostlands chain and XP risk", "HORDE") },
            { item(7230, "Smite's Mighty Hammer", "Slow dungeon alternative"), item(1318, "Night Reaver", "Shadow-proc world drop") },
            item(3822, "Runic Darkblade", "Horde quest two-hand; high XP route", "HORDE")
        ),
        TRINKET_1 = pvpTrinketSlot(19, "WARRIOR", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(19, "WARRIOR", "TRINKET_2"),
        HEAD = auditedTBCSlot(19, "WARRIOR", "HEAD"), NECK = auditedTBCSlot(19, "WARRIOR", "NECK"),
        SHOULDERS = auditedTBCSlot(19, "WARRIOR", "SHOULDERS"), CHEST = auditedTBCSlot(19, "WARRIOR", "CHEST"),
        WRISTS = auditedTBCSlot(19, "WARRIOR", "WRISTS"), HANDS = auditedTBCSlot(19, "WARRIOR", "HANDS"),
        WAIST = auditedTBCSlot(19, "WARRIOR", "WAIST"), LEGS = auditedTBCSlot(19, "WARRIOR", "LEGS"),
        FEET = auditedTBCSlot(19, "WARRIOR", "FEET"), FINGER_1 = auditedTBCSlot(19, "WARRIOR", "FINGER_1"),
        FINGER_2 = auditedTBCSlot(19, "WARRIOR", "FINGER_2"), ONE_HAND = auditedTBCSlot(19, "WARRIOR", "ONE_HAND"),
        OFF_HAND = auditedTBCSlot(19, "WARRIOR", "OFF_HAND"), RANGED = auditedTBCSlot(19, "WARRIOR", "RANGED"),
    },
})

TBC:AuditClass(29, "SHAMAN", {
    sources = { sources.tbcItems, sources.shamanTwentyNine },
    note = "Alliance Draenei Shaman are supported. All level-29 slots and random suffix bases were audited; neutral items lose the Era-only class faction lock, while genuine Horde quest routes remain marked. TBC-enchantable quest pieces are alternatives, not automatic BiS.",
    role = "Enhancement / Elemental / Restoration / Draenei Support",
    slots = {
        HEAD = auditedShamanSlot(29, "HEAD"), SHOULDERS = auditedShamanSlot(29, "SHOULDERS"),
        LEGS = auditedShamanSlot(29, "LEGS"),
        NECK = auditedShamanSlot(29, "NECK"), BACK = auditedShamanSlot(29, "BACK"),
        CHEST = auditedShamanSlot(29, "CHEST"), WRISTS = auditedShamanSlot(29, "WRISTS"),
        HANDS = auditedShamanSlot(29, "HANDS"), WAIST = auditedShamanSlot(29, "WAIST"),
        FEET = auditedShamanSlot(29, "FEET"), FINGER_1 = auditedShamanSlot(29, "FINGER_1"),
        FINGER_2 = auditedShamanSlot(29, "FINGER_2"), TRINKET_1 = auditedShamanSlot(29, "TRINKET_1"),
        TRINKET_2 = auditedShamanSlot(29, "TRINKET_2"), ONE_HAND = auditedShamanSlot(29, "ONE_HAND"),
        TWO_HAND = auditedShamanSlot(29, "TWO_HAND"), OFF_HAND = auditedShamanSlot(29, "OFF_HAND"),
    },
})

TBC:AuditClass(29, "WARLOCK", {
    sources = { sources.tbcItems, sources.warlockTwentyNine },
    note = "Full slot/tier review found the Era profile still representative for TBC. Rating conversion and item-level-35 enchant eligibility change set construction, but do not justify silently promoting a lower-stat base item.",
    slots = {
        TRINKET_1 = pvpTrinketSlot(29, "WARLOCK", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(29, "WARLOCK", "TRINKET_2"),
        HEAD = auditedTBCSlot(29, "WARLOCK", "HEAD"), NECK = auditedTBCSlot(29, "WARLOCK", "NECK"),
        SHOULDERS = auditedTBCSlot(29, "WARLOCK", "SHOULDERS"), BACK = auditedTBCSlot(29, "WARLOCK", "BACK"),
        CHEST = auditedTBCSlot(29, "WARLOCK", "CHEST"), WRISTS = auditedTBCSlot(29, "WARLOCK", "WRISTS"),
        HANDS = auditedTBCSlot(29, "WARLOCK", "HANDS"), WAIST = auditedTBCSlot(29, "WARLOCK", "WAIST"),
        LEGS = auditedTBCSlot(29, "WARLOCK", "LEGS"), FEET = auditedTBCSlot(29, "WARLOCK", "FEET"),
        FINGER_1 = auditedTBCSlot(29, "WARLOCK", "FINGER_1"), FINGER_2 = auditedTBCSlot(29, "WARLOCK", "FINGER_2"),
        ONE_HAND = auditedTBCSlot(29, "WARLOCK", "ONE_HAND"), TWO_HAND = auditedTBCSlot(29, "WARLOCK", "TWO_HAND"),
        OFF_HAND = auditedTBCSlot(29, "WARLOCK", "OFF_HAND"), RANGED = auditedTBCSlot(29, "WARLOCK", "RANGED"),
    },
})

TBC:AuditClass(29, "WARRIOR", {
    sources = { sources.tbcItems, sources.warriorTwentyNine },
    note = "All slots were checked against the period 29 Warrior discussion. War Rider Bracers and Raptor Hunter Tunic remain explicit because their item levels enable TBC enchant choices; the guide also confirms that item-level restrictions must be checked per target item.",
    slots = {
        TRINKET_1 = pvpTrinketSlot(29, "WARRIOR", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(29, "WARRIOR", "TRINKET_2"),
        HEAD = auditedTBCSlot(29, "WARRIOR", "HEAD"), NECK = auditedTBCSlot(29, "WARRIOR", "NECK"),
        SHOULDERS = auditedTBCSlot(29, "WARRIOR", "SHOULDERS"), BACK = auditedTBCSlot(29, "WARRIOR", "BACK"),
        CHEST = auditedTBCSlot(29, "WARRIOR", "CHEST"), WRISTS = auditedTBCSlot(29, "WARRIOR", "WRISTS"),
        HANDS = auditedTBCSlot(29, "WARRIOR", "HANDS"), WAIST = auditedTBCSlot(29, "WARRIOR", "WAIST"),
        LEGS = auditedTBCSlot(29, "WARRIOR", "LEGS"), FEET = auditedTBCSlot(29, "WARRIOR", "FEET"),
        FINGER_1 = auditedTBCSlot(29, "WARRIOR", "FINGER_1"), FINGER_2 = auditedTBCSlot(29, "WARRIOR", "FINGER_2"),
        ONE_HAND = auditedTBCSlot(29, "WARRIOR", "ONE_HAND"), TWO_HAND = auditedTBCSlot(29, "WARRIOR", "TWO_HAND"),
        OFF_HAND = auditedTBCSlot(29, "WARRIOR", "OFF_HAND"), RANGED = auditedTBCSlot(29, "WARRIOR", "RANGED"),
    },
})

TBC:AuditClass(39, "SHAMAN", {
    sources = { sources.tbcItems, sources.shamanThirtyNine },
    note = "Alliance Draenei Shaman are supported at 39. Every inherited tier was checked; blanket Horde class locks are removed from neutral items while genuine Horde quests and their XP risk remain marked. On the patch 2.3+ TBC ruleset, two-handed axes and maces use weapon-master training instead of the old Enhancement talent.",
    role = "Elemental / Restoration / Enhancement / Draenei Support",
    slots = {
        HEAD = auditedShamanSlot(39, "HEAD"), NECK = auditedShamanSlot(39, "NECK"),
        SHOULDERS = auditedShamanSlot(39, "SHOULDERS"), BACK = auditedShamanSlot(39, "BACK"),
        CHEST = auditedShamanSlot(39, "CHEST"), WRISTS = auditedShamanSlot(39, "WRISTS"),
        HANDS = auditedShamanSlot(39, "HANDS"), WAIST = auditedShamanSlot(39, "WAIST"),
        LEGS = auditedShamanSlot(39, "LEGS"), FEET = auditedShamanSlot(39, "FEET"),
        FINGER_1 = auditedShamanSlot(39, "FINGER_1"), FINGER_2 = auditedShamanSlot(39, "FINGER_2"),
        TRINKET_1 = auditedShamanSlot(39, "TRINKET_1"), TRINKET_2 = auditedShamanSlot(39, "TRINKET_2"),
        ONE_HAND = auditedShamanSlot(39, "ONE_HAND"), TWO_HAND = auditedShamanSlot(39, "TWO_HAND"),
        OFF_HAND = auditedShamanSlot(39, "OFF_HAND"),
    },
})

TBC:AuditClass(39, "WARLOCK", {
    sources = { sources.tbcItems, sources.warlockThirtyNine },
    note = "All level-39 slot tiers were reviewed for TBC required level, cloth proficiency, rating conversion and acquisition. Existing Shadow/control alternatives remain representative; PvP rewards stay available but their Era-only wording is removed.",
    slots = {
        TRINKET_1 = pvpTrinketSlot(39, "WARLOCK", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(39, "WARLOCK", "TRINKET_2"),
        HEAD = auditedTBCSlot(39, "WARLOCK", "HEAD"), NECK = auditedTBCSlot(39, "WARLOCK", "NECK"),
        SHOULDERS = auditedTBCSlot(39, "WARLOCK", "SHOULDERS"), BACK = auditedTBCSlot(39, "WARLOCK", "BACK"),
        CHEST = auditedTBCSlot(39, "WARLOCK", "CHEST"), WRISTS = auditedTBCSlot(39, "WARLOCK", "WRISTS"),
        HANDS = auditedTBCSlot(39, "WARLOCK", "HANDS"), WAIST = auditedTBCSlot(39, "WARLOCK", "WAIST"),
        LEGS = auditedTBCSlot(39, "WARLOCK", "LEGS"), FEET = auditedTBCSlot(39, "WARLOCK", "FEET"),
        FINGER_1 = auditedTBCSlot(39, "WARLOCK", "FINGER_1"), FINGER_2 = auditedTBCSlot(39, "WARLOCK", "FINGER_2"),
        ONE_HAND = auditedTBCSlot(39, "WARLOCK", "ONE_HAND"), TWO_HAND = auditedTBCSlot(39, "WARLOCK", "TWO_HAND"),
        OFF_HAND = auditedTBCSlot(39, "WARLOCK", "OFF_HAND"), RANGED = auditedTBCSlot(39, "WARLOCK", "RANGED"),
    },
})

TBC:AuditClass(39, "WARRIOR", {
    sources = { sources.tbcItems, sources.warriorThirtyNine },
    note = "All level-39 tiers were checked for TBC required level, mail and weapon proficiency, rating conversion and XP-bearing acquisition. Pendulum of Doom remains a rare burst profile rather than an uncontested universal choice; PvP reward wording is updated for TBC.",
    slots = {
        TRINKET_1 = pvpTrinketSlot(39, "WARRIOR", "TRINKET_1"),
        TRINKET_2 = pvpTrinketSlot(39, "WARRIOR", "TRINKET_2"),
        HEAD = auditedTBCSlot(39, "WARRIOR", "HEAD"), NECK = auditedTBCSlot(39, "WARRIOR", "NECK"),
        SHOULDERS = auditedTBCSlot(39, "WARRIOR", "SHOULDERS"), BACK = auditedTBCSlot(39, "WARRIOR", "BACK"),
        CHEST = auditedTBCSlot(39, "WARRIOR", "CHEST"), WRISTS = auditedTBCSlot(39, "WARRIOR", "WRISTS"),
        HANDS = auditedTBCSlot(39, "WARRIOR", "HANDS"), WAIST = auditedTBCSlot(39, "WARRIOR", "WAIST"),
        LEGS = auditedTBCSlot(39, "WARRIOR", "LEGS"), FEET = auditedTBCSlot(39, "WARRIOR", "FEET"),
        FINGER_1 = auditedTBCSlot(39, "WARRIOR", "FINGER_1"), FINGER_2 = auditedTBCSlot(39, "WARRIOR", "FINGER_2"),
        ONE_HAND = auditedTBCSlot(39, "WARRIOR", "ONE_HAND"), TWO_HAND = auditedTBCSlot(39, "WARRIOR", "TWO_HAND"),
        OFF_HAND = auditedTBCSlot(39, "WARRIOR", "OFF_HAND"), RANGED = auditedTBCSlot(39, "WARRIOR", "RANGED"),
    },
})
