local addonName, ns = ...

local Brackets = ns.Brackets

Brackets.data = Brackets.data or {}

function Brackets:RegisterData(level, data)
    if type(level) ~= "number" or type(data) ~= "table" then
        return false
    end
    Brackets.data[level] = data
    return true
end

function Brackets:GetData(level)
    return self.data[level]
end

Brackets:RegisterData(19, {
    level = 19,
    bis = ns.BisData,
    enchants = ns.EnchantsData,
    consumables = ns.ConsumablesData,
    basics = ns.BasicsData,
    guides = ns.GuidesData,
    classTiers = ns.ClassTiersData,
    exploration = ns.ExplorationData,
    explorationCategories = ns.ExplorationCategories,
    basicsIntro = "The essential Classic Era rule: experience cannot be locked. Prepare before 19, then avoid every source of character XP.",
})
