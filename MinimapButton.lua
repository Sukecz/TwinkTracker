local addonName, ns = ...

local MinimapButton = {}
ns.MinimapButton = MinimapButton

local RADIUS = 80

local function atan2(y,x)
    if x>0 then return math.atan(y/x) end
    if x<0 and y>=0 then return math.atan(y/x)+math.pi end
    if x<0 and y<0 then return math.atan(y/x)-math.pi end
    if y>0 then return math.pi/2 end
    if y<0 then return -math.pi/2 end
    return 0
end

function MinimapButton:SetPosition(angle)
    local radians=math.rad(angle)
    self.button:ClearAllPoints()
    self.button:SetPoint("CENTER",Minimap,"CENTER",math.cos(radians)*RADIUS,math.sin(radians)*RADIUS)
end

function MinimapButton:UpdateDragPosition()
    local cursorX,cursorY=GetCursorPosition()
    local scale=UIParent:GetEffectiveScale()
    local centerX,centerY=Minimap:GetCenter()
    local angle=math.deg(atan2(cursorY/scale-centerY,cursorX/scale-centerX))%360
    self.dragAngle=angle
    self:SetPosition(angle)
end

function MinimapButton:SetShown(shown)
    if self.button then self.button:SetShown(shown and true or false) end
end

function MinimapButton:Create()
    if self.button then return self.button end

    local button=CreateFrame("Button","TwinkTrackerMinimapButton",Minimap)
    button:SetSize(32,32)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(Minimap:GetFrameLevel()+8)
    button:RegisterForClicks("LeftButtonUp")
    button:RegisterForDrag("LeftButton")

    local background=button:CreateTexture(nil,"BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    local icon=button:CreateTexture(nil,"ARTWORK")
    icon:SetSize(24,24)
    icon:SetPoint("CENTER",0,1)
    icon:SetTexture("Interface\\AddOns\\TwinkTracker\\assets\\minimap-icon.tga")
    icon:SetTexCoord(0,1,0,1)

    local border=button:CreateTexture(nil,"OVERLAY")
    border:SetSize(54,54)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight","ADD")
    button:SetScript("OnClick",function() ns.MainWindow:Toggle() end)
    button:SetScript("OnEnter",function(self)
        GameTooltip:SetOwner(self,"ANCHOR_LEFT")
        GameTooltip:AddLine("TwinkTracker",1.00,0.57,0.14)
        GameTooltip:AddLine("Left-click: Open or close",0.92,0.95,1.00)
        GameTooltip:AddLine("Drag: Move around minimap",0.53,0.60,0.70)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave",function() GameTooltip:Hide() end)
    button:SetScript("OnDragStart",function(self)
        self:SetScript("OnUpdate",function() MinimapButton:UpdateDragPosition() end)
    end)
    button:SetScript("OnDragStop",function(self)
        self:SetScript("OnUpdate",nil)
        if MinimapButton.dragAngle then ns.Database:SetMinimapAngle(MinimapButton.dragAngle) end
    end)

    self.button=button
    self:SetPosition(ns.Database:Get().minimapAngle)
    self:SetShown(ns.Database:Get().showMinimapIcon)
    return button
end
