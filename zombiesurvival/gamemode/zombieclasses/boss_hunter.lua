CLASS.Base = "fast_zombie"
CLASS.Revives = false

CLASS.Name = "Hunter"
CLASS.TranslationName = "class_hunter"
CLASS.Description = "description_hunter"
CLASS.Help = "controls_hunter"

CLASS.Model = Model("models/player/zombie_classic.mdl")

CLASS.SWEP = "weapon_zs_hunterboss"

CLASS.Boss = true
CLASS.ClassType = 3

CLASS.Health = 2000
CLASS.HealthPerWave = 75
CLASS.HealthPerHuman = 25

CLASS.Speed = 285
CLASS.JumpPower = 230

CLASS.Points = 40

CLASS.FearPerInstance = 1

local math_random = math.random

local PainSounds = {
	"npc/zombie/zombie_pain1.wav", 
	"npc/zombie/zombie_pain2.wav", 
	"npc/zombie/zombie_pain3.wav", 
	"npc/zombie/zombie_pain4.wav", 
	"npc/zombie/zombie_pain5.wav", 
	"npc/zombie/zombie_pain6.wav"
}

function CLASS:PlayPainSound(pl)
	pl:EmitSound(PainSounds[math_random(#PainSounds)], 70, 90)

	return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("npc/zombie_poison/pz_die2.wav", 70, 85)

	return true
end

if SERVER then
	function CLASS:OnSpawned(pl)
		pl:SetBodygroup( 1, 1 )
	end

	function CLASS:ProcessDamage(pl, dmginfo)
		local wep = pl:GetActiveWeapon()
		if wep:IsValid() and wep.GetPouncing and wep:GetPouncing() then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
		end
	end	

	local function DoExplode(pl, pos, magnitude, dmginfo)
		local inflictor = pl:GetActiveWeapon()
		if not inflictor:IsValid() then inflictor = pl end

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetMagnitude(magnitude)
		util.Effect("explosion_hunter", effectdata, true)

		pl:CheckRedeem()
	end

	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
		local magnitude = 1

		pl:SetBodygroup(1, 0)

		local pos = pl:WorldSpaceCenter()

		timer.Simple(0, function() DoExplode(pl, pos, magnitude, dmginfo) end)

		return true
	end
end	

local matSkin = Material("models/flesh")
function CLASS:PrePlayerDraw(pl)
	render.ModelMaterialOverride(matSkin)
	render.SetColorModulation(0.57, 0.35, 0.37)
end

function CLASS:PostPlayerDraw(pl)
	render.ModelMaterialOverride(nil)
	render.SetColorModulation(1, 1, 1)
end

if CLIENT then
	CLASS.Icon = "zombiesurvival/killicons/bonemesh"
	CLASS.IconColor = Color(190, 20, 0)
end