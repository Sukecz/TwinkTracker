local addonName, ns = ...

local Database = {}
ns.Database = Database

local validTabs = {
    CHECKLIST = true,
    XP = true,
    BIS = true,
}

local function copyDefaults(source)
    local target = {}
    for key, value in pairs(source) do
        if type(value) == "table" then
            target[key] = copyDefaults(value)
        else
            target[key] = value
        end
    end
    return target
end

local function clamp(value, minimum, maximum)
    if type(value) ~= "number" then
        return 0
    end
    if value < minimum then
        return minimum
    end
    if value > maximum then
        return maximum
    end
    return value
end

function Database:Initialize(saved)
    self.data = type(saved) == "table" and saved or {}
    local defaults = copyDefaults(ns.Defaults)

    if type(self.data.frame) ~= "table" then
        self.data.frame = defaults.frame
    end
    if self.data.frame.point ~= "CENTER" and self.data.frame.point ~= "TOP" and self.data.frame.point ~= "BOTTOM" then
        self.data.frame.point = defaults.frame.point
    end
    self.data.frame.x = clamp(self.data.frame.x, -5000, 5000)
    self.data.frame.y = clamp(self.data.frame.y, -5000, 5000)

    if not ns.BisData.classes[self.data.selectedClass] then
        self.data.selectedClass = defaults.selectedClass
    end
    if not validTabs[self.data.selectedTab] then
        self.data.selectedTab = defaults.selectedTab
    end
    if type(self.data.xpLockdown) ~= "boolean" then
        self.data.xpLockdown = defaults.xpLockdown
    end
    if type(self.data.checklist) ~= "table" then
        self.data.checklist = {}
    end
    return self.data
end

function Database:Get()
    return self.data
end

function Database:SetChecklistDone(key, done)
    if type(key) ~= "string" then
        return false
    end
    self.data.checklist[key] = done and true or nil
    return true
end

function Database:IsChecklistDone(key)
    return self.data.checklist[key] == true
end

function Database:SetSelectedClass(classToken)
    if not ns.BisData.classes[classToken] then
        return false
    end
    self.data.selectedClass = classToken
    return true
end

function Database:SetSelectedTab(tab)
    if not validTabs[tab] then
        return false
    end
    self.data.selectedTab = tab
    return true
end

function Database:SetXPLockdown(enabled)
    self.data.xpLockdown = enabled and true or false
end

function Database:SetFramePosition(point, x, y)
    if point == "TOP" or point == "BOTTOM" or point == "CENTER" then
        self.data.frame.point = point
    else
        self.data.frame.point = "CENTER"
    end
    self.data.frame.x = clamp(x, -5000, 5000)
    self.data.frame.y = clamp(y, -5000, 5000)
end

function Database:ResetFramePosition()
    self.data.frame.point = ns.Defaults.frame.point
    self.data.frame.x = ns.Defaults.frame.x
    self.data.frame.y = ns.Defaults.frame.y
end
