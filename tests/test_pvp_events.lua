local ns = {}

local chunk = assert(loadfile("Data/PvPEvents.lua"))
chunk("TwinkTracker", ns)

assert(ns.PvPEventsData.version == "2026-08-11")
assert(string.find(ns.PvPEventsData.submissionFields,"Realm or cluster",1,true))
for _, level in ipairs({ 19, 29 }) do
    local data = assert(ns.PvPEventsData.brackets[level])
    assert(data.level == level)
    assert(data.contact.character == "Lovepotion")
    assert(data.contact.realm == "Firemaw EU" and data.contact.faction == "Horde")
    assert(data.contact.discord == "https://discord.com/users/608587388184428544")
    assert(type(data.events) == "table")
end
assert(#ns.PvPEventsData.brackets[19].events == 2)
assert(#ns.PvPEventsData.brackets[29].events == 0)
assert(ns.PvPEventsData.brackets[19].events[1].startsAt == 1786802400 and ns.PvPEventsData.brackets[19].events[1].endsAt == 1786820400)
assert(ns.PvPEventsData.brackets[19].events[2].startsAt == 1786888800 and ns.PvPEventsData.brackets[19].events[2].endsAt == 1786906800)
for _, event in ipairs(ns.PvPEventsData.brackets[19].events) do
    assert(event.battleground == "WARSONG GULCH")
    assert(event.queueLabel == "QUEUE FOR WSG")
    assert(event.realm == "FIREMAW CLUSTER" and event.scope == "ALL CONNECTED REALMS")
    assert(event.faction == "HORDE VS ALLIANCE")
    assert(event.time == "16:00-21:00 SERVER TIME")
    assert(event.organizer == nil)
end

print("test_pvp_events.lua: ok")
