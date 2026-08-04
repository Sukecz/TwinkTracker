local addonName, ns = ...

local MainWindow = { classButtons = {}, slotButtons = {}, tierCards = {} }
ns.MainWindow = MainWindow

local C = {
    window = { 0.022, 0.029, 0.044, 0.99 }, panel = { 0.050, 0.065, 0.095, 0.98 },
    panel2 = { 0.070, 0.090, 0.128, 0.98 }, border = { 0.15, 0.20, 0.29, 1 },
    accent = { 0.20, 0.62, 1.00, 1 }, text = { 0.92, 0.95, 1.00, 1 },
    muted = { 0.53, 0.60, 0.70, 1 }, tier = { S={1.00,0.57,0.14,1}, A={0.43,0.73,1.00,1}, B={0.67,0.70,0.78,1} },
}

local CLASS_COORDS = CLASS_ICON_TCOORDS or {
    WARRIOR={0,0.25,0,0.25}, MAGE={0.25,0.496,0,0.25}, ROGUE={0.496,0.742,0,0.25}, DRUID={0.742,0.988,0,0.25},
    HUNTER={0,0.25,0.25,0.496}, SHAMAN={0.25,0.496,0.25,0.496}, PRIEST={0.496,0.742,0.25,0.496},
    WARLOCK={0.742,0.988,0.25,0.496}, PALADIN={0,0.25,0.496,0.742},
}

local function frame(parent, name)
    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    return CreateFrame("Frame", name, parent, template)
end

local function skin(box, color, border)
    if not box.SetBackdrop then return end
    box:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8X8", edgeFile="Interface\\Buttons\\WHITE8X8", edgeSize=1 })
    box:SetBackdropColor(unpack(color or C.panel)); box:SetBackdropBorderColor(unpack(border or C.border))
end

local function label(parent, font, text, color)
    local value = parent:CreateFontString(nil, "OVERLAY", font or "GameFontNormal")
    value:SetText(text or ""); value:SetTextColor(unpack(color or C.text)); return value
end

local function getItemIcon(itemID)
    if not itemID then return "Interface\\Icons\\INV_Misc_QuestionMark" end
    local icon = GetItemIcon and GetItemIcon(itemID)
    return icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

function MainWindow:CreateClassButton(parent, token, index)
    local value = CreateFrame("Button", nil, parent); value:SetSize(52, 52)
    value:SetPoint("TOPLEFT", 14 + ((index - 1) % 3) * 62, -50 - math.floor((index - 1) / 3) * 73)
    local border = value:CreateTexture(nil, "BACKGROUND"); border:SetPoint("TOPLEFT", -2, 2); border:SetPoint("BOTTOMRIGHT", 2, -2); border:SetColorTexture(unpack(C.border)); value.border = border
    local icon = value:CreateTexture(nil, "ARTWORK"); icon:SetAllPoints(); icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    local coords = CLASS_COORDS[token]; if coords then icon:SetTexCoord(unpack(coords)) end
    local name = label(value, "GameFontNormalSmall", ns.BisData.classes[token].name, C.muted); name:SetPoint("TOP", value, "BOTTOM", 0, -3)
    value:SetScript("OnClick", function() ns.Database:SetSelectedClass(token); MainWindow:RebuildSlotButtons(); MainWindow:RefreshGear() end)
    value:SetScript("OnEnter", function() border:SetColorTexture(unpack(C.accent)) end)
    value:SetScript("OnLeave", function() MainWindow:RefreshClassButtons() end)
    value.token = token; self.classButtons[token] = value
end

