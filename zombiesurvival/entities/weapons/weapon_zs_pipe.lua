AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Свинцовая Труба"
SWEP.Description = "Вес свинцовой трубы обладает достаточной силой, чтобы поразить цель, но имеет более низкую скорость удара."

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.2, 1, -2.274), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.599, 1, -6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_canal/mattpipe.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 58
SWEP.MeleeRange = 53
SWEP.MeleeSize = 1.45
SWEP.MeleeKnockBack = 185

SWEP.Primary.Delay = 1.25

SWEP.UseMelee1 = true

SWEP.WalkSpeed = SPEED_FAST

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingTime = 0.7
SWEP.SwingHoldType = "grenade"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.12)

function SWEP:PlayRevupSound()
    self:EmitSound("physics/metal/weapon_impact_soft1.wav", 75, math.random(100, 100), 1, CHAN_AUTO)
    self:EmitSound("physics/metal/metal_canister_impact_soft3.wav", 75, math.random(125, 155), 0.75, CHAN_AUTO)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(55, 65))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.random(115, 125))
end