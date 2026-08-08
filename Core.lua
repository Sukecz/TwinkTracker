local addonName, ns = ...

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")

eventFrame:SetScript("OnEvent", function(_, event, loadedAddon)
    if event == "ADDON_LOADED" then
        if loadedAddon ~= addonName then
            return
        end
        TwinkTrackerDB = ns.Database:Initialize(TwinkTrackerDB)
    elseif event == "PLAYER_LOGIN" then
        ns:RegisterSlashCommands()
        ns.MainWindow:Create()
        ns.MinimapButton:Create()
    elseif event == "GET_ITEM_INFO_RECEIVED" and ns.MainWindow.frame then
        ns.MainWindow:RefreshItemIcons()
    elseif event == "PLAYER_EQUIPMENT_CHANGED" and ns.MainWindow.frame then
        ns.MainWindow:RefreshEquipment()
    end
end)
