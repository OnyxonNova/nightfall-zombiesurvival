CreateClientConVar("zs_bossclass", "", true, true)

local WindowFirst
local WindowSecond
local WindowThird
local HoveredClassWindow
local CurrentType = 0
local ClassTypeButton
local CloseButton

local function CreateHoveredClassWindow(classtable)
	if HoveredClassWindow and HoveredClassWindow:IsValid() then
		HoveredClassWindow:Remove()
	end

	HoveredClassWindow = vgui.Create("ClassInfo")
	HoveredClassWindow:SetSize(ScrW() * 0.5, 128)
	HoveredClassWindow:CenterHorizontal()
	HoveredClassWindow:MoveBelow(WindowFirst, 64)
	HoveredClassWindow:SetClassTable(classtable)
end

function GM:OpenClassSelect(shouldnotplay)
	if WindowFirst and WindowFirst:IsValid() then WindowFirst:Remove() end
    if WindowSecond and WindowSecond:IsValid() then WindowSecond:Remove() end
    if WindowThird and WindowThird:IsValid() then WindowThird:Remove() end
	if CloseButton and CloseButton:IsValid() then CloseButton:Remove() end
	if ClassTypeButton and ClassTypeButton:IsValid() then ClassTypeButton:Remove() end

	WindowFirst = vgui.Create("ClassSelect")
    WindowFirst.ZombieClassType = 1
	WindowFirst:SetAlpha(0)
    WindowFirst:AlphaTo(255, 0.1)
	WindowFirst:MakePopup()
	WindowFirst:InvalidateLayout()
    WindowFirst:CenterHorizontal(0.01)
    WindowFirst:CenterVertical(0.6)
    WindowFirst:ManualClasses()

    WindowSecond = vgui.Create("ClassSelect")
    WindowSecond.ZombieClassType = 3
	WindowSecond:SetAlpha(0)
    WindowSecond:AlphaTo(255, 0.1)
	WindowSecond:MakePopup()
	WindowSecond:InvalidateLayout()
    WindowSecond:CenterHorizontal(0.01)
    WindowSecond:CenterVertical(0.4)
    WindowSecond:ManualClasses()

    WindowThird = vgui.Create("ClassSelect")
    WindowThird.ZombieClassType = 2
	WindowThird:SetAlpha(0)
	WindowThird:AlphaTo(255, 0.1)
	WindowThird:MakePopup()
	WindowThird:InvalidateLayout()
    WindowThird:CenterHorizontal(0.01)
    WindowThird:CenterVertical(0.2)
    WindowThird:ManualClasses()

	ClassTypeButton = EasyButton(nil, translate.Get(CurrentType == 1 and "pclass_back_to_zombie_menu" or "pclass_boss_menu"), 16, 8)
    ClassTypeButton:SetFont("ZSHUDFontSmall")
    ClassTypeButton:SetTextColor(COLOR_WHITE)
    ClassTypeButton:SizeToContents()
    ClassTypeButton.DoClick = function(self)
        if CurrentType == 0 then
            CurrentType = 1
        else
            CurrentType = 0
        end

        GAMEMODE:OpenClassSelect()

		ClassTypeButton:SetText(translate.Get(CurrentType == 1 and "pclass_back_to_zombie_menu" or "pclass_boss_menu"))
    end
    ClassTypeButton:CenterHorizontal(0.63)
    ClassTypeButton:CenterVertical(0.15)

    if CurrentType == 0 then
        ClassTypeButton:SetEnabled(true)
    end

	CloseButton = EasyButton(nil, translate.Get("pclass_close"), 12, 8)
    CloseButton:SetFont("ZSHUDFontSmall")
    CloseButton:SetTextColor(color_white)
    CloseButton:SizeToContents()
    CloseButton.DoClick = function(self)
        WindowFirst:Remove()
        WindowSecond:Remove()
        WindowThird:Remove()
		ClassTypeButton:Remove()
        self:Remove()
    end
    CloseButton:CenterHorizontal(0.36)
    CloseButton:CenterVertical(0.15)

	PlayMenuOpenSound()
end

local PANEL = {}
PANEL.ZombieClassType = 1

