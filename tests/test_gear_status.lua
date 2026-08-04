local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("GearStatus.lua")

local ids = { [1] = 1482, [2] = 15331 }
local links = { [1] = "item:1482", [2] = "item:15331:monkey" }
local names = {
    ["item:1482"] = "Shadowfang",
    ["item:15331:monkey"] = "Wrangler's Wristbands of the Monkey",
}
local equipped = ns.GearStatus:Collect(
    function(_, slot) return ids[slot] end,
    function(_, slot) return links[slot] end,
    function(link) return names[link] end
)

assert(equipped[1482].names.Shadowfang)
assert(equipped[15331].names["Wrangler's Wristbands of the Monkey"])
assert(ns.GearStatus:IsEquipped({ id=1482, name="Shadowfang" }, equipped, { [1482]=1 }))
assert(ns.GearStatus:IsEquipped({ id=15331, name="Wrangler's Wristbands of the Monkey" }, equipped, { [15331]=2 }))
assert(not ns.GearStatus:IsEquipped({ id=15331, name="Wrangler's Wristbands of Stamina" }, equipped, { [15331]=2 }))
assert(not ns.GearStatus:IsEquipped({ id=9999, name="Missing" }, equipped, { [9999]=1 }))

local profile = {
    slotOrder = { "HEAD" },
    slots = { HEAD = { S={{id=1},{id=3}}, A={{id=1}}, B={{id=2}} } },
}
local counts = ns.GearStatus:CountProfileItemIDs(profile)
assert(counts[1] == 2 and counts[2] == 1 and counts[3] == 1)

print("test_gear_status.lua: ok")
