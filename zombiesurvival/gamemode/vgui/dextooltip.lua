local PANEL = {}

function PANEL:Init()
    self:SetDrawOnTop(true)
    self.DeleteContentsOnClose = false
    self:SetText("")
    self:SetFont("ZSHUDFontTiny")
    self:SetTextColor(color_white)
end

function PANEL:UpdateColours(skin)
    return self:SetTextStyleColor(skin.Colours.TooltipText)
end

function PANEL:SetContents(panel, bDelete)
    panel:SetParent(self)
    self.Contents = panel
    self.DeleteContentsOnClose = bDelete or false
    self.Contents:SizeToContents()
    self:InvalidateLayout(true)
    self.Contents:SetVisible(false)
end

function PANEL:PerformLayout()
    if IsValid(self.Contents) then
        self:SetWide(self.Contents:GetWide() + 8)
        self:SetTall(self.Contents:GetTall() + 8)
        self.Contents:SetPos(4, 4)
        self.Contents:SetVisible(true)
    else
        local w, h = self:GetContentSize()
        local screenscale = BetterScreenScale()
        local size = 8 * screenscale
        self:SetSize(w + size, h + size)
        self:SetContentAlignment(5)
    end
end

local Mat = Material("vgui/arrow")
function PANEL:DrawArrow(x, y)
    self.Contents:SetVisible(true)
    surface.SetMaterial(Mat)
    surface.DrawTexturedRect(self.ArrowPosX + x, self.ArrowPosY + y, self.ArrowWide, self.ArrowTall)
end

function PANEL:PositionTooltip()
	if not IsValid(self.TargetPanel) then
		self:Close()
		return
	end
	self:InvalidateLayout( true )

	local x, y = input.GetCursorPos()
	local w, h = self:GetSize()
	local lx, ly = self.TargetPanel:LocalToScreen( 0, 0 )

	y = y - 25 * BetterScreenScale()
	y = math.min( y, ly - h)
	if y < 2 then 
        y = 2 
    end

	self:SetPos( math.Clamp( x - w * 0.5, 0, ScrW() - self:GetWide() ), math.Clamp( y, 0, ScrH() - self:GetTall() ) )
end

function PANEL:Paint(w, h)
    self:PositionTooltip()
    local screenscale = BetterScreenScale()

    local size = math.Round(2 * screenscale)
    h = h - size

    surface.SetDrawColor(180, 180, 180, 255)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(size, size, w - size * 2, h - size * 2)
end

function PANEL:OpenForPanel(panel)
    self.TargetPanel = panel
    self:PositionTooltip()
    self:SetVisible(true)
    self:SetVisible(false)
    timer.Simple(0.2, function()
        if not IsValid(self) then
            return
        end
        if not IsValid(panel) then
            return
        end
        if not (self:GetText() and #self:GetText() > 0 or IsValid(self.Contents)) then
            return
        end
        self:PositionTooltip()
        self:SetVisible(true)
    end)
end

function PANEL:Close()
    if not self.DeleteContentsOnClose and IsValid(self.Contents) then
        self.Contents:SetVisible(false)
        self.Contents:SetParent(nil)
    end
    self:Remove()
end

function PANEL:GenerateExample(ClassName, PropertySheet, Width, Height)
	local ctrl = vgui.Create( "DButton" )
	ctrl:SetText("Hover me")
	ctrl:SetWide( 200 )
	ctrl:SetTooltip("This is a tooltip")

	PropertySheet:AddSheet(ClassName, ctrl, nil, true, true)
end

derma.DefineControl("DExTooltip", "", PANEL, "DLabel")
