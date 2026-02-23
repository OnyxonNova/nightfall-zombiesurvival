AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Арматура"
SWEP.Description = "Дезориентирует зомби при ударе."

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 65

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_debris/rebar004b_48.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.194, 2.111, -16.512), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_debris/rebar004b_48.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.244, 3.529, -15.808), angle = Angle(-3.796, 1.958, -4.97), size = Vector(0.8, 0.8, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 120
SWEP.MeleeRange = 70
SWEP.MeleeSize = 3
SWEP.MeleeKnockBack = 220

SWEP.Primary.Delay = 1.4

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.9
SWEP.SwingHoldType = "melee"

SWEP.Tier = 3

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.15)

function SWEP:PlayRevupSound()
    local sound = CreateSound(self, "physics/concrete/rock_scrape_rough_loop1.wav")

    sound:PlayEx(75, math.random(45, 55))

    timer.Simple(0.15, function()
        if sound then
            sound:Stop()
        end
    end)

    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(55, 65))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/concrete/concrete_break"..math.random(2,3)..".wav", 75, math.random(95, 105))
end