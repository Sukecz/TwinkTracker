local ns = {}

assert(loadfile("Data/Events.lua"))("TwinkTracker", ns)
assert(loadfile("EventTimers.lua"))("TwinkTracker", ns)

assert(#ns.EventTimersData.order == 5)
assert(ns.EventTimersData.events.WSG.frequencyDays == 21)
assert(ns.EventTimersData.events.FISHING.frequencyDays == 7)
assert(ns.EventTimersData.events.GURUBASHI.iconItemID == 18706)

local now = { year=2026, month=8, monthDay=11, hour=19, minute=0, second=0 }
local wsg = ns.EventTimers:GetStatus("WSG",now)
assert(wsg.active == false)
assert(wsg.text == "STARTS IN 2D 5H")
assert(wsg.window == "14 AUG 00:01 - 18 AUG 07:00 SERVER TIME")

local fishing = ns.EventTimers:GetStatus("FISHING",now)
assert(fishing.active == false)
assert(fishing.text == "STARTS IN 4D 19H")
assert(fishing.window == "16 AUG 14:00 - 16 AUG 16:00 SERVER TIME")

local fishingLive = ns.EventTimers:GetStatus("FISHING",{ year=2026, month=8, monthDay=16, hour=14, minute=30, second=0 })
assert(fishingLive.active == true)
assert(fishingLive.text == "LIVE  •  ENDS IN 1H")

local gurubashi = ns.EventTimers:GetStatus("GURUBASHI",now)
assert(gurubashi.active == false and gurubashi.text == "EXPECTED IN 2H 0M")
assert(gurubashi.window == "EVERY 3 HOURS FROM 00:00 SERVER TIME")
assert(gurubashi.iconItemID == 18706)
local gurubashiNow = ns.EventTimers:GetStatus("GURUBASHI",{ year=2026, month=8, monthDay=11, hour=18, minute=2, second=0 })
assert(gurubashiNow.active == true and gurubashiNow.text == "EXPECTED NOW")

local darkmoon = ns.EventTimers:GetStatus("DARKMOON",now)
assert(darkmoon.active == true)
assert(darkmoon.category == "MONTHLY  •  MULGORE")
assert(darkmoon.window == "10 AUG 00:01 - 16 AUG 23:59 SERVER TIME")
local nextDarkmoon = ns.EventTimers:GetStatus("DARKMOON",{ year=2026, month=8, monthDay=17, hour=0, minute=0, second=0 })
assert(nextDarkmoon.category == "MONTHLY  •  ELWYNN FOREST")
assert(nextDarkmoon.window == "7 SEP 00:01 - 13 SEP 23:59 SERVER TIME")

local seasonal = ns.EventTimers:GetStatus("SEASONAL",now)
assert(seasonal.name == "HALLOW'S END")
assert(seasonal.window == "18 OCT 09:00 - 1 NOV 23:59 SERVER TIME")
local winter = ns.EventTimers:GetStatus("SEASONAL",{ year=2026, month=12, monthDay=20, hour=12, minute=0, second=0 })
assert(winter.active == true and winter.name == "FEAST OF WINTER VEIL")
local lunar = ns.EventTimers:GetStatus("SEASONAL",{ year=2027, month=1, monthDay=3, hour=0, minute=0, second=0 })
assert(lunar.name == "LUNAR FESTIVAL")
assert(lunar.window == "5 FEB 09:00 - 19 FEB 23:59 SERVER TIME")

local following = ns.EventTimers:GetStatus("WSG",{ year=2026, month=8, monthDay=18, hour=7, minute=0, second=0 })
assert(following.window == "4 SEP 00:01 - 8 SEP 07:00 SERVER TIME")
assert(ns.EventTimers:GetStatus("UNKNOWN",now) == nil)

print("test_event_timers.lua: ok")
