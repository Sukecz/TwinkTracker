local addonName, ns = ...

for _, level in ipairs(ns.Brackets.order) do
    local data = assert(ns.TBCData:GetBracket(level), "Missing TBC bracket " .. level)
    data.basicsIntro = "Burning Crusade Classic does not offer an XP lock. Prepare routes before level " .. level .. ", and re-check every XP-bearing quest before turn-in."
    ns.Brackets:RegisterData(level, data)
end
