local addonName, ns = ...

local MainWindow = { classButtons = {}, rows = {}, pageButtons = {}, pages = {}, guideCards = {}, tierHeaders = {} }
ns.MainWindow = MainWindow

local ROW_HEIGHT = 52
local MULTI_ROW_HEIGHT = 98
local C = {
    window = { 0.022, 0.029, 0.044, 0.99 }, panel = { 0.050, 0.065, 0.095, 0.98 },
    panel2 = { 0.070, 0.090, 0.128, 0.98 }, border = { 0.15, 0.20, 0.29, 1 },
    accent = { 0.20, 0.62, 1.00, 1 }, text = { 0.92, 0.95, 1.00, 1 },
    muted = { 0.53, 0.60, 0.70, 1 }, tier = { S={1.00,0.57,0.14,1}, A={0.43,0.73,1.00,1}, B={0.67,0.70,0.78,1} },
    equipped = { 0.25, 0.85, 0.43, 1 }, alliance = { 0.36, 0.66, 1.00, 1 }, horde = { 1.00, 0.31, 0.36, 1 },
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

local function getFactionColor(faction)
    if faction == "ALLIANCE" then return C.alliance end
    if faction == "HORDE" then return C.horde end
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

function MainWindow:CreateClassButton(parent, token, index)
    local value = CreateFrame("Button", nil, parent); value:SetSize(52,52)
    value:SetPoint("TOPLEFT",14+((index-1)%3)*62,-50-math.floor((index-1)/3)*73)
    local border=value:CreateTexture(nil,"BACKGROUND"); border:SetPoint("TOPLEFT",-2,2); border:SetPoint("BOTTOMRIGHT",2,-2); border:SetColorTexture(unpack(C.border)); value.border=border
    local icon=value:CreateTexture(nil,"ARTWORK"); icon:SetAllPoints(); icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
    local coords=CLASS_COORDS[token]; if coords then icon:SetTexCoord(unpack(coords)) end
    local name=label(value,"GameFontNormalSmall",ns.BisData.classes[token].name,C.muted); name:SetPoint("TOP",value,"BOTTOM",0,-3)
    value:SetScript("OnClick",function() ns.Database:SetSelectedClass(token); MainWindow:RefreshGear(true) end)
    value:SetScript("OnEnter",function() border:SetColorTexture(unpack(C.accent)) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshClassButtons() end)
    self.classButtons[token]=value
end

function MainWindow:CreateItemCell(parent, tier, column)
    local cell=CreateFrame("Button",nil,parent); cell:SetSize(222,ROW_HEIGHT); cell:SetPoint("LEFT",110+(column-1)*226,0)
    local state=cell:CreateTexture(nil,"BACKGROUND"); state:SetAllPoints(); state:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],0); cell.state=state
    local hover=cell:CreateTexture(nil,"BACKGROUND"); hover:SetPoint("TOPLEFT"); hover:SetPoint("TOPRIGHT"); hover:SetHeight(ROW_HEIGHT); hover:SetColorTexture(0.10,0.14,0.20,0); cell.hover=hover
    local tierColor=C.tier[tier]
    local iconBorder=cell:CreateTexture(nil,"BACKGROUND"); iconBorder:SetSize(44,44); iconBorder:SetPoint("TOPLEFT",4,-4); iconBorder:SetColorTexture(tierColor[1],tierColor[2],tierColor[3],0.72); cell.iconBorder=iconBorder; cell.tier=tier
    local icon=cell:CreateTexture(nil,"ARTWORK"); icon:SetSize(40,40); icon:SetPoint("CENTER",iconBorder); icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark"); icon:SetTexCoord(0.07,0.93,0.07,0.93); cell.icon=icon
    local factionBg=cell:CreateTexture(nil,"OVERLAY"); factionBg:SetSize(16,16); factionBg:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",1,-1); factionBg:Hide(); cell.factionBg=factionBg
    local factionText=label(cell,"GameFontNormalSmall","",C.text); factionText:SetPoint("CENTER",factionBg,"CENTER",0,1); factionText:Hide(); cell.factionText=factionText
    local name=label(cell,"GameFontNormalSmall","Item",C.text); name:SetPoint("TOPLEFT",56,-9); name:SetWidth(160); name:SetHeight(16); name:SetJustifyH("LEFT"); cell.name=name
    local status=label(cell,"GameFontNormalSmall","EQUIPPED",C.equipped); status:SetPoint("TOPRIGHT",-6,-28); status:Hide(); cell.status=status
    local alternative=CreateFrame("Button",nil,cell); alternative:SetSize(214,44); alternative:SetPoint("TOPLEFT",4,-50); alternative:Hide(); cell.alternative=alternative
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

