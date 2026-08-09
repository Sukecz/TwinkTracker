local addonName, ns = ...

local MainWindow = { bracketButtons = {}, classButtons = {}, rows = {}, pageButtons = {}, pages = {}, guideCards = {}, professionGuideButtons = {}, professionGuideSteps = {}, professionGuideRows = {}, tierHeaders = {}, explorationRows = {}, explorationPanels = {}, gearSectionButtons = {}, gearSections = {} }
ns.MainWindow = MainWindow

local ROW_HEIGHT = 52
local MULTI_ROW_HEIGHT = 98
local C = {
    window = { 0.022, 0.029, 0.044, 0.99 }, panel = { 0.050, 0.065, 0.095, 0.98 },
    panel2 = { 0.070, 0.090, 0.128, 0.98 }, border = { 0.15, 0.20, 0.29, 1 },
    accent = { 0.20, 0.62, 1.00, 1 }, text = { 0.92, 0.95, 1.00, 1 },
    secondary = { 0.72, 0.78, 0.88, 1 }, muted = { 0.53, 0.60, 0.70, 1 }, tier = { S={1.00,0.57,0.14,1}, A={0.43,0.73,1.00,1}, B={0.67,0.70,0.78,1} },
    equipped = { 0.25, 0.85, 0.43, 1 }, alliance = { 0.36, 0.66, 1.00, 1 }, horde = { 1.00, 0.31, 0.36, 1 },
    guideAccent = { 0.95, 0.68, 0.30, 1 }, guideText = { 0.82, 0.82, 0.79, 1 }, guideMuted = { 0.64, 0.64, 0.61, 1 },
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

local function increaseFontSize(value)
    local fontPath, fontSize, fontFlags = value:GetFont()
    if fontPath and fontSize then value:SetFont(fontPath, fontSize + 1, fontFlags) end
    return value
end

local function label(parent, font, text, color)
    local value = parent:CreateFontString(nil, "OVERLAY", font or "GameFontNormal")
    increaseFontSize(value)
    value:SetText(text or ""); value:SetTextColor(unpack(color or C.text)); return value
end

local function getItemIcon(itemID)
    if not itemID then return "Interface\\Icons\\INV_Misc_QuestionMark" end
    local icon
    if GetItemInfoInstant then icon = select(5, GetItemInfoInstant(itemID)) end
    if not icon and C_Item and C_Item.GetItemIconByID then icon = C_Item.GetItemIconByID(itemID) end
    if not icon and GetItemIcon then icon = GetItemIcon(itemID) end
    return icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end

local function getFactionColor(faction)
    if faction == "ALLIANCE" then return C.alliance end
    if faction == "HORDE" then return C.horde end
end

local function addFactionSymbols(text)
    if not text then return "" end
    text = string.gsub(text,"Alliance","|cff5ca9ffA|r Alliance")
    text = string.gsub(text,"Horde","|cffff505cH|r Horde")
    return text
end

local function getExplorationProgressColor(percent, available)
    if not available or percent <= 0 then return C.muted end
    if percent >= 100 then return C.equipped end
    if percent >= 70 then return C.alliance end
    if percent >= 40 then return C.tier.S end
    return C.horde
end

local function addMissingExplorationAreas(tooltip, missing)
    if not missing or #missing == 0 then return end
    tooltip:AddLine(" ")
    tooltip:AddLine("Missing map areas:",1,0.82,0.35)
    local visibleCount=math.min(#missing,5)
    for index=1,visibleCount do
        tooltip:AddLine("• "..missing[index],0.85,0.88,0.95,true)
    end
    if #missing>visibleCount then
        tooltip:AddLine(string.format("...and %d more.",#missing-visibleCount),C.muted[1],C.muted[2],C.muted[3])
    end
end

local function insertItemLink(itemID)
    if not itemID or not IsShiftKeyDown or not IsShiftKeyDown() then return end
    local itemLink = GetItemInfo and select(2,GetItemInfo(itemID))
    if itemLink and ChatEdit_InsertLink then ChatEdit_InsertLink(itemLink) end
end

local function handleItemClick(itemData)
    if not itemData then return end
    if IsShiftKeyDown and IsShiftKeyDown() then
        insertItemLink(itemData.id)
    else
        MainWindow:ShowWowheadLink(itemData)
    end
end

local function handleGuideItemClick(itemData)
    if not itemData then return end
    if IsShiftKeyDown and IsShiftKeyDown() then insertItemLink(itemData.id); return end
    local panel=MainWindow.guidesPanel; if not panel or not panel.link then return end
    panel.link.itemData=itemData; panel.link.value=itemData.wowhead; panel.link:SetText(panel.link.value); panel.link:SetFocus(); panel.link:HighlightText()
end

local function formatReferenceDetails(entry,recommendation)
    local details={}
    if entry.effect then details[#details+1]="|cffeaf2ff"..entry.effect.."|r" end
    if recommendation.roles then details[#details+1]="|cff52a0ffROLE:|r |cffb8c7df"..recommendation.roles.."|r" end
    if entry.restrictions then details[#details+1]="|cffffbd5aCAUTION:|r |cffb8c7df"..entry.restrictions.."|r" end
    if recommendation.note then details[#details+1]="|cff8799b3NOTE: "..recommendation.note.."|r" end
    return table.concat(details,"  |cff627089•|r  ")
end

function MainWindow:CreateClassButton(parent, token, index)
    local value = CreateFrame("Button", nil, parent); value:SetSize(52,52)
    value:SetPoint("TOPLEFT",14+((index-1)%3)*62,-50-math.floor((index-1)/3)*73)
    local border=value:CreateTexture(nil,"BACKGROUND"); border:SetPoint("TOPLEFT",-2,2); border:SetPoint("BOTTOMRIGHT",2,-2); border:SetColorTexture(unpack(C.border)); value.border=border
    local icon=value:CreateTexture(nil,"ARTWORK"); icon:SetAllPoints(); icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    local coords=CLASS_COORDS[token]; if coords then icon:SetTexCoord(unpack(coords)) end
    local name=label(value,"GameFontNormalSmall",ns.BisData.classes[token].name,C.muted); name:SetPoint("TOP",value,"BOTTOM",0,-3)
    value:SetScript("OnClick",function() ns.Database:SetSelectedClass(token); MainWindow:RefreshActiveGearSection(true) end)
    value:SetScript("OnEnter",function() border:SetColorTexture(unpack(C.accent)) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshClassButtons() end)
    self.classButtons[token]=value
end

function MainWindow:CreateItemCell(parent, tier, column)
    local cell=CreateFrame("Button",nil,parent); cell:SetSize(222,ROW_HEIGHT); cell:SetPoint("LEFT",110+(column-1)*226,0)
    local state=cell:CreateTexture(nil,"BACKGROUND"); state:SetPoint("TOPLEFT"); state:SetPoint("TOPRIGHT"); state:SetHeight(ROW_HEIGHT); state:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],0); cell.state=state
    local hover=cell:CreateTexture(nil,"BACKGROUND"); hover:SetPoint("TOPLEFT"); hover:SetPoint("TOPRIGHT"); hover:SetHeight(ROW_HEIGHT); hover:SetColorTexture(0.10,0.14,0.20,0); cell.hover=hover
    local tierColor=C.tier[tier]
    local iconBorder=cell:CreateTexture(nil,"BACKGROUND"); iconBorder:SetSize(44,44); iconBorder:SetPoint("TOPLEFT",4,-4); iconBorder:SetColorTexture(tierColor[1],tierColor[2],tierColor[3],0.72); cell.iconBorder=iconBorder; cell.tier=tier
    local icon=cell:CreateTexture(nil,"ARTWORK"); icon:SetSize(40,40); icon:SetPoint("CENTER",iconBorder); icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark"); icon:SetTexCoord(0.07,0.93,0.07,0.93); cell.icon=icon
    local factionBg=cell:CreateTexture(nil,"OVERLAY"); factionBg:SetSize(16,16); factionBg:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",1,-1); factionBg:Hide(); cell.factionBg=factionBg
    local factionText=label(cell,"GameFontNormalSmall","",C.text); factionText:SetPoint("CENTER",factionBg,"CENTER",0,1); factionText:Hide(); cell.factionText=factionText
    local name=label(cell,"GameFontNormalSmall","Item",C.text); name:SetPoint("TOPLEFT",56,-9); name:SetWidth(160); name:SetHeight(16); name:SetJustifyH("LEFT"); cell.name=name
    local status=label(cell,"GameFontNormalSmall","EQUIPPED",C.equipped); status:SetPoint("TOPRIGHT",-6,-28); status:Hide(); cell.status=status
    local alternative=CreateFrame("Button",nil,cell); alternative:SetSize(214,44); alternative:SetPoint("TOPLEFT",4,-50); alternative:Hide(); cell.alternative=alternative
    local altState=alternative:CreateTexture(nil,"BACKGROUND"); altState:SetAllPoints(); altState:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],0); alternative.state=altState
    local altHover=alternative:CreateTexture(nil,"BACKGROUND"); altHover:SetAllPoints(); altHover:SetColorTexture(0.10,0.14,0.20,0); alternative.hover=altHover
    local altBorder=alternative:CreateTexture(nil,"BACKGROUND"); altBorder:SetSize(44,44); altBorder:SetPoint("LEFT"); altBorder:SetColorTexture(tierColor[1],tierColor[2],tierColor[3],0.72); alternative.border=altBorder
    local altIcon=alternative:CreateTexture(nil,"ARTWORK"); altIcon:SetSize(40,40); altIcon:SetPoint("CENTER"); altIcon:SetTexCoord(0.07,0.93,0.07,0.93); alternative.icon=altIcon
    altIcon:ClearAllPoints(); altIcon:SetPoint("CENTER",altBorder)
    local altFactionBg=alternative:CreateTexture(nil,"OVERLAY"); altFactionBg:SetSize(16,16); altFactionBg:SetPoint("BOTTOMRIGHT",altIcon,"BOTTOMRIGHT",1,-1); alternative.factionBg=altFactionBg
    local altFactionText=label(alternative,"GameFontNormalSmall","",C.text); altFactionText:SetPoint("CENTER",altFactionBg,"CENTER",0,1); alternative.factionText=altFactionText
    local altName=label(alternative,"GameFontNormalSmall","Item",C.text); altName:SetPoint("LEFT",52,0); altName:SetJustifyH("LEFT"); alternative.name=altName
    alternative:SetScript("OnEnter",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0.72); if self.itemID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemID); GameTooltip:Show() end end)
    alternative:SetScript("OnLeave",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0); GameTooltip:Hide() end)
    alternative:SetScript("OnClick",function(self) handleItemClick(self.itemData) end)
    cell:SetScript("OnEnter",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0.72); if self.itemID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemID); GameTooltip:Show() end end)
    cell:SetScript("OnLeave",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0); GameTooltip:Hide() end)
    cell:SetScript("OnClick",function(self) handleItemClick(self.itemData) end)
    return cell
