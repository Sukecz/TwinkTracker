local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/GearRandomProperties.lua", "Data/Basics.lua", "Data/Bis.lua",
    "Data/Enchants.lua", "Data/Consumables.lua", "Data/Guides.lua", "Data/ClassTiers.lua",
    "Data/PvPEvents.lua", "Data/Events.lua", "Data/Exploration.lua", "Data/BracketRegistry.lua",
    "Data/Bracket29/Bis.lua", "Data/Bracket29/Enchants.lua", "Data/Bracket29/Consumables.lua",
    "Data/Bracket29/Basics.lua", "Data/Bracket29/Guides.lua", "Data/Bracket29/ClassTiers.lua",
    "Data/Bracket29/Exploration.lua", "Data/Bracket29/Register.lua",
    "Data/Bracket39/Bis.lua", "Data/Bracket39/BisDruidHunterMage.lua",
    "Data/Bracket39/BisPaladinPriestRogue.lua", "Data/Bracket39/BisShamanWarlockWarrior.lua",
    "Data/Bracket39/Enchants.lua", "Data/Bracket39/Consumables.lua", "Data/Bracket39/Basics.lua",
    "Data/Bracket39/Guides.lua", "Data/Bracket39/ClassTiers.lua", "Data/Bracket39/Exploration.lua",
    "Data/Bracket39/Register.lua",
}) do loadModule(path) end

local forbiddenNames = {
    ["Meadow Ring"] = true,
    ["Regal Leggings of Frozen Wrath"] = true,
    ["Royal Sash of Shadow Wrath"] = true,
    ["Royal Gloves of Shadow Wrath"] = true,
    ["Arachnid Gloves of Agility"] = true,
    ["Lunar Mantle of Healing"] = true,
    ["Lunar Mantle of Nature's Wrath"] = true,
}

local function collectClassItems(level, classToken)
    local result = {}
    local profile = assert(ns.Brackets:GetData(level).bis.classes[classToken])
    for _, slot in ipairs(profile.slotOrder) do
        for _, tier in ipairs({ "S", "A", "B" }) do
            for _, entry in ipairs(profile.slots[slot][tier]) do
                if entry.id then result[entry.id] = true end
            end
        end
    end
    return result
end

local function auditRuntime(clientKey)
    for _, level in ipairs(ns.Brackets.order) do
        local data = assert(ns.Brackets:GetData(level))
        for _, classToken in ipairs(data.bis.classOrder) do
            local profile = assert(data.bis.classes[classToken])
            for _, slot in ipairs(profile.slotOrder) do
                for _, tier in ipairs({ "S", "A", "B" }) do
                    for _, entry in ipairs(profile.slots[slot][tier]) do
                        assert(not forbiddenNames[entry.name], clientKey .. " retains impossible or generic suffix " .. entry.name)
                        if entry.id and ns.GearRandomProperties:IsRandomBase(entry.id,clientKey) then
                            assert(ns.GearRandomProperties:Get(entry.id,entry.name,clientKey),
                                string.format("%s missing exact random property for %d %s",clientKey,entry.id,entry.name))
                        end
                    end
                end
            end
        end
    end
end

auditRuntime("ERA")
assert(not collectClassItems(29,"MAGE")[3020])
assert(not collectClassItems(39,"PRIEST")[7513])
assert(not collectClassItems(39,"PRIEST")[9428])
assert(not collectClassItems(29,"WARRIOR")[6689])
assert(not collectClassItems(19,"SHAMAN")[6460])
assert(not collectClassItems(29,"SHAMAN")[6460])
assert(not collectClassItems(39,"SHAMAN")[6975])
assert(not collectClassItems(39,"WARLOCK")[10766])
assert(collectClassItems(39,"WARLOCK")[10704])
assert(collectClassItems(39,"HUNTER")[20101])
assert(collectClassItems(39,"HUNTER")[20116])

for _, path in ipairs({
    "Data/TBC/Base.lua", "Data/TBC/Systems.lua", "Data/TBC/Events.lua",
    "Data/TBC/GearDruidHunterMage.lua", "Data/TBC/GearPaladinPriestRogue.lua",
    "Data/TBC/GearShamanWarlockWarrior.lua", "Data/TBC/ClassTiers.lua", "Data/TBC/Register.lua",
}) do loadModule(path) end

auditRuntime("TBC")
assert(not collectClassItems(29,"MAGE")[3020])
assert(not collectClassItems(39,"PRIEST")[7513])
assert(not collectClassItems(39,"PRIEST")[9428])
assert(not collectClassItems(29,"PALADIN")[20096])
assert(not collectClassItems(29,"PALADIN")[20120])
assert(not collectClassItems(39,"HUNTER")[20101])
assert(not collectClassItems(39,"HUNTER")[20116])
assert(not collectClassItems(39,"HUNTER")[20168])
assert(not collectClassItems(39,"HUNTER")[20192])
assert(collectClassItems(39,"HUNTER")[2276])
assert(not collectClassItems(19,"SHAMAN")[3822])
assert(collectClassItems(19,"SHAMAN")[5322])
assert(not collectClassItems(29,"SHAMAN")[6460])
assert(not collectClassItems(39,"SHAMAN")[6975])
assert(collectClassItems(19,"SHAMAN")[1318])
assert(collectClassItems(19,"SHAMAN")[5815])
assert(not collectClassItems(39,"WARLOCK")[10766])
assert(collectClassItems(39,"WARLOCK")[10704])
assert(not collectClassItems(29,"WARRIOR")[6689])

assert(ns.GearRandomProperties:Get(12006,"Meadow Ring of the Monkey","ERA") == 590)
assert(ns.GearRandomProperties:Get(12006,"Meadow Ring of the Tiger","TBC") == 675)
assert(ns.GearRandomProperties:Get(31264,"Silvermoon Robes of the Sun","TBC") == -58)
assert(ns.GearRandomProperties:Get(31264,"Silvermoon Robes of the Moon","TBC") == -59)
assert(ns.GearRandomProperties:Get(3184,"Hook Dagger of Stamina","ERA") == 22)
assert(ns.GearRandomProperties:Get(3184,"Hook Dagger","ERA") == nil)

local mainWindow = assert(io.open("MainWindow.lua","r")):read("*a")
assert(string.find(mainWindow,"item:%d:0:0:0:0:0:%d",1,true))
assert(string.find(mainWindow,"ns.GearRandomProperties:Get(itemData.id,itemData.name,clientKey)",1,true))
assert(string.find(mainWindow,"showItemTooltip(owner,itemData)",1,true))

print("test_gear_random_properties.lua: ok")
