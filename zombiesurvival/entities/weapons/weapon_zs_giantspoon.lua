AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Гигантская Ложка"
SWEP.Description = "С виду обычная столовая ложка, только размером с весло лодки.\nИмеет увеличенный урон по голове."

if CLIENT then
	SWEP.ViewModelFOV = 60
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
	["models/props_phx/gears/bevel9.mdl++"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.615, 1.31, 15.538), angle = Angle(2.329, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.619, 1.317, -24.077), angle = Angle(0, 0, 0), size = Vector(0.07, 0.07, 0.897), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/bevel9.mdl+"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.66, 1.289, 14.704), angle = Angle(2.339, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.486, -0.23, -0.863), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2a.mdl"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(1.659, 1.264, -29.541), angle = Angle(-89.67, 0, 0), size = Vector(0.136, 0.094, 0.096), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/bevel9.mdl"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(2.609, 1.276, 13.902), angle = Angle(1.634, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2c.mdl"] = { type = "Model", model = "models/hunter/misc/shell2x2c.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(1.728, 1.241, -30.32), angle = Angle(-89, 0, 0), size = Vector(0.14, 0.089, 0.089), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2c.mdl+"] = { type = "Model", model = "models/hunter/misc/shell2x2c.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(1.605, 1.246, -29.757), angle = Angle(-89.513, 0, 0.158), size = Vector(0.136, 0.09, 0.093), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}
	SWEP.WElements = {
	["models/props_phx/gears/bevel9.mdl++"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.615, 1.31, 15.538), angle = Angle(2.329, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.619, 1.317, -24.077), angle = Angle(0, 0, 0), size = Vector(0.07, 0.07, 0.897), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/bevel9.mdl+"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.66, 1.289, 14.704), angle = Angle(2.339, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.631, -0.113, -6.93), angle = Angle(11.666, -2.557, -1.922), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2a.mdl"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.659, 1.264, -29.541), angle = Angle(-89.67, 0, 0), size = Vector(0.136, 0.094, 0.096), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/bevel9.mdl"] = { type = "Model", model = "models/props_phx/gears/bevel9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.609, 1.276, 13.902), angle = Angle(1.634, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2c.mdl"] = { type = "Model", model = "models/hunter/misc/shell2x2c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.728, 1.241, -30.32), angle = Angle(-89, 0, 0), size = Vector(0.14, 0.089, 0.089), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2c.mdl+"] = { type = "Model", model = "models/hunter/misc/shell2x2c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.605, 1.246, -29.757), angle = Angle(-89.513, 0, 0.158), size = Vector(0.136, 0.09, 0.093), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true
SWEP.NoDroppedWorldModel = true

SWEP.DamageType = DMG_CLUB

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 102
SWEP.MeleeRange = 76
SWEP.MeleeSize = 2.5
SWEP.Primary.Delay = 1.5

SWEP.HeadshotMulti = 1.25

SWEP.MeleeKnockBack = 170

SWEP.SwingTime = 0.85

SWEP.SwingRotation = Angle(0, 0, -50)
SWEP.SwingOffset = Vector(10, -20, 20)

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.Tier = 3

SWEP.AllowQualityWeapons = true
SWEP.Culinary = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1)

function SWEP:PlayRevupSound()
    self:EmitSound("physics/metal/weapon_impact_soft1.wav", 75, math.random(95, 115), 1)
    
    timer.Simple(0.07, function()
        if IsValid(self) then
            self:EmitSound("npc/roller/blade_in.wav", 75, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/frying_pan/pan_hit-0"..math.random(4)..".ogg", 75, math.random(90, 95))
end