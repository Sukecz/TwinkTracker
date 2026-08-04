local addonName, ns = ...

local MainWindow = { pages = {}, tabButtons = {}, classButtons = {}, itemCards = {} }
ns.MainWindow = MainWindow

local C = {
    window = { 0.025, 0.032, 0.050, 0.985 }, panel = { 0.055, 0.070, 0.102, 0.96 },
    panel2 = { 0.075, 0.095, 0.135, 0.96 }, border = { 0.16, 0.21, 0.30, 1 },
    accent = { 0.20, 0.62, 1.00, 1 }, gold = { 1.00, 0.72, 0.24, 1 },
    text = { 0.92, 0.95, 1.00, 1 }, muted = { 0.55, 0.62, 0.72, 1 },
    tier = { S = { 1.00, 0.58, 0.16 }, A = { 0.48, 0.74, 1.00 }, B = { 0.66, 0.70, 0.78 } },
}

local CLASS_COORDS = CLASS_ICON_TCOORDS or {
    WARRIOR = { 0, 0.25, 0, 0.25 }, MAGE = { 0.25, 0.496, 0, 0.25 }, ROGUE = { 0.496, 0.742, 0, 0.25 },
    DRUID = { 0.742, 0.988, 0, 0.25 }, HUNTER = { 0, 0.25, 0.25, 0.496 }, SHAMAN = { 0.25, 0.496, 0.25, 0.496 },
    PRIEST = { 0.496, 0.742, 0.25, 0.496 }, WARLOCK = { 0.742, 0.988, 0.25, 0.496 }, PALADIN = { 0, 0.25, 0.496, 0.742 },
}

local function frame(parent, name)
    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    return CreateFrame("Frame", name, parent, template)
end

local function skin(box, color, border)
    if not box.SetBackdrop then return end
    box:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 })
    box:SetBackdropColor(unpack(color or C.panel))
    box:SetBackdropBorderColor(unpack(border or C.border))
end

local function label(parent, font, text, color)
    local value = parent:CreateFontString(nil, "OVERLAY", font or "GameFontNormal")
    value:SetText(text or "")
    value:SetTextColor(unpack(color or C.text))
    return value
end

local function button(parent, text, width, height)
    local value = CreateFrame("Button", nil, parent)
    value:SetSize(width, height)
    local bg = value:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(); bg:SetColorTexture(0.09, 0.12, 0.17, 1); value.bg = bg
    local line = value:CreateTexture(nil, "ARTWORK")
    line:SetPoint("BOTTOMLEFT"); line:SetPoint("BOTTOMRIGHT"); line:SetHeight(2); line:SetColorTexture(0.2, 0.62, 1, 0); value.line = line
    local title = label(value, "GameFontNormal", text); title:SetPoint("CENTER"); value.title = title
    value:SetScript("OnEnter", function(self) self.bg:SetColorTexture(0.12, 0.17, 0.24, 1) end)
    value:SetScript("OnLeave", function(self) if not self.active then self.bg:SetColorTexture(0.09, 0.12, 0.17, 1) end end)
    return value
end

local function setActive(value, active)
    value.active = active
    value.bg:SetColorTexture(active and 0.10 or 0.09, active and 0.19 or 0.12, active and 0.29 or 0.17, 1)
    value.line:SetColorTexture(0.2, 0.62, 1, active and 1 or 0)
    value.title:SetTextColor(active and 0.35 or 0.78, active and 0.75 or 0.82, 1, 1)
end

local function formatNumber(value)
    if type(BreakUpLargeNumbers) == "function" then return BreakUpLargeNumbers(value) end
    return tostring(value)
end

