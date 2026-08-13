local function loadClient(projectID, version)
    local ns = {}
    WOW_PROJECT_ID = projectID
    WOW_PROJECT_BURNING_CRUSADE_CLASSIC = 5
    C_AddOns = {
        GetAddOnMetadata = function(addonName, field)
            assert(addonName == "TwinkTracker" and field == "Version")
            return version
        end,
    }
    local chunk = assert(loadfile("Client.lua"))
    chunk("TwinkTracker", ns)
    return ns.Client
end

local era = loadClient(2, "0.4.0")
assert(era.key == "ERA")
assert(era.label == "CLASSIC ERA")
assert(era:GetDisplayText() == "CLASSIC ERA 0.4.0")
assert(era:IsPageAvailable("PVP"))
assert(era:IsPageAvailable("GEAR"))

local tbc = loadClient(5, "0.4.0")
assert(tbc.key == "TBC")
assert(tbc.label == "BURNING CRUSADE CLASSIC")
assert(tbc:GetDisplayText() == "BURNING CRUSADE CLASSIC 0.4.0")
assert(not tbc:IsPageAvailable("PVP"))
assert(tbc:IsPageAvailable("GEAR"))

print("test_client.lua: ok")
