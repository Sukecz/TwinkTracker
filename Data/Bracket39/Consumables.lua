local addonName, ns = ...

local function deepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[deepCopy(key)] = deepCopy(entry) end
    return result
end

local data = deepCopy(ns.Bracket29ConsumablesData)
data.version = "2026-08-13"

local function add(itemID, name, effect, requiredLevel, profession, restrictions)
    data.catalog[itemID] = {
        itemID=itemID, name=name, effect=effect, requiredLevel=requiredLevel,
        profession=profession, restrictions=restrictions,
        wowhead="https://www.wowhead.com/classic/item=" .. itemID,
    }
end

add(3928,"Superior Healing Potion","Restores 700-900 health",35,nil,"Shares the combat-potion cooldown")
add(6149,"Greater Mana Potion","Restores 700-900 mana",31,nil,"Shares the combat-potion cooldown")
add(9030,"Restorative Potion","Removes one Magic, Curse, Poison or Disease effect every 5 sec for 30 sec",32,nil,"Shares the combat-potion cooldown; dispel behavior is situational")
add(9172,"Invisibility Potion","Invisibility for 18 sec",37,nil,"Outside combat only; 10 min cooldown; interaction cancels invisibility")
add(9187,"Elixir of Greater Agility","25 Agility for 1 hour",38,nil,"Does not stack with another Agility elixir")
add(9206,"Elixir of Giants","25 Strength for 1 hour",38,nil,"Does not stack with another Strength elixir")
add(9155,"Arcane Elixir","20 spell damage for 30 min",37,nil,"Classic Era permits multiple different elixir effects; an equal or stronger spell-damage effect may replace it")
add(9179,"Elixir of Greater Intellect","25 Intellect for 1 hour",37,nil,"May replace an equivalent Intellect buff; verify live")
add(9088,"Gift of Arthas","10 Shadow resistance and a melee attacker debuff for 30 min",38,nil,"Classic Era defensive elixir; its identical-stat and debuff interactions remain situational")
add(4422,"Scroll of Stamina III","12 Stamina for 30 min",35,nil,"May replace Power Word: Fortitude or an equivalent Stamina buff")
add(4419,"Scroll of Intellect III","12 Intellect for 30 min",35,nil,"May replace Arcane Intellect or an equivalent Intellect buff")
add(4424,"Scroll of Spirit III","12 Spirit for 30 min",30,nil,"May replace Divine Spirit or an equivalent Spirit buff")
add(4421,"Scroll of Protection III","240 Armor for 30 min",30,nil,"May replace an equivalent Armor buff")
add(12215,"Heavy Kodo Stew","Well Fed: 12 Stamina and Spirit",35,nil,"Well Fed alternatives do not stack")
add(17222,"Spider Sausage","Well Fed: 12 Stamina and Spirit",35,nil,"Well Fed alternatives do not stack")
add(13928,"Grilled Squid","Well Fed: 10 Agility",35,nil,"Well Fed alternatives do not stack; seasonal fish availability")
add(13931,"Nightfin Soup","8 mana every 5 sec",35,nil,"Well Fed alternatives do not stack; Nightfin time window")
add(13927,"Cooked Glossy Mightfish","10 Stamina for 10 min",35,nil,"Short instant-applied food buff; stacking needs live validation")
add(12217,"Dragonbreath Chili","Chance for a frontal Fire-damage proc",35,nil,"Cooking buff; melee proc behavior needs live validation")
add(18641,"Dense Dynamite","340-460 area Fire damage",nil,"Engineering 250","1 min explosives cooldown")
add(15993,"Thorium Grenade","300-500 Fire damage and a 3 sec break-on-damage stun",nil,"Engineering 260","1 min explosives cooldown")
add(16005,"Dark Iron Bomb","225-675 Fire damage and a 4 sec break-on-damage stun",nil,"Engineering 285","1 min explosives cooldown")
add(16040,"Arcane Bomb","Drains mana, deals Arcane damage and silences for 5 sec",nil,"Engineering 300","1 min explosives cooldown")
add(10586,"The Big One","340-460 area Fire damage",nil,"Engineering 225","Long cast; 1 min explosives cooldown")
add(16023,"Masterwork Target Dummy","High-health target dummy for up to 15 sec",nil,"Engineering 275","PvE escape tool; does not taunt players")
add(18637,"Major Recombobulator","Dispels Polymorph and restores 375-625 health and mana to a friendly target",nil,"Engineering 275","10-charge trinket; 5 min cooldown")
add(10588,"Goblin Rocket Helmet","Charges and stuns a target",nil,"Goblin Engineering 235","Equipped head; can malfunction; long cooldown")
add(10725,"Gnomish Battle Chicken","Summons a mechanical guardian",nil,"Gnomish Engineering 230","BoP specialization trinket; guardian behavior and cooldown need live validation")
add(10587,"Goblin Bomb Dispenser","Summons a mobile bomb",nil,"Goblin Engineering 230","BoP specialization trinket; can malfunction")
add(10645,"Gnomish Death Ray","Channels a high-variance damage beam",nil,"Gnomish Engineering 240","BoP specialization trinket; costs health; dangerous on Hardcore")
add(20746,"Lesser Wizard Oil","16 spell damage for 30 min",30,nil,"Temporary weapon coating; conflicts with stones, poisons and Shaman imbues")
add(12404,"Dense Sharpening Stone","8 damage to a sharp weapon for 30 min",35,nil,"Temporary weapon coating; conflicts with oils, poisons and Shaman imbues")
add(12643,"Dense Weightstone","8 damage to a blunt weapon for 30 min",35,nil,"Temporary weapon coating; conflicts with oils, poisons and Shaman imbues")
add(3465,"Exploding Shot","9.5 ranged damage per second",nil,nil,"Gun ammunition; the item has no use-level requirement, but its finite quest-supply route requires planning")
add(8069,"Crafted Solid Shot","8.5 ranged damage per second",30,nil,"Gun ammunition")
add(9399,"Precision Arrow","11.5 ranged damage per second",35,nil,"Bow ammunition; finite Uldaman drop supply and dungeon XP exposure")
add(6950,"Instant Poison III","20% chance for 44-56 Nature damage",36,nil,"Rogue only; temporary weapon poison")
add(2893,"Deadly Poison II","Stacking Nature damage over time",38,nil,"Rogue only; temporary weapon poison")
add(10918,"Wound Poison","30% chance to reduce healing by 55 for 15 sec; stacks up to 5",32,nil,"Rogue only; temporary weapon poison")
add(5513,"Mana Jade","Restores 550-650 mana",38,nil,"Mage only; conjured and Unique")
add(5511,"Lesser Healthstone","Restores 250 health",12,nil,"Lower Warlock-created rank; retained in the catalog but not recommended at level 39")
add(19006,"Lesser Healthstone","Restores 275 health",12,nil,"Lower one-talent Warlock-created rank; retained in the catalog but not recommended at level 39")
add(19007,"Lesser Healthstone","Restores 300 health",12,nil,"Lower two-talent Warlock-created rank; retained in the catalog but not recommended at level 39")
add(5510,"Greater Healthstone","Restores 800 health",36,nil,"Warlock-created base version; conjured and Unique")
add(19010,"Greater Healthstone","Restores 880 health",36,nil,"Warlock-created version with one Improved Healthstone talent point; conjured and Unique")
add(19011,"Greater Healthstone","Restores 960 health",36,nil,"Warlock-created version with two Improved Healthstone talent points; conjured and Unique")
add(5232,"Minor Soulstone","Stores a soul for resurrection",nil,nil,"Created by a Warlock from level 18; no item use-level requirement; resurrection is unavailable on Hardcore")

