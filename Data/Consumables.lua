local addonName, ns = ...

local catalog = {
    [14530]={name="Heavy Runecloth Bandage",effect="Heals 2000 over 8 sec",profession="First Aid 225 to use",restrictions="A level-19 character cannot craft this; obtain finished bandages from another character or the Auction House; damage interrupts; Recently Bandaged for 60 sec"},
    [14529]={name="Runecloth Bandage",effect="Heals 1360 over 8 sec",profession="First Aid 200 to use",restrictions="Weaker Runecloth fallback; a level-19 character cannot craft this; obtain finished bandages from another character or the Auction House; damage interrupts; Recently Bandaged for 60 sec"},
    [8544]={name="Mageweave Bandage",effect="Heals 800 over 8 sec",profession="First Aid 150",restrictions="Damage interrupts; Recently Bandaged for 60 sec"},
    [6451]={name="Heavy Silk Bandage",effect="Heals 640 over 8 sec",profession="First Aid 125",restrictions="Damage interrupts; Recently Bandaged for 60 sec"},
    [6453]={name="Strong Anti-Venom",effect="Cures a poison up to level 35",restrictions="Situational poison removal"},
    [3665]={name="Curiously Tasty Omelet",effect="Restores 552 health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [5527]={name="Goblin Deviled Clams",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [3726]={name="Big Bear Steak",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [5479]={name="Crispy Lizard Tail",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=12,restrictions="Well Fed; alternatives do not stack"},
    [3664]={name="Crocolisk Gumbo",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [3666]={name="Gooey Spider Cake",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [3727]={name="Hot Lion Chops",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [5480]={name="Lean Venison",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [12209]={name="Lean Wolf Steak",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [3663]={name="Murloc Fin Soup",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [1082]={name="Redridge Goulash",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=10,restrictions="Well Fed; alternatives do not stack"},
    [1017]={name="Seasoned Wolf Kabob",effect="Restores health; Well Fed: 6 Stamina and Spirit",requiredLevel=15,restrictions="Well Fed; alternatives do not stack"},
    [21072]={name="Smoked Sagefish",effect="Restores health and mana; Well Fed: 3 mana every 5 sec",requiredLevel=10,restrictions="Well Fed; alternatives do not stack"},
    [1205]={name="Melon Juice",effect="Restores 835 mana over 24 sec",requiredLevel=15},
    [21151]={name="Rumsey Rum Black Label",effect="15 Stamina for 15 min",restrictions="Intoxicates; Firemaw availability and stacking need live verification"},
    [929]={name="Healing Potion",effect="Restores 280-360 health",requiredLevel=12,restrictions="Shares the 2 min potion cooldown"},
    [3385]={name="Lesser Mana Potion",effect="Restores 280-360 mana",requiredLevel=14,restrictions="Shares the 2 min potion cooldown"},
    [2456]={name="Minor Rejuvenation Potion",effect="Restores 90-150 health and mana",requiredLevel=5,restrictions="Shares the 2 min potion cooldown"},
    [2459]={name="Swiftness Potion",effect="50% run speed for 15 sec",requiredLevel=5,restrictions="Shares the 2 min potion cooldown"},
    [3384]={name="Minor Magic Resistance Potion",effect="25 to all magic resistances for 3 min",requiredLevel=12,restrictions="Shares the 2 min potion cooldown"},
    [6048]={name="Shadow Protection Potion",effect="Absorbs 675-1125 Shadow damage",requiredLevel=17,restrictions="Shares the 2 min potion cooldown"},
    [6051]={name="Holy Protection Potion",effect="Absorbs 300-500 Holy damage",requiredLevel=10,restrictions="Shares the 2 min potion cooldown"},
    [6372]={name="Swim Speed Potion",effect="100% swim speed for 20 sec",requiredLevel=10,restrictions="Shares the 2 min potion cooldown"},
    [3390]={name="Elixir of Lesser Agility",effect="8 Agility for 1 hour",requiredLevel=18},
    [6662]={name="Elixir of Giant Growth",effect="8 Strength and increased size for 2 min",requiredLevel=8},
    [3389]={name="Elixir of Defense",effect="150 Armor for 1 hour",requiredLevel=16},
    [3388]={name="Strong Troll's Blood Potion",effect="Regenerates 6 health every 5 sec for 1 hour",requiredLevel=15},
    [2458]={name="Elixir of Minor Fortitude",effect="27 maximum health for 1 hour",requiredLevel=2},
    [3383]={name="Elixir of Wisdom",effect="6 Intellect for 1 hour",requiredLevel=10},
    [6373]={name="Elixir of Firepower",effect="10 Fire spell damage for 30 min",requiredLevel=18},
    [3012]={name="Scroll of Agility",effect="5 Agility for 30 min",requiredLevel=10,restrictions="Verify same-stat buff replacement live"},
    [954]={name="Scroll of Strength",effect="5 Strength for 30 min",requiredLevel=10,restrictions="Verify same-stat buff replacement live"},
    [1180]={name="Scroll of Stamina",effect="4 Stamina for 30 min",requiredLevel=5,restrictions="Verify same-stat buff replacement live"},
    [955]={name="Scroll of Intellect",effect="4 Intellect for 30 min",requiredLevel=5,restrictions="Verify same-stat buff replacement live"},
    [1712]={name="Scroll of Spirit II",effect="7 Spirit for 30 min",requiredLevel=15,restrictions="Verify same-stat buff replacement live"},
    [1478]={name="Scroll of Protection II",effect="120 Armor for 30 min",requiredLevel=15,restrictions="Verify armor-buff stacking live"},
    [4380]={name="Big Bronze Bomb",effect="85-115 Fire damage and 2 sec break-on-damage stun",profession="Engineering 140",restrictions="1 min explosives cooldown"},
    [4378]={name="Heavy Dynamite",effect="128-172 Fire damage in a 5 yard radius",profession="Engineering 125",restrictions="1 min explosives cooldown; no stun"},
    [4384]={name="Explosive Sheep",effect="Summons a sheep that explodes for 135-165 damage",profession="Engineering 150",restrictions="1 min cooldown; targeting needs live verification"},
    [4366]={name="Target Dummy",effect="Attracts nearby monsters for up to 15 sec",profession="Engineering 85",restrictions="PvE escape tool; does not taunt players"},
    [4381]={name="Minor Recombobulator",effect="Removes Polymorph from a friendly target; restores 150-250 health and mana",profession="Engineering 140",restrictions="Equipped trinket with 10 charges"},
    [4388]={name="Discombobulator Ray",effect="Reduces the target's melee damage and spell power by 40 and movement speed by 20% for 12 sec",restrictions="No Engineering required to use; 5 charges; crafted at Engineering 160; shares the 1 min explosives cooldown"},
    [7189]={name="Goblin Rocket Boots",effect="Significantly increases run speed for 20 sec",restrictions="No level or Engineering requirement to use; equipped cloth boots; 5 min cooldown; can explode and be destroyed; avoid on Hardcore"},
    [2091]={name="Magic Dust",effect="Puts one enemy to sleep for up to 30 sec",requiredLevel=10,restrictions="Damage awakens the target; 1 min cooldown; rare Dust Devil drop in Westfall"},
    [5332]={name="Glowing Cat Figurine",effect="Summons an uncontrolled Ghost Saber guardian for 10 min",restrictions="Unique; binds when picked up; one charge; rare Ghost Saber drop in Darkshore"},
    [20744]={name="Minor Wizard Oil",effect="8 spell damage for 30 min",requiredLevel=5,restrictions="Temporary weapon coating"},
    [2871]={name="Heavy Sharpening Stone",effect="4 damage to a sharp weapon for 30 min",requiredLevel=15,restrictions="Temporary weapon coating"},
    [3241]={name="Heavy Weightstone",effect="4 damage to a blunt weapon for 30 min",requiredLevel=15,restrictions="Temporary weapon coating"},
    [2515]={name="Sharp Arrow",effect="3.5 ranged damage per second",requiredLevel=10,restrictions="Bow ammunition"},
    [2519]={name="Heavy Shot",effect="3.5 ranged damage per second",requiredLevel=10,restrictions="Gun ammunition"},
    [8068]={name="Crafted Heavy Shot",effect="4.5 ranged damage per second",requiredLevel=15,restrictions="Gun ammunition"},
    [17056]={name="Light Feather",effect="Reagent for Slow Fall",restrictions="Mage class resource; consumed when Slow Fall is cast"},
    [2136]={name="Conjured Purified Water",effect="Restores 835 mana over 24 sec",requiredLevel=15,restrictions="Conjured Mage item"},
    [1113]={name="Conjured Bread",effect="Restores 243 health over 21 sec",requiredLevel=5,restrictions="Conjured Mage item"},
    [7676]={name="Thistle Tea",effect="Restores 100 Energy",requiredLevel=5,restrictions="Rogue only; obtain from a higher-level Rogue because the recipe comes from the level-20 class quest"},
    [6265]={name="Soul Shard",effect="Resource for summons and stone creation",restrictions="Warlock only; generated from an XP or honor-eligible target"},
    [5512]={name="Minor Healthstone",effect="Restores 100 health",restrictions="Warlock only; self-created at level 10 for one Soul Shard"},
    [5232]={name="Minor Soulstone",effect="Stores a soul for resurrection",requiredLevel=18,restrictions="Warlock only; Era only; unavailable for Hardcore resurrection; live test pending"},
    [5631]={name="Rage Potion",effect="Restores 20-40 Rage",requiredLevel=4,restrictions="Warrior only; shares the 2 min potion cooldown"},
}

for itemID, entry in pairs(catalog) do
    entry.itemID = itemID
    entry.wowhead = "https://www.wowhead.com/classic/item=" .. itemID
end

ns.ConsumablesData = {
    version = "2026-08-11",
    categoryOrder = { "BANDAGES", "FOOD_DRINK", "POTIONS", "ELIXIRS", "SCROLLS", "ENGINEERING", "WORLD_UTILITY", "WEAPON", "CLASS" },
    categoryNames = {
        BANDAGES="Bandages", FOOD_DRINK="Food and Drink", POTIONS="Potions",
        ELIXIRS="Elixirs and Buffs", SCROLLS="Scrolls", ENGINEERING="Engineering",
        WORLD_UTILITY="World Utility", WEAPON="Weapon Consumables", CLASS="Class Resources",
    },
    catalog = catalog,
    classes = {},
}

local function recommendation(itemID, priority, roles, note)
    return { itemID=itemID, priority=priority, roles=roles, note=note }
end

local function addProfile(classToken, categories)
    local order = {}
    for _, category in ipairs(ns.ConsumablesData.categoryOrder) do
        if categories[category] and #categories[category] > 0 then order[#order+1] = category end
    end
    ns.ConsumablesData.classes[classToken] = { categoryOrder=order, categories=categories }
end

local bandage = {
    recommendation(14530,"CORE","maximum level-19 First Aid healing; usable but not craftable at level 19"),
    recommendation(14529,"ALTERNATIVE","weaker Runecloth option; usable but not craftable at level 19"),
    recommendation(8544,"ALTERNATIVE","self-crafted at level 19"),
    recommendation(6451,"ALTERNATIVE","First Aid 125 fallback"),
    recommendation(6453,"OPTIONAL","anti-poison"),
}
local engineering = {
    recommendation(4380,"CORE","control / interrupt"),
    recommendation(4378,"CORE","area damage"),
    recommendation(4388,"CORE","PvP debuff / slow; obtain from an Engineering 160 crafter"),
    recommendation(4384,"OPTIONAL","burst damage"),
    recommendation(4366,"OPTIONAL","open-world / Hardcore escape"),
    recommendation(4381,"OPTIONAL","friendly Polymorph removal / emergency healing"),
    recommendation(7189,"OPTIONAL","equipped mobility; destructive malfunction risk; not for Hardcore"),
}
local worldUtility = {
    recommendation(2091,"CORE","break-on-damage crowd control"),
    recommendation(5332,"OPTIONAL","rare one-use guardian"),
}
local staminaSpiritFood = {
    recommendation(3665,"CORE","Well Fed: 6 Stamina and Spirit"),
    recommendation(5527,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(3726,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(5479,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(3664,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(3666,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(3727,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(5480,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(12209,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(3663,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(1082,"ALTERNATIVE","same Well Fed bonus"),
    recommendation(1017,"ALTERNATIVE","same Well Fed bonus"),
}
local physicalFood = { recommendation(21151,"CORE","survival") }
local casterFood = { recommendation(21072,"CORE","mana sustain"), recommendation(21151,"ALTERNATIVE","survival") }
for _, recommendationEntry in ipairs(staminaSpiritFood) do
    physicalFood[#physicalFood+1] = recommendationEntry
    casterFood[#casterFood+1] = recommendationEntry
end
local physicalPotions = {
    recommendation(929,"CORE","emergency healing"), recommendation(2459,"CORE","mobility"),
    recommendation(3384,"OPTIONAL","all-school resistance"), recommendation(6048,"OPTIONAL","Shadow protection"),
    recommendation(6051,"OPTIONAL","Holy protection"), recommendation(6372,"OPTIONAL","world travel / escape"),
}
local casterPotions = {
    recommendation(3385,"CORE","mana emergency"), recommendation(929,"CORE","emergency healing"),
    recommendation(2456,"OPTIONAL","combined health and mana"), recommendation(2459,"CORE","mobility"),
    recommendation(3384,"OPTIONAL","all-school resistance"), recommendation(6048,"OPTIONAL","Shadow protection"),
    recommendation(6372,"OPTIONAL","world travel / escape"),
}
local physicalElixirs = {
    recommendation(3390,"CORE","Agility / damage / avoidance"), recommendation(6662,"OPTIONAL","short Strength burst"),
    recommendation(3389,"CORE","physical defense"), recommendation(2458,"OPTIONAL","maximum health"),
    recommendation(3388,"OPTIONAL","health regeneration"),
}
local casterElixirs = {
    recommendation(3383,"CORE","Intellect / mana"), recommendation(3389,"OPTIONAL","physical defense"),
    recommendation(2458,"OPTIONAL","maximum health"), recommendation(3388,"OPTIONAL","health regeneration"),
    recommendation(6373,"OPTIONAL","Fire spell build"),
}
local hybridElixirs = {
    recommendation(3383,"CORE","caster / healer mana"), recommendation(3390,"CORE","physical Agility"),
    recommendation(6662,"OPTIONAL","short Strength burst"), recommendation(3389,"OPTIONAL","physical defense"),
    recommendation(2458,"OPTIONAL","maximum health"), recommendation(3388,"OPTIONAL","health regeneration"),
}
local physicalScrolls = {
    recommendation(3012,"CORE","Agility / damage / avoidance"), recommendation(954,"CORE","Strength / melee damage"),
    recommendation(1180,"OPTIONAL","Stamina / survival"), recommendation(1478,"OPTIONAL","Armor / physical defense"),
    recommendation(1712,"OPTIONAL","health regeneration between fights"),
}
local casterScrolls = {
    recommendation(955,"CORE","Intellect / mana"), recommendation(1712,"CORE","Spirit / regeneration"),
    recommendation(1180,"OPTIONAL","Stamina / survival"), recommendation(1478,"OPTIONAL","Armor / physical defense"),
    recommendation(3012,"OPTIONAL","Agility / dodge / armor"),
}
local hybridScrolls = {
    recommendation(955,"CORE","Intellect / mana"), recommendation(3012,"CORE","Agility / physical"),
    recommendation(954,"OPTIONAL","Strength / melee"), recommendation(1180,"OPTIONAL","Stamina / survival"),
    recommendation(1712,"OPTIONAL","Spirit / regeneration"), recommendation(1478,"OPTIONAL","Armor / physical defense"),
}

addProfile("DRUID", {
    BANDAGES=bandage, FOOD_DRINK=casterFood,
    POTIONS=casterPotions, ELIXIRS=hybridElixirs, SCROLLS=hybridScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(20744,"OPTIONAL","caster weapon"),recommendation(3241,"OPTIONAL","blunt melee weapon","Weapon damage does not increase Bear Form attacks")},
})

addProfile("HUNTER", {
    BANDAGES=bandage, FOOD_DRINK=physicalFood, POTIONS=physicalPotions,
    ELIXIRS=physicalElixirs,
    SCROLLS={recommendation(3012,"CORE","ranged damage"),recommendation(955,"CORE","mana"),recommendation(1180,"OPTIONAL","survival"),recommendation(1478,"OPTIONAL","physical defense"),recommendation(1712,"OPTIONAL","regeneration")},
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(2871,"OPTIONAL","sharp melee weapon"),recommendation(3241,"OPTIONAL","blunt melee weapon"),recommendation(2515,"CORE","best legal bow ammunition"),recommendation(8068,"CORE","best legal gun ammunition"),recommendation(2519,"ALTERNATIVE","vendor gun ammunition")},
})

addProfile("MAGE", {
    BANDAGES=bandage, FOOD_DRINK=casterFood, POTIONS=casterPotions,
    ELIXIRS=casterElixirs, SCROLLS=casterScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(20744,"CORE","spell pressure")},
    CLASS={recommendation(2136,"CORE","conjured mana drink"),recommendation(1113,"OPTIONAL","conjured food"),recommendation(17056,"OPTIONAL","Slow Fall reagent")},
})

addProfile("PALADIN", {
    BANDAGES=bandage, FOOD_DRINK=casterFood, POTIONS=casterPotions,
    ELIXIRS=hybridElixirs, SCROLLS=hybridScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(2871,"CORE","sword / axe"),recommendation(3241,"CORE","mace")},
})

addProfile("PRIEST", {
    BANDAGES=bandage, FOOD_DRINK=casterFood, POTIONS=casterPotions,
    ELIXIRS=casterElixirs, SCROLLS=casterScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(20744,"CORE","Shadow pressure","Healing benefit must not be assumed")},
})

addProfile("ROGUE", {
    BANDAGES=bandage, FOOD_DRINK=physicalFood, POTIONS=physicalPotions,
    ELIXIRS=physicalElixirs, SCROLLS=physicalScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(2871,"CORE","dagger / sword"),recommendation(3241,"OPTIONAL","mace"),recommendation(2515,"CORE","best legal bow ammunition"),recommendation(8068,"CORE","best legal gun ammunition")},
    CLASS={recommendation(7676,"CORE","energy burst")},
})

addProfile("SHAMAN", {
    BANDAGES=bandage, FOOD_DRINK=casterFood, POTIONS=casterPotions,
    ELIXIRS=hybridElixirs, SCROLLS=hybridScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(20744,"OPTIONAL","caster"),recommendation(3241,"OPTIONAL","melee","Replaces Rockbiter or Flametongue")},
})

addProfile("WARLOCK", {
    BANDAGES=bandage, FOOD_DRINK=physicalFood, POTIONS=casterPotions,
    ELIXIRS=casterElixirs, SCROLLS=casterScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(20744,"CORE","spell pressure")},
    CLASS={recommendation(5512,"CORE","self-created healing"),recommendation(6265,"OPTIONAL","spell resource"),recommendation(5232,"OPTIONAL","Era resurrection","Do not present as functional on Hardcore")},
})

addProfile("WARRIOR", {
    BANDAGES=bandage, FOOD_DRINK=physicalFood,
    POTIONS={recommendation(5631,"CORE","Rage burst"),recommendation(929,"CORE","emergency healing"),recommendation(2459,"CORE","mobility"),recommendation(3384,"OPTIONAL","all-school resistance"),recommendation(6048,"OPTIONAL","Shadow protection"),recommendation(6372,"OPTIONAL","world travel / escape")},
    ELIXIRS=physicalElixirs, SCROLLS=physicalScrolls,
    ENGINEERING=engineering, WORLD_UTILITY=worldUtility,
    WEAPON={recommendation(2871,"CORE","sword / axe"),recommendation(3241,"CORE","mace"),recommendation(2515,"CORE","best legal bow ammunition"),recommendation(8068,"CORE","best legal gun ammunition"),recommendation(2519,"ALTERNATIVE","vendor gun ammunition")},
})