function MainWindow:CreateSlotButton(parent, slot, index)
    local value = CreateFrame("Button", nil, parent); value:SetSize(146, 30); value:SetPoint("TOPLEFT", 12, -46 - (index - 1) * 32)
    local bg = value:CreateTexture(nil, "BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.065, 0.08, 0.115, 1); value.bg = bg
    local accent = value:CreateTexture(nil, "ARTWORK"); accent:SetPoint("TOPLEFT"); accent:SetPoint("BOTTOMLEFT"); accent:SetWidth(2); accent:SetColorTexture(0.2,0.62,1,0); value.accent = accent
    local title = label(value, "GameFontNormalSmall", string.upper(ns.BisData.slotNames[slot]), C.muted); title:SetPoint("LEFT", 10, 0); value.title = title
    value:SetScript("OnClick", function() ns.Database:SetSelectedSlot(slot); MainWindow:RefreshGear() end)
    value:SetScript("OnEnter", function() bg:SetColorTexture(0.10,0.14,0.20,1) end)
    value:SetScript("OnLeave", function() MainWindow:RefreshSlotButtons() end)
    value.slot = slot; value:Show(); return value
end

function MainWindow:CreateTierCard(parent, tier, index)
    local card = frame(parent); card:SetSize(194, 330); card:SetPoint("TOPLEFT", 14 + (index - 1) * 204, -94); skin(card, C.panel)
    local tierColor = C.tier[tier]
    local top = card:CreateTexture(nil, "ARTWORK"); top:SetPoint("TOPLEFT"); top:SetPoint("TOPRIGHT"); top:SetHeight(3); top:SetColorTexture(unpack(tierColor))
    local tierText = label(card, "GameFontNormalHuge", "TIER " .. tier, tierColor); tierText:SetPoint("TOP", 0, -20)
    local iconBorder = card:CreateTexture(nil, "BACKGROUND"); iconBorder:SetSize(112,112); iconBorder:SetPoint("TOP", 0, -65); iconBorder:SetColorTexture(tierColor[1],tierColor[2],tierColor[3],0.78)
    local iconButton = CreateFrame("Button", nil, card); iconButton:SetSize(104,104); iconButton:SetPoint("CENTER", iconBorder)
    local icon = iconButton:CreateTexture(nil, "ARTWORK"); icon:SetAllPoints(); icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark"); icon:SetTexCoord(0.07,0.93,0.07,0.93); card.icon = icon
    local name = label(card, "GameFontNormalLarge", "Item", C.text); name:SetPoint("TOP", iconButton, "BOTTOM", 0, -16); name:SetWidth(170); name:SetJustifyH("CENTER"); card.name = name
    local note = label(card, "GameFontNormalSmall", "", C.muted); note:SetPoint("TOP", name, "BOTTOM", 0, -12); note:SetWidth(166); note:SetJustifyH("CENTER"); card.note = note
    local itemID = label(card, "GameFontNormalSmall", "", {0.34,0.42,0.53,1}); itemID:SetPoint("BOTTOM", 0, 15); card.itemIDText = itemID
    iconButton:SetScript("OnEnter", function(self) if self.itemID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemID); GameTooltip:Show() end end)
    iconButton:SetScript("OnLeave", function() GameTooltip:Hide() end); card.iconButton = iconButton
    self.tierCards[tier] = card
end

function MainWindow:Create()
    if self.frame then return self.frame end
    local saved = ns.Database:Get(); local root = frame(UIParent, "TwinkTrackerMainFrame")
    root:SetSize(1100,700); root:SetPoint(saved.frame.point,UIParent,saved.frame.point,saved.frame.x,saved.frame.y); root:SetFrameStrata("DIALOG")
    root:SetMovable(true); root:EnableMouse(true); root:RegisterForDrag("LeftButton"); root:SetScript("OnDragStart",root.StartMoving)
    root:SetScript("OnDragStop",function(self) self:StopMovingOrSizing(); local p,_,_,x,y=self:GetPoint(); ns.Database:SetFramePosition(p,x,y) end)
    skin(root,C.window,C.border); root:Hide(); self.frame=root
    local glow=root:CreateTexture(nil,"BACKGROUND",nil,-1); glow:SetPoint("TOPLEFT",1,-1); glow:SetPoint("TOPRIGHT",-1,-1); glow:SetHeight(62); glow:SetColorTexture(0.03,0.23,0.42,0.30)
    local brand=label(root,"GameFontNormalHuge","TWINK|cff45a7ffTRACKER|r"); brand:SetPoint("TOPLEFT",26,-18)
    local close=CreateFrame("Button",nil,root); close:SetSize(28,28); close:SetPoint("TOPRIGHT",-17,-15); local x=label(close,"GameFontNormalLarge","×",C.muted); x:SetPoint("CENTER",0,1)
    close:SetScript("OnEnter",function() x:SetTextColor(1,0.3,0.3) end); close:SetScript("OnLeave",function() x:SetTextColor(unpack(C.muted)) end); close:SetScript("OnClick",function() root:Hide() end)

    local content=frame(root); content:SetPoint("TOPLEFT",20,-70); content:SetPoint("BOTTOMRIGHT",-20,20)
    local classes=frame(content); classes:SetPoint("TOPLEFT"); classes:SetPoint("BOTTOMLEFT"); classes:SetWidth(208); skin(classes,C.panel)
    local classTitle=label(classes,"GameFontNormal","SELECT CLASS",C.muted); classTitle:SetPoint("TOPLEFT",14,-16)
    for i,token in ipairs(ns.BisData.classOrder) do self:CreateClassButton(classes,token,i) end

    local slots=frame(content); slots:SetPoint("TOPLEFT",classes,"TOPRIGHT",10,0); slots:SetPoint("BOTTOMLEFT",classes,"BOTTOMRIGHT",10,0); slots:SetWidth(170); skin(slots,C.panel); self.slotPanel=slots
    local slotTitle=label(slots,"GameFontNormal","SELECT SLOT",C.muted); slotTitle:SetPoint("TOPLEFT",12,-16)

    local detail=frame(content); detail:SetPoint("TOPLEFT",slots,"TOPRIGHT",10,0); detail:SetPoint("BOTTOMRIGHT"); skin(detail,C.window); self.detail=detail
    self.className=label(detail,"GameFontNormalHuge","DRUID",C.text); self.className:SetPoint("TOPLEFT",16,-15)
    self.classRole=label(detail,"GameFontNormalSmall","",C.muted); self.classRole:SetPoint("TOPLEFT",self.className,"BOTTOMLEFT",1,-5)
    self.slotName=label(detail,"GameFontNormalLarge","HEAD",C.accent); self.slotName:SetPoint("TOPRIGHT",-16,-22)
    for i,tier in ipairs({"S","A","B"}) do self:CreateTierCard(detail,tier,i) end
    local footer=frame(detail); footer:SetPoint("TOPLEFT",14,-438); footer:SetPoint("BOTTOMRIGHT",-14,14); skin(footer,C.panel2)
    local footerTitle=label(footer,"GameFontNormal","TIER NOTES",C.muted); footerTitle:SetPoint("TOPLEFT",14,-13)
    self.footerText=label(footer,"GameFontNormalSmall","",C.muted); self.footerText:SetPoint("TOPLEFT",14,-40); self.footerText:SetWidth(590); self.footerText:SetJustifyH("LEFT")
    self:RebuildSlotButtons(); self:RefreshGear(); return root