end

function MainWindow:CreateGearRow(parent,index)
    local row=CreateFrame("Frame",nil,parent); row:SetSize(800,ROW_HEIGHT); row:SetPoint("TOPLEFT",0,-(index-1)*ROW_HEIGHT)
    local bg=row:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(index%2==0 and 0.040 or 0.055,index%2==0 and 0.052 or 0.070,index%2==0 and 0.078 or 0.102,0.92)
    local slot=label(row,"GameFontNormalSmall","SLOT",C.muted); slot:SetPoint("LEFT",12,0); slot:SetWidth(88); slot:SetJustifyH("LEFT"); row.slot=slot
    local divider=row:CreateTexture(nil,"ARTWORK"); divider:SetPoint("BOTTOMLEFT"); divider:SetPoint("BOTTOMRIGHT"); divider:SetHeight(1); divider:SetColorTexture(0.14,0.18,0.25,0.55)
    row.cells={}
    for column,tier in ipairs({"S","A","B"}) do row.cells[tier]=self:CreateItemCell(row,tier,column) end
    self.rows[index]=row; return row
end

function MainWindow:CreateScrollBar(parent,scrollFrame)
    local bar=CreateFrame("Slider",nil,parent); bar:SetOrientation("VERTICAL"); bar:SetWidth(7); bar:SetPoint("TOPRIGHT",-4,-142); bar:SetPoint("BOTTOMRIGHT",-4,12); bar:SetMinMaxValues(0,0); bar:SetValueStep(ROW_HEIGHT); bar:SetValue(0)
    local track=parent:CreateTexture(nil,"BACKGROUND"); track:SetWidth(2); track:SetPoint("TOP",bar,"TOP"); track:SetPoint("BOTTOM",bar,"BOTTOM"); track:SetColorTexture(0.14,0.18,0.26,0.7)
    bar:SetThumbTexture("Interface\\Buttons\\WHITE8X8"); local thumb=bar:GetThumbTexture(); thumb:SetSize(7,42); thumb:SetColorTexture(unpack(C.accent))
    bar:SetScript("OnValueChanged",function(_,value) scrollFrame:SetVerticalScroll(value) end)
    scrollFrame:EnableMouseWheel(true); scrollFrame:SetScript("OnMouseWheel",function(_,delta) bar:SetValue(math.max(0,math.min(MainWindow.maxScroll or 0,bar:GetValue()-delta*ROW_HEIGHT*2))) end)
    self.scrollBar=bar
end

function MainWindow:CreatePageButton(parent,key,text,anchor,x)
    local value=CreateFrame("Button",nil,parent); value:SetSize(100,30); value:SetPoint(anchor,x,-35)
    local bg=value:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.06,0.08,0.12,0.95); value.bg=bg
    local accent=value:CreateTexture(nil,"ARTWORK"); accent:SetPoint("BOTTOMLEFT"); accent:SetPoint("BOTTOMRIGHT"); accent:SetHeight(2); accent:SetColorTexture(0.2,0.62,1,0); value.accent=accent
    local title=label(value,"GameFontNormalSmall",text,C.muted); title:SetPoint("CENTER"); value.title=title
    value:SetScript("OnClick",function() MainWindow:SelectPage(key) end)
    value:SetScript("OnEnter",function() bg:SetColorTexture(0.10,0.14,0.20,1) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshPageButtons() end)
    self.pageButtons[key]=value
end

function MainWindow:CreateBracketButton(parent,level,index)
    local profile=ns.Brackets.profiles[level]
    local value=CreateFrame("Button",nil,parent); value:SetSize(34,34); value:SetPoint("TOP",(index-2)*40,-72); value.level=level; value.available=profile.available
    local icon=value:CreateTexture(nil,"ARTWORK"); icon:SetAllPoints(); icon:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\bracket-"..level..".tga"); value.icon=icon
    value:SetScript("OnClick",function(self)
        if ns.Database:SetSelectedBracket(self.level) then MainWindow:RefreshBracketButtons() end
    end)
    value:SetScript("OnEnter",function(self)
        if not self.available then
            GameTooltip:SetOwner(self,"ANCHOR_BOTTOM")
            GameTooltip:AddLine("Level "..self.level.." bracket",0.92,0.95,1.00)
            GameTooltip:AddLine("Coming soon",0.53,0.60,0.70)
            GameTooltip:Show()
        end
    end)
    value:SetScript("OnLeave",function() GameTooltip:Hide(); MainWindow:RefreshBracketButtons() end)
    self.bracketButtons[level]=value
end

function MainWindow:RefreshBracketButtons()
    local selected=ns.Database:Get().selectedBracket
    for level,value in pairs(self.bracketButtons) do
        local active=level==selected and value.available
        value.icon:SetDesaturated(not value.available)
        if active then value.icon:SetVertexColor(1,1,1,1) else value.icon:SetVertexColor(0.52,0.55,0.60,0.82) end
    end
end

function MainWindow:CreateGearSectionButton(parent,key,text,x)
    local value=CreateFrame("Button",nil,parent); value:SetSize(96,25); value:SetPoint("TOPLEFT",x,-13)
    local bg=value:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.06,0.08,0.12,0.95); value.bg=bg
    local accent=value:CreateTexture(nil,"ARTWORK"); accent:SetPoint("BOTTOMLEFT"); accent:SetPoint("BOTTOMRIGHT"); accent:SetHeight(2); accent:SetColorTexture(0.2,0.62,1,0); value.accent=accent
    local title=label(value,"GameFontNormalSmall",text,C.muted); title:SetPoint("CENTER"); value.title=title
    value:SetScript("OnClick",function() MainWindow:SelectGearSection(key) end)
    value:SetScript("OnEnter",function() bg:SetColorTexture(0.10,0.14,0.20,1) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshGearSectionButtons() end)
    self.gearSectionButtons[key]=value
end

