local ns = {}

local function loadModule(path)
    local chunk = assert(loadfile(path))
    chunk("TwinkTracker", ns)
end

for _, path in ipairs({
    "Data/Brackets.lua", "Data/Bis.lua", "Data/ClassTiers.lua",
    "Data/Bracket29/Bis.lua", "Data/Bracket29/ClassTiers.lua",
    "Data/Bracket39/Bis.lua", "Data/Bracket39/ClassTiers.lua",
}) do
    loadModule(path)
end

local validTier = { S=true, A=true, B=true, C=true }

local function validate(data)
    assert(data.status == nil)
    assert(string.find(data.criteria,"OFFENSE",1,true))
    assert(string.find(data.criteria,"SURVIVAL",1,true))
    assert(string.find(data.criteria,"UTILITY",1,true))
    assert(#data.classOrder == 9)
    local seen = {}
    for _, token in ipairs(data.classOrder) do
        assert(not seen[token], "duplicate class tier entry " .. token)
        seen[token] = true
        local entry = assert(data.classes[token], "missing class tier entry " .. token)
        assert(validTier[entry.overall])
        for _, key in ipairs({ "offense", "survival", "utility" }) do
            assert(type(entry[key]) == "number" and entry[key] >= 0 and entry[key] <= 10 and entry[key] == math.floor(entry[key]))
        end
        assert(type(entry.role) == "string" and entry.role ~= "")
        assert(type(entry.summary) == "string" and entry.summary ~= "")
    end
end

validate(ns.ClassTiersData)
validate(ns.Bracket29ClassTiersData)
validate(ns.Bracket39ClassTiersData)
assert(ns.ClassTiersData.classes.HUNTER.overall == "S")
assert(ns.ClassTiersData.classes.PRIEST.overall == "S")
assert(ns.ClassTiersData.classes.HUNTER.offense == 10)
assert(ns.Bracket29ClassTiersData.classes.MAGE.overall == "S")
assert(ns.Bracket29ClassTiersData.classes.WARRIOR.overall == "C")
assert(ns.Bracket39ClassTiersData.classes.WARRIOR.overall == "S")
assert(string.find(ns.ClassTiersData.intro,"Equal tiers are not ranked",1,true))

print("test_class_tiers.lua: ok")
