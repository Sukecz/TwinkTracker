local addonName, ns = ...

local contact = {
    character = "Lovepotion",
    realm = "Firemaw EU",
    faction = "Horde",
    discord = "https://discord.com/users/608587388184428544",
}

local function bracket(level)
    local events = {}
    if level == 29 then
        events = {
            { battleground="WARSONG GULCH", queueLabel="QUEUE FOR WSG", realm="FIREMAW CLUSTER", scope="ALL CONNECTED REALMS", date="EVERY TUESDAY", time="20:00 SERVER TIME", recurringLabel="EVERY TUESDAY", faction="HORDE VS ALLIANCE" },
        }
    end
    return {
        level = level,
        contact = contact,
        events = events,
    }
end

ns.PvPEventsData = {
    version = "2026-08-28",
    submissionFields = "Realm or cluster, bracket, battleground, date, start time with time zone, faction and organizer contact.",
    brackets = {
        [19] = bracket(19),
        [29] = bracket(29),
        [39] = bracket(39),
    },
}
