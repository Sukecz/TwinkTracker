local addonName, ns = ...

local item = ns.BisHelpers.item
local tiers = ns.BisHelpers.tiers
local profile = ns.BisHelpers.profile

local function factionChoices(hordeID, hordeName, allianceID, allianceName, note)
    if (string.find(note, "WSG", 1, true) or string.find(note, "AB", 1, true) or string.find(note, "PvP", 1, true))
        and not string.find(note, "Era", 1, true) then
        note = note .. "; Era only, unavailable on Hardcore"
    end
    local choices = {}
    if hordeID then choices[#choices + 1] = item(hordeID, hordeName, "Horde " .. note, "HORDE") end
    if allianceID then choices[#choices + 1] = item(allianceID, allianceName, "Alliance " .. note, "ALLIANCE") end
    return choices
end

local function combine(...)
    local choices = {}
    for index = 1, select("#", ...) do
        local value = select(index, ...)
        if value.id ~= nil or value.name then
            choices[#choices + 1] = value
        else
            for _, entry in ipairs(value) do choices[#choices + 1] = entry end
        end
    end
    assert(#choices <= 3, "Bracket 39 tier has more than three choices")
    return choices
end

local function noVerified(label)
    return item(nil, "No verified Era " .. label, "No lower recommendation is promoted without Classic Era evidence")
end

local function randomNote(role)
    return role .. "; random suffix, verify the exact live / AH roll"
end

local function addClass(token, name, role, slots, extraSlots)
    ns.Bracket39BisData.classes[token] = profile(name, role, {}, slots, extraSlots)
end

ns.Bracket39BisData = {
    wowheadClassicItemURL = "https://www.wowhead.com/classic/item=",
    slotNames = ns.BisData.slotNames,
    classOrder = ns.BisData.classOrder,
    classes = {},
}

ns.Bracket39BisHelpers = {
    item = item,
    tiers = tiers,
    factionChoices = factionChoices,
    combine = combine,
    noVerified = noVerified,
    randomNote = randomNote,
    addClass = addClass,
}
