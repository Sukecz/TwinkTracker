local addonName, ns = ...

local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("PLAYER_XP_UPDATE")
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
eventFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED")

eventFrame:SetScript("OnEvent", function(_, event, loadedAddon)
    if event == "ADDON_LOADED" then
        if loadedAddon ~= addonName then
            return
        end
        TwinkTrackerDB = ns.Database:Initialize(TwinkTrackerDB)
    elseif event == "PLAYER_LOGIN" then
        ns:RegisterSlashCommands()
        ns.MainWindow:Create()
    elseif (event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP") and ns.MainWindow.frame and ns.MainWindow.pages.XP:IsShown() then
        ns.MainWindow:RefreshXP()
    elseif event == "GET_ITEM_INFO_RECEIVED" and ns.MainWindow.frame then
        ns.MainWindow:RefreshItemIcons()
    end
end)
