local addonName, ns = ...

local function deepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[deepCopy(key)] = deepCopy(entry) end
    return result
end

local data = deepCopy(ns.ConsumablesData)
data.version = "2026-08-14"
data.classes = {}

local function add(itemID, name, effect, requiredLevel, profession, restrictions)
    data.catalog[itemID] = {
        itemID = itemID,
        name = name,
        effect = effect,
        requiredLevel = requiredLevel,
        profession = profession,
        restrictions = restrictions,
        wowhead = "https://www.wowhead.com/classic/item=" .. itemID,
    }
end

add(8545,"Heavy Mageweave Bandage","Heals 1104 over 8 sec",nil,"First Aid 175 to use","A level-29 character cannot craft this; obtain finished bandages elsewhere; damage interrupts; Recently Bandaged for 60 sec")
add(3729,"Soothing Turtle Bisque","Restores health; Well Fed: 8 Stamina and Spirit",25,nil,"Well Fed alternatives do not stack")
add(6038,"Giant Clam Scorcho","Restores health; Well Fed: 8 Stamina and Spirit",25,nil,"Well Fed alternatives do not stack")
add(13851,"Hot Wolf Ribs","Restores health; Well Fed: 8 Stamina and Spirit",25,nil,"Well Fed alternatives do not stack")
add(12212,"Jungle Stew","Restores health; Well Fed: 8 Stamina and Spirit",25,nil,"Well Fed alternatives do not stack")
add(12210,"Roast Raptor","Restores health; Well Fed: 8 Stamina and Spirit",25,nil,"Well Fed alternatives do not stack")
add(1708,"Sweet Nectar","Restores 1344 mana over 27 sec",25)
add(10841,"Goldthorn Tea","Restores 1344 mana over 27 sec",25,nil,"Cooking 175 recipe")
add(3772,"Conjured Spring Water","Restores 1344 mana over 27 sec",25,nil,"Conjured Mage item")
add(1487,"Conjured Pumpernickel","Restores health over 27 sec",25,nil,"Conjured Mage item")
add(1710,"Greater Healing Potion","Restores 455-585 health",21,nil,"Shares the combat-potion cooldown")
add(3827,"Mana Potion","Restores 455-585 mana",22,nil,"Shares the combat-potion cooldown")
add(5634,"Free Action Potion","Immune to stun and movement-impairing effects for 30 sec",20,nil,"Does not remove effects already active; shares the combat-potion cooldown")
add(6049,"Fire Protection Potion","Absorbs 975-1625 Fire damage",23,nil,"Shares the combat-potion cooldown")
add(6050,"Frost Protection Potion","Absorbs 1350-2250 Frost damage",28,nil,"Shares the combat-potion cooldown")
add(6052,"Nature Protection Potion","Absorbs 1350-2250 Nature damage",28,nil,"Shares the combat-potion cooldown")
add(3823,"Lesser Invisibility Potion","Invisibility for 15 sec",23,nil,"Outside combat only; 10 min cooldown; interaction with other potion cooldowns needs live verification")
add(2633,"Jungle Remedy","Cures one disease and one poison",22,nil,"Shares the combat-potion cooldown")
add(5633,"Great Rage Potion","Restores 30-60 Rage",25,nil,"Warrior only; shares the combat-potion cooldown")
add(8949,"Elixir of Agility","15 Agility for 1 hour",27)
add(3391,"Elixir of Ogre's Strength","8 Strength for 1 hour",20)
add(8951,"Elixir of Greater Defense","250 Armor for 1 hour",29)
add(3825,"Elixir of Fortitude","120 maximum health for 1 hour",25)
add(3826,"Mighty Troll's Blood Potion","Regenerates 12 health every 5 sec for 1 hour",26)
add(17708,"Elixir of Frost Power","15 Frost spell damage for 30 min",28,nil,"Seasonal recipe and availability")
add(3828,"Elixir of Detect Lesser Invisibility","Detect lesser invisibility for 10 min",29,nil,"Does not detect Rogue Stealth")
add(3386,"Elixir of Poison Resistance","Removes up to four poison effects up to level 60",14,nil,"3 sec cooldown")
add(1477,"Scroll of Agility II","9 Agility for 30 min",25,nil,"May replace an equivalent class or stat buff; verify live")
add(2289,"Scroll of Strength II","9 Strength for 30 min",25,nil,"May replace an equivalent class or stat buff; verify live")
add(1711,"Scroll of Stamina II","8 Stamina for 30 min",20,nil,"May replace an equivalent class or stat buff; verify live")
add(2290,"Scroll of Intellect II","8 Intellect for 30 min",20,nil,"May replace an equivalent class or stat buff; verify live")
add(4390,"Iron Grenade","132-218 Fire damage and a 3 sec break-on-damage stun",nil,"Engineering 175","1 min explosives cooldown")
add(4394,"Big Iron Bomb","149-201 Fire damage and a 3 sec break-on-damage stun",nil,"Engineering 190","1 min explosives cooldown")
add(10514,"Mithril Frag Bomb","149-201 Fire damage and a 2 sec break-on-damage stun",nil,"Engineering 205","1 min explosives cooldown")
add(10646,"Goblin Sapper Charge","450-750 area Fire damage and 375-625 self-damage",nil,"Engineering 205 to use","BoE specialist craft from a level-30+ engineer; 5 min cooldown; avoid on Hardcore")
add(4392,"Advanced Target Dummy","Attracts nearby monsters for up to 15 sec",nil,"Engineering 185","PvE escape tool; 2 min cooldown; does not taunt players")
add(4397,"Gnomish Cloaking Device","Invisibility for 10 sec",nil,"Engineering 200","Generic craft despite the name; 1 hour cooldown")
add(10518,"Parachute Cloak","Slow fall for 10 sec",nil,"Engineering 225","Equipped cloak; 30 min cooldown")
add(10720,"Gnomish Net-o-Matic Projector","Roots a target for 10 sec",nil,"Engineering 210 to use","BoE specialist craft from a level-30+ engineer; can fail or backfire; 10 min cooldown")
add(10716,"Gnomish Shrink Ray","Reduces melee attack power by 250",nil,"Engineering 205 to use","BoE specialist craft from a level-30+ engineer; can backfire; 5 min cooldown")
add(10577,"Goblin Mortar","383-517 Fire damage and a 3 sec area stun",nil,"Engineering 205 to use","BoE specialist craft from a level-30+ engineer; 6 charges; 10 min cooldown")
add(10726,"Gnomish Mind Control Cap","Attempts to control a humanoid for 20 sec",nil,"Engineering 215 to use","BoE specialist craft from a level-30+ engineer; can backfire; combat behavior needs live verification")
add(10724,"Gnomish Rocket Boots","Greatly increases run speed for 20 sec",nil,"Engineering 225 to use","BoE specialist craft from a level-30+ engineer; can malfunction; 30 min cooldown")
add(4852,"Flash Bomb","Causes nearby beasts to flee for 10 sec",27,nil,"Situational PvE control")
add(4376,"Flame Deflector","Absorbs 500 Fire damage for 1 min",15,nil,"5 charges; 15 min cooldown; does not require Engineering to use")
add(4941,"Really Sticky Glue","Roots a target for 10 sec",nil,nil,"Horde-only BoP quest supply; one use; 1 min cooldown")
add(3434,"Slumber Sand","Puts a target to sleep for 20 sec",nil,nil,"Horde-only BoP quest supply; one use; damage breaks sleep")
add(5816,"Light of Elune","Immune to damage and spells for 10 sec",nil,nil,"Alliance-only Unique BoP one-use quest reward; shares potion cooldown")
add(1191,"Bag of Marbles","Reduces target hit chance by 25% for 10 sec",nil,nil,"Alliance-only BoP quest reward; 10 charges")
add(1187,"Spiked Collar","Summons an aggressive guardian for 1 hour",20,nil,"Unique BoP one-use quest reward; unsafe on Hardcore")
add(4945,"Faintly Glowing Skull","Steals 75-125 life",nil,nil,"Horde-only Unique BoP one-use quest reward")
add(20745,"Minor Mana Oil","4 mana every 5 sec for 30 min",20,nil,"Temporary weapon coating; conflicts with other oils, stones, poisons and Shaman imbues")
add(7964,"Solid Sharpening Stone","6 damage to a sharp weapon for 30 min",25,nil,"Temporary weapon coating; conflicts with oils, poisons and Shaman imbues")
add(7965,"Solid Weightstone","6 damage to a blunt weapon for 30 min",25,nil,"Temporary weapon coating; conflicts with oils, poisons and Shaman imbues")
add(3824,"Shadow Oil","15% chance to cast Shadow Bolt III on hit",24,nil,"Temporary weapon coating; conflicts with other oils, stones, poisons and Shaman imbues")
add(3030,"Razor Arrow","7.5 ranged damage per second",25,nil,"Bow ammunition")
add(3033,"Solid Shot","7.5 ranged damage per second",25,nil,"Gun ammunition")
add(6949,"Instant Poison II","20% chance for 30-38 Nature damage; 55 charges",28,nil,"Rogue only; temporary weapon poison")
add(3775,"Crippling Poison","30% chance to reduce movement speed by 50% for 12 sec",20,nil,"Rogue only; temporary weapon poison")
add(5237,"Mind-numbing Poison","20% chance to increase cast time by 40% for 10 sec",24,nil,"Rogue only; temporary weapon poison")
add(5514,"Mana Agate","Restores 375-425 mana",23,nil,"Mage only; conjured and Unique")
add(17031,"Rune of Teleportation","Reagent consumed by Teleport",nil,nil,"Mage only")
add(5140,"Flash Powder","Reagent consumed by Vanish",nil,nil,"Rogue only")
add(17057,"Shiny Fish Scales","Reagent consumed by Water Breathing",nil,nil,"Shaman only")
add(17058,"Fish Oil","Reagent consumed by Water Walking",nil,nil,"Shaman only")
add(5511,"Lesser Healthstone","Restores 250 health",nil,nil,"Warlock only; created at level 22")
add(19006,"Lesser Healthstone (1/2 Improved)","Restores 275 health",nil,nil,"Warlock only; one Improved Healthstone talent point")
add(19007,"Lesser Healthstone (2/2 Improved)","Restores 300 health",nil,nil,"Warlock only; two Improved Healthstone talent points")

