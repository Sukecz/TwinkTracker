local addonName, ns = ...

local TBC_ITEM_URL = "https://www.wowhead.com/tbc/item="

local tbcItemNames = {
    [3107] = "Broken Keen Throwing Knife",
    [20090] = "Highlander's Padded Girdle",
    [20093] = "Highlander's Padded Greaves",
    [20126] = "Highlander's Mail Girdle",
    [20129] = "Highlander's Mail Greaves",
    [20197] = "Defiler's Padded Girdle",
    [20207] = "Defiler's Mail Girdle",
    [20210] = "Defiler's Mail Greaves",
}

local function normalizeText(value)
    value = string.gsub(value, "https://www%.wowhead%.com/classic/", "https://www.wowhead.com/tbc/")
    value = string.gsub(value, "Era only, unavailable on Hardcore", "TBC PvP reward; verify the current vendor phase")
    value = string.gsub(value, "Era only", "TBC availability; verify the current phase")
    value = string.gsub(value, "Era%-only", "TBC availability; verify the current phase")
    value = string.gsub(value, "Era PvP only", "TBC PvP reward; verify the current vendor phase")
    value = string.gsub(value, "Era WSG only", "TBC WSG reward; verify the current vendor phase")
    value = string.gsub(value, "unavailable on Hardcore", "verify the current TBC client")
    value = string.gsub(value, "current Era", "current TBC")
    value = string.gsub(value, "Classic Era", "Burning Crusade Classic")
    value = string.gsub(value, "No verified Era", "No verified TBC")
    value = string.gsub(value, "Era%-source%-verified", "TBC-source-verified")
    return value
end

local function deepCopy(value, seen)
    if type(value) ~= "table" then
        if type(value) == "string" then
            return normalizeText(value)
        end
        return value
    end
    seen = seen or {}
    if seen[value] then return seen[value] end
    local result = {}
    seen[value] = result
    for key, entry in pairs(value) do result[deepCopy(key, seen)] = deepCopy(entry, seen) end
    if result.id and tbcItemNames[result.id] then result.name = tbcItemNames[result.id] end
    return result
end

local function inferFaction(note, faction)
    if faction or not note then return faction end
    local alliance = string.find(note, "Alliance", 1, true)
    local horde = string.find(note, "Horde", 1, true)
    if alliance and not horde then return "ALLIANCE" end
    if horde and not alliance then return "HORDE" end
end

local function item(id, name, note, faction)
    return {
        id = id,
        name = name,
        note = note,
        faction = inferFaction(note, faction),
        wowhead = id and TBC_ITEM_URL .. id or nil,
    }
end

local function choices(value)
    if value[1] then
        local result = {}
        for index, entry in ipairs(value) do result[index] = entry end
        return result
    end
    return { value }
end

local function tiers(s, a, b)
    return { S = choices(s), A = choices(a), B = choices(b) }
end

local TBC = {
    brackets = {},
    audit = {},
    item = item,
    tiers = tiers,
}
ns.TBCData = TBC

for _, level in ipairs(ns.Brackets.order) do
    local source = ns.Brackets:GetData(level)
    assert(source, "TBC base requires registered bracket " .. level)
    TBC.brackets[level] = deepCopy(source)
    TBC.brackets[level].pvp.events = {}
    TBC.audit[level] = {}
end

function TBC:GetBracket(level)
    return self.brackets[level]
end

function TBC:AuditClass(level, token, specification)
    local bracket = assert(self.brackets[level], "Unknown TBC bracket " .. tostring(level))
    local class = assert(bracket.bis.classes[token], "Unknown TBC class " .. tostring(token))
    assert(type(specification) == "table", "TBC class audit specification is required")
    assert(type(specification.sources) == "table" and #specification.sources > 0, "TBC class audit needs sources")

    local classAudit = { sources = specification.sources, slots = {}, note = specification.note }
    for _, slot in ipairs(class.slotOrder) do
        local slotData = assert(class.slots[slot], token .. " is missing TBC slot " .. slot)
        classAudit.slots[slot] = {}
        for _, tier in ipairs({ "S", "A", "B" }) do
            assert(type(slotData[tier]) == "table" and #slotData[tier] > 0, token .. " " .. slot .. " is missing TBC tier " .. tier)
            classAudit.slots[slot][tier] = "KEEP"
        end
    end

    for slot, replacement in pairs(specification.slots or {}) do
        assert(class.slots[slot], token .. " cannot override unknown slot " .. slot)
        assert(type(replacement) == "table", token .. " " .. slot .. " override must be tiered")
        for _, tier in ipairs({ "S", "A", "B" }) do
            assert(type(replacement[tier]) == "table" and #replacement[tier] > 0, token .. " " .. slot .. " override is missing tier " .. tier)
            classAudit.slots[slot][tier] = "CHANGE"
        end
        class.slots[slot] = replacement
    end

    if specification.role then class.role = specification.role end
    self.audit[level][token] = classAudit
end
