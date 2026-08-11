local addonName, ns = ...

local contact = {
    character = "Lovepotion",
    realm = "Firemaw EU",
    faction = "Horde",
    discord = "https://discord.com/users/608587388184428544",
}

local function bracket(level)
    return {
        level = level,
        contact = contact,
        events = level == 19 and {
            { battleground="WARSONG GULCH", realm="FIREMAW CLUSTER", scope="ALL CONNECTED REALMS", date="15 AUG 2026", time="16:00-21:00 SERVER TIME", startsAt=1786802400, endsAt=1786820400, faction="HORDE VS ALLIANCE" },
            { battleground="WARSONG GULCH", realm="FIREMAW CLUSTER", scope="ALL CONNECTED REALMS", date="16 AUG 2026", time="16:00-21:00 SERVER TIME", startsAt=1786888800, endsAt=1786906800, faction="HORDE VS ALLIANCE" },
        } or {},
    }
end

ns.PvPEventsData = {
    version = "2026-08-11",
    submissionFields = "Realm or cluster, bracket, battleground, date, start time with time zone, faction and organizer contact.",
    brackets = {
        [19] = bracket(19),
        [29] = bracket(29),
    },
}