data.catalog[14530].restrictions = "A level-29 character cannot craft this; obtain finished bandages elsewhere; damage interrupts; Recently Bandaged for 60 sec"
data.catalog[14529].restrictions = "Weaker Runecloth fallback; a level-29 character cannot craft this; obtain finished bandages elsewhere; damage interrupts; Recently Bandaged for 60 sec"
data.catalog[8544].restrictions = "Best bandage a level-29 character can craft personally; damage interrupts; Recently Bandaged for 60 sec"
data.catalog[6453].restrictions = "Situational poison removal; 1 min cooldown; does not use the potion cooldown"
data.catalog[4381].restrictions = "Equipped Engineering 140 trinket; 10 charges; 5 min cooldown"
data.catalog[7676].profession = "Cooking 60"
data.catalog[7676].restrictions = "Rogue only; recipe comes from the level-20 poison class quest; 5 min cooldown"
data.catalog[5332].restrictions = "Unique; binds when picked up; one charge; rare Ghost Saber drop in Darkshore; 10 min cooldown"
data.catalog[4852].restrictions = "PvP and PvE anti-Beast control, including Hunter pets and beast forms; 1 min cooldown"
data.catalog[10726].restrictions = "BoE specialist craft from a level-30+ engineer; can backfire; 30 min cooldown; combat behavior needs live verification"
data.catalog[5237].effect = "20% chance to increase cast time by 40% for 10 sec; 50 charges"
data.catalog[5237].restrictions = "Rogue only; 30 min temporary weapon poison"
data.catalog[3434].restrictions = "Horde-only BoP quest supply; one use; damage breaks sleep; 1 min cooldown"
data.catalog[1191].restrictions = "Alliance-only BoP quest reward; 10 charges; 1 min cooldown"

