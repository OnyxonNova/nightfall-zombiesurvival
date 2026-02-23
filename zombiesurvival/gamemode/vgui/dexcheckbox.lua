local PANEL = {}

AccessorFunc(PANEL, "m_bChecked", "Checked", FORCE_BOOL)

Derma_Install_Convar_Functions(PANEL)

function PANEL:Init()
    self:SetSize(15, 15)
    self:SetText("")
end

function PANEL:IsEditing()
    return self.Depressed
end

function PANEL:SetValue(val)
    if tonumber(val) == 0 then
        val = 0
    end
    val = tobool(val)

    self:SetChecked(val)
    self.m_bValue = val

    self:OnChange(val)

    if val then
        val = "1"
    else
        val = "0"
    end
    
    self:ConVarChanged(val)
end

function PANEL:DoClick()
    self:Toggle()
end

function PANEL:Toggle()
    if self:GetChecked() == nil or not self:GetChecked() then
        self:SetValue(true)
    else
        self:SetValue(false)
    end
end

function PANEL:OnChange(val)
end

local check = Material("zombiesurvival/killicons/zs_check")
local cross = Material("zombiesurvival/killicons/zs_cross")
function PANEL:Paint(w, h)
    local unchecked = self:GetChecked() == nil or not self:GetChecked()
    local ColorChecker = unchecked and Color(255, 50, 50, 210) or Color(70, 255, 70, 210)
    surface.SetDrawColor(ColorChecker)
    surface.DrawOutlinedRect(0, 0, w, h)
    
    surface.DrawOutlinedRect(1, 1, w - 2, h - 2)

    surface.SetMaterial(unchecked and cross or check)
    surface.DrawTexturedRect(0, 0, w, h)
end

function PANEL:Think()
    self:ConVarStringThink()
end

function PANEL:GenerateExample(class, tabs, w, h)
end

derma.DefineControl("DEXCheckBox", "Simple Checkbox", PANEL, "DButton")

PANEL = {}

AccessorFunc(PANEL, "m_iIndent", "Indent")

function PANEL:Init()
    self:SetTall(16)
    self.Button = vgui.Create("DEXCheckBox", self)
    self.Button.OnChange = function(m, b)
        self:OnChange(b)
    end
    self.Label = vgui.Create("DLabel", self)
    self.Label:SetMouseInputEnabled(true)
    self.Label.DoClick = function()
        self:Toggle()
    end
    self.Label:CenterVertical()
end

function PANEL:SetDark(b)
    self.Label:SetDark(b)
end

function PANEL:SetBright(b)
    self.Label:SetBright(b)
end

function PANEL:SetConVar(cvar)
    self.Button:SetConVar(cvar)
end

function PANEL:SetValue(val)
    self.Button:SetValue(val)
end

function PANEL:SetChecked(val)
    self.Button:SetChecked(val)
end

function PANEL:GetChecked(val)
    return self.Button:GetChecked()
end

function PANEL:Toggle()
    self.Button:Toggle()
end

function PANEL:PerformLayout()
    local x = self.m_iIndent or 0
    local screenscale = BetterScreenScale()
    self.Button:SetSize(24 * screenscale, 24 * screenscale)
    self.Button:SetPos(x, math.floor((self:GetTall() - self.Button:GetTall()) / 2))
    self.Label:SizeToContents()
    self.Label:SetPos(x + self.Button:GetWide() + 9 * screenscale, 0)
    self.Label:CenterVertical()
end

function PANEL:SetTextColor(color)
    self.Label:SetTextColor(color)
end

function PANEL:SizeToContents()
    self:InvalidateLayout(true)
    self:SetWide(self.Label.x + self.Label:GetWide())
    self:SetTall(math.max(self.Button:GetTall(), self.Label:GetTall()))
    self:InvalidateLayout()
end

function PANEL:SetText(text)
    self.Label:SetText(text)
    self:SizeToContents()
end

function PANEL:SetFont(font)
    self.Label:SetFont(font)
    self:SizeToContents()
end

function PANEL:GetText()
    return self.Label:GetText()
end

function PANEL:Paint()
end

function PANEL:OnChange(cbVal)
end

function PANEL:GenerateExample(ClassName, PropertySheet, Width, Height)
	local ctrl = vgui.Create(ClassName)
	ctrl:SetText("CheckBox")
	ctrl:SetWide(200)
	PropertySheet:AddSheet(ClassName, ctrl, nil, true, true)
end

derma.DefineControl("DEXCheckBoxLabel", "Simple Checkbox", PANEL, "DPanel")