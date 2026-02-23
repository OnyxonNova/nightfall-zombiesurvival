CLASS.Name = "Zombine"
CLASS.TranslationName = "class_zombine"
CLASS.Description = "description_zombine"
CLASS.Help = "controls_zombine"

CLASS.Wave = 5 / 6
CLASS.ClassType = 3

CLASS.Health = 285
CLASS.HealthPerWave = 17
CLASS.Speed = 140
CLASS.Mass = DEFAULT_MASS

CLASS.CanTaunt = true

CLASS.Points = CLASS.Health/GM.PoisonZombiePointRatio

CLASS.SWEP = "weapon_zs_zombine"

CLASS.Model = Model("models/zombie/zombie_soldier.mdl")

CLASS.DeathSounds = {"weapons/npc/zombine/zombine_die"..math.random(1, 2)..".mp3"}

CLASS.PainSounds = {"weapons/npc/zombine/zombine_pain"..math.random(1, 4)..".mp3"}

CLASS.VoicePitch = 0.6

CLASS.CanFeignDeath = true

CLASS.BloodColor = BLOOD_COLOR_MECH

local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local bit_band = bit.band
local DMG_BULLET = DMG_BULLET

function CLASS:KnockedDown(pl, status, exists)
	pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD)
end

sound.Add({
	name = "fatty.footstep",
    channel = CHAN_BODY,
    volume = 0.8,
    soundlevel = 65,
    pitchstart = 75,
    pitchend = 75,
    sound = {"npc/combine_soldier/gear1.wav", "npc/combine_soldier/gear2.wav", "npc/combine_soldier/gear3.wav"}
})

sound.Add({
	name = "fatty.footscuff",
    channel = CHAN_BODY,
    volume = 0.8,
    soundlevel = 65,
    pitchstart = 75,
    pitchend = 75,
    sound = {"npc/combine_soldier/gear4.wav", "npc/combine_soldier/gear5.wav", "npc/combine_soldier/gear6.wav"}
})

local mathrandom = math.random
local math_max = math.max