function MainWindow:CreateReferenceSection(parent,key,titleText,description)
    local section=frame(parent); section:SetPoint("TOPLEFT",10,-103); section:SetPoint("BOTTOMRIGHT",-14,12); section:Hide(); skin(section,C.window)
    section.key=key
    local heading=label(section,"GameFontNormalLarge",titleText,C.text); heading:SetPoint("TOPLEFT",16,-13)
    local className=label(section,"GameFontNormalSmall","",C.accent); className:SetPoint("TOPRIGHT",-18,-16); section.className=className
    local header=frame(section); header:SetPoint("TOPLEFT",8,-42); header:SetPoint("TOPRIGHT",-24,-42); header:SetHeight(30); skin(header,C.panel2)
    local groupHeader=label(header,"GameFontNormalSmall",key=="ENCHANTS" and "SLOT" or "TYPE",C.muted); groupHeader:SetPoint("LEFT",10,0); groupHeader:SetWidth(118); groupHeader:SetJustifyH("LEFT")
    local itemHeader=label(header,"GameFontNormalSmall",key=="ENCHANTS" and "ENCHANT" or "ITEM",C.muted); itemHeader:SetPoint("LEFT",key=="CONSUMABLES" and 178 or 138,0); itemHeader:SetWidth(key=="CONSUMABLES" and 170 or 210); itemHeader:SetJustifyH("LEFT")
    local detailHeader=label(header,"GameFontNormalSmall","EFFECT / ROLE / RESTRICTIONS",C.muted); detailHeader:SetPoint("LEFT",358,0); detailHeader:SetJustifyH("LEFT")
    local scroll=CreateFrame("ScrollFrame",nil,section,"UIPanelScrollFrameTemplate"); scroll:SetPoint("TOPLEFT",8,-76); scroll:SetPoint("BOTTOMRIGHT",-28,8)
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(620,1); scroll:SetScrollChild(child); section.scroll=scroll; section.child=child; section.rows={}
    local body=label(child,"GameFontNormalSmall",description,C.muted); body:SetPoint("TOPLEFT",12,-18); body:SetWidth(540); body:SetJustifyH("LEFT"); section.body=body
    self.gearSections[key]=section
end

function MainWindow:GetReferenceRow(section,index)
    if section.rows[index] then return section.rows[index] end
    local row=CreateFrame("Button",nil,section.child); row:SetHeight(52); row:SetPoint("TOPLEFT",0,-(index-1)*52); row:SetPoint("TOPRIGHT")
    local bg=row:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(index%2==0 and 0.040 or 0.055,index%2==0 and 0.052 or 0.070,index%2==0 and 0.078 or 0.102,0.92); row.bg=bg
    local group=label(row,"GameFontNormalSmall","",C.muted); group:SetPoint("LEFT",10,0); group:SetWidth(118); group:SetJustifyH("LEFT"); row.group=group
    local iconBorder=row:CreateTexture(nil,"BACKGROUND"); iconBorder:SetSize(36,36); iconBorder:SetPoint("LEFT",136,0); iconBorder:SetColorTexture(C.accent[1],C.accent[2],C.accent[3],0.65); iconBorder:SetShown(section.key=="CONSUMABLES"); row.iconBorder=iconBorder
    local icon=row:CreateTexture(nil,"ARTWORK"); icon:SetSize(32,32); icon:SetPoint("CENTER",iconBorder); icon:SetTexCoord(0.07,0.93,0.07,0.93); icon:SetShown(section.key=="CONSUMABLES"); row.icon=icon
    local textLeft=section.key=="CONSUMABLES" and 178 or 138; local textWidth=section.key=="CONSUMABLES" and 170 or 210
    local name=label(row,"GameFontNormal","",C.text); name:SetPoint("LEFT",textLeft,8); name:SetWidth(textWidth); name:SetJustifyH("LEFT"); row.name=name
    local priority=label(row,"GameFontNormalSmall","",C.accent); priority:SetPoint("LEFT",textLeft,-11); priority:SetWidth(textWidth); priority:SetJustifyH("LEFT"); row.priority=priority
    local detail=label(row,"GameFontNormalSmall","",C.muted); detail:SetPoint("TOPLEFT",358,-8); detail:SetPoint("RIGHT",-10,0); detail:SetHeight(38); detail:SetJustifyH("LEFT"); row.detail=detail
    row:SetScript("OnClick",function(self)
        if self.tooltipType == "item" and IsShiftKeyDown and IsShiftKeyDown() then
            insertItemLink(self.tooltipID)
        elseif self.linkData then
            MainWindow:ShowWowheadLink(self.linkData)
        end
    end)
    row:SetScript("OnEnter",function(self) self.bg:SetColorTexture(0.10,0.14,0.20,0.92); if self.tooltipType=="item" and self.tooltipID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.tooltipID); GameTooltip:Show() elseif self.tooltipType=="spell" and self.tooltipID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("spell:"..self.tooltipID); GameTooltip:Show() end end)
    row:SetScript("OnLeave",function(self) self.bg:SetColorTexture(index%2==0 and 0.040 or 0.055,index%2==0 and 0.052 or 0.070,index%2==0 and 0.078 or 0.102,0.92); GameTooltip:Hide() end)
    section.rows[index]=row; return row
end

function MainWindow:RefreshReferenceSection(sectionKey,profile,catalog,order,groups)
    local section=self.gearSections[sectionKey]; if not section then return end
    for _,row in ipairs(section.rows) do row:Hide() end
    local rowIndex=0
    for _,groupKey in ipairs(order or {}) do
        local recommendations=groups[groupKey] or {}
        for recommendationIndex,recommendation in ipairs(recommendations) do
            local catalogKey=recommendation.key or recommendation.itemID; local entry=catalog[catalogKey]
            if entry then
                rowIndex=rowIndex+1; local row=self:GetReferenceRow(section,rowIndex); row:Show()
                local groupName=sectionKey=="ENCHANTS" and (ns.BisData.slotNames[groupKey] or groupKey) or (ns.ConsumablesData.categoryNames[groupKey] or groupKey)
                row.group:SetText(recommendationIndex==1 and string.upper(groupName) or "")
                row.name:SetText(entry.name); row.priority:SetText(recommendation.priority or "")
                row.detail:SetText(formatReferenceDetails(entry,recommendation)); row.linkData={ id=entry.itemID, name=entry.name, wowhead=entry.wowhead }
                row.tooltipType=entry.itemID and "item" or (entry.spellID and "spell" or nil); row.tooltipID=entry.itemID or entry.spellID
                if row.icon and sectionKey=="CONSUMABLES" then
                    row.icon:SetTexture(getItemIcon(entry.itemID))
                end
            end
        end
    end
    section.body:SetShown(rowIndex==0); section.child:SetHeight(math.max(1,rowIndex*52)); section.scroll:SetVerticalScroll(0)
end

function MainWindow:CreateBasicsPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.BASICS=page
    local heading=label(page,"GameFontNormalHuge","TWINK BASICS",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","The essential Classic Era rule: experience cannot be locked. Prepare before 19, then avoid every source of character XP.",C.muted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)
    for index,entry in ipairs(ns.BasicsData) do
        local card=frame(page); card:SetHeight(92); skin(card,C.panel,entry.critical and C.horde or C.border); self.guideCards[index]=card
        local title=label(card,"GameFontNormal",entry.title,entry.critical and C.horde or C.text); title:SetPoint("TOPLEFT",16,-15)
        local text=label(card,"GameFontNormalSmall",entry.text,C.secondary); text:SetPoint("TOPLEFT",16,-39); text:SetJustifyH("LEFT"); card.body=text
    end
end

function MainWindow:CreateGuideButton(parent,key,index)
    local data=ns.GuidesData.sections[key]
    local value=CreateFrame("Button",nil,parent); value:SetSize(142,30); value:SetPoint("TOPLEFT",8+(index-1)*148,-55)
    local bg=value:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.06,0.08,0.12,0.95); value.bg=bg
    local accent=value:CreateTexture(nil,"ARTWORK"); accent:SetPoint("BOTTOMLEFT"); accent:SetPoint("BOTTOMRIGHT"); accent:SetHeight(2); accent:SetColorTexture(C.guideAccent[1],C.guideAccent[2],C.guideAccent[3],0); value.accent=accent
    local title=label(value,"GameFontNormalSmall",string.upper(data.name),C.muted); title:SetPoint("CENTER"); value.title=title
    value:SetScript("OnClick",function() MainWindow:SelectGuide(key) end)
    value:SetScript("OnEnter",function() bg:SetColorTexture(0.10,0.14,0.20,1) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshGuideButtons() end)
    self.professionGuideButtons[key]=value
end

