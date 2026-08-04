local addonName, ns = ...

local GearStatus = {}
ns.GearStatus = GearStatus

function GearStatus:Collect(getItemID, getItemLink, getItemInfo)
    getItemID = getItemID or GetInventoryItemID
    getItemLink = getItemLink or GetInventoryItemLink
    getItemInfo = getItemInfo or GetItemInfo
    local equipped = {}

    if not getItemID then return equipped end
    for slot = 1, 19 do
        local itemID = getItemID("player", slot)
        if itemID then
            local entry = equipped[itemID]
            if not entry then entry = { names = {} }; equipped[itemID] = entry end
            local link = getItemLink and getItemLink("player", slot)
            local name = link and getItemInfo and getItemInfo(link)
            if name then entry.names[name] = true end
        end
    end
    return equipped
end

function GearStatus:CountProfileItemIDs(profile)
    local counts = {}
    for _, slot in ipairs(profile.slotOrder) do
        for _, tier in ipairs({ "S", "A", "B" }) do
            for _, itemData in ipairs(profile.slots[slot][tier]) do
                local itemID = itemData.id
                if itemID then counts[itemID] = (counts[itemID] or 0) + 1 end
            end
        end
    end
    return counts
end

function GearStatus:IsEquipped(itemData, equipped, profileCounts)
    if not itemData.id or not equipped[itemData.id] then return false end
    if (profileCounts[itemData.id] or 0) <= 1 then return true end

    local names = equipped[itemData.id].names
    if names and next(names) then return names[itemData.name] == true end
    return false
end