function MainWindow:CreatePageButton(parent,key,text,x)
    local value=CreateFrame("Button",nil,parent); value:SetSize(100,30); value:SetPoint("TOPLEFT",x,-35)
    local bg=value:CreateTexture(nil,"BACKGROUND"); bg:SetAllPoints(); bg:SetColorTexture(0.06,0.08,0.12,0.95); value.bg=bg
    local accent=value:CreateTexture(nil,"ARTWORK"); accent:SetPoint("BOTTOMLEFT"); accent:SetPoint("BOTTOMRIGHT"); accent:SetHeight(2); accent:SetColorTexture(0.2,0.62,1,0); value.accent=accent
    local title=label(value,"GameFontNormalSmall",text,C.muted); title:SetPoint("CENTER"); value.title=title
    value:SetScript("OnClick",function() MainWindow:SelectPage(key) end)
    value:SetScript("OnEnter",function() bg:SetColorTexture(0.10,0.14,0.20,1) end)
    value:SetScript("OnLeave",function() MainWindow:RefreshPageButtons() end)
    self.pageButtons[key]=value
end

function MainWindow:CreateBasicsPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.BASICS=page
    local heading=label(page,"GameFontNormalHuge","TWINK BASICS",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","The short version: finish every XP-risk task before the final level-19 lock-in.",C.muted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)
    for index,entry in ipairs(ns.GuideData) do
        local card=frame(page); card:SetHeight(92); skin(card,C.panel); self.guideCards[index]=card
        local number=label(card,"GameFontNormalLarge",string.format("%02d",index),C.accent); number:SetPoint("TOPLEFT",14,-14)
        local title=label(card,"GameFontNormal",entry.title,C.text); title:SetPoint("TOPLEFT",52,-14)
        local text=label(card,"GameFontNormalSmall",entry.text,C.muted); text:SetPoint("TOPLEFT",52,-38); text:SetJustifyH("LEFT"); card.body=text
    end
end

function MainWindow:CreateCommunityPage(parent)
    local page=frame(parent); page:SetAllPoints(); page:Hide(); self.pages.COMMUNITY=page
    local heading=label(page,"GameFontNormalHuge","COMMUNITY",C.text); heading:SetPoint("TOPLEFT",6,-6)
    local intro=label(page,"GameFontNormalSmall","Guilds and community links for level-19 Classic Era twinks.",C.muted); intro:SetPoint("TOPLEFT",heading,"BOTTOMLEFT",1,-5)

    local card=frame(page); card:SetPoint("TOPLEFT",6,-62); card:SetPoint("TOPRIGHT",-6,-62); card:SetHeight(190); skin(card,C.panel)
    local badge=frame(card); badge:SetSize(48,48); badge:SetPoint("TOPLEFT",16,-16); skin(badge,{0.34,0.055,0.070,1},{0.72,0.12,0.15,1})
    local badgeText=label(badge,"GameFontNormalHuge","H",C.horde); badgeText:SetPoint("CENTER",0,1)

    local guildName=label(card,"GameFontNormalLarge","TWINK OR TREAT",C.text); guildName:SetPoint("TOPLEFT",badge,"TOPRIGHT",14,-2)
    local realm=label(card,"GameFontNormalSmall","HORDE  |  FIREMAW CLUSTER  |  EU PVP  |  CLASSIC ERA",C.horde); realm:SetPoint("TOPLEFT",guildName,"BOTTOMLEFT",0,-7)
    local description=label(card,"GameFontNormalSmall","Horde guild on the EU PvP Classic Era Firemaw Cluster.",C.muted); description:SetPoint("TOPLEFT",16,-82)

    local discordLabel=label(card,"GameFontNormalSmall","DISCORD INVITE",C.muted); discordLabel:SetPoint("TOPLEFT",16,-112)
    local template=BackdropTemplateMixin and "BackdropTemplate" or nil
    local discord=CreateFrame("EditBox",nil,card,template); discord:SetPoint("TOPLEFT",16,-132); discord:SetPoint("TOPRIGHT",-16,-132); discord:SetHeight(38)
    skin(discord,C.panel2,C.border); discord:SetFontObject(GameFontHighlightSmall); discord:SetTextInsets(10,10,0,0); discord:SetAutoFocus(false); discord:SetTextColor(unpack(C.accent))
    local discordURL="https://discord.gg/BdABEghf3M"
    discord:SetText(discordURL); discord:SetCursorPosition(0)
    discord:SetScript("OnTextChanged",function(self,userInput) if userInput and self:GetText()~=discordURL then self:SetText(discordURL); self:HighlightText() end end)
    discord:SetScript("OnEditFocusGained",function(self) self:HighlightText() end)
    discord:SetScript("OnMouseUp",function(self) self:SetFocus(); self:HighlightText() end)
    discord:SetScript("OnEscapePressed",function(self) self:ClearFocus() end)
    discord:SetScript("OnEnterPressed",function(self) self:HighlightText() end)
    local copyHint=label(card,"GameFontNormalSmall","Click the address, then press Ctrl+C to copy.",C.muted); copyHint:SetPoint("BOTTOMRIGHT",-17,8)
end

function MainWindow:CreateWowheadBar(parent)
    local bar=frame(parent); bar:SetPoint("TOPLEFT",10,-65); bar:SetPoint("TOPRIGHT",-14,-65); bar:SetHeight(30); skin(bar,C.panel2)
    local caption=label(bar,"GameFontNormalSmall","WOWHEAD LINK",C.muted); caption:SetPoint("LEFT",10,0); caption:SetWidth(220); caption:SetJustifyH("LEFT"); self.wowheadCaption=caption
    local template=BackdropTemplateMixin and "BackdropTemplate" or nil
    local link=CreateFrame("EditBox",nil,bar,template); link:SetPoint("TOPLEFT",232,-4); link:SetPoint("BOTTOMRIGHT",-5,4)
    skin(link,C.panel,C.border); link:SetFontObject(GameFontHighlightSmall); link:SetTextInsets(8,8,0,0); link:SetAutoFocus(false); link:SetTextColor(unpack(C.accent))
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
    local logoFallback=root:CreateFontString(nil,"BORDER","GameFontNormalHuge"); logoFallback:SetPoint("TOP",0,-31); logoFallback:SetText("TWINK TRACKER"); logoFallback:SetTextColor(0.95,0.58,0.16,1)
    local logo=root:CreateTexture(nil,"ARTWORK"); logo:SetSize(276,100); logo:SetPoint("TOP",0,-1); logo:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\logo.tga"); logo:SetTexCoord(0,1,0.1367,0.8633)
    self:CreatePageButton(root,"GEAR","GEAR",20); self:CreatePageButton(root,"BASICS","TWINK BASICS",128)
    self:CreatePageButton(root,"COMMUNITY","COMMUNITY",236)
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
    local legend=label(gear,"GameFontNormalSmall","|cff40d96eEQUIPPED|r   |cff5ca9ffA  ALLIANCE|r   |cffff505cH  HORDE|r",C.muted); legend:SetPoint("TOPRIGHT",-18,-22)
    self:CreateWowheadBar(gear)
    local header=frame(gear); header:SetPoint("TOPLEFT",10,-103); header:SetPoint("TOPRIGHT",-14,-103); header:SetHeight(34); skin(header,C.panel2)
    local slotHeader=label(header,"GameFontNormalSmall","SLOT",C.muted); slotHeader:SetPoint("LEFT",12,0); slotHeader:SetWidth(88); slotHeader:SetJustifyH("LEFT")
    for column,tier in ipairs({"S","A","B"}) do local title=label(header,"GameFontNormal","TIER "..tier,C.tier[tier]); title:SetPoint("LEFT",122+(column-1)*226,0); self.tierHeaders[tier]=title end

    local scroll=CreateFrame("ScrollFrame",nil,gear); scroll:SetPoint("TOPLEFT",10,-141); scroll:SetPoint("BOTTOMRIGHT",-16,12); self.scrollFrame=scroll
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(800,ROW_HEIGHT); scroll:SetScrollChild(child); self.scrollChild=child
    for index=1,18 do self:CreateGearRow(child,index) end
    self:CreateScrollBar(gear,scroll); self:CreateBasicsPage(content); self:CreateCommunityPage(content); self:CreateResizeGrip(root)
    root:SetScript("OnSizeChanged",function() if MainWindow.gear then MainWindow:Layout() end end)
    self:Layout(); self:RefreshGear(true); self:SelectPage(saved.selectedPage); return root
end

function MainWindow:RefreshPageButtons()
    local selected=ns.Database:Get().selectedPage
    for key,value in pairs(self.pageButtons) do local active=key==selected; value.bg:SetColorTexture(active and 0.10 or 0.06,active and 0.17 or 0.08,active and 0.25 or 0.12,1); value.accent:SetColorTexture(0.2,0.62,1,active and 1 or 0); value.title:SetTextColor(active and 0.50 or 0.53,active and 0.80 or 0.60,active and 1.00 or 0.70,1) end
end

function MainWindow:SelectPage(page)
    ns.Database:SetSelectedPage(page)
    for key,value in pairs(self.pages) do value:SetShown(key==page) end
    self:RefreshPageButtons()
    if page=="GEAR" then self:RefreshGear(false) end
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
    for index,card in ipairs(self.guideCards) do local column=(index-1)%2; local row=math.floor((index-1)/2); card:ClearAllPoints(); card:SetPoint("TOPLEFT",6+column*(guideWidth+6),-62-row*100); card:SetWidth(guideWidth); card.body:SetWidth(guideWidth-68) end
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
                cell.state:SetColorTexture(C.equipped[1],C.equipped[2],C.equipped[3],isEquipped and not alternative and 0.16 or 0)
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

function MainWindow:RefreshItemIcons()
    if self.frame and self.frame:IsShown() and self.pages.GEAR:IsShown() then self:RefreshGear(false) end
end
function MainWindow:RefreshEquipment()
    if self.frame and self.frame:IsShown() and self.pages.GEAR:IsShown() then self:RefreshGear(false) end
end
function MainWindow:Toggle()
    local root=self:Create()
    if root:IsShown() then root:Hide() else root:Show(); self:SelectPage(ns.Database:Get().selectedPage) end
end
function MainWindow:Show()
    local root=self:Create(); root:Show(); self:SelectPage(ns.Database:Get().selectedPage)
end
function MainWindow:Hide() if self.frame then self.frame:Hide() end end