function MainWindow:CreateGuidesPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.GUIDES=page
    local heading=label(page,"GameFontNormalHuge","GUIDES",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","Level-19 profession routes and related items. Informational only; every item opens its normal tooltip.",C.guideMuted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)
    for index,key in ipairs(ns.GuidesData.order) do self:CreateGuideButton(page,key,index) end

    local panel=frame(page); panel:SetPoint("TOPLEFT",6,-94); panel:SetPoint("BOTTOMRIGHT",-6,6); skin(panel,C.panel)
    local title=label(panel,"GameFontNormalLarge","",C.text); title:SetPoint("TOPLEFT",16,-13); panel.title=title
    local tagline=label(panel,"GameFontNormalSmall","",C.guideMuted); tagline:SetPoint("TOPLEFT",16,-37); panel.tagline=tagline
    local link=CreateFrame("EditBox",nil,panel,BackdropTemplateMixin and "BackdropTemplate" or nil); link:SetPoint("TOPRIGHT",-16,-11); link:SetSize(420,30); skin(link,C.panel2,C.accent); link:SetFontObject(GameFontHighlightSmall); increaseFontSize(link); link:SetTextInsets(8,8,0,0); link:SetAutoFocus(false); link:SetTextColor(unpack(C.text)); if link.SetHighlightColor then link:SetHighlightColor(C.accent[1],C.accent[2],C.accent[3],0.45) end; link.value="Left-click an item to copy its Wowhead link."; link:SetText(link.value)
    link:SetScript("OnTextChanged",function(self,userInput) if userInput and self:GetText()~=self.value then self:SetText(self.value); self:HighlightText() end end)
    link:SetScript("OnEditFocusGained",function(self) if self.itemData then self:HighlightText() end end); link:SetScript("OnMouseUp",function(self) if self.itemData then self:SetFocus(); self:HighlightText() end end); link:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
    panel.link=link
    local scroll=CreateFrame("ScrollFrame",nil,panel,"UIPanelScrollFrameTemplate"); scroll:SetPoint("TOPLEFT",10,-68); scroll:SetPoint("BOTTOMRIGHT",-30,10)
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(900,1); scroll:SetScrollChild(child); panel.scroll=scroll; panel.child=child
    self.guidesPanel=panel
end

function MainWindow:GetGuideRow(index)
    local panel=self.guidesPanel
    if self.professionGuideRows[index] then return self.professionGuideRows[index] end
    local row=CreateFrame("Button",nil,panel.child); row:SetPoint("TOPLEFT"); row:SetPoint("TOPRIGHT"); row:SetHeight(50)
    local bg=row:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.055,0.070,0.102,0.92); row.bg=bg
    local iconBorder=row:CreateTexture(nil,"BACKGROUND"); iconBorder:SetSize(40,40); iconBorder:SetPoint("LEFT",8,0); iconBorder:SetColorTexture(C.accent[1],C.accent[2],C.accent[3],0.65); row.iconBorder=iconBorder
    local icon=row:CreateTexture(nil,"ARTWORK"); icon:SetSize(36,36); icon:SetPoint("CENTER",iconBorder); icon:SetTexCoord(0.07,0.93,0.07,0.93); row.icon=icon
    local name=label(row,"GameFontNormal","",C.text); name:SetPoint("TOPLEFT",58,-8); name:SetWidth(245); name:SetJustifyH("LEFT"); row.name=name
    local note=label(row,"GameFontNormalSmall","",C.secondary); note:SetPoint("LEFT",315,0); note:SetPoint("RIGHT",-12,0); note:SetJustifyH("LEFT"); row.note=note
    row:SetScript("OnEnter",function(self) self.bg:SetColorTexture(0.10,0.14,0.20,0.92); GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemData.id); GameTooltip:Show() end)
    row:SetScript("OnLeave",function(self) self.bg:SetColorTexture(0.055,0.070,0.102,0.92); GameTooltip:Hide() end)
    row:SetScript("OnClick",function(self) handleGuideItemClick(self.itemData) end)
    self.professionGuideRows[index]=row; return row
end

function MainWindow:GetGuideStep(index)
    local panel=self.guidesPanel
    if self.professionGuideSteps[index] then return self.professionGuideSteps[index] end
    local card=frame(panel.child); card:SetHeight(72); skin(card,C.panel2,C.border)
    local stripe=card:CreateTexture(nil,"ARTWORK"); stripe:SetPoint("TOPLEFT",0,0); stripe:SetPoint("BOTTOMLEFT",0,0); stripe:SetWidth(3); stripe:SetColorTexture(unpack(C.guideAccent))
    local number=label(card,"GameFontNormalLarge",tostring(index),C.guideAccent); number:SetPoint("TOPLEFT",14,-13)
    local title=label(card,"GameFontNormal","",C.guideAccent); title:SetPoint("TOPLEFT",44,-10); title:SetPoint("TOPRIGHT",-14,-10); title:SetJustifyH("LEFT"); card.title=title; card.lines={}
    self.professionGuideSteps[index]=card; return card
end

function MainWindow:GetGuideStepLine(card,index)
    if card.lines[index] then return card.lines[index] end
    local value={}
    local tag=label(card,"GameFontNormalSmall","",C.guideAccent); tag:SetJustifyH("LEFT"); value.tag=tag
    local textValue=label(card,"GameFontNormalSmall","",C.guideText); textValue:SetJustifyH("LEFT"); value.text=textValue; value.icons={}
    card.lines[index]=value; return value
end

function MainWindow:GetGuideLineIcon(card,lineView,index)
    if lineView.icons[index] then return lineView.icons[index] end
    local button=CreateFrame("Button",nil,card); button:SetSize(28,28)
    local border=button:CreateTexture(nil,"BACKGROUND"); border:SetAllPoints(); border:SetColorTexture(C.guideAccent[1],C.guideAccent[2],C.guideAccent[3],0.65); button.border=border
    local icon=button:CreateTexture(nil,"ARTWORK"); icon:SetPoint("TOPLEFT",2,-2); icon:SetPoint("BOTTOMRIGHT",-2,2); icon:SetTexCoord(0.07,0.93,0.07,0.93); button.icon=icon
    local hover=button:CreateTexture(nil,"HIGHLIGHT"); hover:SetAllPoints(); hover:SetColorTexture(C.guideAccent[1],C.guideAccent[2],C.guideAccent[3],0.24)
    button:SetScript("OnEnter",function(self) self.border:SetColorTexture(unpack(C.guideAccent)); GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemData.id); GameTooltip:Show() end)
    button:SetScript("OnLeave",function(self) self.border:SetColorTexture(C.guideAccent[1],C.guideAccent[2],C.guideAccent[3],0.65); GameTooltip:Hide() end)
    button:SetScript("OnClick",function(self) handleGuideItemClick(self.itemData) end)
    lineView.icons[index]=button; return button
end

function MainWindow:RefreshGuideButtons()
    local selected=ns.Database:Get().selectedGuide
    for key,value in pairs(self.professionGuideButtons) do local active=key==selected; value.bg:SetColorTexture(active and 0.15 or 0.06,active and 0.12 or 0.08,active and 0.07 or 0.12,1); value.accent:SetColorTexture(C.guideAccent[1],C.guideAccent[2],C.guideAccent[3],active and 1 or 0); value.title:SetTextColor(unpack(active and C.guideAccent or C.guideMuted)) end
end

