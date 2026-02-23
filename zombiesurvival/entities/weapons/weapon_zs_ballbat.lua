AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Бейсбольная бита"
SWEP.Description = "Лёгкое оружие которое отлично подбрасывает зомби в воздух!"

if CLIENT then
	SWEP.ViewModelFOV = 70

	SWEP.ViewModelFlip = false
	SWEP.UseHands = true
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.167, -0.51, -0.557), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.312, 1.748, -3.386), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl++++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.325, 1.748, 1.69), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.115), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.319, 1.761, -2.757), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_dome360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_dome360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.299, 1.72, -27.39), angle = Angle(180, 0, 0), size = Vector(0.028, 0.028, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/props_phx/games/chess/white_dama.mdl"] = { type = "Model", model = "models/props_phx/games/chess/white_dama.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.331, 1.754, 7.798), angle = Angle(0.194, 1.995, -178.461), size = Vector(0.1, 0.1, 0.521), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl+++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.325, 1.748, -1.418), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.065), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.319, 1.761, -2.118), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_junk/GlassBottle01a.mdl"] = { type = "Model", model = "models/props_junk/GlassBottle01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.316, 1.705, -9.785), angle = Angle(0, 0, 0), size = Vector(0.833, 0.833, 2.717), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.165, -0.666, -0.653), angle = Angle(7.617, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.312, 1.748, -3.386), angle = Angle(0, 0, 0), size = Vector(0.014, 0.016, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl++++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.325, 1.748, 1.69), angle = Angle(0, 0, 0), size = Vector(0.014, 0.016, 0.115), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.319, 1.761, -2.757), angle = Angle(0, 0, 0), size = Vector(0.014, 0.016, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_dome360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_dome360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.309, 1.707, -27.3), angle = Angle(180, -72.726, 0), size = Vector(0.029, 0.029, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/props_phx/games/chess/white_dama.mdl"] = { type = "Model", model = "models/props_phx/games/chess/white_dama.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.331, 1.754, 7.798), angle = Angle(0.194, 1.995, -178.461), size = Vector(0.1, 0.1, 0.521), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl+++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.325, 1.748, -1.418), angle = Angle(0, 0, 0), size = Vector(0.014, 0.016, 0.065), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_phx/construct/metal_plate_curve360.mdl++"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.319, 1.761, -2.118), angle = Angle(0, 0, 0), size = Vector(0.014, 0.016, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs03", skin = 0, bodygroup = {} },
	["models/props_junk/GlassBottle01a.mdl"] = { type = "Model", model = "models/props_junk/GlassBottle01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.316, 1.705, -9.785), angle = Angle(0, 0, 0), size = Vector(0.833, 0.833, 2.717), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} }
}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.MeleeDamage = 60
SWEP.MeleeRange = 75
SWEP.MeleeSize = 1.25
SWEP.MeleeKnockBack = 200

SWEP.Primary.Delay = 1.05

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingRotation = Angle(50, 0, -70)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.75
SWEP.Tier = 2

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.14)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Крокет", "Лишен отдачи и долгий замах, но наносит приличный урон и повреждает ноги", function(wept)
	wept.SwingTime = wept.SwingTime * 1.4
	wept.Primary.Delay = wept.Primary.Delay * 1.115

	wept.MeleeDamage = wept.MeleeDamage * 1.2
	wept.MeleeKnockBack = 0
	wept.WalkSpeed = SPEED_NORMAL

	wept.MeleeSize = wept.MeleeSize * 1.35

	wept.LegDamage = 20

	wept.HoldType = "melee2"

	wept.VElements = {
	["models/props_phx/construct/metal_dome360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_dome360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(-1.201, 1.258, -19.8), angle = Angle(92.327, 0, 0), size = Vector(0.039, 0.041, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.951, 1.384, -14.926), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.061, -0.164, -0.424), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl11+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.951, 1.384, -3.155), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 10), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.951, 1.384, -16.865), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(0, 31, 127, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.951, 1.384, -9.377), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(3.24, 1.269, -19.614), angle = Angle(87.295, 180, 0), size = Vector(0.039, 0.039, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} }
}

	wept.WElements = {
	["models/props_phx/construct/metal_dome360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_dome360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-1.247, 1.259, -19.9), angle = Angle(92.327, 0, 0), size = Vector(0.039, 0.039, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.384, -14.938), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.386, -0.172, -0.424), angle = Angle(1.703, 0, -3.685), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl11+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.384, -3.155), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 10), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.384, -16.865), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(0, 31, 127, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl1+++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.384, -9.377), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.25), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.24, 1.269, -19.696), angle = Angle(87.295, 180, 0), size = Vector(0.039, 0.039, 3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} }
}

	function wept:PlayHitSound()
		self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(115, 120))
	end
end)
branch.Killicon = "weapon_zs_kroket"
branch.NewNames = {[0]="Крокет"}
branch.Colors = {[0]=Color(255, 255, 255)}

function SWEP:PlayRevupSound()
    self:EmitSound("physics/wood/wood_plank_impact_soft"..math.random(1, 3)..".wav")
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(45, 55), 0.75, CHAN_AUTO)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 75, math.random(80,90))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/wood/wood_plank_impact_hard"..math.random(5)..".wav", 75, math.random(80,90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_impact_bullet"..math.random(5)..".wav", 75, math.random(80,90))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() then
		hitent:AddLegDamageExt(self.LegDamage or 0, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end