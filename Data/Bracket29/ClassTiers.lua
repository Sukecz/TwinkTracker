local addonName, ns = ...

local function class(overall, offense, survival, utility, role, summary, note)
    return { overall=overall, offense=offense, survival=survival, utility=utility, role=role, summary=summary, note=note }
end

ns.Bracket29ClassTiersData = {
    version = "2026-08-11",
    status = "CURATED COMMUNITY ESTIMATE",
    intro = "A fast level-29 community estimate. Sources are thinner than for level 19, so role, build and gear can move a class substantially.",
    criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
    classOrder = ns.Bracket29BisData.classOrder,
    classes = {
        DRUID = class("B",6,8,9,"FLAG CARRIER / HYBRID","Cat Form, shifting, roots and healing create strong mobility, with less consistent broad impact.","ROLE DEPENDENT"),
        HUNTER = class("S",10,8,9,"RANGED DPS / CONTROL","Ranged scaling, Cheetah mobility, traps and exceptional weapons dominate every setting."),
        MAGE = class("S",9,7,10,"CONTROL / BURST","Blink and a fuller control kit make Mage one of the strongest organized-play classes."),
        PALADIN = class("A",7,10,10,"HEALER / SUPPORT / FC","Durability and defensive utility make a geared Paladin a premier Alliance team anchor.","ALLIANCE ONLY"),
        PRIEST = class("A",7,9,10,"HEALER / SUPPORT","Healing, shields, dispels, fear and scouting produce exceptional organized value."),
        ROGUE = class("A",10,8,8,"ASSASSIN / DEFENSE","Cheap Shot, Vanish, poisons and stealth provide superb solo agency and objective defense."),
        SHAMAN = class("B",8,7,9,"HYBRID / SUPPORT","Ghost Wolf, Purge, shocks, totems and healing offer strong but build-dependent utility.","HORDE ONLY • SPEC DEPENDENT"),
        WARLOCK = class("B",9,6,8,"DOT PRESSURE / CONTROL","A geared shadow build can overwhelm teams with DoTs, but remains fragile and gear-dependent.","GEAR DEPENDENT"),
        WARRIOR = class("C",8,6,6,"MELEE DPS / PEEL","Heavy hits and Hamstring pressure help, but no Intercept until 30 severely limits access."),
    },
}
