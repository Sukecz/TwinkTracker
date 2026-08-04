local addonName, ns = ...

local MainWindow = { classButtons = {}, rows = {} }
ns.MainWindow = MainWindow

local ROW_HEIGHT = 52
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
    local hover=cell:CreateTexture(nil,"BACKGROUND"); hover:SetAllPoints(); hover:SetColorTexture(0.10,0.14,0.20,0); cell.hover=hover
    local tierColor=C.tier[tier]
    local iconBorder=cell:CreateTexture(nil,"BACKGROUND"); iconBorder:SetSize(44,44); iconBorder:SetPoint("LEFT",4,0); iconBorder:SetColorTexture(tierColor[1],tierColor[2],tierColor[3],0.72)
    local icon=cell:CreateTexture(nil,"ARTWORK"); icon:SetSize(40,40); icon:SetPoint("CENTER",iconBorder); icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark"); icon:SetTexCoord(0.07,0.93,0.07,0.93); cell.icon=icon
    local name=label(cell,"GameFontNormalSmall","Item",C.text); name:SetPoint("TOPLEFT",56,-9); name:SetWidth(160); name:SetHeight(16); name:SetJustifyH("LEFT"); cell.name=name
    local note=label(cell,"GameFontNormalSmall","",C.muted); note:SetPoint("TOPLEFT",56,-28); note:SetWidth(160); note:SetHeight(15); note:SetJustifyH("LEFT"); cell.note=note
    cell:SetScript("OnEnter",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0.72); if self.itemID then GameTooltip:SetOwner(self,"ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..self.itemID); GameTooltip:Show() end end)
    cell:SetScript("OnLeave",function(self) self.hover:SetColorTexture(0.10,0.14,0.20,0); GameTooltip:Hide() end)
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
    local bar=CreateFrame("Slider",nil,parent); bar:SetOrientation("VERTICAL"); bar:SetWidth(7); bar:SetPoint("TOPRIGHT",-4,-104); bar:SetPoint("BOTTOMRIGHT",-4,12); bar:SetMinMaxValues(0,0); bar:SetValueStep(ROW_HEIGHT); bar:SetValue(0)
    local track=parent:CreateTexture(nil,"BACKGROUND"); track:SetWidth(2); track:SetPoint("TOP",bar,"TOP"); track:SetPoint("BOTTOM",bar,"BOTTOM"); track:SetColorTexture(0.14,0.18,0.26,0.7)
    bar:SetThumbTexture("Interface\\Buttons\\WHITE8X8"); local thumb=bar:GetThumbTexture(); thumb:SetSize(7,42); thumb:SetColorTexture(unpack(C.accent))
    bar:SetScript("OnValueChanged",function(_,value) scrollFrame:SetVerticalScroll(value) end)
    scrollFrame:EnableMouseWheel(true); scrollFrame:SetScript("OnMouseWheel",function(_,delta) bar:SetValue(math.max(0,math.min(MainWindow.maxScroll or 0,bar:GetValue()-delta*ROW_HEIGHT*2))) end)
    self.scrollBar=bar
end

function MainWindow:Create()
    if self.frame then return self.frame end
    local saved=ns.Database:Get(); local root=frame(UIParent,"TwinkTrackerMainFrame")
    root:SetSize(1100,700); root:SetPoint(saved.frame.point,UIParent,saved.frame.point,saved.frame.x,saved.frame.y); root:SetFrameStrata("DIALOG")
    root:SetMovable(true); root:EnableMouse(true); root:RegisterForDrag("LeftButton"); root:SetScript("OnDragStart",root.StartMoving)
    root:SetScript("OnDragStop",function(self) self:StopMovingOrSizing(); local p,_,_,x,y=self:GetPoint(); ns.Database:SetFramePosition(p,x,y) end)
    skin(root,C.window,C.border); root:Hide(); self.frame=root
    local glow=root:CreateTexture(nil,"BACKGROUND",nil,-1); glow:SetPoint("TOPLEFT",1,-1); glow:SetPoint("TOPRIGHT",-1,-1); glow:SetHeight(100); glow:SetColorTexture(0.03,0.23,0.42,0.30)
    local logo=root:CreateTexture(nil,"ARTWORK"); logo:SetSize(276,100); logo:SetPoint("TOP",0,-1); logo:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\logo.png")
    local close=CreateFrame("Button",nil,root); close:SetSize(28,28); close:SetPoint("TOPRIGHT",-17,-15); local x=label(close,"GameFontNormalLarge","×",C.muted); x:SetPoint("CENTER",0,1)
    close:SetScript("OnEnter",function() x:SetTextColor(1,0.3,0.3) end); close:SetScript("OnLeave",function() x:SetTextColor(unpack(C.muted)) end); close:SetScript("OnClick",function() root:Hide() end)

    local content=frame(root); content:SetPoint("TOPLEFT",20,-108); content:SetPoint("BOTTOMRIGHT",-20,20)
    local classes=frame(content); classes:SetPoint("TOPLEFT"); classes:SetPoint("BOTTOMLEFT"); classes:SetWidth(208); skin(classes,C.panel)
    local classTitle=label(classes,"GameFontNormal","SELECT CLASS",C.muted); classTitle:SetPoint("TOPLEFT",14,-16)
    for i,token in ipairs(ns.BisData.classOrder) do self:CreateClassButton(classes,token,i) end

    local gear=frame(content); gear:SetPoint("TOPLEFT",classes,"TOPRIGHT",10,0); gear:SetPoint("BOTTOMRIGHT"); skin(gear,C.window); self.gear=gear
    self.className=label(gear,"GameFontNormalHuge","DRUID",C.text); self.className:SetPoint("TOPLEFT",16,-14)
    self.classRole=label(gear,"GameFontNormalSmall","",C.muted); self.classRole:SetPoint("TOPLEFT",self.className,"BOTTOMLEFT",1,-4)
    local header=frame(gear); header:SetPoint("TOPLEFT",10,-65); header:SetPoint("TOPRIGHT",-14,-65); header:SetHeight(34); skin(header,C.panel2)
    local slotHeader=label(header,"GameFontNormalSmall","SLOT",C.muted); slotHeader:SetPoint("LEFT",12,0); slotHeader:SetWidth(88); slotHeader:SetJustifyH("LEFT")
    for column,tier in ipairs({"S","A","B"}) do local title=label(header,"GameFontNormal","TIER "..tier,C.tier[tier]); title:SetPoint("LEFT",122+(column-1)*226,0) end

    local scroll=CreateFrame("ScrollFrame",nil,gear); scroll:SetPoint("TOPLEFT",10,-103); scroll:SetPoint("BOTTOMRIGHT",-16,12); self.scrollFrame=scroll
    local child=CreateFrame("Frame",nil,scroll); child:SetSize(800,ROW_HEIGHT); scroll:SetScrollChild(child); self.scrollChild=child
    for index=1,17 do self:CreateGearRow(child,index) end
    self:CreateScrollBar(gear,scroll); self:RefreshGear(true); return root
end

function MainWindow:RefreshClassButtons()
    local selected=ns.Database:Get().selectedClass
    for token,value in pairs(self.classButtons) do value.border:SetColorTexture(token==selected and 0.20 or 0.15,token==selected and 0.62 or 0.20,token==selected and 1.00 or 0.29,1) end
end

function MainWindow:RefreshGear(resetScroll)
    local profile=ns.BisData.classes[ns.Database:Get().selectedClass]
    self.className:SetText(string.upper(profile.name)); self.classRole:SetText(profile.role); self:RefreshClassButtons()
    for index,row in ipairs(self.rows) do
        local slot=profile.slotOrder[index]; row:SetShown(slot~=nil)
        if slot then
            row.slot:SetText(string.upper(ns.BisData.slotNames[slot]))
            for _,tier in ipairs({"S","A","B"}) do
                local data=profile.slots[slot][tier]; local cell=row.cells[tier]; cell.itemID=data.id; cell.icon:SetTexture(getItemIcon(data.id)); cell.name:SetText(data.name); cell.note:SetText(data.note or "")
                if data.id and C_Item and C_Item.RequestLoadItemDataByID then C_Item.RequestLoadItemDataByID(data.id) end
            end
        end
    end
    local contentHeight=#profile.slotOrder*ROW_HEIGHT; self.scrollChild:SetHeight(contentHeight)
    local viewport=self.scrollFrame:GetHeight(); if not viewport or viewport<=0 then viewport=495 end
    self.maxScroll=math.max(0,contentHeight-viewport); self.scrollBar:SetMinMaxValues(0,self.maxScroll)
    if resetScroll then self.scrollBar:SetValue(0) elseif self.scrollBar:GetValue()>self.maxScroll then self.scrollBar:SetValue(self.maxScroll) end
end

function MainWindow:RefreshItemIcons() if self.frame and self.frame:IsShown() then self:RefreshGear(false) end end
function MainWindow:Toggle() local root=self:Create(); if root:IsShown() then root:Hide() else root:Show(); self:RefreshGear(false) end end
function MainWindow:Show() local root=self:Create(); root:Show(); self:RefreshGear(false) end
function MainWindow:Hide() if self.frame then self.frame:Hide() end end
