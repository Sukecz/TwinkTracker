local addonName, ns = ...

local function findShortAliasConflict()
    for globalName,value in pairs(_G) do
        if type(globalName)=="string" and type(value)=="string" and string.lower(value)=="/tt" and not string.match(globalName,"^SLASH_TWINKTRACKER%d+$") then
            return string.match(globalName,"^SLASH_(.-)%d+$") or globalName
        end
    end
end

function ns:RegisterSlashCommands()
    local conflict=findShortAliasConflict()
    SLASH_TWINKTRACKER1 = "/twinktracker"
    SLASH_TWINKTRACKER2 = "/tt"
    SLASH_TWINKTRACKER3 = "/twink"
    SLASH_TWINKTRACKER4 = "/twt"
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
                ns.MainWindow.frame:SetSize(ns.Defaults.frame.width, ns.Defaults.frame.height)
                ns.MainWindow:Layout()
            end
            print("TwinkTracker: window position and size reset.")
        else
            print("TwinkTracker: /twt [show|hide|reset|help]")
        end
    end
    if conflict then print("TwinkTracker: /tt is already used by "..conflict.."; use /twt.") end
end
