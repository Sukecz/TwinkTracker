local addonName, ns = ...

local XPTracker = {}
ns.XPTracker = XPTracker

XPTracker.thresholds = {
    WATCH = 0.60,
    DANGER = 0.80,
    CRITICAL = 0.92,
}

function XPTracker:Calculate(current, maximum, level)
    current = type(current) == "number" and current or 0
    maximum = type(maximum) == "number" and maximum or 0
    level = type(level) == "number" and level or 0

    if maximum <= 0 then
        return {
            current = current,
            maximum = maximum,
            remaining = 0,
            usedPercent = 0,
            level = level,
            risk = "UNAVAILABLE",
        }
    end

    local usedPercent = math.max(0, math.min(1, current / maximum))
    local risk = "SAFE"
    if level ~= 19 then
        risk = "NOT_19"
    elseif usedPercent >= self.thresholds.CRITICAL then
        risk = "CRITICAL"
    elseif usedPercent >= self.thresholds.DANGER then
        risk = "DANGER"
    elseif usedPercent >= self.thresholds.WATCH then
        risk = "WATCH"
    end

    return {
        current = current,
        maximum = maximum,
        remaining = math.max(0, maximum - current),
        usedPercent = usedPercent,
        level = level,
        risk = risk,
    }
end

function XPTracker:GetLive()
    return self:Calculate(UnitXP("player"), UnitXPMax("player"), UnitLevel("player"))
end

function XPTracker:GetRiskText(snapshot)
    local descriptions = {
        SAFE = "SAFE — below the pilot watch threshold.",
        WATCH = "WATCH — review planned XP sources.",
        DANGER = "DANGER — avoid unplanned XP activities.",
        CRITICAL = "CRITICAL — remaining XP buffer is very small.",
        NOT_19 = "Informational only — XP caution mode is designed for level 19.",
        UNAVAILABLE = "XP data is currently unavailable.",
    }
    return descriptions[snapshot.risk] or descriptions.UNAVAILABLE
end
