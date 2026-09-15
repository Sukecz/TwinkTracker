local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Data/GearAcquisition.lua")
loadModule("Data/GearQuests.lua")

local function countEntries(value)
    local count = 0
    for _ in pairs(value) do count = count + 1 end
    return count
end

for _, clientKey in ipairs({ "ERA", "TBC" }) do
    local questCatalog = ns.GearQuests.catalogs[clientKey]
    assert(countEntries(questCatalog) == ns.GearQuests.counts[clientKey], clientKey .. " quest count drifted")
    for itemID, acquisition in pairs(ns.GearAcquisition.catalogs[clientKey]) do
        local quests = ns.GearQuests:GetAll(itemID, clientKey)
        if acquisition.source == "QUEST" then
            assert(quests and #quests > 0, clientKey .. " missing quest metadata for " .. itemID)
        else
            assert(quests == nil, clientKey .. " non-quest item has quest metadata " .. itemID)
        end
    end
    for itemID, quests in pairs(questCatalog) do
        local acquisition = assert(ns.GearAcquisition:Get(itemID, clientKey))
        assert(acquisition.source == "QUEST", clientKey .. " quest metadata points to a non-quest source " .. itemID)
        for _, quest in ipairs(quests) do
            assert(type(quest.id) == "number" and quest.id > 0)
            assert(type(quest.name) == "string" and quest.name ~= "" and not string.find(quest.name, "OLD ", 1, true))
            assert(type(quest.minLevel) == "number" and quest.minLevel > 0)
            assert(type(quest.startsAt) == "string" and quest.startsAt ~= "")
            assert(type(quest.location) == "string" and quest.location ~= "")
            assert(quest.faction == nil or quest.faction == "ALLIANCE" or quest.faction == "HORDE")
            local url = ns.GearQuests:GetWowheadURL(quest.id, clientKey)
            local expected = clientKey == "TBC" and "https://www.wowhead.com/tbc/quest=" or "https://www.wowhead.com/classic/quest="
            assert(url == expected .. quest.id)
            for _, chainStart in ipairs(quest.chainStarts or {}) do
                assert(type(chainStart.id) == "number" and chainStart.id > 0)
                assert(type(chainStart.name) == "string" and chainStart.name ~= "")
                assert(type(chainStart.minLevel) == "number" and chainStart.minLevel > 0)
                assert(type(chainStart.startsAt) == "string" and chainStart.startsAt ~= "")
                assert(type(chainStart.location) == "string" and chainStart.location ~= "")
            end
        end
    end
end

UnitFactionGroup = function() return "Alliance" end
assert(ns.GearQuests:GetMinimumLevel({ id = 2041 }, "ERA") == 14)
assert(ns.GearQuests:GetMinimumLevel({ id = 4197 }, "ERA") == 29)
assert(ns.GearQuests:GetMinimumLevel({ id = 4197 }, "TBC") == 23)
assert(ns.GearQuests:Get({ id = 10823 }, "TBC")[1].id == 3636)

UnitFactionGroup = function() return "Horde" end
assert(ns.GearQuests:Get({ id = 10823 }, "TBC")[1].id == 3341)
assert(ns.GearQuests:GetMinimumLevel({ id = 3742 }, "TBC") == 17)

local lines = {}
local tooltip = {
    AddLine = function(_, text) lines[#lines + 1] = text end,
}
assert(ns.GearQuests:AddToTooltip(tooltip, { id = 2041 }, "ERA"))
assert(table.concat(lines, "\n"):find("The Defias Brotherhood", 1, true))
assert(table.concat(lines, "\n"):find("Minimum level: 14", 1, true))
assert(table.concat(lines, "\n"):find("Gryan Stoutmantle", 1, true))

local cursedEye = assert(ns.GearQuests:GetAll(2944, "ERA"))[1]
assert(cursedEye.note and cursedEye.note:find("keep the quest incomplete", 1, true))
assert(ns.GearQuests:GetAll(19024, "ERA") == nil)
assert(ns.GearQuests:GetWowheadURL(nil, "ERA") == nil)

local source = assert(io.open("MainWindow.lua", "r")):read("*a")
assert(source:find('|cff86bff5LVL "..questLevel', 1, true), "gear row does not append the quest minimum level")
assert(source:find("ns.GearQuests:AddToTooltip(GameTooltip,itemData", 1, true), "gear tooltip does not append quest details")

print("test_gear_quests.lua: ok")
