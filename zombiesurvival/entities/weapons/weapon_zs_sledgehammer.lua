AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Кувалда"
SWEP.Description = "Тяжелое, но мощное холодное оружие. Имеет значительное отбрасывание."

if CLIENT then
	SWEP.ViewModelFOV = 65
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.UseHands = true
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 83
SWEP.MeleeRange = 70
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 200

SWEP.Primary.Delay = 1.35

SWEP.Tier = 2

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 1
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Отбивной Молот", "Имеет неплохую скорость атаки и уменьшенный вес, но меньше урон и дальность атаки", function(wept)
	wept.ShowWorldModel = false

	wept.WalkSpeed = SPEED_SLOW

	wept.SwingTime = wept.SwingTime * 0.85
	wept.Primary.Delay = wept.Primary.Delay * 0.925

	wept.MeleeRange = wept.MeleeRange * 0.95
	wept.MeleeSize = wept.MeleeSize * 1.5
	wept.MeleeKnockBack = wept.MeleeKnockBack * 1.2

	wept.MeleeDamage = wept.MeleeDamage	* 0.9

	wept.Culinary = true

	wept.VElements = {
		["spikes2"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.051, -5.915, -0.113), angle = Angle(0, 0, -90), size = Vector(0.076, 1.013, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes2+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.047, 5.934, 0.104), angle = Angle(0, 0, 90), size = Vector(0.076, 1.013, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["sledgetop"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.466, 2.184, -22.969), angle = Angle(0, 90, -5.652), size = Vector(0.196, 0.326, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.087, -5.854, 0), angle = Angle(-90, 90, 0), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "sledgetop", pos = Vector(-0.04, 5.888, 0), angle = Angle(90, 90, 0), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} }
	}
	wept.WElements = {
		["top"] = { type = "Model", model = "models/props_junk/cardboard_box001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(0, 0, 35.433), angle = Angle(90, 90, 0), size = Vector(0.196, 0.305, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes1++"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(-5.422, -0.069, 35.549), angle = Angle(0, -90, 90), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes1+++"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(5.407, -0.069, 35.538), angle = Angle(0, 90, 90), size = Vector(0.059, 0.95, 0.374), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes1"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(-5.487, 0, 35.361), angle = Angle(90, -90, 90), size = Vector(0.076, 1.011, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["spikes1+"] = { type = "Model", model = "models/props_phx/mechanics/slider1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(5.535, 0.126, 35.361), angle = Angle(90, 90, 90), size = Vector(0.076, 1.011, 0.356), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["sledge"] = { type = "Model", model = "models/weapons/w_sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.203, 1.284, 4.852), angle = Angle(180, 0, 0), size = Vector(0.759, 1.2, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	function wept:PlaySwingSound()
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(25, 35))
	end

	function wept:PlayHitSound()
		self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(70, 74))
	end

	function wept:PlayHitFleshSound()
		self:EmitSound("physics/flesh/flesh_impact_hard"..math.random(2, 3)..".wav", 75, math.Rand(80, 84))
	end
end)
branch.Killicon = "weapon_zs_meattenderizer"
branch.NewNames = {[0]="Отбивной Молот"}
branch.Colors = {[0]=Color(255, 255, 255)}

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(15, 25), 1)
    
    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end
