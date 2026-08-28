local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

WOW_PROJECT_ID = 5
WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
C_AddOns = { GetAddOnMetadata = function() return "0.4.1" end }

for _, path in ipairs({
    "Client.lua", "Defaults.lua", "Data/Brackets.lua", "Data/GearAcquisition.lua", "Data/GearRandomProperties.lua", "Data/Basics.lua", "Data/Bis.lua",
    "Data/Enchants.lua", "Data/Consumables.lua", "Data/Guides.lua", "Data/ClassTiers.lua",
    "Data/PvPEvents.lua", "Data/Events.lua", "Data/TBC/Events.lua", "Data/Exploration.lua", "Data/BracketRegistry.lua",
    "Database.lua",
}) do loadModule(path) end

local saved = ns.Database:Initialize({ selectedPage = "PVP" })
assert(saved.selectedPage == "GEAR", "TBC retained a saved PvP Events page")
assert(ns.Database:SetSelectedPage("BASICS"))
assert(not ns.Database:SetSelectedPage("PVP"), "TBC allowed the PvP Events page to be activated")
assert(ns.Database:Get().selectedPage == "BASICS", "rejected TBC PvP selection changed the active page")

local handle = assert(io.open("MainWindow.lua", "r"))
local source = handle:read("*a")
handle:close()
assert(string.find(source, 'if ns.Client:IsPageAvailable("PVP") then self:CreatePageButton', 1, true))
assert(string.find(source, 'if ns.Client:IsPageAvailable("PVP") then self:CreatePvpPage', 1, true))
assert(string.find(source, 'ns.GearAcquisition:Format(itemData,ns.Client and ns.Client.key or "ERA")', 1, true), "gear acquisition line is not client-aware")
assert(string.find(source, 'ns.GearRandomProperties:Get(itemData.id,itemData.name,clientKey)', 1, true), "gear links do not resolve exact random properties")

print("test_tbc_ui.lua: ok")
