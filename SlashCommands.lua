local addonName, ns = ...

function ns:RegisterSlashCommands()
    SLASH_TWINKTRACKER1 = "/twinktracker"
    SLASH_TWINKTRACKER2 = "/tt"
    SLASH_TWINKTRACKER3 = "/twink"
    SlashCmdList.TWINKTRACKER = function(message)
        local command = string.lower((message or ""):match("^%s*(.-)%s*$"))
        if command == "" then
            ns.MainWindow:Toggle()
        elseif command == "show" then
            ns.MainWindow:Show()
        elseif command == "hide" then
            ns.MainWindow:Hide()
        elseif command == "reset" then
            ns.Database:ResetFramePosition()
            if ns.MainWindow.frame then
                ns.MainWindow.frame:ClearAllPoints()
                ns.MainWindow.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
            end
            print("TwinkTracker: window position reset.")
        else
            print("TwinkTracker: /tt [show|hide|reset|help]")
        end
    end
end
