AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "'Заряд' Импульсный Молот"
SWEP.Description = "Нанеся достаточное количество ударов по зомби сможет создать импульсный взрыв который им нанесёт дополнительный урон!"

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["models/props_combine/breenpod.mdl+"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(1.789, 0.982, -21.185), angle = Angle(89.811, -16.959, 180), size = Vector(0.145, 0.143, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basegolovka"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.371, -0.463, -15.935), angle = Angle(1.621, -5.353, 0.358), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/combine_rifle_ammo01.mdl+"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-6.935, -2.668, -20.878), angle = Angle(94.802, -20.671, 180), size = Vector(1.12, 0.712, 1.12), color = Color(0, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/combine_rifle_ammo01.mdl"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(16.503, 6.21, -18.983), angle = Angle(94.802, -20.671, 0), size = Vector(1.12, 0.763, 1.12), color = Color(0, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1x1solid.mdl++1++"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-6.934, -5.426, -15.389), angle = Angle(-81.969, -13.054, 97.456), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1x1solid.mdl++1+"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-5.587, -5.219, -26.025), angle = Angle(6.451, -20.344, 91.819), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
	["models/props_trainstation/trainstation_column001.mdl"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(4.889, 2.14, -23.286), angle = Angle(5.397, -23.847, 1.394), size = Vector(0.194, 0.142, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["basehandle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.093, -0.285, -10.964), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_combine/combine_intwallunit.mdl"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(4.655, 3.484, -19.828), angle = Angle(168.445, 70.226, -84.718), size = Vector(0.412, 0.164, 0.19), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1x1solid.mdl"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(16.135, 8.611, -23.904), angle = Angle(-175.75, -20.16, -93.779), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
	["models/props_combine/breenpod.mdl"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(7.883, 2.838, -20.409), angle = Angle(102.166, -15.896, -2.895), size = Vector(0.145, 0.143, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1x1solid.mdl+"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(17.025, 3.943, -12.875), angle = Angle(-176.258, -19.972, 86.29), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
	["models/props_combine/combine_intwallunit.mdl+"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(5.07, 0.314, -20.174), angle = Angle(172.58, -111.429, -95.594), size = Vector(0.412, 0.164, 0.19), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0.239, 1.371, 26.42), angle = Angle(6.51, -25.008, -90.487), size = Vector(0.1, 0.115, 0.068), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.777, 0.429, 9.675), angle = Angle(-14.712, 23.416, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

	SWEP.WElements = {
		["models/props_combine/breenpod.mdl+"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(1.789, 0.982, -21.185), angle = Angle(89.811, -16.959, 180), size = Vector(0.145, 0.143, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basegolovka"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.336, -0.12, -0.047), angle = Angle(1.621, -5.353, 0.358), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/Items/combine_rifle_ammo01.mdl+"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-6.935, -2.668, -20.878), angle = Angle(94.802, -20.671, 180), size = Vector(1.12, 0.712, 1.12), color = Color(0, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/Items/combine_rifle_ammo01.mdl"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(16.503, 6.21, -18.983), angle = Angle(94.802, -20.671, 0), size = Vector(1.12, 0.763, 1.12), color = Color(0, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/phxtended/tri1x1x1solid.mdl++1++"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-6.934, -5.426, -15.389), angle = Angle(-81.969, -13.054, 97.456), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/phxtended/tri1x1x1solid.mdl++1+"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(-5.587, -5.219, -26.025), angle = Angle(6.451, -20.344, 91.819), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/props_trainstation/trainstation_column001.mdl"] = { type = "Model", model = "models/props_trainstation/trainstation_column001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(4.889, 2.14, -23.286), angle = Angle(5.397, -23.847, 1.394), size = Vector(0.194, 0.142, 0.194), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["basehandle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_intwallunit.mdl"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(4.655, 3.484, -19.828), angle = Angle(168.445, 70.226, -84.718), size = Vector(0.412, 0.164, 0.19), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/phxtended/tri1x1x1solid.mdl"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(16.135, 8.611, -23.904), angle = Angle(-175.75, -20.16, -93.779), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/props_combine/breenpod.mdl"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(7.883, 2.838, -20.409), angle = Angle(102.166, -15.896, -2.895), size = Vector(0.145, 0.143, 0.093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/phxtended/tri1x1x1solid.mdl+"] = { type = "Model", model = "models/phxtended/tri1x1x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(17.025, 3.943, -12.875), angle = Angle(-176.258, -19.972, 86.29), size = Vector(0.114, 0.114, 0.114), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/props_combine/combine_intwallunit.mdl+"] = { type = "Model", model = "models/props_combine/combine_intwallunit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basegolovka", pos = Vector(4.975, 0.216, -20.071), angle = Angle(172.58, -111.429, -95.594), size = Vector(0.412, 0.164, 0.19), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0.239, 1.371, 26.42), angle = Angle(6.51, -25.008, -90.487), size = Vector(0.1, 0.115, 0.068), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.256, 1.93, -16.81), angle = Angle(1.3, -0.556, -8.358), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 143
SWEP.MeleeRange = 75
SWEP.MeleeSize = 4
SWEP.MeleeKnockBack = 250

SWEP.Primary.Delay = 1.45

SWEP.LegDamage = 26

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.9
SWEP.SwingHoldType = "melee"

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.IsImpulseHammer = true

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.10)

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/stunstick/spark"..math.random(1, 3)..".wav", 75, math.Rand(55, 75))
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(30, 40))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(76, 80))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(76, 80))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() then
		hitent:AddLegDamageExt(self.LegDamage, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end