CLASS.Name = "Investigator"
CLASS.TranslationName = "class_investigator"
CLASS.Description = "description_investigator"
CLASS.Help = "controls_investigator"

CLASS.Boss = true
CLASS.ClassType = 2

CLASS.KnockbackScale = 0

CLASS.FearPerInstance = 1

CLASS.CanTaunt = true

CLASS.Points = 55

CLASS.SWEP = "weapon_zs_investigator"

CLASS.Model = Model("models/player/skeleton.mdl")

CLASS.Health = 3000
CLASS.HealthPerWave = 95
CLASS.HealthPerHuman = 115
CLASS.Speed = 175

CLASS.VoicePitch = 0.35

CLASS.ModelScale = 1.2
CLASS.Hull = {Vector(-16, -16, 0), Vector(16, 16, 72)}
CLASS.HullDuck = {Vector(-16, -16, 0), Vector(16, 16, 36)}
CLASS.ViewOffset = DEFAULT_VIEW_OFFSET * CLASS.ModelScale
CLASS.ViewOffsetDucked = DEFAULT_VIEW_OFFSET_DUCKED * CLASS.ModelScale
CLASS.StepSize = 25
CLASS.Mass = DEFAULT_MASS * CLASS.ModelScale

local math_random = math.random
local math_min = math.min
local math_ceil = math.ceil
local CurTime = CurTime

local DIR_BACK = DIR_BACK
local ACT_INVALID = ACT_INVALID
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_GMOD_GESTURE_TAUNT_ZOMBIE = ACT_GMOD_GESTURE_TAUNT_ZOMBIE

function CLASS:ScalePlayerDamage(pl, hitgroup, dmginfo)
	return true
end

function CLASS:IgnoreLegDamage(pl, dmginfo)
	return true
end

function CLASS:PlayerStepSoundTime(pl, iType, bWalking)
	return GAMEMODE.BaseClass.PlayerStepSoundTime(GAMEMODE.BaseClass, pl, iType, bWalking) * 1.8
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("npc/antlion_guard/antlion_guard_die"..math_random(2)..".wav", 100, math_random(80, 90))

	return true
end

function CLASS:PlayPainSound(pl)
	pl:EmitSound("npc/antlion/pain2.wav", 75, math_random(85, 95))
	pl.NextPainSound = CurTime() + 1.5

	return true
end

local StepSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)

	pl:EmitSound(StepSounds[math_random(#StepSounds)], 77, 50)

	if iFoot == 0 then
		pl:EmitSound("^npc/dog/dog_footstep_run3.wav", 100, math_random(115, 50))
	else
		pl:EmitSound("^npc/dog/dog_footstep_run4.wav", 100, math_random(115, 50))
	end

	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_PISTOL, -1
	elseif pl:Crouching() then
		if velocity:Length2DSqr() <= 1 then
			return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1
		else
			return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1
		end
	else
		return ACT_HL2MP_RUN_ZOMBIE, -1
	end

	return true
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local len2d = velocity:Length2D()
	if len2d > 1 then
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed * 0.5 , 3))
	else
		pl:SetPlaybackRate(1 / self.ModelScale)
	end

	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE, true)
		return ACT_INVALID
	elseif event == PLAYERANIMEVENT_RELOAD then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		return ACT_INVALID
	end
end

if SERVER then
	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo)
		local fakedeath = pl:FakeDeath(234, self.ModelScale)
		if fakedeath and fakedeath:IsValid() then
		end

		return true
	end

	function CLASS:OnSpawned(pl)
        pl:CreateAmbience("investigator")

        local effectData = EffectData()
        effectData:SetOrigin(pl:GetPos())
        effectData:SetAngles(pl:GetAngles())
        util.Effect("boss_spawn_rock", effectData, nil, true)

        util.ScreenShake(pl:GetPos(), 5, 5, 1, 300)
    end
end

if not CLIENT then return end

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local LocalToWorld = LocalToWorld
local colGlow = Color(255, 0, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(-11, -2, -0)
local vecEyeRight = Vector(-11, -2, -0)

function CLASS:PrePlayerDraw(pl)
	render_SetBlend(1)
	render_SetColorModulation(0.1, 0.1, 0.1)
end

function CLASS:PrePlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(nil)
end

if CLIENT then
    function CLASS:PostPlayerDraw(pl)
        render.SetColorModulation(1, 1, 1)

        if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

        local pos, ang = pl:GetBonePositionMatrixed(6)
        if pos then
            render_SetMaterial(matGlow)
            render.DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 50, 50, colGlow)
            render.DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 80, 80, colGlow)
        end
    end
end

CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
CLASS.IconColor = Color(0.5, 0.5, 0.5)
