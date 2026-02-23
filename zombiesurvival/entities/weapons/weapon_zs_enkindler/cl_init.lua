INC_CLIENT()

SWEP.ViewModelFlip = false

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.HUD3DPos = Vector(4, 0, 15)
SWEP.HUD3DAng = Angle(0, 180, 180)
SWEP.HUD3DScale = 0.04
SWEP.HUD3DBone = "base"

SWEP.VElements = {
	["base++++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "base", rel = "base", pos = Vector(16, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "base", rel = "base", pos = Vector(22, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base++++++"] = { type = "Model", model = "models/props_junk/propane_tank001a.mdl", bone = "base", rel = "base", pos = Vector(33.765, 9, -4.676), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/weapons/c_shotgun.mdl", bone = "base", rel = "", pos = Vector(8, -4.5, -21), angle = Angle(90, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+++++++"] = { type = "Model", model = "models/props_junk/popcan01a.mdl", bone = "base", rel = "base", pos = Vector(30.649, 8.5, -9.87), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "base", rel = "base", pos = Vector(36, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "base", rel = "base", pos = Vector(42, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["base+++++"] = { type = "Model", model = "models/weapons/w_shotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(34.805, 9, -9), angle = Angle(-7, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(22, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base++++++"] = { type = "Model", model = "models/props_junk/propane_tank001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(33.765, 9, -4.676), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
	["base++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(42, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_junk/popcan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-16.5, 8.5, -11), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+++++++"] = { type = "Model", model = "models/props_junk/popcan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(30.649, 8.5, -9.87), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(36, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base++++"] = { type = "Model", model = "models/props_lab/rotato.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(16, 9, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:DrawHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72

	local yy = ScrH() - hei * 2 - screenscale * 60

	local c = 0
	if not self.NextMineCheckTime or self.NextMineCheckTime < CurTime() then
		for _, ent in pairs(ents.FindByClass("projectile_impactmine_kin")) do
			if (CLIENT or ent.CreateTime + 300 > CurTime()) and ent:GetOwner() == self:GetOwner() then
				c = c + 1
			end
		end
		self.CachedMines = c
		self.NextMineCheckTime = CurTime() + 1
	else
		c = self.CachedMines
	end

	local chargetxt = "Мины: " .. c .. " / " .. self.MaxMines

	if GAMEMODE:ShouldDraw2DWeaponHUD() then
		draw.SimpleTextBlurry(chargetxt, "ZSHUDFont", x + wid * 0.5, yy + hei * 0.45, COLOR_CYAN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		self.BaseClass.Draw2DHUD(self)
	end
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local owner = self:GetOwner()
	
	local wid, hei = 180, 64
	local x, y = wid * -0.5, hei * -1.2

	local c = 0
	if not self.NextMineCheckTime or self.NextMineCheckTime < CurTime() then
		for _, ent in pairs(ents.FindByClass("projectile_impactmine_kin")) do
			if (CLIENT or ent.CreateTime + 300 > CurTime()) and ent:GetOwner() == self:GetOwner() then
				c = c + 1
			end
		end
		self.CachedMines = c
		self.NextMineCheckTime = CurTime() + 1
	else
		c = self.CachedMines
	end

	local chargetxt = "Мины: " .. c .. " / " .. self.MaxMines

	cam.Start3D2D(pos, ang, self.HUD3DScale)
		draw.SimpleTextBlurry(chargetxt, "ZSHUDFontBigNSNon", x + wid * 0.5, y - hei * 0.5, COLOR_CYAN, TEXT_ALIGN_CENTER)
	cam.End3D2D()

	self.BaseClass.Draw3DHUD(self,vm, pos, ang)
end