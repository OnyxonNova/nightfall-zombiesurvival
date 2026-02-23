AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Лампа"

if CLIENT then
	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_interiors/Furniture_Lamp01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.85, -8), angle = Angle(183, 0, 2), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_interiors/Furniture_Lamp01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.837, 1.638, -10), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_interiors/Furniture_Lamp01a.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.MeleeDamage = 58
SWEP.MeleeRange = 68
SWEP.MeleeSize = 2
SWEP.MeleeKnockBack = 150
SWEP.Primary.Delay = 1.2

SWEP.WalkSpeed = SPEED_SLOW

SWEP.SwingRotation = Angle(0, 0, -90)
SWEP.SwingOffset = Vector(10, -20, 10)
SWEP.SwingTime = 0.65
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true
SWEP.DismantleDiv = 3.05

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1)

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 50), 1)
    
    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 80, math.Rand(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_solid_impact_hard"..math.random(4, 5)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