function MainWindow:SelectGuide(key)
    if not ns.Database:SetSelectedGuide(key) then return end
    local data=ns.GuidesData.sections[key]; local panel=self.guidesPanel
    panel.title:SetText(string.upper(data.name)); panel.tagline:SetText(data.tagline)
    for _,card in ipairs(self.professionGuideSteps) do card:Hide() end
    for _,row in ipairs(self.professionGuideRows) do row:Hide() end
    local itemsByID={}; for _,itemData in ipairs(data.items) do itemsByID[itemData.id]=itemData end
    local y=0
    for index,step in ipairs(data.steps) do
        local card=self:GetGuideStep(index); card:ClearAllPoints(); card:SetPoint("TOPLEFT",0,-y); card:SetPoint("TOPRIGHT"); card.title:SetText(step.title)
        for _,lineView in ipairs(card.lines) do lineView.tag:Hide(); lineView.text:Hide(); for _,iconButton in ipairs(lineView.icons) do iconButton:Hide() end end
        card.title:ClearAllPoints(); card.title:SetPoint("TOPLEFT",44,-10); card.title:SetPoint("TOPRIGHT",-14,-10)
        local lineY=38
        for lineIndex,lineData in ipairs(step.lines) do
            local lineView=self:GetGuideStepLine(card,lineIndex); lineView.tag:ClearAllPoints(); lineView.tag:SetPoint("TOPLEFT",44,-lineY); lineView.tag:SetWidth(106); lineView.tag:SetText(lineData.label); lineView.tag:Show()
            for iconIndex,itemID in ipairs(lineData.itemIDs) do
                local itemData=itemsByID[itemID]; local iconButton=self:GetGuideLineIcon(card,lineView,iconIndex); iconButton:ClearAllPoints(); iconButton:SetPoint("TOPLEFT",156+(iconIndex-1)*30,-lineY+5); iconButton.itemData=itemData; iconButton.icon:SetTexture(getItemIcon(itemID)); iconButton:Show(); if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(itemID) end
            end
            local textLeft=156+#lineData.itemIDs*30; lineView.text:ClearAllPoints(); lineView.text:SetPoint("TOPLEFT",textLeft,-lineY); lineView.text:SetPoint("TOPRIGHT",-14,-lineY); lineView.text:SetHeight(48); lineView.text:SetText(lineData.text)
            local textHeight=lineView.text.GetStringHeight and lineView.text:GetStringHeight() or 16; textHeight=math.max(16,math.ceil(textHeight)); lineView.text:SetHeight(textHeight); lineView.text:Show(); lineY=lineY+math.max(28,textHeight)+8
        end
        local cardHeight=math.max(72,lineY+4); card:SetHeight(cardHeight); card:Show(); y=y+cardHeight+6
    end
    if not panel.shopping then panel.shopping=label(panel.child,"GameFontNormal","RELATED ITEMS",C.accent) end
    panel.shopping:ClearAllPoints(); panel.shopping:SetPoint("TOPLEFT",8,-y-4); y=y+28
    for index,itemData in ipairs(data.items) do local row=self:GetGuideRow(index); row:ClearAllPoints(); row:SetPoint("TOPLEFT",0,-y); row:SetPoint("TOPRIGHT"); row.itemData=itemData; row.icon:SetTexture(getItemIcon(itemData.id)); row.name:SetText(itemData.name); row.note:SetText(itemData.note); row:Show(); if C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(itemData.id) end; y=y+52 end
    panel.child:SetHeight(math.max(1,y)); panel.scroll:SetVerticalScroll(0); self:RefreshGuideButtons()
end