end

function MainWindow:RebuildSlotButtons()
    for _,value in ipairs(self.slotButtons) do value:Hide() end; self.slotButtons={}
    local profile=ns.BisData.classes[ns.Database:Get().selectedClass]
    for index,slot in ipairs(profile.slotOrder) do self.slotButtons[index]=self:CreateSlotButton(self.slotPanel,slot,index) end
end

function MainWindow:RefreshClassButtons()
    local selected=ns.Database:Get().selectedClass
    for token,value in pairs(self.classButtons) do value.border:SetColorTexture(token==selected and 0.20 or 0.15,token==selected and 0.62 or 0.20,token==selected and 1.00 or 0.29,1) end
end

function MainWindow:RefreshSlotButtons()
    local selected=ns.Database:Get().selectedSlot
    for _,value in ipairs(self.slotButtons) do local active=value.slot==selected; value.bg:SetColorTexture(active and 0.10 or 0.065,active and 0.17 or 0.08,active and 0.25 or 0.115,1); value.accent:SetColorTexture(0.2,0.62,1,active and 1 or 0); value.title:SetTextColor(active and 0.50 or 0.53,active and 0.80 or 0.60,active and 1.00 or 0.70,1) end
end

function MainWindow:RefreshGear()
    local saved=ns.Database:Get(); local profile=ns.BisData.classes[saved.selectedClass]; local slot=saved.selectedSlot
    if not profile.slots[slot] then slot=profile.slotOrder[1]; ns.Database:SetSelectedSlot(slot) end
    self.className:SetText(string.upper(profile.name)); self.classRole:SetText(profile.role); self.slotName:SetText(string.upper(ns.BisData.slotNames[slot])); self:RefreshClassButtons(); self:RefreshSlotButtons()
    for _,tier in ipairs({"S","A","B"}) do local data=profile.slots[slot][tier]; local card=self.tierCards[tier]; card.icon:SetTexture(getItemIcon(data.id)); card.name:SetText(data.name); card.note:SetText(data.note or ""); card.iconButton.itemID=data.id; card.itemIDText:SetText(data.id and ("ITEM "..data.id) or "NO VERIFIED ITEM")
        if data.id and C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(data.id) end
    end
    self.footerText:SetText("S is the primary competitive recommendation. A and B are role, faction, availability or budget alternatives. Random-suffix items require the named suffix. Verify acquisition and restrictions in the current Classic Era client before investing gold or XP.")
end

function MainWindow:RefreshItemIcons() if self.frame and self.frame:IsShown() then self:RefreshGear() end end
function MainWindow:Toggle() local root=self:Create(); if root:IsShown() then root:Hide() else root:Show(); self:RefreshGear() end end
function MainWindow:Show() local root=self:Create(); root:Show(); self:RefreshGear() end
function MainWindow:Hide() if self.frame then self.frame:Hide() end end
