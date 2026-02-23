CLASS.Base = "boss_nightmare"

CLASS.Name = "Ancient Nightmare"
CLASS.TranslationName = "class_ancient_nightmare"
CLASS.Description = "description_ancient_nightmare"
CLASS.Help = "controls_ancient_nightmare"

CLASS.Boss = true
CLASS.ClassType = 1

CLASS.KnockbackScale = 0

CLASS.Health = 3000
CLASS.HealthPerWave = 100
CLASS.HealthPerHuman = 95
CLASS.Speed = 160

CLASS.Points = 60

CLASS.SWEP = "weapon_zs_anightmare"

CLASS.Model = Model("models/player/skeleton.mdl")
CLASS.OverrideModel = false

CLASS.BloodColor = BLOOD_COLOR_MECH

CLASS.Skeletal = true

local math_random = math.random

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if math_random(2) == 1 then
		pl:EmitSound("npc/barnacle/neck_snap1.wav", 65, math_random(65, 80), 0.27)
	else
		pl:EmitSound("npc/barnacle/neck_snap2.wav", 65, math_random(65, 80), 0.27)
	end

	return true
end

function CLASS:PlayPainSound(pl)
    pl:EmitSound("npc/crow/pain2.wav", 100, math_random(12, 15))
    pl:EmitSound("npc/headcrab/headbite.wav", 100, math_random(135, 145))
    pl.NextPainSound = CurTime() + 0.5
    return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(55, 70))
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(80, 90))
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(100, 120))

	return true
end

function CLASS:PlayDeathSound(pl)
    pl:EmitSound("ambient/machines/slicer4.wav", 100, math_random(12, 15))
    pl:EmitSound("ambient/machines/slicer3.wav", 100, math_random(24, 30))
    pl:EmitSound("ambient/machines/teleport1.wav", 100, math_random(75, 85))
    pl:EmitSound("ambient/machines/teleport4.wav", 100, math_random(145, 165))
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(55, 70))
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(80, 90))
	pl:EmitSound("zombiesurvival/warp4.ogg", 100, math_random(100, 120))

    return true
end

if SERVER then
	function CLASS:ProcessDamage(pl, dmginfo)
		if dmginfo:GetInflictor().IsMelee then
			dmginfo:SetDamage(dmginfo:GetDamage() / 1.55)
		end
	end
end

function CLASS:OnSpawned(pl)
    if SERVER then
        pl:CreateAmbience("ancientambience")
    end
end

local function DoExplode(pl, pos, magnitude, dmginfo)
	local inflictor = pl:GetActiveWeapon()
	if not inflictor:IsValid() then inflictor = pl end

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetMagnitude(magnitude)
	util.Effect("explosion_nightmare", effectdata, true)
end

function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
	local magnitude = 1
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.GetCharge then magnitude = wep:GetCharge() end

	if suicide and magnitude < 1 then return end
	magnitude = 0.25 + magnitude * 0.75

	local pos = pl:WorldSpaceCenter()

	timer.Simple(0, function() DoExplode(pl, pos, magnitude, dmginfo) end)

	return true
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/ancient_nightmare"