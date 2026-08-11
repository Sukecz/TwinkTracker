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

local function getBracketData(level)
    return ns.Brackets:GetData(level) or ns.Brackets:GetData(ns.Defaults.selectedBracket)
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
    self.data.frame.width = type(self.data.frame.width) == "number" and clamp(self.data.frame.width, 880, 1500) or defaults.frame.width
    self.data.frame.height = type(self.data.frame.height) == "number" and clamp(self.data.frame.height, 620, 950) or defaults.frame.height

    local bracket = ns.Brackets.profiles[self.data.selectedBracket]
    if not bracket or not bracket.available or not ns.Brackets:GetData(self.data.selectedBracket) then
        self.data.selectedBracket = defaults.selectedBracket
    end
    local bracketData = getBracketData(self.data.selectedBracket)
    if not bracketData.bis.classes[self.data.selectedClass] then
        self.data.selectedClass = defaults.selectedClass
    end
    self.data.selectedTab = "BIS"
    if self.data.selectedPage ~= "GEAR" and self.data.selectedPage ~= "BASICS" and self.data.selectedPage ~= "CLASS_TIERS" and self.data.selectedPage ~= "GUIDES" and self.data.selectedPage ~= "EXPLORATION" and self.data.selectedPage ~= "COMMUNITY" then
        self.data.selectedPage = defaults.selectedPage
    end
    if self.data.selectedGearSection ~= "GEAR" and self.data.selectedGearSection ~= "ENCHANTS" and self.data.selectedGearSection ~= "CONSUMABLES" then
        self.data.selectedGearSection = defaults.selectedGearSection
    end
    if not bracketData.guides.sections[self.data.selectedGuide] then
        self.data.selectedGuide = defaults.selectedGuide
    end
    self.data.minimapAngle = type(self.data.minimapAngle) == "number" and clamp(self.data.minimapAngle, 0, 360) or defaults.minimapAngle
    if type(self.data.showMinimapIcon) ~= "boolean" then
        self.data.showMinimapIcon = defaults.showMinimapIcon
    end
    local profile = bracketData.bis.classes[self.data.selectedClass]
    if type(self.data.selectedSlot) ~= "string" or not profile.slots[self.data.selectedSlot] then
        self.data.selectedSlot = defaults.selectedSlot
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
    local bracketData = getBracketData(self.data.selectedBracket)
    if not bracketData.bis.classes[classToken] then
        return false
    end
    self.data.selectedClass = classToken
    if not bracketData.bis.classes[classToken].slots[self.data.selectedSlot] then
        self.data.selectedSlot = bracketData.bis.classes[classToken].slotOrder[1]
    end
    return true
end

function Database:SetSelectedBracket(level)
    local bracket = ns.Brackets.profiles[level]
    local bracketData = ns.Brackets:GetData(level)
    if not bracket or not bracket.available or not bracketData then
        return false
    end
    self.data.selectedBracket = level
    if not bracketData.bis.classes[self.data.selectedClass] then
        self.data.selectedClass = ns.Defaults.selectedClass
    end
    local profile = bracketData.bis.classes[self.data.selectedClass]
    if not profile.slots[self.data.selectedSlot] then
        self.data.selectedSlot = profile.slotOrder[1]
    end
    if not bracketData.guides.sections[self.data.selectedGuide] then
        self.data.selectedGuide = bracketData.guides.order[1]
    end
    return true
end

function Database:SetSelectedSlot(slot)
    local profile = getBracketData(self.data.selectedBracket).bis.classes[self.data.selectedClass]
    if not profile.slots[slot] then return false end
    self.data.selectedSlot = slot
    return true
end

function Database:SetSelectedPage(page)
    if page ~= "GEAR" and page ~= "BASICS" and page ~= "CLASS_TIERS" and page ~= "GUIDES" and page ~= "EXPLORATION" and page ~= "COMMUNITY" then return false end
    self.data.selectedPage = page
    return true
end

function Database:SetSelectedGuide(guide)
    if not getBracketData(self.data.selectedBracket).guides.sections[guide] then return false end
    self.data.selectedGuide = guide
    return true
end

function Database:SetSelectedGearSection(section)
    if section ~= "GEAR" and section ~= "ENCHANTS" and section ~= "CONSUMABLES" then return false end
    self.data.selectedGearSection = section
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

function Database:SetFrameSize(width, height)
    self.data.frame.width = clamp(width, 880, 1500)
    self.data.frame.height = clamp(height, 620, 950)
end

function Database:SetMinimapAngle(angle)
    self.data.minimapAngle = clamp(angle,0,360)
end

function Database:SetShowMinimapIcon(shown)
    self.data.showMinimapIcon = shown and true or false
end

function Database:ResetFramePosition()
    self.data.frame.point = ns.Defaults.frame.point
    self.data.frame.x = ns.Defaults.frame.x
    self.data.frame.y = ns.Defaults.frame.y
    self.data.frame.width = ns.Defaults.frame.width
    self.data.frame.height = ns.Defaults.frame.height
end