function MainWindow:CreateCommunityPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.COMMUNITY=page
    local heading=label(page,"GameFontNormalHuge","COMMUNITY",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","Guilds and community links for level-19 Classic Era twinks.",C.muted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)

    local card=frame(page); card:SetPoint("TOPLEFT",6,-62); card:SetPoint("TOPRIGHT",-6,-62); card:SetHeight(190); skin(card,C.panel)
    local badge=frame(card); badge:SetSize(66,66); badge:SetPoint("TOPLEFT",16,-12); skin(badge,C.panel2,C.horde)
    local guildLogo=badge:CreateTexture(nil,"ARTWORK"); guildLogo:SetPoint("TOPLEFT",3,-3); guildLogo:SetPoint("BOTTOMRIGHT",-3,3); guildLogo:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\twinkortreat.tga"); guildLogo:SetTexCoord(0,1,0,1)

    local guildName=label(card,"GameFontNormalLarge","TWINK OR TREAT",C.text); guildName:SetPoint("TOPLEFT",badge,"TOPRIGHT",14,-2)
    local realm=label(card,"GameFontNormalSmall","H  HORDE  |  FIREMAW CLUSTER  |  EU PVP  |  CLASSIC ERA",C.horde); realm:SetPoint("TOPLEFT",guildName,"BOTTOMLEFT",0,-7)
    local description=label(card,"GameFontNormalSmall","Level-19 twink guild on the EU PvP Classic Era Firemaw Cluster.",C.muted); description:SetPoint("TOPLEFT",16,-82)

    local discordLabel=label(card,"GameFontNormalSmall","DISCORD INVITE",C.muted); discordLabel:SetPoint("TOPLEFT",16,-112)
    local template=BackdropTemplateMixin and "BackdropTemplate" or nil
    local discord=CreateFrame("EditBox",nil,card,template); discord:SetPoint("TOPLEFT",16,-132); discord:SetPoint("TOPRIGHT",-16,-132); discord:SetHeight(38)
    skin(discord,C.panel2,C.border); discord:SetFontObject(GameFontHighlightSmall); increaseFontSize(discord); discord:SetTextInsets(10,10,0,0); discord:SetAutoFocus(false); discord:SetTextColor(unpack(C.accent))
    local discordURL="https://discord.gg/BdABEghf3M"
    discord:SetText(discordURL); discord:SetCursorPosition(0)
    discord:SetScript("OnTextChanged",function(self,userInput) if userInput and self:GetText()~=discordURL then self:SetText(discordURL); self:HighlightText() end end)
    discord:SetScript("OnEditFocusGained",function(self) self:HighlightText() end)
    discord:SetScript("OnMouseUp",function(self) self:SetFocus(); self:HighlightText() end)
    discord:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
    discord:SetScript("OnEnterPressed",function(self) self:HighlightText() end)
    local copyHint=label(card,"GameFontNormalSmall","Click the address, then press Ctrl+C to copy.",C.muted); copyHint:SetPoint("BOTTOMRIGHT",-17,8)

    local allianceCard=frame(page); allianceCard:SetPoint("TOPLEFT",6,-264); allianceCard:SetPoint("TOPRIGHT",-6,-264); allianceCard:SetHeight(126); skin(allianceCard,C.panel)
    local allianceBadge=frame(allianceCard); allianceBadge:SetSize(48,48); allianceBadge:SetPoint("TOPLEFT",16,-16); skin(allianceBadge,{0.045,0.16,0.34,1},{0.18,0.48,0.88,1})
    local allianceBadgeText=label(allianceBadge,"GameFontNormalHuge","A",C.alliance); allianceBadgeText:SetPoint("CENTER",0,1)

    local allianceName=label(allianceCard,"GameFontNormalLarge","TWINK FACTORY",C.text); allianceName:SetPoint("TOPLEFT",allianceBadge,"TOPRIGHT",14,-2)
    local allianceRealm=label(allianceCard,"GameFontNormalSmall","A  ALLIANCE  |  FIREMAW CLUSTER  |  EU PVP  |  CLASSIC ERA",C.alliance); allianceRealm:SetPoint("TOPLEFT",allianceName,"BOTTOMLEFT",0,-7)
    local allianceDescription=label(allianceCard,"GameFontNormalSmall","Level-19 twink guild. Whisper Sparre for an invite.",C.muted); allianceDescription:SetPoint("TOPLEFT",16,-84)
end

function MainWindow:CreateExplorationColumn(page, faction, titleText, color)
    local panel=frame(page); panel:SetPoint("TOPLEFT",6,-72); panel:SetPoint("BOTTOMLEFT",6,6); panel:SetWidth(440); skin(panel,C.panel,color); self.explorationPanels[faction]=panel
    local title=label(panel,"GameFontNormalLarge",titleText,color); title:SetPoint("TOPLEFT",14,-12)
    local subtitle=label(panel,"GameFontNormalSmall","MAP REVEAL  •  RED > GOLD > BLUE > GREEN",C.muted); subtitle:SetPoint("TOPLEFT",14,-36)
    local scroll=CreateFrame("ScrollFrame",nil,panel,"UIPanelScrollFrameTemplate"); scroll:SetPoint("TOPLEFT",10,-60); scroll:SetPoint("BOTTOMRIGHT",-30,10)
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(390,1); scroll:SetScrollChild(child); panel.scroll=scroll; panel.child=child
    self.explorationRows[faction]={}
    local y=0
    local rowIndex=0
    for _,groupKey in ipairs(ns.ExplorationCategories.order) do
        local header=CreateFrame("Frame",nil,child); header:SetHeight(26); header:SetPoint("TOPLEFT",0,-y); header:SetPoint("TOPRIGHT")
        local groupTitle=label(header,"GameFontNormalSmall",ns.ExplorationCategories.labels[groupKey],C.secondary); groupTitle:SetPoint("LEFT",2,0)
        y=y+28
        for _,zone in ipairs(ns.ExplorationData[faction]) do
            if zone.group==groupKey then
                rowIndex=rowIndex+1
                local row=CreateFrame("Button",nil,child); row:SetHeight(44); row:SetPoint("TOPLEFT",0,-y)
                local shade=rowIndex%2==0 and {0.055,0.070,0.100,0.95} or {0.070,0.086,0.120,0.95}; row.baseColor=shade
                local bg=row:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(unpack(shade)); row.bg=bg
                local zoneName=label(row,"GameFontNormal",zone.name,C.text); zoneName:SetPoint("TOPLEFT",11,-6); zoneName:SetPoint("TOPRIGHT",-126,-6); zoneName:SetJustifyH("LEFT"); row.zoneName=zoneName
                local meta=label(row,"GameFontNormalSmall",zone.levels,C.muted); meta:SetPoint("TOPLEFT",11,-25)
                local initialTotal=#(ns.ExplorationOverlayData[zone.mapID] or {})
                local progress=label(row,"GameFontNormalSmall",string.format("0/%d  ·  0%%",initialTotal),C.muted); progress:SetPoint("RIGHT",-8,1); progress:SetWidth(112); progress:SetJustifyH("RIGHT"); row.progress=progress
                local progressBar=CreateFrame("StatusBar",nil,row); progressBar:SetPoint("BOTTOMLEFT",3,1); progressBar:SetPoint("BOTTOMRIGHT",-1,1); progressBar:SetHeight(3); progressBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8"); progressBar:SetMinMaxValues(0,100); progressBar:SetValue(0); row.progressBar=progressBar
                local progressTrack=progressBar:CreateTexture(nil,"BACKGROUND"); progressTrack:SetAllPoints(); progressTrack:SetColorTexture(0.13,0.17,0.24,0.85)
                row.zone=zone
                row:SetScript("OnEnter",function(self)
                    self.bg:SetColorTexture(0.10,0.14,0.20,0.98)
                    GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
                    GameTooltip:AddLine(self.zone.name,1,0.82,0.35)
                    GameTooltip:AddLine(ns.ExplorationCategories.labels[self.zone.group],C.secondary[1],C.secondary[2],C.secondary[3])
                    GameTooltip:AddLine(addFactionSymbols(self.zone.note),0.85,0.88,0.95,true)
                    GameTooltip:AddLine(" ")
                    local state=self.progressData
                    if state and state.available then GameTooltip:AddLine(string.format("Map reveal: %d of %d map areas (%d%%).",state.explored,state.total,state.percent),0.53,0.73,0.95,true)
                    else GameTooltip:AddLine("Map reveal data is currently unavailable.",0.53,0.60,0.70,true) end
                    if state and state.available then addMissingExplorationAreas(GameTooltip,state.missing) end
                    GameTooltip:AddLine("100% map reveal does not guarantee that no exploration XP remains.",1,0.72,0.30,true)
                    GameTooltip:Show()
                end)
                row:SetScript("OnLeave",function(self) self.bg:SetColorTexture(unpack(self.baseColor)); GameTooltip:Hide() end)
                self.explorationRows[faction][#self.explorationRows[faction]+1]=row
                y=y+48
            end
        end
    end
    child:SetHeight(math.max(1,y))
end

function MainWindow:CreateExplorationPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.EXPLORATION=page
    local heading=label(page,"GameFontNormalHuge","EXPLORATION",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","Automatic visible-map progress for this character. 100% map reveal does not guarantee that no exploration XP remains.",C.muted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)
    self:CreateExplorationColumn(page,"HORDE","H  HORDE ROUTES",C.horde)
    self:CreateExplorationColumn(page,"ALLIANCE","A  ALLIANCE ROUTES",C.alliance)
end

function MainWindow:CreateWowheadBar(parent)
    local bar=frame(parent); bar:SetPoint("TOPLEFT",10,-65); bar:SetPoint("TOPRIGHT",-14,-65); bar:SetHeight(30); skin(bar,C.panel2)
    local caption=label(bar,"GameFontNormalSmall","WOWHEAD LINK",C.muted); caption:SetPoint("LEFT",10,0); caption:SetWidth(220); caption:SetJustifyH("LEFT"); self.wowheadCaption=caption
    local template=BackdropTemplateMixin and "BackdropTemplate" or nil
    local link=CreateFrame("EditBox",nil,bar,template); link:SetPoint("TOPLEFT",232,-4); link:SetPoint("BOTTOMRIGHT",-5,4)
    skin(link,C.panel,C.accent); link:SetFontObject(GameFontHighlightSmall); increaseFontSize(link); link:SetTextInsets(8,8,0,0); link:SetAutoFocus(false); link:SetTextColor(unpack(C.text)); if link.SetHighlightColor then link:SetHighlightColor(C.accent[1],C.accent[2],C.accent[3],0.45) end
    bar.linkValue="Left-click an item to select its Wowhead link."
    link:SetText(bar.linkValue); link:SetCursorPosition(0)
    link:SetScript("OnTextChanged",function(self,userInput) if userInput and self:GetText()~=bar.linkValue then self:SetText(bar.linkValue); self:HighlightText() end end)
    link:SetScript("OnEditFocusGained",function(self) if bar.itemData then self:HighlightText() end end)
    link:SetScript("OnMouseUp",function(self) if bar.itemData then self:SetFocus(); self:HighlightText() end end)
    link:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
    self.wowheadBar=bar; self.wowheadLink=link
end

function MainWindow:ShowWowheadLink(itemData)
    if not self.wowheadLink then return end
    if not itemData.wowhead then
        self.wowheadBar.itemData=nil
        self.wowheadBar.linkValue="No Wowhead link is available for this reference entry."
        self.wowheadCaption:SetText("WOWHEAD LINK")
        self.wowheadLink:SetText(self.wowheadBar.linkValue)
        self.wowheadLink:ClearFocus()
        return
    end
    self.wowheadBar.itemData=itemData
    self.wowheadBar.linkValue=itemData.wowhead
    self.wowheadCaption:SetText("WOWHEAD: "..string.upper(itemData.name))
    self.wowheadLink:SetText(itemData.wowhead)
    self.wowheadLink:SetFocus()
    self.wowheadLink:HighlightText()
end

function MainWindow:CreateResizeGrip(root)
    local grip=CreateFrame("Button",nil,root); grip:SetSize(22,22); grip:SetPoint("BOTTOMRIGHT",-3,3)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    grip:SetScript("OnMouseDown",function(_,mouseButton) if mouseButton=="LeftButton" then root:StartSizing("BOTTOMRIGHT") end end)
    grip:SetScript("OnMouseUp",function() root:StopMovingOrSizing(); ns.Database:SetFrameSize(root:GetWidth(),root:GetHeight()); MainWindow:Layout() end)
    self.resizeGrip=grip
end

function MainWindow:Create()
    if self.frame then return self.frame end
    local saved=ns.Database:Get(); local root=frame(UIParent,"TwinkTrackerMainFrame")
    root:SetSize(saved.frame.width,saved.frame.height); root:SetPoint(saved.frame.point,UIParent,saved.frame.point,saved.frame.x,saved.frame.y); root:SetFrameStrata("DIALOG")
    root:SetResizable(true)
    if root.SetResizeBounds then root:SetResizeBounds(980,620,1500,950) else root:SetMinResize(980,620); root:SetMaxResize(1500,950) end
    root:SetMovable(true); root:EnableMouse(true); root:RegisterForDrag("LeftButton"); root:SetScript("OnDragStart",root.StartMoving)
    root:SetScript("OnDragStop",function(self) self:StopMovingOrSizing(); local p,_,_,x,y=self:GetPoint(); ns.Database:SetFramePosition(p,x,y) end)
    skin(root,C.window,C.border); root:Hide(); self.frame=root
    local glow=root:CreateTexture(nil,"BACKGROUND",nil,-1); glow:SetPoint("TOPLEFT",1,-1); glow:SetPoint("TOPRIGHT",-1,-1); glow:SetHeight(100); glow:SetColorTexture(0.03,0.23,0.42,0.30)
    local logoFallback=root:CreateFontString(nil,"BORDER","GameFontNormalHuge"); increaseFontSize(logoFallback); logoFallback:SetPoint("TOP",0,-31); logoFallback:SetText("TWINK TRACKER"); logoFallback:SetTextColor(0.95,0.58,0.16,1)
    local logo=root:CreateTexture(nil,"ARTWORK"); logo:SetSize(276,100); logo:SetPoint("TOP",0,-1); logo:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\logo.tga"); logo:SetTexCoord(0,1,0.1367,0.8633)
    for index,level in ipairs(ns.Brackets.order) do self:CreateBracketButton(root,level,index) end
    self:RefreshBracketButtons()
    self:CreatePageButton(root,"GEAR","GEAR","TOPLEFT",20); self:CreatePageButton(root,"BASICS","TWINK BASICS","TOPLEFT",128); self:CreatePageButton(root,"GUIDES","GUIDES","TOPLEFT",236)
    self:CreatePageButton(root,"EXPLORATION","EXPLORATION","TOPRIGHT",-172); self:CreatePageButton(root,"COMMUNITY","COMMUNITY","TOPRIGHT",-64)
    local close=CreateFrame("Button",nil,root); close:SetSize(28,28); close:SetPoint("TOPRIGHT",-17,-15); local x=label(close,"GameFontNormalLarge","×",C.muted); x:SetPoint("CENTER",0,1)
    close:SetScript("OnEnter",function() x:SetTextColor(1,0.3,0.3) end); close:SetScript("OnLeave",function() x:SetTextColor(unpack(C.muted)) end); close:SetScript("OnClick",function() root:Hide() end)

    local content=frame(root); content:SetPoint("TOPLEFT",20,-108); content:SetPoint("BOTTOMRIGHT",-20,20); self.content=content
    local gearPage=frame(content); gearPage:SetAllPoints(); self.pages.GEAR=gearPage
    local classes=frame(gearPage); classes:SetPoint("TOPLEFT"); classes:SetPoint("BOTTOMLEFT"); classes:SetWidth(208); skin(classes,C.panel)
    local classTitle=label(classes,"GameFontNormal","SELECT CLASS",C.muted); classTitle:SetPoint("TOPLEFT",14,-16)
    for i,token in ipairs(ns.BisData.classOrder) do self:CreateClassButton(classes,token,i) end

    local gear=frame(gearPage); gear:SetPoint("TOPLEFT",classes,"TOPRIGHT",10,0); gear:SetPoint("BOTTOMRIGHT"); skin(gear,C.window); self.gear=gear
    self.className=label(gear,"GameFontNormalHuge","DRUID",C.text); self.className:SetPoint("TOPLEFT",16,-14)
    self.classRole=label(gear,"GameFontNormalSmall","",C.muted); self.classRole:SetPoint("TOPLEFT",self.className,"BOTTOMLEFT",1,-4)
    self:CreateGearSectionButton(gear,"GEAR","GEAR",218); self:CreateGearSectionButton(gear,"ENCHANTS","ENCHANTS",320); self:CreateGearSectionButton(gear,"CONSUMABLES","CONSUMABLES",422)
    local legend=label(gear,"GameFontNormalSmall","|cff40d96eEQUIPPED|r   |cff5ca9ffA  ALLIANCE|r   |cffff505cH  HORDE|r",C.muted); legend:SetPoint("TOPRIGHT",-18,-50); self.gearLegend=legend
    self:CreateWowheadBar(gear)
    local header=frame(gear); header:SetPoint("TOPLEFT",10,-103); header:SetPoint("TOPRIGHT",-14,-103); header:SetHeight(34); skin(header,C.panel2)
    local slotHeader=label(header,"GameFontNormalSmall","SLOT",C.muted); slotHeader:SetPoint("LEFT",12,0); slotHeader:SetWidth(88); slotHeader:SetJustifyH("LEFT")
    for column,tier in ipairs({"S","A","B"}) do local title=label(header,"GameFontNormal","TIER "..tier,C.tier[tier]); title:SetPoint("LEFT",122+(column-1)*226,0); self.tierHeaders[tier]=title end

    local scroll=CreateFrame("ScrollFrame",nil,gear); scroll:SetPoint("TOPLEFT",10,-141); scroll:SetPoint("BOTTOMRIGHT",-16,12); self.scrollFrame=scroll
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(800,ROW_HEIGHT); scroll:SetScrollChild(child); self.scrollChild=child
    for index=1,18 do self:CreateGearRow(child,index) end
    self:CreateScrollBar(gear,scroll); self.gearViewFrames={header,scroll,self.scrollBar,self.gearLegend}
    self:CreateReferenceSection(gear,"ENCHANTS","ENCHANTS","Relevant equipment slots will replace the gear table here. Each class profile will reference a shared, source-verified enchant catalog.")
    self:CreateReferenceSection(gear,"CONSUMABLES","CONSUMABLES","A class-specific table grouped by bandages, food and drink, potions, elixirs, scrolls, Engineering, weapon consumables and class resources will appear here.")
    self:CreateBasicsPage(content); self:CreateGuidesPage(content); self:CreateExplorationPage(content); self:CreateCommunityPage(content); self:CreateResizeGrip(root)
    root:SetScript("OnSizeChanged",function() if MainWindow.gear then MainWindow:Layout() end end)
    self:Layout(); self:RefreshGear(true); self:SelectGearSection(saved.selectedGearSection); self:SelectGuide(saved.selectedGuide); self:SelectPage(saved.selectedPage); return root
end

function MainWindow:RefreshGearSectionButtons()
    local selected=ns.Database:Get().selectedGearSection
    for key,value in pairs(self.gearSectionButtons) do local active=key==selected; value.bg:SetColorTexture(active and 0.10 or 0.06,active and 0.17 or 0.08,active and 0.25 or 0.12,1); value.accent:SetColorTexture(0.2,0.62,1,active and 1 or 0); value.title:SetTextColor(active and 0.50 or 0.53,active and 0.80 or 0.60,active and 1.00 or 0.70,1) end
end

function MainWindow:SelectGearSection(section)
    if not ns.Database:SetSelectedGearSection(section) then return end
    for _,value in ipairs(self.gearViewFrames or {}) do value:SetShown(section=="GEAR") end
    for key,value in pairs(self.gearSections) do value:SetShown(key==section) end
    self:RefreshGearSectionButtons(); self:RefreshActiveGearSection(false)
end

function MainWindow:RefreshActiveGearSection(resetScroll)
    local section=ns.Database:Get().selectedGearSection
    if section=="GEAR" then self:RefreshGear(resetScroll); return end
    local profile=ns.BisData.classes[ns.Database:Get().selectedClass]
    self.className:SetText(string.upper(profile.name)); self.classRole:SetText(profile.role); self:RefreshClassButtons()
    local panel=self.gearSections[section]
    if panel then
        panel.className:SetText(string.upper(profile.name).." PROFILE")
        if section=="ENCHANTS" then local data=ns.EnchantsData.classes[ns.Database:Get().selectedClass]; self:RefreshReferenceSection(section,data,ns.EnchantsData.catalog,data.slotOrder,data.slots)
        else local data=ns.ConsumablesData.classes[ns.Database:Get().selectedClass]; self:RefreshReferenceSection(section,data,ns.ConsumablesData.catalog,data.categoryOrder,data.categories) end
    end
end

function MainWindow:RefreshPageButtons()
    local selected=ns.Database:Get().selectedPage
    for key,value in pairs(self.pageButtons) do local active=key==selected; value.bg:SetColorTexture(active and 0.10 or 0.06,active and 0.17 or 0.08,active and 0.25 or 0.12,1); value.accent:SetColorTexture(0.2,0.62,1,active and 1 or 0); value.title:SetTextColor(active and 0.50 or 0.53,active and 0.80 or 0.60,active and 1.00 or 0.70,1) end
end

function MainWindow:SelectPage(page)
    ns.Database:SetSelectedPage(page)
    for key,value in pairs(self.pages) do value:SetShown(key==page) end
    self:RefreshPageButtons()
    if page=="GEAR" then self:SelectGearSection(ns.Database:Get().selectedGearSection) elseif page=="GUIDES" then self:SelectGuide(ns.Database:Get().selectedGuide) elseif page=="EXPLORATION" then self:RefreshExploration() end
end

function MainWindow:Layout()
    if not self.gear then return end
    local rowWidth=math.max(660,self.gear:GetWidth()-26); local tierWidth=(rowWidth-110)/3
    self.scrollChild:SetWidth(rowWidth)
    local profile=ns.BisData.classes[ns.Database:Get().selectedClass]
    local contentHeight=0
    for index,row in ipairs(self.rows) do
        local slot=profile.slotOrder[index]
        local rowHeight=ROW_HEIGHT
        if slot then
            for _,tier in ipairs({"S","A","B"}) do
                if #profile.slots[slot][tier]>1 then rowHeight=MULTI_ROW_HEIGHT; break end
            end
        end
        row:ClearAllPoints(); row:SetPoint("TOPLEFT",0,-contentHeight); row:SetHeight(rowHeight)
        row:SetWidth(rowWidth)
        for column,tier in ipairs({"S","A","B"}) do
            local cell=row.cells[tier]; cell:ClearAllPoints(); cell:SetPoint("TOPLEFT",110+(column-1)*tierWidth,0); cell:SetWidth(tierWidth-4); cell:SetHeight(rowHeight)
            cell:SetHitRectInsets(0,0,0,math.max(0,rowHeight-48))
            local textWidth=math.max(90,tierWidth-62); cell.textWidth=textWidth
            cell.name:SetWidth(math.max(45,textWidth-(cell.equipped and not cell.hasAlternative and 62 or 0)))
            cell.alternative:SetWidth(math.max(44,tierWidth-12)); cell.alternative.name:SetWidth(textWidth)
        end
        if slot then contentHeight=contentHeight+rowHeight end
    end
    for column,tier in ipairs({"S","A","B"}) do local title=self.tierHeaders[tier]; title:ClearAllPoints(); title:SetPoint("LEFT",122+(column-1)*tierWidth,0) end
    local guideWidth=math.max(390,(self.content:GetWidth()-18)/2)
    for index,card in ipairs(self.guideCards) do local column=(index-1)%2; local row=math.floor((index-1)/2); card:ClearAllPoints(); card:SetPoint("TOPLEFT",6+column*(guideWidth+6),-62-row*100); card:SetWidth(guideWidth); card.body:SetWidth(guideWidth-32) end
    local explorationWidth=math.max(390,(self.content:GetWidth()-18)/2)
    for index,faction in ipairs({"HORDE","ALLIANCE"}) do
        local panel=self.explorationPanels[faction]
        if panel then panel:ClearAllPoints(); panel:SetPoint("TOPLEFT",6+(index-1)*(explorationWidth+6),-72); panel:SetPoint("BOTTOMLEFT",6+(index-1)*(explorationWidth+6),6); panel:SetWidth(explorationWidth); panel.child:SetWidth(math.max(320,explorationWidth-48)); for _,explorationRow in ipairs(self.explorationRows[faction]) do explorationRow:SetWidth(math.max(320,explorationWidth-48)) end end
    end
    for _,section in pairs(self.gearSections) do local width=math.max(620,section:GetWidth()-44); section.child:SetWidth(width); section.body:SetWidth(math.max(420,width-24)) end
    if self.guidesPanel then self.guidesPanel.child:SetWidth(math.max(700,self.guidesPanel:GetWidth()-48)) end
    self.scrollChild:SetHeight(contentHeight)
    local viewport=self.scrollFrame:GetHeight(); if not viewport or viewport<=0 then viewport=455 end
    self.maxScroll=math.max(0,contentHeight-viewport); self.scrollBar:SetMinMaxValues(0,self.maxScroll); if self.scrollBar:GetValue()>self.maxScroll then self.scrollBar:SetValue(self.maxScroll) end
end

function MainWindow:RefreshClassButtons()
    local selected=ns.Database:Get().selectedClass
    for token,value in pairs(self.classButtons) do value.border:SetColorTexture(token==selected and 0.20 or 0.15,token==selected and 0.62 or 0.20,token==selected and 1.00 or 0.29,1) end
end

function MainWindow:RefreshGear(resetScroll)
    local profile=ns.BisData.classes[ns.Database:Get().selectedClass]
    local equipped=ns.GearStatus:Collect(); local profileCounts=ns.GearStatus:CountProfileItemIDs(profile)
    self.className:SetText(string.upper(profile.name)); self.classRole:SetText(profile.role); self:RefreshClassButtons()
    for index,row in ipairs(self.rows) do
        local slot=profile.slotOrder[index]; row:SetShown(slot~=nil)
        if slot then
            row.slot:SetText(string.upper(ns.BisData.slotNames[slot]))
            for _,tier in ipairs({"S","A","B"}) do
                local choices=profile.slots[slot][tier]; local data=choices[1]; local alternative=choices[2]; local cell=row.cells[tier]; local isEquipped=ns.GearStatus:IsEquipped(data,equipped,profileCounts)
                cell.itemID=data.id; cell.itemData=data; cell.equipped=isEquipped; cell.icon:SetTexture(getItemIcon(data.id)); cell.name:SetText(data.name)
                cell.state:SetHeight(alternative and 48 or ROW_HEIGHT); cell.state:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],isEquipped and 0.16 or 0)
                local borderColor=isEquipped and C.equipped or C.tier[tier]; cell.iconBorder:SetColorTexture(borderColor[1],borderColor[2],borderColor[3],isEquipped and 1 or 0.72)
                cell.hasAlternative=alternative~=nil; cell.status:SetShown(isEquipped and not alternative); cell.status:ClearAllPoints(); cell.status:SetPoint("TOPRIGHT",-6,-28)
                cell.name:SetTextColor(unpack(isEquipped and C.equipped or C.text))
                cell.name:ClearAllPoints(); cell.name:SetPoint("TOPLEFT",56,isEquipped and not alternative and -9 or -17)
                cell.hover:SetHeight(alternative and 48 or ROW_HEIGHT)
                cell.name:SetWidth(math.max(45,(cell.textWidth or 160)-(isEquipped and not alternative and 62 or 0)))
                local factionColor=getFactionColor(data.faction)
                cell.factionBg:SetShown(factionColor~=nil); cell.factionText:SetShown(factionColor~=nil)
                if factionColor then cell.factionBg:SetColorTexture(unpack(factionColor)); cell.factionText:SetText(string.sub(data.faction,1,1)) end
                if data.id and C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(data.id) end
                cell.alternative:SetShown(alternative~=nil)
                if alternative then
                    local altEquipped=ns.GearStatus:IsEquipped(alternative,equipped,profileCounts); local altColor=altEquipped and C.equipped or C.tier[tier]
                    cell.alternative.state:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],altEquipped and 0.16 or 0)
                    cell.alternative.itemID=alternative.id; cell.alternative.itemData=alternative; cell.alternative.icon:SetTexture(getItemIcon(alternative.id)); cell.alternative.border:SetColorTexture(altColor[1],altColor[2],altColor[3],altEquipped and 1 or 0.72)
                    cell.alternative.name:SetText(alternative.name); cell.alternative.name:SetTextColor(unpack(altEquipped and C.equipped or C.text))
                    local altFactionColor=getFactionColor(alternative.faction); cell.alternative.factionBg:SetShown(altFactionColor~=nil); cell.alternative.factionText:SetShown(altFactionColor~=nil)
                    if altFactionColor then cell.alternative.factionBg:SetColorTexture(unpack(altFactionColor)); cell.alternative.factionText:SetText(string.sub(alternative.faction,1,1)) end
                    if alternative.id and C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(alternative.id) end
                end
            end
        end
    end
    self:Layout()
    if resetScroll then self.scrollBar:SetValue(0) elseif self.scrollBar:GetValue()>self.maxScroll then self.scrollBar:SetValue(self.maxScroll) end
