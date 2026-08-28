local addonName, ns = ...

local projectID = WOW_PROJECT_ID
local tbcProjectID = WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5
local isTBC = projectID == tbcProjectID

local metadata
if C_AddOns and C_AddOns.GetAddOnMetadata then
    metadata = C_AddOns.GetAddOnMetadata
elseif GetAddOnMetadata then
    metadata = GetAddOnMetadata
end

local version = metadata and metadata(addonName, "Version") or "dev"

ns.Client = {
    key = isTBC and "TBC" or "ERA",
    label = isTBC and "BURNING CRUSADE CLASSIC" or "CLASSIC ERA",
    version = version or "dev",
}

local unavailablePages = isTBC and { PVP = true } or {}

function ns.Client:GetDisplayText()
    return self.label .. " " .. self.version
end

function ns.Client:IsPageAvailable(page)
    return unavailablePages[page] ~= true
end
