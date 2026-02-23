CLASS.Name = "Skeletal Walker"
CLASS.TranslationName = "class_skeletal_walker"
CLASS.Description = "description_skeletal_walker"
CLASS.Help = "controls_skeletal_walker"

CLASS.Wave = 0
CLASS.ClassType = 1
CLASS.Unlocked = true

CLASS.Health = 190
CLASS.HealthPerWave = 10
CLASS.Speed = 160
CLASS.Revives = true
CLASS.TorsoClass = "Skeletal Crawler"

CLASS.CanTaunt = true

CLASS.Points = CLASS.Health/GM.SkeletonPointRatio

CLASS.SWEP = "weapon_zs_skeleton"

CLASS.BetterVersion = "Skeletal Shambler"

CLASS.Model = Model("models/player/skeleton.mdl")

CLASS.VoicePitch = 0.8

CLASS.CanFeignDeath = true

CLASS.BloodColor = -1

CLASS.Skeletal = true
CLASS.SkeletalRes = false

local math_random = math.random
local math_Clamp = math.Clamp
local math_min = math.min
local math_max = math.max
local string_format = string.format
local bit_band = bit.band
local DMG_BULLET = DMG_BULLET
local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_IDLE_ZOMBIE = ACT_HL2MP_IDLE_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01
local ACT_HL2MP_WALK_ZOMBIE_01 = ACT_HL2MP_WALK_ZOMBIE_01

function CLASS:KnockedDown(pl, status, exists)
	pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)
end

if SERVER then
	function CLASS:ReviveCallback(pl, attacker, dmginfo)
		if not pl:ShouldReviveFrom(dmginfo) then return false end

		local classtable = GAMEMODE.ZombieClasses[self.TorsoClass]
		if classtable then
			pl:RemoveStatus("overridemodel", false, true)
			local deathclass = pl.DeathClass or pl:GetZombieClass()
			pl:SetZombieClass(classtable.Index)
			pl:DoHulls(classtable.Index, TEAM_UNDEAD)
			pl.DeathClass = deathclass

			pl:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 75)
			pl:EmitSound("npc/antlion/attack_double1.wav", 100, 85)

			pl:Gib()
			pl.Gibbed = nil

			timer.Simple(0, function()
				if IsValid(pl) then
					pl:SecondWind()
				end
			end)
			return true
		end
		return false
	end
end

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if math_random(2) == 1 then
		pl:EmitSound("npc/barnacle/neck_snap1.wav", 65, math_random(135, 150), 0.27)
	else
		pl:EmitSound("npc/barnacle/neck_snap2.wav", 65, math_random(135, 150), 0.27)
	end

	return true
end

function CLASS:PlayPainSound(pl)
	pl:EmitSound(string_format("npc/metropolice/pain%d.wav", math_random(4)), 65, math_random(70, 75))

	return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound(string_format("npc/zombie/zombie_die%d.wav", math_random(3)), 75, math_random(122, 128))

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	local revive = pl.Revive
	if revive and revive:IsValid() then
		return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1
	end
	
	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetDirection() == DIR_BACK then
			return 1, pl:LookupSequence("zombie_slump_rise_02_fast")
		end

		return ACT_HL2MP_ZOMBIE_SLUMP_RISE, -1
	end

	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_PISTOL, -1
	end

	if velocity:Length2DSqr() <= 1 then
		if pl:Crouching() and pl:OnGround() then
			return ACT_HL2MP_IDLE_CROUCH_FIST, -1
		end

		return ACT_HL2MP_IDLE_KNIFE, -1
	end

	if pl:Crouching() and pl:OnGround() then
		return ACT_HL2MP_WALK_CROUCH_KNIFE, -1
	end

	return ACT_HL2MP_RUN_KNIFE, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local revive = pl.Revive
	if revive and revive:IsValid() then
		pl:SetCycle(0.4 + (1 - math_Clamp((revive:GetReviveTime() - CurTime()) / revive.AnimTime, 0, 1)) * 0.6)
		pl:SetPlaybackRate(0)
		return true
	end

	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetState() == 1 then
			pl:SetCycle(1 - math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)
		else
			pl:SetCycle(math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.666)
		end
		pl:SetPlaybackRate(0)
		return true
	end

	local len = velocity:Length()
	if len > 1 then
		pl:SetPlaybackRate(math_min(len / maxseqgroundspeed, 3))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:DoZombieAttackAnim(data)
		return ACT_INVALID
	elseif event == PLAYERANIMEVENT_RELOAD then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		return ACT_INVALID
	end
end

function CLASS:DoesntGiveFear(pl)
	return pl.FeignDeath and pl.FeignDeath:IsValid()
end

if SERVER then
	function CLASS:AltUse(pl)
		pl:StartFeignDeath()
	end

	function CLASS:ProcessDamage(pl, dmginfo)
		if bit_band(dmginfo:GetDamageType(), DMG_BULLET) ~= 0 then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.65)
		elseif bit_band(dmginfo:GetDamageType(), DMG_SLASH) == 0 and bit_band(dmginfo:GetDamageType(), DMG_CLUB) == 0 then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.75)
		end

		local damage = dmginfo:GetDamage()
		if damage >= 70 or damage < pl:Health() then return end

		local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
		if attacker == pl or not attacker:IsPlayer() or inflictor.IsMelee or inflictor.NoReviveFromKills then return end

		if pl:WasHitInHead() or pl:GetStatus("shockdebuff") then return end

		local dmgtype = dmginfo:GetDamageType()
		if bit_band(dmgtype, DMG_ALWAYSGIB) ~= 0 or bit_band(dmgtype, DMG_BURN) ~= 0 or bit_band(dmgtype, DMG_CRUSH) ~= 0 then return end

		if pl.FeignDeath and pl.FeignDeath:IsValid() then return end

		if CurTime() < (pl.NextZombieRevive or 0) then return end
		pl.NextZombieRevive = CurTime() + 3

		dmginfo:SetDamage(0)
		pl:SetHealth(10)

		local status = pl:GiveStatus("revive_slump")
		if status then
			status:SetReviveTime(CurTime() + 2.25)
			status:SetReviveHeal(10)
		end

		return true
	end
end


if CLIENT then
	CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
end
