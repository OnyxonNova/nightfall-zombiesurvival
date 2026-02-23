INC_CLIENT()

DEFINE_BASECLASS("weapon_zs_baseproj")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 61

SWEP.HUD3DBone = "ValveBiped.square"
SWEP.HUD3DPos = Vector(1.1, 0, -2)
SWEP.HUD3DScale = 0.015

SWEP.WElements = {
	["base"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.5, 2, -3.701), angle = Angle(0, -90, -8), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.VElements = {
	["base"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(0, 0.5, 3), angle = Angle(0, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["2+"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -3, 0), angle = Angle(0, 90, 180), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.VMPos = Vector(0, -5.5, 2)

function SWEP:Draw2DHUD()
	self.BaseClass.Draw2DHUD(self)
	local owner = self:GetOwner()
	if not owner:IsSkillActive(SKILL_SMARTTARGETING) then return end

	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72

	local yy = ScrH() - hei * 2 - screenscale * 60

	local player = self:GetSeekedPlayer()
	local text = player:IsValidLivingHuman() and player:Name() or "Нет цели"

	local texthp = player:IsValidLivingHuman() and player:Name() and (player:Health().."/".. player:GetMaxHealth() .." ОЗ") or ""
	local healthfraction = player:IsValidLivingHuman() and player:Name() and math.max(player:Health() / player:GetMaxHealth(), 0) or 0
	local playercolor = 0.75 <= healthfraction and COLOR_LIMEGREEN or 0.5 <= healthfraction and COLOR_SCRATCHED or 0.25 <= healthfraction and COLOR_HURT or COLOR_CRITICAL

	local shield = player:IsValidLivingHuman() and player:Name() and player:GetStatus("medrifledefboost") or nil
	local strength = player:IsValidLivingHuman() and player:Name() and player:GetStatus("strengthdartboost") or nil
	if shield and shield:IsValid() and self.DefenceGun then
		local shieldtimer = math.max(shield:GetStartTime() + shield:GetDuration() - CurTime(), 0)
		draw.SimpleTextBlurry("(ЗАЩИТА - " .. math.Round(shieldtimer, 1) ..")", "ZSHUDFontSmallester", x + wid * 0.5, yy + hei - 110 * screenscale, Color(90, 120, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	if strength and strength:IsValid() and self.StrengthGun then
		local strengthtimer = math.max(strength:GetStartTime() + strength:GetDuration() - CurTime(), 0)
		draw.SimpleTextBlurry("(СИЛА - " .. math.Round(strengthtimer, 1) ..")", "ZSHUDFontSmallester", x + wid * 0.5, yy + hei - 110 * screenscale, Color(255, 60, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	draw.SimpleTextBlurry(player:IsValidLivingHuman() and player:Name() and texthp or "", "ZSHUDFont", x + wid * 0.5, yy + hei - 75 * screenscale, playercolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleTextBlurry(text,"ZSHUDFont", x + wid * 0.5, yy + hei * 0.45, text ~= "Нет цели" and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:Draw3DHUD(vm, pos, ang)
	self.BaseClass.Draw3DHUD(self,vm, pos, ang)
	local owner = self:GetOwner()
	if not owner:IsSkillActive(SKILL_SMARTTARGETING) then return end
	
	local wid, hei = 180, 64
	local x, y = wid * -0.5, hei * -1.2

	local player = self:GetSeekedPlayer()
	local text = player:IsValidLivingHuman() and player:Name() or "Нет цели"

	local texthp = player:IsValidLivingHuman() and player:Name() and (player:Health().."/".. player:GetMaxHealth() .." ОЗ") or ""
	local healthfraction = player:IsValidLivingHuman() and player:Name() and math.max(player:Health() / player:GetMaxHealth(), 0) or 0
	local playercolor = 0.75 <= healthfraction and COLOR_LIMEGREEN or 0.5 <= healthfraction and COLOR_SCRATCHED or 0.25 <= healthfraction and COLOR_HURT or COLOR_CRITICAL

	local shield = player:IsValidLivingHuman() and player:Name() and player:GetStatus("medrifledefboost") or nil
	local strength = player:IsValidLivingHuman() and player:Name() and player:GetStatus("strengthdartboost") or nil

	cam.Start3D2D(pos, ang, self.HUD3DScale)
		if shield and shield:IsValid() and self.DefenceGun then
			local shieldtimer = math.max(shield:GetStartTime() + shield:GetDuration() - CurTime(), 0)
			draw.SimpleTextBlurry("(ЗАЩИТА - " .. math.Round(shieldtimer, 1) ..")", "ZSHUDFontSmallerNSNon", x + wid * 0.5, y - hei * 1.7, Color(90, 120, 220), TEXT_ALIGN_CENTER)
		end
		if strength and strength:IsValid() and self.StrengthGun then
			local strengthtimer = math.max(strength:GetStartTime() + strength:GetDuration() - CurTime(), 0)
			draw.SimpleTextBlurry("(СИЛА - " .. math.Round(strengthtimer, 1) ..")", "ZSHUDFontSmallerNSNon", x + wid * 0.5, y - hei * 1.7, Color(255, 60, 50), TEXT_ALIGN_CENTER)
		end
		draw.SimpleTextBlurry(player:IsValidLivingHuman() and player:Name() and texthp or "", "ZSHUDFontNormalNSNon", x + wid * 0.5, y - hei * 1.2, playercolor, TEXT_ALIGN_CENTER)
		draw.SimpleTextBlurry(text, "ZSHUDFontBigNSNon", x + wid * 0.5, y - hei * 0.5, text ~= "Нет цели" and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end