end

function MainWindow:RefreshExploration()
    if not self.frame or not self.pages.EXPLORATION or not self.pages.EXPLORATION:IsShown() then return end
    for _,faction in ipairs({"HORDE","ALLIANCE"}) do
        for _,row in ipairs(self.explorationRows[faction] or {}) do
            local state=ns.ExplorationProgress:GetZoneProgress(row.zone.mapID)
            row.progressData=state
            if state and state.available then
                local progressColor=getExplorationProgressColor(state.percent,true)
                row.progress:SetText(string.format("%d/%d  ·  %d%%",state.explored,state.total,state.percent))
                row.progress:SetTextColor(unpack(progressColor))
                row.zoneName:SetTextColor(unpack(state.complete and C.equipped or C.text))
                row.progressBar:SetStatusBarColor(progressColor[1],progressColor[2],progressColor[3],0.92)
                row.progressBar:SetValue(state.percent)
            else
                local total=state and state.total or 0
                row.progress:SetText(string.format("0/%d  ·  0%%",total))
                row.progress:SetTextColor(unpack(C.muted))
                row.zoneName:SetTextColor(unpack(C.text))
                row.progressBar:SetStatusBarColor(C.muted[1],C.muted[2],C.muted[3],0.55)
                row.progressBar:SetValue(0)
            end
        end
    end
end

function MainWindow:RefreshItemIcons()
    if self.frame and self.frame:IsShown() and self.pages.GEAR:IsShown() then
        if ns.Database:Get().selectedGearSection=="GEAR" then self:RefreshGear(false)
        elseif ns.Database:Get().selectedGearSection=="CONSUMABLES" then self:RefreshActiveGearSection(false) end
    end
    if self.frame and self.frame:IsShown() and self.pages.GUIDES:IsShown() then self:SelectGuide(ns.Database:Get().selectedGuide) end
end
function MainWindow:RefreshEquipment()
    if self.frame and self.frame:IsShown() and self.pages.GEAR:IsShown() and ns.Database:Get().selectedGearSection=="GEAR" then self:RefreshGear(false) end
end
function MainWindow:Toggle()
    local root=self:Create()
    if root:IsShown() then root:Hide() else root:Show(); self:SelectPage(ns.Database:Get().selectedPage) end
end
function MainWindow:Show()
    local root=self:Create(); root:Show(); self:SelectPage(ns.Database:Get().selectedPage)
end
function MainWindow:Hide() if self.frame then self.frame:Hide() end end
