INC_CLIENT()

DEFINE_BASECLASS("weapon_zs_baseproj")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 65
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.IronsightsMultiplier = 0.25
SWEP.HUD3DBone = "v_weapon.scout_Parent"
SWEP.HUD3DPos = Vector(-1, -3.35, -5)
SWEP.HUD3DAng = Angle(0, 0, 0)
SWEP.HUD3DScale = 0.017

SWEP.IronSightsPos = Vector(5.015, -8, 2.52)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VMPos = Vector(-1, -5, 1.5)

SWEP.VElements = {
	["body2"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.431, 0, 7.743), angle = Angle(-180, 90, 0), size = Vector(0.541, 0.736, 1.307), color = Color(85, 120, 195, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-1.833, 0, 11.97), angle = Angle(90, 0, 0), size = Vector(0.717, 0.061, 0.061), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body3"] = { type = "Model", model = "models/props_trainstation/train001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.57, 0, -5.768), angle = Angle(0, 90, 90), size = Vector(0.009, 0.016, 0.012), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["scope"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "v_weapon.scout_Parent", rel = "", pos = Vector(0, -5.212, -11.976), angle = Angle(0, 90, 180), size = Vector(0.368, 0.616, 0.603), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body4"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-5.567, 0, -7.106), angle = Angle(-90, 0, 0), size = Vector(0.009, 0.014, 0.01), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-2.309, 0, 0.996), angle = Angle(-90, 0, 0), size = Vector(3.167, 0.043, 0.061), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body5"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(-3.738, 0, 5.004), angle = Angle(0, -90, -90), size = Vector(0.096, 0.284, 0.081), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["stuff"] = { type = "Model", model = "models/props_c17/FurnitureDrawer001a_Chunk05.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "scope", pos = Vector(0.041, 0, -5.003), angle = Angle(90, 0, 0), size = Vector(0.05, 0.035, 0.05), color = Color(255, 255, 195, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["body2"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.922, 0, 15.505), angle = Angle(-180, 90, 0), size = Vector(0.582, 0.805, 1.307), color = Color(85, 120, 195, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["body3"] = { type = "Model", model = "models/props_trainstation/train001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.491, 0, -2.517), angle = Angle(0, 90, 90), size = Vector(0.009, 0.016, 0.012), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["barrel"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.411, 0, 16.427), angle = Angle(90, 0, 0), size = Vector(0.99, 0.061, 0.061), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["scope"] = { type = "Model", model = "models/props_combine/breenlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.253, 0.721, -7.623), angle = Angle(-100, 0, 0), size = Vector(0.433, 0.616, 0.755), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body4"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-6.316, 0, -2.192), angle = Angle(-90, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-2.75, 0, 8.814), angle = Angle(-90, 0, 0), size = Vector(3.167, 0.043, 0.065), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["body5"] = { type = "Model", model = "models/props_combine/breenconsole.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(-3.738, 0, 12.616), angle = Angle(0, -90, -90), size = Vector(0.096, 0.419, 0.093), color = Color(85, 120, 195, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["stuff"] = { type = "Model", model = "models/props_c17/FurnitureDrawer001a_Chunk05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "scope", pos = Vector(0.046, 0, -6.447), angle = Angle(90, 0, 0), size = Vector(0.05, 0.035, 0.061), color = Color(255, 255, 195, 255), surpresslightning = false, material = "models/props_combine/masterinterface_alert", skin = 0, bodygroup = {} }
}

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:GetViewModelPosition(pos, ang)
	if GAMEMODE.DisableScopes then return end

	if self:IsScoped() then
		return pos + ang:Up() * 256, ang
	end

	return BaseClass.GetViewModelPosition(self, pos, ang)
end

function SWEP:DrawHUDBackground()
	if GAMEMODE.DisableScopes then return end

	if self:IsScoped() then
		self:DrawFuturisticScope()
	end
end

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
	draw.SimpleTextBlurry(text, "ZSHUDFont", x + wid * 0.5, yy + hei * 0.45, text ~= "Нет цели" and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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