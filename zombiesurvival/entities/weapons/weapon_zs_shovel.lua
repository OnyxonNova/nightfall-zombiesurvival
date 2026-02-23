AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Лопата"
SWEP.Description = "Без каких либо свойств, просто эффективное оружие ближнего боя."

if CLIENT then
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 1.363, -7.728), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.15, 1, -15), angle = Angle(-3, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 76
SWEP.MeleeRange = 71
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 230

SWEP.Primary.Delay = 1.3

SWEP.Tier = 2

SWEP.WalkSpeed = SPEED_SLOW

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true

local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Метла", "МетллллААААА!\nИмеет слабую отдачу и неплохую скорость атаки.", function(wept)
	wept.MeleeDamage = math.Round(wept.MeleeDamage * 0.88)
	wept.MeleeRange = math.Round(wept.MeleeRange * 0.975)
	wept.MeleeSize = 1.7
	wept.MeleeKnockBack = math.Round(wept.MeleeKnockBack * 0.39)

	wept.Primary.Delay = math.Round(wept.Primary.Delay * 0.8, 2)

	wept.VElements = {
		["base"] = { type = "Model", model = "models/props_c17/pushbroom.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 0.5, 8), angle = Angle(-65, -90, 90), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	wept.WElements = {
		["models/props_c17/pushbroom.mdl"] = { type = "Model", model = "models/props_c17/pushbroom.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.101, 1.656, 2.513), angle = Angle(-61.515, -36.894, 123.668), size = Vector(0.741, 0.741, 0.741), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	wept.WalkSpeed = SPEED_FAST

	wept.SwingRotation = Angle(0, 0, -90)
	wept.SwingOffset = Vector(10, -20, 10)

	function wept:PlayRevupSound()
		self:EmitSound("physics/wood/wood_plank_impact_soft3.wav", 75, math.random(100, 100), 1, CHAN_AUTO)
	end
	
	function wept:PlaySwingSound()
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 80, math.Rand(60, 65))
	end
	
	function wept:PlayHitSound()
		self:EmitSound("physics/wood/wood_plank_impact_hard"..math.random(4)..".wav", 75, math.random(75, 80))
	end
	
	function wept:PlayHitFleshSound()
		self:EmitSound("physics/wood/wood_plank_impact_hard"..math.random(4)..".wav", 75, math.random(75, 80))
	end
end)
branch.Killicon = "weapon_zs_pushbroom"
branch.Colors = {[0]=Color(255, 255, 255)}

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.09, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.06, 1)

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(30, 35), 1, CHAN_AUTO)
    
    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/shovel/shovel_hit-0"..math.random(4)..".ogg")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