function MainWindow:Create()
    if self.frame then return self.frame end
    local saved = ns.Database:Get()
    local root = frame(UIParent, "TwinkTrackerMainFrame")
    root:SetSize(1040, 700); root:SetPoint(saved.frame.point, UIParent, saved.frame.point, saved.frame.x, saved.frame.y)
    root:SetFrameStrata("DIALOG"); root:SetMovable(true); root:EnableMouse(true); root:RegisterForDrag("LeftButton")
    root:SetScript("OnDragStart", root.StartMoving)
    root:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); local p, _, _, x, y = self:GetPoint(); ns.Database:SetFramePosition(p, x, y) end)
    skin(root, C.window, C.border); root:Hide(); self.frame = root

    local glow = root:CreateTexture(nil, "BACKGROUND", nil, -1)
    glow:SetPoint("TOPLEFT", 1, -1); glow:SetPoint("TOPRIGHT", -1, -1); glow:SetHeight(105); glow:SetColorTexture(0.03, 0.23, 0.42, 0.34)
    local brand = label(root, "GameFontNormalHuge", "TWINK|cff45a7ffTRACKER|r")
    brand:SetPoint("TOPLEFT", 28, -20)
    local sub = label(root, "GameFontNormalSmall", "CLASSIC ERA  •  LEVEL 19 BUILD COMMAND CENTER", C.muted)
    sub:SetPoint("TOPLEFT", brand, "BOTTOMLEFT", 2, -5)
    local version = label(root, "GameFontNormalSmall", "PILOT 0.1.0", C.muted); version:SetPoint("TOPRIGHT", -54, -29)
    local close = CreateFrame("Button", nil, root); close:SetSize(26, 26); close:SetPoint("TOPRIGHT", -18, -18)
    local x = label(close, "GameFontNormalLarge", "×", C.muted); x:SetPoint("CENTER", 0, 1)
    close:SetScript("OnEnter", function() x:SetTextColor(1, 0.35, 0.35) end); close:SetScript("OnLeave", function() x:SetTextColor(unpack(C.muted)) end); close:SetScript("OnClick", function() root:Hide() end)

    local nav = frame(root); nav:SetPoint("TOPLEFT", 22, -82); nav:SetPoint("TOPRIGHT", -22, -82); nav:SetHeight(42); skin(nav, C.panel)
    local tabs = { { "CHECKLIST", "CHECKLIST" }, { "XP", "XP TRACKER" }, { "BIS", "GEAR & LOADOUT" } }
    for i, spec in ipairs(tabs) do
        local value = button(nav, spec[2], 176, 42); value:SetPoint("LEFT", (i - 1) * 178, 0)
        value:SetScript("OnClick", function() self:SelectTab(spec[1]) end); self.tabButtons[spec[1]] = value
    end
    local live = label(nav, "GameFontNormalSmall", "●  LIVE CHARACTER DATA", { 0.35, 0.90, 0.55, 1 }); live:SetPoint("RIGHT", -16, 0)

    local content = frame(root); content:SetPoint("TOPLEFT", 22, -134); content:SetPoint("BOTTOMRIGHT", -22, 22); self.content = content
    self:CreateChecklistPage(); self:CreateXPPage(); self:CreateBisPage(); self:SelectTab(saved.selectedTab)
    return root
end

function MainWindow:CreatePage()
    local page = CreateFrame("Frame", nil, self.content); page:SetAllPoints(); page:Hide(); return page
end