local function rec(itemID, priority, roles, note)
    return { itemID=itemID, priority=priority, roles=roles, note=note }
end
local function R(itemID, roles, note) return rec(itemID,"CORE",roles,note) end
local function A(itemID, roles, note) return rec(itemID,"ALTERNATIVE",roles,note) end
local function O(itemID, roles, note) return rec(itemID,"OPTIONAL",roles,note) end

local bandages={R(14530,"maximum healing; usable but not craftable at 29"),A(14529,"weaker Runecloth; usable but not craftable at 29"),A(8545,"third choice; usable but not craftable at 29"),A(8544,"best self-crafted bandage"),O(6453,"poison removal")}
local food={R(21151,"survival"),R(3729,"Well Fed stamina / spirit"),A(6038,"same Well Fed bonus"),A(13851,"same Well Fed bonus"),A(12212,"same Well Fed bonus"),A(12210,"same Well Fed bonus")}
local casterFood={R(3729,"Well Fed stamina / spirit"),R(21072,"mana regeneration"),A(1708,"mana drink"),A(10841,"mana drink"),A(21151,"survival")}
local physicalPotions={R(1710,"emergency healing"),R(5634,"PvP control immunity"),R(2459,"mobility"),O(6049,"Fire protection"),O(6050,"Frost protection"),O(6052,"Nature protection"),O(6048,"Shadow protection"),O(3384,"all-school resistance"),O(3823,"out-of-combat escape"),O(2633,"disease / poison cure")}
local casterPotions={R(3827,"mana emergency"),R(1710,"emergency healing"),R(5634,"PvP control immunity"),R(2459,"mobility"),O(6049,"Fire protection"),O(6050,"Frost protection"),O(6052,"Nature protection"),O(6048,"Shadow protection"),O(3823,"out-of-combat escape")}
local physicalElixirs={R(8949,"Agility"),R(3825,"maximum health"),R(8951,"physical defense"),A(3391,"Strength"),O(3826,"health regeneration"),O(3386,"poison cleanse")}
local casterElixirs={R(3825,"maximum health"),R(3383,"Intellect / mana"),A(8951,"physical defense"),A(3826,"health regeneration"),O(17708,"Frost pressure"),O(6373,"Fire pressure"),O(3828,"lesser-invisibility detection")}
local hybridElixirs={R(3825,"maximum health"),R(8951,"physical defense"),R(3383,"caster mana"),A(8949,"physical Agility"),A(3391,"physical Strength"),O(3826,"health regeneration")}
local physicalScrolls={R(1477,"Agility"),R(2289,"Strength"),R(1711,"Stamina"),O(1478,"Armor"),O(1712,"Spirit")}
local casterScrolls={R(2290,"Intellect"),R(1711,"Stamina"),R(1712,"Spirit"),O(1478,"Armor"),O(1477,"Agility / avoidance")}
local hybridScrolls={R(2290,"Intellect"),R(1477,"Agility"),R(1711,"Stamina"),A(2289,"Strength"),O(1712,"Spirit"),O(1478,"Armor")}
local engineering={R(4390,"control / interrupt"),R(4394,"larger-area control"),A(10514,"wide-area control"),O(10646,"burst; avoid on Hardcore"),R(4388,"debuff / slow"),R(4392,"PvE / Hardcore escape"),R(10518,"fall safety"),O(10720,"root with backfire risk"),O(10716,"melee debuff with backfire risk"),O(10577,"charged area stun"),O(10726,"humanoid control; live validation"),O(10724,"mobility with malfunction risk"),O(7189,"mobility; avoid on Hardcore"),O(4852,"beast control")}
local worldUtility={R(2091,"break-on-damage crowd control"),O(4941,"Horde-only limited root"),O(3434,"Horde-only limited sleep"),O(5816,"Alliance-only one-use immunity"),O(1191,"Alliance-only limited hit debuff"),O(5332,"aggressive one-use guardian; unsafe on Hardcore"),O(1187,"aggressive one-use guardian; unsafe on Hardcore")}
local rogueEngineering=deepCopy(engineering)
rogueEngineering[#rogueEngineering+1]=O(4381,"friendly Polymorph removal / emergency healing")
rogueEngineering[#rogueEngineering+1]=O(4376,"extra Fire absorb on its own cooldown")
local rogueWorldUtility=deepCopy(worldUtility)
rogueWorldUtility[#rogueWorldUtility+1]=O(4945,"Horde-only one-use life steal")

local function addProfile(classToken,categories)
    local order={}
    for _,category in ipairs(data.categoryOrder) do
        if categories[category] and #categories[category]>0 then order[#order+1]=category end
    end
    data.classes[classToken]={categoryOrder=order,categories=categories}
end

addProfile("DRUID",{BANDAGES=bandages,FOOD_DRINK=casterFood,POTIONS=casterPotions,ELIXIRS=hybridElixirs,SCROLLS=hybridScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20745,"Restoration sustain"),R(20744,"Balance pressure")}})
addProfile("HUNTER",{BANDAGES=bandages,FOOD_DRINK=food,POTIONS=casterPotions,ELIXIRS=physicalElixirs,SCROLLS={R(1477,"ranged damage"),R(1711,"survival"),R(2290,"mana"),O(1478,"physical defense"),O(1712,"regeneration")},ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(3464,"best bow ammunition; externally acquired"),A(3030,"vendor bow ammunition"),R(3033,"gun ammunition"),O(7964,"sharp melee swap"),O(7965,"blunt melee swap")}})
addProfile("MAGE",{BANDAGES=bandages,FOOD_DRINK=casterFood,POTIONS=casterPotions,ELIXIRS=casterElixirs,SCROLLS=casterScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20744,"spell pressure"),A(20745,"mana sustain")},CLASS={R(5514,"conjured mana gem"),R(3772,"conjured drink"),A(1487,"conjured food"),R(17056,"Slow Fall reagent; consumed"),O(17031,"Teleport reagent")}})
addProfile("PALADIN",{BANDAGES=bandages,FOOD_DRINK=food,POTIONS=casterPotions,ELIXIRS=hybridElixirs,SCROLLS=hybridScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20745,"healer sustain"),R(7964,"sharp melee weapon"),R(7965,"blunt melee weapon"),O(20744,"spell pressure")}})
addProfile("PRIEST",{BANDAGES=bandages,FOOD_DRINK=casterFood,POTIONS=casterPotions,ELIXIRS=casterElixirs,SCROLLS=casterScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20745,"healer sustain"),R(20744,"Shadow pressure")}})
addProfile("ROGUE",{BANDAGES=bandages,FOOD_DRINK=food,POTIONS=physicalPotions,ELIXIRS=physicalElixirs,SCROLLS=physicalScrolls,ENGINEERING=rogueEngineering,WORLD_UTILITY=rogueWorldUtility,WEAPON={R(6949,"damage poison"),R(3775,"movement control poison"),R(5237,"caster-control poison"),O(7964,"poison-free sharp weapon")},CLASS={R(7676,"energy burst"),R(5140,"Vanish reagent")}})
addProfile("SHAMAN",{BANDAGES=bandages,FOOD_DRINK=casterFood,POTIONS=casterPotions,ELIXIRS=hybridElixirs,SCROLLS=hybridScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20745,"Restoration sustain"),R(20744,"Elemental pressure"),A(7964,"sharp Enhancement weapon"),A(7965,"blunt Enhancement weapon","Replaces the Shaman weapon imbue")},CLASS={R(17057,"Water Breathing reagent"),R(17058,"Water Walking reagent")}})
addProfile("WARLOCK",{BANDAGES=bandages,FOOD_DRINK=food,POTIONS=casterPotions,ELIXIRS=casterElixirs,SCROLLS=casterScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(20744,"spell pressure"),A(20745,"mana sustain","Conflicts with Firestone")},CLASS={R(19007,"maximum Improved Lesser Healthstone"),A(19006,"one-talent Lesser Healthstone"),A(5511,"base Lesser Healthstone"),R(6265,"spell resource"),O(5232,"Era resurrection only","Does not resurrect on Hardcore")}})
addProfile("WARRIOR",{BANDAGES=bandages,FOOD_DRINK=food,POTIONS={R(5633,"Rage burst"),R(1710,"emergency healing"),R(5634,"PvP control immunity"),R(2459,"mobility"),O(6049,"Fire protection"),O(6050,"Frost protection"),O(6052,"Nature protection"),O(6048,"Shadow protection")},ELIXIRS=physicalElixirs,SCROLLS=physicalScrolls,ENGINEERING=engineering,WORLD_UTILITY=worldUtility,WEAPON={R(7964,"sharp weapon"),R(7965,"blunt weapon"),A(3824,"Shadow proc"),R(3464,"best bow ammunition; externally acquired"),A(3030,"vendor bow ammunition"),R(3033,"gun ammunition")}})

ns.Bracket29ConsumablesData=data
