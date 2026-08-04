local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("XPTracker.lua")

local safe = ns.XPTracker:Calculate(100, 1000, 19)
assert(safe.remaining == 900)
assert(safe.risk == "SAFE")

assert(ns.XPTracker:Calculate(600, 1000, 19).risk == "WATCH")
assert(ns.XPTracker:Calculate(800, 1000, 19).risk == "DANGER")
assert(ns.XPTracker:Calculate(920, 1000, 19).risk == "CRITICAL")
assert(ns.XPTracker:Calculate(999, 1000, 18).risk == "NOT_19")
assert(ns.XPTracker:Calculate(0, 0, 19).risk == "UNAVAILABLE")

print("test_xp_tracker.lua: ok")
