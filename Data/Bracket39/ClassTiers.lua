local addonName, ns = ...

local function class(overall, offense, survival, utility, role, summary, note)
    return { overall=overall, offense=offense, survival=survival, utility=utility, role=role, summary=summary, note=note }
end

ns.Bracket39ClassTiersData = {
    version = "2026-08-13",
    intro = "A curated level-39 community estimate. Every class has a viable build; composition, role and access to rare gear can move a class substantially.",
    criteria = "OFFENSE = kill pressure   •   SURVIVAL = durability and escapes   •   UTILITY = control, healing, mobility and objectives",
    classOrder = ns.Bracket39BisData.classOrder,
    classes = {
        DRUID = class("A",7,9,10,"FLAG CARRIER / HYBRID","Travel Form, shifting, roots and healing make Druid the premier mobile objective carrier.","ROLE DEPENDENT"),
        HUNTER = class("S",10,8,9,"RANGED DPS / CONTROL","Strong ranged scaling, traps, pet pressure and Cheetah mobility dominate open space."),
        MAGE = class("S",9,8,10,"CONTROL / BURST","Blink, Counterspell and a mature control kit give Mage exceptional team and solo impact."),
        PALADIN = class("A",8,10,10,"HEALER / SUPPORT / MELEE","Heavy durability, Cleanse and defensive blessings anchor Alliance teams.","ALLIANCE ONLY"),
        PRIEST = class("A",8,9,10,"HEALER / SHADOW SUPPORT","Efficient healing, shields, dispels, fear and Shadow pressure provide broad organized value."),
        ROGUE = class("S",10,8,9,"ASSASSIN / DEFENSE","A full control toolkit, poisons and stealth create elite kill and flag-return pressure."),
        SHAMAN = class("A",9,8,10,"HYBRID / SUPPORT","Purge, shocks, totems, healing and Ghost Wolf support several powerful team roles.","HORDE ONLY • SPEC DEPENDENT"),
        WARLOCK = class("A",9,8,9,"DOT PRESSURE / CONTROL","DoTs, Fear, pets and improved survivability sustain pressure across long fights."),
        WARRIOR = class("S",10,9,8,"ARMS PRESSURE / PEEL","Intercept, Mortal Strike builds, mail armor and strong weapon scaling create decisive melee pressure.","GEAR DEPENDENT"),
    },
}