local StepSounds = {

	"npc/combine_soldier/gear1.wav",
	"npc/combine_soldier/gear2.wav",
	"npc/combine_soldier/gear3.wav"
	
}
local ScuffSounds = {

	"npc/combine_soldier/gear4.wav",
	"npc/combine_soldier/gear5.wav",
	"npc/combine_soldier/gear6.wav"
}

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if mathrandom() < 0.15 then
		pl:EmitSound(ScuffSounds[mathrandom(#ScuffSounds)], 70, 75)
	else
		pl:EmitSound(StepSounds[mathrandom(#StepSounds)], 70, 75)
	end

	return true
end

function CLASS:Move(pl, mv)

    local wep = pl:GetActiveWeapon()
    
    if IsValid(wep) then
        if wep.IsInAttackAnim && wep:IsInAttackAnim() || wep.GetGrenadingEndTime and CurTime() <= wep:GetGrenadingEndTime() then
            --mv:SetForwardSpeed( 0 )
            --mv:SetSideSpeed( 0 )
            mv:SetMaxClientSpeed( 130 )
            mv:SetMaxSpeed( 130 )
        end
        
        if wep.IsMoaning and wep:IsMoaning() then
            if mv:GetForwardSpeed() < 140 then
                mv:SetForwardSpeed( 140 )
            end
        end
    end
    
end

function CLASS:CalcMainActivity(pl, velocity)

	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetDirection() == DIR_BACK then
			return 1, pl:LookupSequence("slumprise_a2")
		end

		return 1, pl:LookupSequence("slumprise_b")
	end

	local wep = pl:GetActiveWeapon()

	if IsValid(wep) then
		if wep.IsInAttackAnim and wep:IsInAttackAnim() then
			return 1, pl:LookupSequence("FastAttack")
		elseif wep.IsMoaning and wep:IsMoaning() then
			if velocity:Length2D() > 0.5 then
				if not wep:IsGrenading() then
					return ACT_RUN, -1
				else
					return 1, pl:LookupSequence("Run_All_grenade")
				end	
			else	
				if not wep:IsGrenading() then
					return ACT_IDLE, -1
				else
					return 1, pl:LookupSequence("Idle_Grenade")
				end	
			end
		else
			if wep.IsGrenading and wep:IsGrenading() then
				if wep.GetGrenadingEndTime and CurTime() <= wep:GetGrenadingEndTime() then
					--pl:SetPlaybackRate(0)
					return 1, pl:LookupSequence("pullGrenade")
				else
					if velocity:Length2D() > 0.5 then
						return 1, pl:LookupSequence("walk_All_Grenade")
					else	
						--pl:SetPlaybackRate(0)
						return 1, pl:LookupSequence("Idle_Grenade")
					end	
				end
			end
		end
	end	
	
	if pl:OnGround() then
		if velocity:Length2D() > 0.5 then
			return ACT_WALK, -1
		else
			return ACT_IDLE, -1
		end
	elseif pl:WaterLevel() >= 3 then
		return ACT_RUN, -1
	else
		return ACT_RUN, -1
	end

	return true
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)

	pl:FixModelAngles(velocity)
	
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.IsInAttackAnim then
		if wep:IsInAttackAnim() then
			pl:SetPlaybackRate(0)
			pl:SetCycle((1 - (wep:GetAttackAnimTime() - CurTime()) / wep.Primary.Delay))

			return true
		end
	end

	local feign = pl.FeignDeath
	if feign and feign:IsValid() then
		if feign:GetState() == 1 then
			pl:SetCycle(1 - math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.625)
		else
			pl:SetCycle(math_max(feign:GetStateEndTime() - CurTime(), 0) * 0.625)
		end
		pl:SetPlaybackRate(0)
		return true
	end

	local len2d = velocity:Length2D()
	if len2d > 1 then
		local wep = pl:GetActiveWeapon()
		if IsValid(wep) then
			if wep.GetGrenadingEndTime and CurTime() <= wep:GetGrenadingEndTime() then
				pl:SetCycle(1-math_max(wep:GetGrenadingEndTime() - CurTime(), 0) * 0.666)
				pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed * 0.555, 3))
			else
				if wep.IsMoaning and wep:IsMoaning() then
					pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed, 3))	
				else
					pl:SetPlaybackRate(math.min(len2d / maxseqgroundspeed * 0.555, 3))
				end
			end
		end	
	else
		if wep and wep:IsValid() then 
			if wep.IsGrenading and wep:IsGrenading() and wep.GetGrenadingEndTime then
				pl:SetCycle(1-math_max(wep:GetGrenadingEndTime() - CurTime(), 0) * 0.666)
				pl:SetPlaybackRate(0)
			else
				pl:SetPlaybackRate(1)
			end
		end
		pl:SetPlaybackRate(1)
	end
	
	if !pl:IsOnGround() || pl:WaterLevel() >= 3 then
	
		pl:SetPlaybackRate(1)

		return true
	end

	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		return ACT_INVALID
	end
end

function CLASS:DoesntGiveFear(pl)
	return pl.FeignDeath and pl.FeignDeath:IsValid()
end

if SERVER then
	function CLASS:OnSpawned(pl)
		pl:SetSkin( math.Rand( 0, 3 ) )
		pl:SetBodygroup( 1, 1 )
	end

	function CLASS:ProcessDamage(pl, dmginfo)
		if bit_band(dmginfo:GetDamageType(), DMG_BULLET) ~= 0 then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.8)
		elseif bit_band(dmginfo:GetDamageType(), DMG_SLASH) == 0 and bit_band(dmginfo:GetDamageType(), DMG_CLUB) == 0 then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.85)
		end
	end

	function CLASS:AltUse(pl)
	pl:StartFeignDeath()
	end
	
	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
		pl:SetBodygroup( 1, 0 )
	end
end	

if CLIENT then
	CLASS.Icon = "zombiesurvival/killicons/zs_zombine"
	CLASS.Image = "fwkzt/class_icons/zombine.png"
end