function MainWindow:CreateChecklistPage()
    local page = self:CreatePage(); self.pages.CHECKLIST = page; self.checklistControls = {}
    local heading = label(page, "GameFontNormalLarge", "Preparation checklist"); heading:SetPoint("TOPLEFT", 4, -4)
    local intro = label(page, "GameFontNormalSmall", "Your progress is saved per character. XP-risk tasks are highlighted in amber.", C.muted); intro:SetPoint("TOPLEFT", heading, "BOTTOMLEFT", 0, -6)
    for index, entry in ipairs(ns.ChecklistData) do
        local column = (index - 1) % 2; local row = math.floor((index - 1) / 2)
        local card = frame(page); card:SetSize(480, 88); card:SetPoint("TOPLEFT", 4 + column * 494, -60 - row * 98); skin(card, C.panel)
        local check = CreateFrame("CheckButton", nil, card, "UICheckButtonTemplate"); check:SetSize(30, 30); check:SetPoint("TOPLEFT", 12, -12); check.entryID = entry.id
        check:SetScript("OnClick", function(self) ns.Database:SetChecklistDone(self.entryID, self:GetChecked()) end)
        local title = label(card, "GameFontNormal", entry.title, entry.risk and C.gold or C.text); title:SetPoint("TOPLEFT", 48, -14)
        local detail = label(card, "GameFontNormalSmall", entry.detail, C.muted); detail:SetPoint("TOPLEFT", 48, -38); detail:SetWidth(410); detail:SetJustifyH("LEFT")
        self.checklistControls[#self.checklistControls + 1] = check
    end
end

function MainWindow:CreateXPPage()
    local page = self:CreatePage(); self.pages.XP = page
    local hero = frame(page); hero:SetPoint("TOPLEFT", 80, -45); hero:SetPoint("TOPRIGHT", -80, -45); hero:SetHeight(215); skin(hero, C.panel)
    self.xpLevel = label(hero, "GameFontNormalHuge", "LEVEL 19"); self.xpLevel:SetPoint("TOP", 0, -28)
    self.xpValue = label(hero, "GameFontHighlightLarge", "0 / 0 XP"); self.xpValue:SetPoint("TOP", self.xpLevel, "BOTTOM", 0, -12)
    local bar = CreateFrame("StatusBar", nil, hero); bar:SetSize(700, 18); bar:SetPoint("TOP", self.xpValue, "BOTTOM", 0, -20); bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar"); bar:SetStatusBarColor(0.2, 0.62, 1); bar:SetMinMaxValues(0, 1); self.xpBar = bar
    local barBg = bar:CreateTexture(nil, "BACKGROUND"); barBg:SetAllPoints(); barBg:SetColorTexture(0.02, 0.025, 0.04, 1)
    self.xpRemaining = label(hero, "GameFontNormal", "Remaining: 0", C.muted); self.xpRemaining:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -13)
    self.xpPercent = label(hero, "GameFontNormal", "0.0%", C.text); self.xpPercent:SetPoint("TOPRIGHT", bar, "BOTTOMRIGHT", 0, -13)
    self.xpRisk = label(hero, "GameFontNormal", "SAFE"); self.xpRisk:SetPoint("BOTTOM", 0, 20)

    local warning = frame(page); warning:SetPoint("TOPLEFT", 80, -280); warning:SetPoint("TOPRIGHT", -80, -280); warning:SetHeight(145); skin(warning, C.panel2)
    local lockdown = CreateFrame("CheckButton", nil, warning, "UICheckButtonTemplate"); lockdown:SetSize(32, 32); lockdown:SetPoint("TOPLEFT", 18, -18); self.lockdownCheck = lockdown
    lockdown:SetScript("OnClick", function(self) ns.Database:SetXPLockdown(self:GetChecked()); MainWindow:RefreshXP() end)
    local lockTitle = label(warning, "GameFontNormalLarge", "XP LOCKDOWN", C.gold); lockTitle:SetPoint("LEFT", lockdown, "RIGHT", 8, 0)
    local copy = label(warning, "GameFontNormal", "Local warning mode only — it does not disable XP gain in World of Warcraft.", C.text); copy:SetPoint("TOPLEFT", 20, -62)
    local thresholds = label(warning, "GameFontNormalSmall", "WATCH 60%   •   DANGER 80%   •   CRITICAL 92%   |   Product safety thresholds, not Blizzard rules.", C.muted); thresholds:SetPoint("TOPLEFT", copy, "BOTTOMLEFT", 0, -12)
end

function MainWindow:CreateClassButton(parent, classToken, index)
    local value = CreateFrame("Button", nil, parent); value:SetSize(52, 52)
    value:SetPoint("TOPLEFT", 14 + ((index - 1) % 3) * 62, -56 - math.floor((index - 1) / 3) * 74)
    local border = value:CreateTexture(nil, "BACKGROUND"); border:SetAllPoints(); border:SetColorTexture(0.12, 0.16, 0.22, 1); value.border = border
    local icon = value:CreateTexture(nil, "ARTWORK"); icon:SetPoint("TOPLEFT", 3, -3); icon:SetPoint("BOTTOMRIGHT", -3, 3); icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    local coord = CLASS_COORDS[classToken]; if coord then icon:SetTexCoord(unpack(coord)) end
    local name = label(value, "GameFontNormalSmall", ns.BisData.classes[classToken].name, C.muted); name:SetPoint("TOP", value, "BOTTOM", 0, -3)
    value:SetScript("OnClick", function() ns.Database:SetSelectedClass(classToken); MainWindow:RefreshBis() end)
    value:SetScript("OnEnter", function() border:SetColorTexture(0.2, 0.62, 1, 0.8) end)
    value:SetScript("OnLeave", function() MainWindow:RefreshClassButtons() end)
    value.classToken = classToken; self.classButtons[classToken] = value