local function rec(itemID, priority, roles, note)
    return { itemID=itemID, priority=priority, roles=roles, note=note }
end
local function R(itemID, roles, note) return rec(itemID,"CORE",roles,note) end
local function A(itemID, roles, note) return rec(itemID,"ALTERNATIVE",roles,note) end
local function O(itemID, roles, note) return rec(itemID,"OPTIONAL",roles,note) end
local function prepend(list, ...)
    local result = { ... }
    for _, entry in ipairs(list) do result[#result + 1] = entry end
    return result
end

local food = { R(21151,"survival alcohol"), R(12215,"Well Fed stamina / spirit"), A(17222,"same Well Fed bonus"), A(13928,"Agility set"), O(13927,"fast post-death Stamina"), O(12217,"melee Fire proc") }
local casterFood = { R(12215,"Well Fed stamina / spirit"), R(13931,"mana regeneration"), A(17222,"same Well Fed bonus"), O(13927,"fast post-death Stamina"), O(21151,"survival alcohol") }
local physicalPotions = { R(3928,"emergency healing"), R(5634,"PvP control immunity"), R(2459,"mobility"), O(9030,"periodic dispel"), O(9172,"out-of-combat route"), O(6049,"Fire protection"), O(6050,"Frost protection"), O(6052,"Nature protection"), O(6048,"Shadow protection") }
local casterPotions = { R(6149,"mana emergency"), R(3928,"healing emergency"), R(5634,"PvP control immunity"), R(2459,"mobility"), O(9030,"periodic dispel"), O(9172,"out-of-combat route"), O(6049,"Fire protection"), O(6050,"Frost protection"), O(6052,"Nature protection"), O(6048,"Shadow protection") }
local physicalElixirs = { R(9187,"Agility"), R(9206,"Strength"), R(3825,"maximum health"), A(8951,"physical defense"), O(9088,"Shadow defense / attacker debuff"), O(3386,"poison cleanse") }
local casterElixirs = { R(9155,"spell damage"), R(9179,"Intellect / mana"), R(3825,"maximum health"), A(8951,"physical defense"), O(17708,"Frost pressure"), O(9088,"Shadow defense / attacker debuff") }
local hybridElixirs = { R(3825,"maximum health"), R(9179,"caster mana"), R(9187,"physical Agility"), R(9206,"physical Strength"), A(9155,"spell pressure"), O(8951,"physical defense"), O(9088,"Shadow defense / attacker debuff") }
local physicalScrolls = { R(4422,"Stamina"), R(1477,"Agility"), R(2289,"Strength"), O(4421,"Armor"), O(4424,"Spirit") }
local casterScrolls = { R(4419,"Intellect"), R(4422,"Stamina"), R(4424,"Spirit"), O(4421,"Armor"), O(1477,"Agility / avoidance") }
local hybridScrolls = { R(4419,"Intellect"), R(4422,"Stamina"), R(1477,"Agility"), A(2289,"Strength"), O(4424,"Spirit"), O(4421,"Armor") }
local engineering = { R(15993,"ranged control"), R(16005,"longer area control"), R(16040,"mana drain / silence"), R(18641,"fast area damage"), A(10586,"large casted explosive"), O(10646,"burst; avoid on Hardcore"), R(16023,"PvE escape"), R(18637,"friendly Polymorph dispel / recovery"), R(10518,"fall safety"), O(10720,"root with backfire risk"), O(10588,"Goblin charge"), O(10725,"Gnomish guardian"), O(10587,"Goblin bomb guardian"), O(10645,"Gnomish burst; dangerous on Hardcore"), O(10724,"mobility with malfunction risk") }

local function setCommon(classToken, caster, hybrid)
    local categories = data.classes[classToken].categories
    categories.BANDAGES = { R(14530,"maximum self-crafted healing"), A(14529,"cheaper Runecloth fallback"), A(8545,"Mageweave fallback"), O(6453,"poison removal") }
    categories.FOOD_DRINK = caster and casterFood or food
    categories.POTIONS = caster and casterPotions or physicalPotions
    categories.ELIXIRS = hybrid and hybridElixirs or (caster and casterElixirs or physicalElixirs)
    categories.SCROLLS = hybrid and hybridScrolls or (caster and casterScrolls or physicalScrolls)
    categories.ENGINEERING = engineering
end

setCommon("DRUID",true,true)
setCommon("HUNTER",false,false)
setCommon("MAGE",true,false)
setCommon("PALADIN",true,true)
setCommon("PRIEST",true,false)
setCommon("ROGUE",false,false)
setCommon("SHAMAN",true,true)
setCommon("WARLOCK",true,false)
setCommon("WARRIOR",false,false)

-- Hybrid/ranged profiles need the resources used by their actual level-39
-- builds, not only the physical/caster preset selected above.
data.classes.DRUID.categories.FOOD_DRINK = {
    R(12215,"Well Fed stamina / spirit"), R(13931,"mana regeneration"),
    A(13928,"Feral Agility"), O(13927,"fast post-death Stamina"),
    O(12217,"Feral melee Fire proc"), O(21151,"survival alcohol"),
}
data.classes.HUNTER.categories.POTIONS = prepend(physicalPotions,R(6149,"mana emergency"))
data.classes.MAGE.categories.FOOD_DRINK = prepend(casterFood,O(12217,"situational Fire proc documented by the level-39 Mage guide"))

data.classes.DRUID.categories.WEAPON={R(20746,"Balance / Restoration spell pressure"),A(20745,"mana sustain"),O(12643,"Feral blunt weapon")}
data.classes.HUNTER.categories.WEAPON={R(9399,"best level-39 bow ammunition; finite Uldaman supply"),R(3465,"best gun ammunition; limited quest supply"),A(8069,"crafted gun fallback"),O(12404,"sharp melee swap"),O(12643,"blunt melee swap")}
data.classes.MAGE.categories.WEAPON={R(20746,"spell pressure"),A(20745,"mana sustain")}
data.classes.MAGE.categories.CLASS=prepend(data.classes.MAGE.categories.CLASS,R(5513,"conjured mana gem"))
data.classes.PALADIN.categories.WEAPON={R(20746,"Holy spell pressure"),A(20745,"healer sustain"),R(12404,"sharp melee weapon"),R(12643,"blunt melee weapon")}
data.classes.PRIEST.categories.WEAPON={R(20746,"healing / Shadow pressure"),A(20745,"mana sustain")}
data.classes.ROGUE.categories.WEAPON={R(6950,"instant damage poison"),R(2893,"stacking damage poison"),R(10918,"healing reduction"),R(3775,"movement control"),R(5237,"caster control"),O(12404,"poison-free weapon")}
data.classes.SHAMAN.categories.WEAPON={R(20746,"Elemental / Restoration pressure"),A(20745,"healer sustain"),A(12404,"sharp Enhancement weapon"),A(12643,"blunt Enhancement weapon","Replaces the Shaman weapon imbue")}
data.classes.WARLOCK.categories.WEAPON={R(20746,"spell pressure"),A(20745,"mana sustain","Conflicts with Firestone")}
local warlockClass = {}
for _, entry in ipairs(data.classes.WARLOCK.categories.CLASS) do
    if entry.itemID ~= 5511 and entry.itemID ~= 19006 and entry.itemID ~= 19007 then
        warlockClass[#warlockClass + 1] = entry
    end
end
data.classes.WARLOCK.categories.CLASS=prepend(warlockClass,R(19011,"maximum Improved Greater Healthstone"),A(19010,"one-talent Greater Healthstone"),A(5510,"base Greater Healthstone"))
data.classes.WARRIOR.categories.POTIONS=prepend(physicalPotions,R(5633,"Rage burst"))
data.classes.WARRIOR.categories.WEAPON={R(12404,"sharp weapon"),R(12643,"blunt weapon"),R(9399,"best level-39 bow ammunition; finite Uldaman supply"),R(3465,"best gun ammunition; limited quest supply"),A(8069,"crafted gun fallback")}

ns.Bracket39ConsumablesData = data
