INC_CLIENT()

SWEP.ViewModelFlip = false

SWEP.HUD3DPos = Vector(4, -1, 15)
SWEP.HUD3DAng = Angle(0, 180, 180)
SWEP.HUD3DScale = 0.04
SWEP.HUD3DBone = "base"

function SWEP:DrawHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72

	local yy = ScrH() - hei * 2 - screenscale * 60

	local c = 0
	if not self.NextMineCheckTime or self.NextMineCheckTime < CurTime() then
		for _, ent in pairs(ents.FindByClass("projectile_impactmine")) do
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
		for _, ent in pairs(ents.FindByClass("projectile_impactmine")) do
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