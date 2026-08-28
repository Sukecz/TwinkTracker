local addonName, ns = ...

local TBC = ns.TBCData

local function class(overall, offense, survival, utility, role, summary, note)
    return { overall=overall, offense=offense, survival=survival, utility=utility, role=role, summary=summary, note=note }
end

local commonSources = {
    "https://www.wowhead.com/tbc/guide/class-talent-overview-the-burning-crusade-classic-tbc",
    "https://www.wowhead.com/tbc/guide/classes/paladin/overview-basics",
    "https://www.wowhead.com/tbc/guide/classes/shaman/overview-basics",
    "https://www.wowhead.com/tbc/guide/burning-crusade-classic-pre-patch-content-overview-whats-new",
}

local dataByLevel = {
    [19] = {
        version = "2026-08-13-tbc.1",
        sources = {
            commonSources[1], commonSources[2], commonSources[3], commonSources[4],
            "https://us.forums.blizzard.com/en/wow/t/who-is-lvl-19-twinking-in-tbc/1008403",
            "https://xpoff.com/threads/tbc-19-hunter-checklist.96778/",
            "https://www.reddit.com/r/classicwowtbc/comments/lyhi9q/how_is_warlock_at_19_twink_in_tbc/",
        },
        intro = "A TBC Classic level-19 estimate synthesized from contemporary class guides and bracket discussion. Equal tiers are not ranked within the tier; race, role and team composition can move a class substantially.",
        criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
        classes = {
            DRUID = class("A",5,9,10,"FLAG CARRIER / HYBRID","Bear Form, shifting, roots and healing retain elite flag-carrying value, while TBC gear and enchants reinforce survival.","ROLE DEPENDENT"),
            HUNTER = class("S",10,8,10,"RANGED DPS / CONTROL","Ranged pressure, pet scaling, Wing Clip, slows and kiting define the TBC level-19 midfield.","PET XP REQUIRES PLANNING"),
            MAGE = class("B",7,5,9,"CONTROL / CASTER PRESSURE","Nova, Polymorph and repeated slows provide strong team control; limited mobility before Blink keeps survival role-dependent.","ROLE DEPENDENT"),
            PALADIN = class("A",6,10,10,"SUPPORT / HEALER / FC","Healing, blessings and defensive cooldowns anchor a team; Blood Elf makes Paladin available to Horde and adds Arcane Torrent utility.","ALLIANCE OR BLOOD ELF"),
            PRIEST = class("S",8,9,10,"HEALER / SUPPORT","Shields, dispels, fear, efficient healing and wand pressure remain the bracket's most complete support package."),
            ROGUE = class("A",10,6,8,"ASSASSIN / DEFENSE","Stealth and exceptional opener burst create decisive picks, but ranged slows and coordinated peeling punish failed entries."),
            SHAMAN = class("B",7,7,8,"HYBRID / SUPPORT","Shocks, heals and totems offer flexible support, while the pre-Ghost-Wolf kit remains more composition-dependent than higher brackets.","HORDE OR DRAENEI • SPEC DEPENDENT"),
            WARLOCK = class("C",7,6,7,"DOT PRESSURE / CONTROL","Fear, pets and damage-over-time pressure remain useful, but contemporary TBC discussion places the class behind Hunter and Rogue in direct agency.","TEAM DEPENDENT"),
            WARRIOR = class("C",7,5,7,"PEEL / SUPPORT","Charge, Hamstring and shield swaps help coordinated teams, but target access and solo survival remain severe constraints."),
        },
    },
    [29] = {
        version = "2026-08-13-tbc.1",
        sources = {
            commonSources[1], commonSources[2], commonSources[3], commonSources[4],
            "https://xpoff.com/threads/29-tbc-gearing-all-classes-gear-sheet.95156/",
            "https://www.wowhead.com/tbc/forums/topic/the-best-lvl-to-twink-for-each-class-8663",
            "https://www.wowhead.com/classic-ptr/forums/topic/lvl-29-twink-again-39712",
        },
        intro = "A TBC Classic level-29 community estimate. Equal tiers are not ranked within the tier; the bracket has several top builds and TBC enchant eligibility can magnify gear differences.",
        criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
        classes = {
            DRUID = class("A",7,9,10,"FLAG CARRIER / HYBRID","Cat Form, Feral Charge builds, shifting, roots and healing create elite objective mobility and flexible support.","ROLE DEPENDENT"),
            HUNTER = class("S",10,8,10,"RANGED DPS / CONTROL","Cheetah mobility, traps, pet pressure and exceptional ranged weapons make Hunter consistently dominant."),
            MAGE = class("S",9,7,10,"CONTROL / BURST","Blink, Counterspell, Nova and Polymorph give Mage outstanding control, resets and organized-play impact."),
            PALADIN = class("A",8,10,10,"HEALER / SUPPORT / MELEE","Durability, healing and blessings make Paladin a premier team anchor on either faction; Blood Elf adds an AoE silence.","ALLIANCE OR BLOOD ELF"),
            PRIEST = class("A",8,9,10,"HEALER / SUPPORT","Healing, shields, dispels, fear and offensive pressure provide exceptional organized value."),
            ROGUE = class("S",10,8,9,"ASSASSIN / DEFENSE","Cheap Shot, Vanish, poisons, Sprint and stealth provide exceptional solo agency and flag-return pressure."),
            SHAMAN = class("B",8,8,9,"HYBRID / SUPPORT","Instant Ghost Wolf builds, Purge, shocks, totems and healing offer strong but specialization-dependent utility.","HORDE OR DRAENEI • SPEC DEPENDENT"),
            WARLOCK = class("B",9,7,8,"DOT PRESSURE / CONTROL","DoTs, Fear and pets can overwhelm prolonged fights, but mobility and focused-fire survival remain limiting.","GEAR DEPENDENT"),
            WARRIOR = class("C",8,6,7,"MELEE DPS / PEEL","Weapon and enchant scaling produce heavy hits, but Intercept is learned at 30 and is unavailable in this bracket."),
        },
    },
    [39] = {
        version = "2026-08-13-tbc.1",
        sources = {
            commonSources[1], commonSources[2], commonSources[3], commonSources[4],
            "https://xpoff.com/threads/39-tbc-bis-standards-phase-1.96062/",
            "https://xpoff.com/threads/classic-vanilla-or-tbc-for-39s.95227/",
            "https://xpoff.com/threads/39-twink-tier-list.91477/",
        },
        intro = "A TBC Classic level-39 community estimate. Equal tiers are not ranked within the tier; every class has a viable build and the bracket is especially sensitive to composition, rare gear and high-end enchants.",
        criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
        classes = {
            DRUID = class("A",8,10,10,"FLAG CARRIER / HYBRID","Travel Form, shifting, Feral Charge or Nature's Swiftness builds, roots and healing make Druid the premier mobile objective carrier.","ROLE DEPENDENT"),
            HUNTER = class("S",10,8,10,"RANGED DPS / CONTROL","Scatter Shot or Intimidation builds, traps, pets and Cheetah mobility dominate open space and coordinated pressure."),
            MAGE = class("S",10,8,10,"CONTROL / BURST","Blink, Counterspell and 21-point talent options such as Ice Block, Presence of Mind or Blast Wave create exceptional control and burst."),
            PALADIN = class("A",8,10,10,"HEALER / SUPPORT / MELEE","Defensive cooldowns, healing, Blessing of Freedom and protection utility anchor either faction; level 39 remains below 31-point talents.","ALLIANCE OR BLOOD ELF"),
            PRIEST = class("A",9,9,10,"HEALER / SHADOW SUPPORT","Efficient healing, shields, dispels, fear and 21-point Discipline or Shadow options provide broad organized value."),
            ROGUE = class("S",10,9,10,"ASSASSIN / DEFENSE","Preparation or Cold Blood builds, Kidney Shot, Blind, poisons and stealth create elite kill and flag-return control."),
            SHAMAN = class("A",9,8,10,"HYBRID / SUPPORT","Windfury, Purge, shocks, Grounding Totem, Ghost Wolf and 21-point talent options support several powerful roles.","HORDE OR DRAENEI • SPEC DEPENDENT"),
            WARLOCK = class("A",10,8,9,"DOT PRESSURE / CONTROL","Strong TBC enchant scaling, DoTs, Fear and pets sustain immense pressure, though Soul Link is still unavailable before level 40.","GEAR DEPENDENT"),
            WARRIOR = class("A",10,8,8,"ARMS PRESSURE / PEEL","Intercept, Pummel, Hamstring and exceptional weapon scaling create real melee pressure; Mortal Strike needs 31 talent points and is unavailable at 39.","GEAR AND TEAM DEPENDENT"),
        },
    },
}

for level, data in pairs(dataByLevel) do
    local bracket = assert(TBC:GetBracket(level), "Missing TBC bracket " .. level)
    data.classOrder = bracket.bis.classOrder
    bracket.classTiers = data
end

ns.TBCClassTiersData = dataByLevel