end

function MainWindow:CreateItemCard(parent, tier, index)
    local card = CreateFrame("Button", nil, parent); card:SetSize(228, 82); card:SetPoint("TOPLEFT", 10, -48 - (index - 1) * 90)
    local bg = card:CreateTexture(nil, "BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.055, 0.07, 0.10, 1)
    local accent = card:CreateTexture(nil, "ARTWORK"); accent:SetPoint("TOPLEFT"); accent:SetPoint("BOTTOMLEFT"); accent:SetWidth(3); accent:SetColorTexture(unpack(C.tier[tier]))
    local icon = card:CreateTexture(nil, "ARTWORK"); icon:SetSize(54, 54); icon:SetPoint("LEFT", 14, 0); icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark"); card.icon = icon
    local iconBorder = card:CreateTexture(nil, "OVERLAY"); iconBorder:SetSize(62, 62); iconBorder:SetPoint("CENTER", icon); iconBorder:SetTexture("Interface\\Buttons\\UI-Quickslot2")
    local name = label(card, "GameFontNormal", "Item"); name:SetPoint("TOPLEFT", 78, -16); name:SetWidth(138); name:SetJustifyH("LEFT"); card.name = name
    local slot = label(card, "GameFontNormalSmall", "SLOT", C.muted); slot:SetPoint("TOPLEFT", 78, -39); card.slot = slot
    local note = label(card, "GameFontNormalSmall", "", C.muted); note:SetPoint("TOPLEFT", 78, -56); note:SetWidth(138); note:SetJustifyH("LEFT"); card.note = note
    card:SetScript("OnEnter", function(self) bg:SetColorTexture(0.09, 0.12, 0.17, 1); if self.itemID then GameTooltip:SetOwner(self, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:" .. self.itemID); GameTooltip:Show() end end)
    card:SetScript("OnLeave", function() bg:SetColorTexture(0.055, 0.07, 0.10, 1); GameTooltip:Hide() end)
    return card
end

function MainWindow:CreateBisPage()
    local page = self:CreatePage(); self.pages.BIS = page
    local classes = frame(page); classes:SetPoint("TOPLEFT"); classes:SetPoint("BOTTOMLEFT"); classes:SetWidth(208); skin(classes, C.panel)
    local classTitle = label(classes, "GameFontNormal", "SELECT CLASS", C.muted); classTitle:SetPoint("TOPLEFT", 14, -16)
    for i, token in ipairs(ns.BisData.classOrder) do self:CreateClassButton(classes, token, i) end
    local source = label(classes, "GameFontNormalSmall", "Classic Era pilot data\nFaction and acquisition checks\nremain required.", C.muted); source:SetPoint("BOTTOMLEFT", 14, 18); source:SetWidth(178); source:SetJustifyH("LEFT")

    local gear = frame(page); gear:SetPoint("TOPLEFT", classes, "TOPRIGHT", 12, 0); gear:SetPoint("BOTTOMRIGHT"); skin(gear, C.window)
    self.className = label(gear, "GameFontNormalLarge", "DRUID"); self.className:SetPoint("TOPLEFT", 16, -13)
    self.classRole = label(gear, "GameFontNormalSmall", "ROLE", C.muted); self.classRole:SetPoint("LEFT", self.className, "RIGHT", 12, 0)
    local tiers = { "S", "A", "B" }
    for column, tier in ipairs(tiers) do
        local tierFrame = frame(gear); tierFrame:SetSize(248, 332); tierFrame:SetPoint("TOPLEFT", 10 + (column - 1) * 256, -48); skin(tierFrame, C.panel)
        local tierName = label(tierFrame, "GameFontNormalLarge", "TIER " .. tier, C.tier[tier]); tierName:SetPoint("TOPLEFT", 12, -13)
        self.itemCards[tier] = {}
        for index = 1, 3 do self.itemCards[tier][index] = self:CreateItemCard(tierFrame, tier, index) end
    end
    local extras = frame(gear); extras:SetPoint("TOPLEFT", 10, -392); extras:SetPoint("BOTTOMRIGHT", -10, 10); skin(extras, C.panel)
    local ench = label(extras, "GameFontNormal", "ENCHANTS", C.accent); ench:SetPoint("TOPLEFT", 14, -12)
    self.enchantText = label(extras, "GameFontNormalSmall", "", C.muted); self.enchantText:SetPoint("TOPLEFT", ench, "BOTTOMLEFT", 0, -8); self.enchantText:SetWidth(355); self.enchantText:SetJustifyH("LEFT")
    local con = label(extras, "GameFontNormal", "CONSUMABLES", C.gold); con:SetPoint("TOPLEFT", 402, -12)
    self.consumableText = label(extras, "GameFontNormalSmall", "", C.muted); self.consumableText:SetPoint("TOPLEFT", con, "BOTTOMLEFT", 0, -8); self.consumableText:SetWidth(340); self.consumableText:SetJustifyH("LEFT")
end

function MainWindow:SelectTab(tab)
    ns.Database:SetSelectedTab(tab)
    for id, page in pairs(self.pages) do page:SetShown(id == tab); setActive(self.tabButtons[id], id == tab) end
    if tab == "CHECKLIST" then self:RefreshChecklist() elseif tab == "XP" then self:RefreshXP() elseif tab == "BIS" then self:RefreshBis() end
end

function MainWindow:RefreshChecklist()
    for _, control in ipairs(self.checklistControls) do control:SetChecked(ns.Database:IsChecklistDone(control.entryID)) end
end

function MainWindow:RefreshXP()
    local s = ns.XPTracker:GetLive(); local riskColor = ({ SAFE = { 0.25, 0.9, 0.5 }, WATCH = C.gold, DANGER = { 1, 0.38, 0.18 }, CRITICAL = { 1, 0.12, 0.12 }, NOT_19 = C.muted, UNAVAILABLE = C.muted })[s.risk]
    self.xpLevel:SetText("LEVEL " .. s.level); self.xpValue:SetText(string.format("%s / %s XP", formatNumber(s.current), formatNumber(s.maximum)))
    self.xpRemaining:SetText("Remaining: " .. formatNumber(s.remaining)); self.xpPercent:SetText(string.format("%.1f%%", s.usedPercent * 100)); self.xpBar:SetValue(s.usedPercent)
    self.xpRisk:SetText(s.risk .. "  •  " .. ns.XPTracker:GetRiskText(s)); self.xpRisk:SetTextColor(unpack(riskColor)); self.lockdownCheck:SetChecked(ns.Database:Get().xpLockdown)
end

function MainWindow:RefreshClassButtons()
    local selected = ns.Database:Get().selectedClass
    for token, value in pairs(self.classButtons) do value.border:SetColorTexture(token == selected and 0.20 or 0.12, token == selected and 0.62 or 0.16, token == selected and 1.00 or 0.22, 1) end
end

function MainWindow:RefreshBis()
    local profile = ns.BisData.classes[ns.Database:Get().selectedClass]; self.className:SetText(string.upper(profile.name)); self.classRole:SetText(profile.role); self:RefreshClassButtons()
    for tier, cards in pairs(self.itemCards) do
        for index, card in ipairs(cards) do
            local data = profile.tiers[tier][index]; card.itemID = data.id; card.name:SetText(data.name); card.slot:SetText(data.slot); card.note:SetText(data.note or "")
            local icon = GetItemIcon and GetItemIcon(data.id); card.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")
            if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(data.id) end
        end
    end
    self.enchantText:SetText(table.concat(ns.BisData.enchants, "  •  ")); self.consumableText:SetText(table.concat(ns.ConsumablesData, "  •  "))
end

function MainWindow:RefreshItemIcons()
    if self.pages.BIS and self.pages.BIS:IsShown() then self:RefreshBis() end
end

function MainWindow:Toggle() local root = self:Create(); if root:IsShown() then root:Hide() else root:Show(); self:SelectTab(ns.Database:Get().selectedTab) end end
function MainWindow:Show() local root = self:Create(); root:Show(); self:SelectTab(ns.Database:Get().selectedTab) end
function MainWindow:Hide() if self.frame then self.frame:Hide() end end
