local addonName, ns = ...

local function class(overall, offense, survival, utility, role, summary, note)
    return { overall=overall, offense=offense, survival=survival, utility=utility, role=role, summary=summary, note=note }
end

ns.ClassTiersData = {
    version = "2026-08-11",
    status = "CURATED COMMUNITY OVERVIEW",
    intro = "A fast level-19 overview synthesized from Classic community guides and bracket discussions. Equal tiers are not ranked within the tier.",
    criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
    classOrder = ns.BisData.classOrder,
    classes = {
        DRUID = class("A",5,9,10,"FLAG CARRIER","Elite objective mobility through Bear Form, shifting and roots; less dominant outside flag play.","ROLE DEPENDENT"),
        HUNTER = class("S",10,8,9,"RANGED DPS / CONTROL","Ranged pressure, pet utility, slows and kiting make Hunter consistently dominant."),
        MAGE = class("B",6,5,9,"CONTROL","Nova, Polymorph and slows bring strong team control, but solo durability and damage lag behind.","ROLE DEPENDENT"),
        PALADIN = class("A",5,10,10,"SUPPORT / HEALER / FC","Defensive cooldowns and Blessings can decide team fights despite limited mobility.","ALLIANCE ONLY"),
        PRIEST = class("S",7,9,10,"HEALER / SUPPORT","Shields, dispels, fear, efficient healing and wand pressure define the bracket's top healer."),
        ROGUE = class("A",9,6,7,"ASSASSIN / DEFENSE","Stealth and burst excel at target picks and objective defense, with difficult top-tier counters."),
        SHAMAN = class("B",7,7,7,"HYBRID / SUPPORT","Totems, shocks and burst add useful utility, but the level-19 kit remains spec-dependent.","HORDE ONLY • SPEC DEPENDENT"),
        WARLOCK = class("C",6,5,6,"DOT / CONTROL","Fear and damage-over-time pressure disrupt fights, but other low-level casters are more complete."),
        WARRIOR = class("C",6,4,7,"PEEL / SUPPORT","Hamstring, Charge and shield play help a coordinated team; solo target access is punishing."),
    },
}
