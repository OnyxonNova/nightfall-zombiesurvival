local PANEL = {}

local matGlow = Material("sprites/glow04_noz")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
local colHealth = Color(0, 0, 0, 240)
local function ContentsPaint(self, w, h)
	local lp = MySelf
	if lp:IsValid() then
		local screenscale = BetterScreenScale()
		local health = math.max(lp:Health(), 0)
		local healthperc = math.Clamp(health / lp:GetMaxHealthEx(), 0, 1)
		local wid, hei = 360 * screenscale, 18 * screenscale

		local nightmarescare = lp:Team() == TEAM_HUMAN and lp:GetStatus("nightmarescare")
		local time = CurTime()

		colHealth.r = (1 - healthperc) * 180
		colHealth.g = healthperc * 180
		colHealth.b = 0

		local x = 14 * screenscale
		local y = 115 * screenscale

		if nightmarescare then
			health = math.floor(math.abs(math.sin(time * 0.65)) * math.Clamp(lp:Health() * 0.565, 0, 120))
			healthperc = math.abs(math.sin(time * 0.65)) * math.Clamp(lp:GetMaxHealthEx(), 0, 0.6)
			colHealth.g = (0.5 - healthperc) * 180
			colHealth.r = (healthperc) * 180
		end

		local subwidth = healthperc * wid
		
		draw.SimpleTextBlurry(health, "ZSHUDFont", x + wid + 12 * screenscale, y + (hei / 2) * screenscale, colHealth, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x, y, wid, hei)

		surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 160)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 2, y + 1, subwidth - 4, hei - 2)
		surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 30)
		surface.DrawRect(x + 2, y + 1, subwidth - 4, hei - 2)

		local g, b = 0, 0
		if lp:GetBarricadeGhosting() then
            b = 50 + 195 * math.abs(math.sin(CurTime() * 5))
            g = b / 2
			surface.SetDrawColor(0, g, b, 160)
			surface.DrawRect(x, y, wid, hei)
        end

		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + 2 + subwidth - 6, y + 1 - hei/2, 4, hei * 2)

		if lp:Team() == TEAM_HUMAN then
			local bloodarmor = lp:GetBloodArmor()
			if bloodarmor > 0 or nightmarescare then
				y = 142 * screenscale
				local wid, hei = 240 * screenscale, 14 * screenscale

				healthperc = math.Clamp(bloodarmor / (lp:GetMaxBloodArmor() or 10), 0, 1)
				colHealth.r = 50 + healthperc * 205
				colHealth.g = 0
				colHealth.b = (1 - healthperc) * 50

				if nightmarescare then
					bloodarmor = math.floor(math.abs(math.sin(time * 1.3)) * math.Clamp(lp:GetBloodArmor() * 0.8, 8, 100))
					healthperc = math.abs(math.sin(time * 1.3)) * math.Clamp(lp:GetMaxBloodArmor(), 0, 0.4)
					colHealth.r = 50 + (0.5 - healthperc) * 205
					colHealth.b = healthperc * 50
				end

				subwidth = healthperc * wid

				draw.SimpleTextBlurry(bloodarmor, "ZSHUDFontSmall", x + wid + 12 * screenscale, y + (hei / 2) * screenscale, colHealth, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

				surface.SetDrawColor(0, 0, 0, 230)
				surface.DrawRect(x, y, wid, hei)

				surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 160)
				surface.SetTexture(texDownEdge)
				surface.DrawTexturedRect(x + 2, y + 1, subwidth - 4, hei - 2)
				surface.SetDrawColor(colHealth.r * 0.5, colHealth.g * 0.5, colHealth.b, 30)
				surface.DrawRect(x + 2, y + 1, subwidth - 4, hei - 2)

				surface.SetMaterial(matGlow)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawTexturedRect(x + 2 + subwidth - 6, y + 1 - hei/2, 4, hei * 2)
			end
		end
	end
end

function PANEL:Init()
	self:DockMargin(0, 0, 0, 0)
	self:DockPadding(0, 0, 0, 0)

	local contents = vgui.Create("Panel", self)
    contents:Dock(FILL)
	contents.Paint = ContentsPaint

	self:ParentToHUD()
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()

	self:SetSize(screenscale * 575, screenscale * 168)

	self:AlignLeft()
	self:AlignBottom()
end

local matGradientLeft = CreateMaterial("gradient-l", "UnlitGeneric", {["$basetexture"] = "vgui/gradient-l", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1", ["$ignorez"] = "1", ["$nomip"] = "1"})
function PANEL:Paint(w, h)
	if GAMEMODE.HideShadowInterface then return true end

	local y = h * 0.6
	w = 575 * BetterScreenScale()
	h = h - y

	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawRect(0, y, w * 0.4, h + 1)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(w * 0.4, y, w * 0.6, h + 1)

	surface.SetDrawColor(0, 0, 0, 250)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(0, y, w, 1)

	return true
end

vgui.Register("ZSHealthArea", PANEL, "Panel")