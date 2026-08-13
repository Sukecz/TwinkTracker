local addonName, ns = ...

local function deepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[deepCopy(key)] = deepCopy(entry) end
    return result
end

-- Level 39 can still use the same endgame-applied permanent enchants. The
-- bracket-29 profile already exposes every target-item-level scope tier and
-- the role-specific weapon, shield and shoulder choices needed here.
local data = deepCopy(ns.Bracket29EnchantsData)
data.version = "2026-08-13"

ns.Bracket39EnchantsData = data
