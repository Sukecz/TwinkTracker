local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

loadModule("Defaults.lua")
loadModule("Data/Bis.lua")
loadModule("Database.lua")

local db = ns.Database:Initialize({
    frame = { point = "INVALID", x = 9001, y = -9001 },
    selectedClass = "INVALID",
    selectedTab = "INVALID",
    xpLockdown = "yes",
    checklist = "invalid",
})

assert(db.frame.point == "CENTER")
assert(db.frame.x == 5000 and db.frame.y == -5000)
assert(db.selectedClass == "DRUID")
assert(db.selectedTab == "BIS")
assert(db.selectedSlot == "HEAD")
assert(db.xpLockdown == false)
assert(type(db.checklist) == "table")

assert(ns.Database:SetSelectedClass("ROGUE"))
assert(ns.Database:Get().selectedClass == "ROGUE")
assert(not ns.Database:SetSelectedClass("DEMONHUNTER"))
assert(ns.Database:SetSelectedSlot("RANGED"))
assert(not ns.Database:SetSelectedSlot("RELIC"))
assert(ns.Database:SetSelectedTab("BIS"))
assert(not ns.Database:SetSelectedTab("UNKNOWN"))
assert(ns.Database:SetChecklistDone("gear_plan", true))
assert(ns.Database:IsChecklistDone("gear_plan"))
assert(ns.Database:SetChecklistDone("gear_plan", false))
assert(not ns.Database:IsChecklistDone("gear_plan"))

ns.Database:SetFramePosition("TOP", 10, 20)
assert(ns.Database:Get().frame.point == "TOP")
ns.Database:ResetFramePosition()
assert(ns.Database:Get().frame.point == "CENTER")

print("test_database.lua: ok")
