local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/GearAcquisition.lua", "Data/GearRandomProperties.lua", "Data/Basics.lua", "Data/Bis.lua",
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

local validBindings = { BOE = true, BOP = true, UNBOUND = true }
local validSources = {
    QUEST = true, ["DUNGEON DROP"] = true, ["WORLD DROP"] = true,
    CRAFTED = true, VENDOR = true, ["HONOR / REPUTATION"] = true,
    EVENT = true, FISHING = true, OTHER = true,
}

local function countEntries(value)
    local count = 0
    for _ in pairs(value) do count = count + 1 end
    return count
end

local function auditRuntime(clientKey)
    local seen = {}
    for _, level in ipairs(ns.Brackets.order) do
        local data = assert(ns.Brackets:GetData(level), clientKey .. " missing bracket " .. level)
        for _, classToken in ipairs(data.bis.classOrder) do
            local profile = assert(data.bis.classes[classToken])
            for _, slot in ipairs(profile.slotOrder) do
                for _, tier in ipairs({ "S", "A", "B" }) do
                    for _, item in ipairs(profile.slots[slot][tier]) do
                        if item.id then
                            local metadata = assert(ns.GearAcquisition:Get(item.id,clientKey),
                                clientKey .. " missing acquisition metadata for " .. item.id)
                            assert(validBindings[metadata.binding], clientKey .. " invalid binding for " .. item.id)
                            assert(validSources[metadata.source], clientKey .. " invalid source for " .. item.id)
                            assert(type(ns.GearAcquisition:Format(item,clientKey)) == "string")
                            seen[item.id] = true
                        end
                    end
                end
            end
        end
    end
    assert(countEntries(seen) == ns.GearAcquisition.counts[clientKey], clientKey .. " runtime gear count drifted")
    assert(countEntries(ns.GearAcquisition.catalogs[clientKey]) == ns.GearAcquisition.counts[clientKey], clientKey .. " catalog count drifted")
    for itemID in pairs(ns.GearAcquisition.catalogs[clientKey]) do
        assert(seen[itemID], clientKey .. " catalog contains unused item " .. itemID)
    end
end

auditRuntime("ERA")

for _, path in ipairs({
    "Data/TBC/Base.lua", "Data/TBC/Systems.lua", "Data/TBC/Events.lua",
    "Data/TBC/GearDruidHunterMage.lua", "Data/TBC/GearPaladinPriestRogue.lua",
    "Data/TBC/GearShamanWarlockWarrior.lua", "Data/TBC/ClassTiers.lua", "Data/TBC/Register.lua",
}) do loadModule(path) end

auditRuntime("TBC")

local function assertMetadata(itemID, clientKey, binding, source)
    local metadata = assert(ns.GearAcquisition:Get(itemID,clientKey))
    assert(metadata.binding == binding, itemID .. " " .. clientKey .. " binding mismatch")
    assert(metadata.source == source, itemID .. " " .. clientKey .. " source mismatch")
end

assertMetadata(5404, "ERA", "UNBOUND", "DUNGEON DROP")
assertMetadata(5404, "TBC", "BOP", "DUNGEON DROP")
assertMetadata(15313, "ERA", "UNBOUND", "WORLD DROP")
assertMetadata(6667, "ERA", "BOP", "QUEST")
assertMetadata(22984, "TBC", "BOP", "QUEST")
assertMetadata(9375, "TBC", "BOE", "WORLD DROP")
assertMetadata(10299, "ERA", "BOP", "DUNGEON DROP")
assertMetadata(11982, "ERA", "BOE", "WORLD DROP")
assertMetadata(16768, "TBC", "BOP", "HONOR / REPUTATION")
assertMetadata(19024, "ERA", "BOP", "EVENT")
assertMetadata(23173, "TBC", "BOP", "EVENT")
assertMetadata(29584, "TBC", "BOE", "VENDOR")
assertMetadata(19969, "ERA", "BOP", "FISHING")

local eraNaxx = assert(ns.GearAcquisition:Format({ id = 15313, requiresNaxxEnchant = true },"ERA"))
local tbcNaxx = assert(ns.GearAcquisition:Format({ id = 5404, requiresNaxxEnchant = true },"TBC"))
assert(string.find(eraNaxx,"NO BIND",1,true) and string.find(eraNaxx,"+ NAXX",1,true))
assert(not string.find(tbcNaxx,"+ NAXX",1,true), "TBC gear shows the Era-only Naxx warning")
assert(ns.GearAcquisition:Get(nil,"ERA") == nil)
assert(ns.GearAcquisition:Format({ name = "Placeholder" },"ERA") == nil)

print("test_gear_acquisition.lua: ok")