function PANEL:ManualClasses()
    self.ClassButtons = {}

    local already_added = {}
    local use_better_versions = GAMEMODE:ShouldUseBetterVersionSystem()

    for i = 1, #GAMEMODE.ZombieClasses do
        local classtab  = GAMEMODE.ZombieClasses[GAMEMODE:GetBestAvailableZombieClass(i)]
        if classtab and classtab.ClassType == self.ZombieClassType and not classtab.Disabled and not already_added[classtab.Index] then
            already_added[classtab.Index] = true
            local ok
            if CurrentType == 1 then
                ok = classtab.Boss
            else
                ok = not classtab.Boss and (not classtab.Hidden or classtab.CanUse and classtab:CanUse(MySelf)) and (not GAMEMODE.ObjectiveMap or classtab.Unlocked)
            end
            if ok then
                if not use_better_versions or not classtab.BetterVersionOf or GAMEMODE:IsClassUnlocked(classtab.Index) then
                    local button = vgui.Create("ClassButton")
                    button:SetClassTable(classtab)
                    button.Wave = classtab.Wave or 1
                    self.ClassButtons[#self.ClassButtons + 1] = button
                    self.ButtonGrid:AddItem(button)
                end
            end
        end
    end
end

function PANEL:Init()
    if not self.ButtonGrid then
        self.ButtonGrid = vgui.Create("DGrid", self)
        self.ButtonGrid:SetContentAlignment(5)
        self.ButtonGrid:Dock(NODOCK)
        self.ButtonGrid:DockMargin(0, 30, 0, 0)
    end

	self.ButtonGrid:SortByMember("Wave")
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
    local w = ScrW() / #self.ClassButtons
    w = math.min(ScrW() / 15, w)

    self:SetSize(ScrW() * 1.05, w * 1.10)

    self.ButtonGrid:SetCols(#self.ClassButtons)
    self.ButtonGrid:SetColWide(w * 1.05)
    self.ButtonGrid:SetRowHeight(w * 1.05)

    self.ButtonGrid:CenterVertical(0.6)
    self.ButtonGrid:CenterHorizontal()
	self.ButtonGrid:SizeToContents()
end

function PANEL:OnRemove()
end

local ClassCat = {translate.Get("pclass_destroyer"), translate.Get("pclass_support"), translate.Get("pclass_offensive")}
local texUpEdge = surface.GetTextureID("gui/gradient_up")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
function PANEL:Paint()
	local wid, hei = self:GetSize()
	local edgesize = 8

	DisableClipping(true)
	surface.SetDrawColor(Color(0, 0, 0, 220))
	surface.DrawRect(0, 0, wid, hei * 1.3)
	surface.SetTexture(texUpEdge)
	surface.DrawTexturedRect(0, -edgesize, wid, edgesize)
	surface.SetTexture(texDownEdge)
	surface.DrawTexturedRect(0, hei * 1.3, wid, edgesize)

    draw.SimpleTextBlurry(ClassCat[self.ZombieClassType], "ZSHUDFontSmall", wid * 0.425, 0, color_white, TEXT_ALIGN_LEFT)

	DisableClipping(false)

	return true
end

vgui.Register("ClassSelect", PANEL, "Panel")

PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(true)
	self:SetContentAlignment(5)

	self.NameLabel = vgui.Create("DLabel", self)
	self.NameLabel:SetFont("ZSHUDFontSmaller")
	self.NameLabel:SetAlpha(200)

	self.Image = vgui.Create("DImage", self)

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
    local cell_size = self:GetParent():GetColWide()

    self:SetSize(cell_size / 0.85, cell_size)
    self.Image:SetSize(cell_size * 0.7, cell_size * 0.7)

    self.Image:AlignBottom(25)
    self.Image:CenterHorizontal()

    self.NameLabel:SizeToContents()
    self.NameLabel:AlignBottom(10)
    self.NameLabel:CenterHorizontal()
end

function PANEL:SetClassTable(classtable)
    self.ClassTable = classtable

    local len = #translate.Get(classtable.TranslationName)

    self.NameLabel:SetText(translate.Get(classtable.TranslationName))
    self.NameLabel:SetFont(len > 15 and "ZSHUDFontTiny" or "ZSHUDFontEvenSmaller")

    self.Image:SetImage(classtable.Icon)
    self.Image:SetImageColor(classtable.IconColor or color_white)

    self:InvalidateLayout()
end

function PANEL:DoClick()
    if self.ClassTable then
        if self.ClassTable.Boss then
            RunConsoleCommand("zs_bossclass", self.ClassTable.Name)
            GAMEMODE:CenterNotify(translate.Format("boss_class_select", translate.Get(self.ClassTable.TranslationName)))
        else
            net.Start("zs_changeclass")
                net.WriteString(self.ClassTable.Name)
                net.WriteBool(GAMEMODE.SuicideOnChangeClass)
            net.SendToServer()
        end
    end

	surface.PlaySound("buttons/button15.wav")

	WindowFirst:Remove()
    WindowSecond:Remove()
    WindowThird:Remove()

	CloseButton:Remove()
    ClassTypeButton:Remove()

    CurrentType = 0 
end

function PANEL:Paint()
	return true
end

function PANEL:OnCursorEntered()
	self.NameLabel:SetAlpha(230)

	CreateHoveredClassWindow(self.ClassTable)
end

function PANEL:OnCursorExited()
	self.NameLabel:SetAlpha(170)

	if HoveredClassWindow and HoveredClassWindow:IsValid() and HoveredClassWindow.ClassTable == self.ClassTable then
		HoveredClassWindow:Remove()
	end
end

function PANEL:Think()
	if not self.ClassTable then return end

	local enabled
	if MySelf:GetZombieClass() == self.ClassTable.Index then
		enabled = 2
	elseif self.ClassTable.Boss or gamemode.Call("IsClassUnlocked", self.ClassTable.Index) then
		enabled = 1
	else
		enabled = 0
	end

	if enabled ~= self.LastEnabledState then
		self.LastEnabledState = enabled

		if enabled == 2 then
			self.NameLabel:SetTextColor(COLOR_GREEN)
			self.Image:SetImageColor(self.ClassTable.IconColor or color_white)
			self.Image:SetAlpha(245)
		elseif enabled == 1 then
			self.NameLabel:SetTextColor(COLOR_GRAY)
			self.Image:SetImageColor(self.ClassTable.IconColor or color_white)
			self.Image:SetAlpha(245)
		else
			self.NameLabel:SetTextColor(COLOR_DARKRED)
			self.Image:SetImageColor(COLOR_DARKRED)
			self.Image:SetAlpha(170)
		end
	end
end

vgui.Register("ClassButton", PANEL, "Button")

PANEL = {}

function PANEL:Init()
	self.NameLabel = vgui.Create("DLabel", self)
	self.NameLabel:SetFont("ZSHUDFontSmaller")

	self.DescLabels = self.DescLabels or {}

	self:InvalidateLayout()
end

function PANEL:SetClassTable(classtable)
	self.ClassTable = classtable

	self.NameLabel:SetText(translate.Get(classtable.TranslationName))
	self.NameLabel:SizeToContents()

	self:CreateDescLabels()

	self:InvalidateLayout()
end

function PANEL:RemoveDescLabels()
	for _, label in pairs(self.DescLabels) do
		label:Remove()
	end

	self.DescLabels = {}
end

function PANEL:CreateDescLabels()
	self:RemoveDescLabels()

	self.DescLabels = {}

	local classtable = self.ClassTable
	if not classtable or not classtable.Description then return end

	local lines = {}

	if classtable.Wave and classtable.Wave > 0 then
		table.insert(lines, translate.Format("unlocked_on_wave_x", classtable.Wave))
	end

	if classtable.BetterVersion then
		local betterclasstable = GAMEMODE.ZombieClasses[classtable.BetterVersion]
		if betterclasstable then
			table.insert(lines, translate.Format("evolves_in_to_x_on_wave_y", translate.Get(betterclasstable.TranslationName) or betterclasstable.Name, betterclasstable.Wave))
		end
	end

	table.insert(lines, " ")
	table.Add(lines, string.Explode("\n", translate.Get(classtable.Description)))

	if classtable.Help then
		table.insert(lines, " ")
		table.Add(lines, string.Explode("\n", translate.Get(classtable.Help)))
	end

	for i, line in ipairs(lines) do
		local label = vgui.Create("DLabel", self)
		local notwaveone = classtable.Wave and classtable.Wave > 0

		label:SetText(line)
		if i == (notwaveone and 2 or 1) and classtable.BetterVersion then
			label:SetColor(COLOR_RORANGE)
		end
		label:SetFont(i == 1 and notwaveone and "ZSBodyTextFontBig" or "ZSBodyTextFont")
		label:SizeToContents()
		table.insert(self.DescLabels, label)
	end
end

function PANEL:PerformLayout()
	self.NameLabel:SizeToContents()
	self.NameLabel:CenterHorizontal()

	local maxw = self.NameLabel:GetWide()
	for _, label in pairs(self.DescLabels) do
		maxw = math.max(maxw, label:GetWide())
	end
	self:SetWide(maxw + 64)
	self:CenterHorizontal()

	for i, label in ipairs(self.DescLabels) do
		label:MoveBelow(self.DescLabels[i - 1] or self.NameLabel)
		label:CenterHorizontal()
	end

	local lastlabel = self.DescLabels[#self.DescLabels] or self.NameLabel
	local _, y = lastlabel:GetPos()
	self:SetTall(y + lastlabel:GetTall())
end

function PANEL:Think()
	if not WindowFirst or not WindowFirst:IsValid() or not WindowFirst:IsVisible() then
		self:Remove()
	end
end

function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Frame", self, w, h)

	return true
end

vgui.Register("ClassInfo", PANEL, "Panel")