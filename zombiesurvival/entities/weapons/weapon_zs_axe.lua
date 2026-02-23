AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Топор"
SWEP.Description = "Простой топор со сбалансированными характеристиками в плане урона, дальности и скорости удара."

if CLIENT then
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.UseHands = true

	SWEP.VElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.299, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 2, -4), angle = Angle(0, -20, 80), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-0.2, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.332, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.2, 0), angle = Angle(0, 0, 0) }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 60
SWEP.MeleeRange = 57
SWEP.MeleeSize = 2
SWEP.MeleeKnockBack = 155
SWEP.Primary.Delay = 1.25

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.SwingTime = 0.75
SWEP.SwingRotation = Angle(0, 0, -90)
SWEP.SwingOffset = Vector(10, -20, 10)
SWEP.SwingHoldType = "melee"

SWEP.HitDecal = "Manhackcut"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.02, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_RANGE, 2)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_KNOCK, 8, 1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Кирка", "Тяжёлая кирка без каких-либо свойств, кроме большой задержки удара и приличного урона.", function(wept)
	wept.WalkSpeed = SPEED_SLOW
	wept.SwingTime = math.Round(wept.SwingTime * 1.2, 2)
	wept.MeleeDamage = math.Round(wept.MeleeDamage * 1.175)
	wept.MeleeRange = math.Round(wept.MeleeRange * 1.08)
	wept.MeleeSize = wept.MeleeSize * 1.5
	wept.MeleeKnockBack = math.Round(wept.MeleeKnockBack * 1.1)
	wept.Primary.Delay = math.Round(wept.Primary.Delay * 1.125, 2)

	wept.VElements = {
		["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, -7.421), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(-5.5780000686646, 0.52799999713898, -13.795999526978), angle = Angle(1.12399995327, -10.767999649048, 88.793998718262), size = Vector(0.75400000810623, 0.19499999284744, 0.30000001192093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(4.2620000839233, 2.4389998912811, -14.293000221252), angle = Angle(5.6449999809265, -12.793000221252, -1.2630000114441), size = Vector(0.027000000700355, 0.01799999922514, 1.0329999923706), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(1.2949999570847, 0.85399997234344, 19.750999450684), angle = Angle(5.6449999809265, -12.793000221252, -1.2630000114441), size = Vector(0.024000000208616, 0.014000000432134, 1.0329999923706), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(4.3660001754761, 2.5520000457764, -15.845999717712), angle = Angle(5.3649997711182, -11.880999565125, -1.6660000085831), size = Vector(0.025000000372529, 0.014999999664724, 0.391999989748), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(9.8850002288818, 3.3980000019073, -15.298000335693), angle = Angle(-174.72799682617, -8.6429996490479, -178.32299804688), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl+"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(9.7399997711182, 3.9630000591278, -15.288999557495), angle = Angle(-174.41799926758, -16.089000701904, -180), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl++"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "basemelee", pos = Vector(9.8970003128052, 3.0469999313354, -15.282999992371), angle = Angle(-174.62300109863, -5.2550001144409, -178.04600524902), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
	
	wept.WElements = {
		["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.1369999647141, -0.19499999284744, -11.319000244141), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-5.5780000686646, 0.52799999713898, -13.795999526978), angle = Angle(1.12399995327, -10.767999649048, 88.793998718262), size = Vector(0.75400000810623, 0.19499999284744, 0.30000001192093), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(4.2620000839233, 2.4389998912811, -14.293000221252), angle = Angle(5.6449999809265, -12.793000221252, -1.2630000114441), size = Vector(0.027000000700355, 0.019999999552965, 1.0329999923706), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.2949999570847, 0.85399997234344, 19.750999450684), angle = Angle(5.6449999809265, -12.793000221252, -1.2630000114441), size = Vector(0.024000000208616, 0.016000000759959, 1.0329999923706), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(4.3660001754761, 2.5520000457764, -15.845999717712), angle = Angle(5.3649997711182, -11.880999565125, -1.6660000085831), size = Vector(0.025000000372529, 0.017000000923872, 0.391999989748), color = Color(109, 109, 109, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(9.8850002288818, 3.3980000019073, -15.298000335693), angle = Angle(-174.72799682617, -8.6429996490479, -178.32299804688), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl+"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(9.7399997711182, 3.9630000591278, -15.288999557495), angle = Angle(-174.41799926758, -16.089000701904, -180), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_phx/misc/small_ramp.mdl++"] = { type = "Model", model = "models/props_phx/misc/small_ramp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(9.8970003128052, 3.0469999313354, -15.282999992371), angle = Angle(-174.62300109863, -5.2550001144409, -178.04600524902), size = Vector(0.014999999664724, 0.0049999998882413, 0.0099999997764826), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} }
	}
end)
branch.Killicon = "weapon_zs_pickaxe"
branch.Colors = {[0]=Color(255, 255, 255)}

local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "Циркулярная Пила", "Ловкая пила которая легко разрубает зомби надвое!", function(wept)
	wept.MeleeDamage = math.Round(wept.MeleeDamage * 0.6725)
	wept.MeleeRange = math.Round(wept.MeleeRange * 1.03)
	wept.MeleeKnockBack = math.Round(wept.MeleeKnockBack * 0.8)
	wept.MeleeViewPunchScale = 0.25

	wept.Primary.Delay = math.Round(wept.Primary.Delay / 2, 2)

	wept.SwingTime = wept.SwingTime / 5
	wept.SwingRotation = Angle(0, -35, -50)
	wept.SwingOffset = Vector(10, 0, 0)
	wept.SwingHoldType = "melee2"

	wept.HitAnim = ACT_VM_MISSCENTER

	wept.NoHitSoundFlesh = true

	wept.WalkSpeed = SPEED_FAST

	wept.VElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.184, 1.501, -7.421), angle = Angle(2.427, -10, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 90, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} }
	}

	wept.WElements = {
		["axe"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.023, 2.147, -8.32), angle = Angle(-6.166, 20.881, 86.675), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["saw2"] = { type = "Model", model = "models/XQM/Rails/trackball_1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, 0), angle = Angle(0, 90, 0), size = Vector(0.234, 0.234, 0.133), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_lab/door_klab01", skin = 0, bodygroup = {} },
		["saw"] = { type = "Model", model = "models/props_junk/sawblade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "axe", pos = Vector(0, 14, -0.021), angle = Angle(0, 0, 0), size = Vector(0.449, 0.449, 0.805), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	function wept:PlayRevupSound()
    	self:EmitSound("npc/roller/blade_in.wav", 95, math.random(95, 115), 0.75)
    
    	timer.Simple(0.2, function()
        	if IsValid(self) then
            	self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        	end
    	end)
	end

	function wept:PlaySwingSound()
		self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(75, 80))
	end

	function wept:PlayHitSound()
		self:EmitSound("npc/manhack/grind"..math.random(5)..".wav")
	end

	function wept:PlayHitFleshSound()
		self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav")
	end

	function wept:OnMeleeHit(hitent, hitflesh, tr)
		if not hitflesh then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetMagnitude(2)
				effectdata:SetScale(1)
			util.Effect("sparks", effectdata)
		end
	end
end)	
branch.Killicon = "weapon_zs_sawhack"
branch.Colors = {[0]=Color(255, 255, 255)}

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/golf club/golf_hit-0"..math.random(4)..".ogg")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 50), 1)
    
    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end