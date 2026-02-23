CLASS.Name = "Warden"
CLASS.TranslationName = "class_warden"
CLASS.Description = "description_warden"
CLASS.Help = "controls_warden"

CLASS.Wave = 5 / 6
CLASS.ClassType = 1

CLASS.CanTaunt = true
CLASS.SWEP = "weapon_zs_warden"

CLASS.Model = Model("models/player/zombie_lacerator2.mdl")
CLASS.OverrideModel = Model("models/Zombie/Poison.mdl")

CLASS.NoHideMainModel = true

CLASS.Health = 315
CLASS.HealthPerWave = 15
CLASS.KnockbackScale = 0.05
CLASS.Speed = 145

CLASS.Points = CLASS.Health / GM.HumanoidZombiePointRatio

CLASS.VoicePitch = 0.35

local math_random = math.random
local math_min = math.min
local math_ceil = math.ceil
local CurTime = CurTime

local DIR_BACK = DIR_BACK
local ACT_INVALID = ACT_INVALID
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01
local ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL = ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_GMOD_GESTURE_TAUNT_ZOMBIE = ACT_GMOD_GESTURE_TAUNT_ZOMBIE

function CLASS:IgnoreLegDamage(pl, dmginfo)
	return true
end

CLASS.DeathSounds = {
    "weapons/npc/zombine/zombine_die1.mp3",
    "weapons/npc/zombine/zombine_die2.mp3"
}

function CLASS:PlayDeathSound(pl)
    local sound = self.DeathSounds[math_random(#self.DeathSounds)]
    pl:EmitSound(sound, 100, math_random(50, 60))

    return true
end

CLASS.PainSounds = {
    "weapons/npc/zombine/zombine_pain1.mp3",
    "weapons/npc/zombine/zombine_pain2.mp3",
    "weapons/npc/zombine/zombine_pain3.mp3",
    "weapons/npc/zombine/zombine_pain4.mp3"
}

function CLASS:PlayPainSound(pl)
    local sound = self.PainSounds[math_random(#self.PainSounds)]
    pl:EmitSound(sound, 75, math_random(85, 60))
    pl.NextPainSound = CurTime() + 1.5

    return true
end

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
    if math_random() < 0.15 then
        pl:EmitSound(ScuffSounds[math_random(#ScuffSounds)], 50, 60)
    else
        pl:EmitSound(StepSounds[math_random(#StepSounds)], 50, 60)
    end

    return true
end

function CLASS:CalcMainActivity(pl, velocity)
    if pl:WaterLevel() >= 3 then
        return ACT_HL2MP_SWIM_PISTOL, -1
    end

    if pl:Crouching() and pl:OnGround() then
        if velocity:Length2DSqr() <= 1 then
            return ACT_HL2MP_IDLE_CROUCH_ZOMBIE, -1
        end

        return ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 - 1 + math_ceil((CurTime() / 4 + pl:EntIndex()) % 3), -1
    end

    return ACT_HL2MP_RUN_ZOMBIE, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
    local len2d = velocity:Length2D()
    if len2d > 0.5 then
        pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))
    else
        pl:SetPlaybackRate(1)
    end

    return true
end

function CLASS:DoAnimationEvent(pl, event, data)
    local wep = pl:GetActiveWeapon()

    if not wep:IsValid() then
        return
    end

    if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
        if wep.BoostedDamage then
            pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL, true)
        else
            pl:DoZombieAttackAnim(data)
        end
        return ACT_INVALID
    elseif event == PLAYERANIMEVENT_RELOAD then
        pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
        return ACT_INVALID
    end
end

if SERVER then
    function CLASS:ProcessDamage(pl, dmginfo)
        local inflictor = dmginfo:GetInflictor()
        if inflictor and inflictor.IsMelee then
            dmginfo:SetDamage(dmginfo:GetDamage() * 0.45)
        end
    end
end


if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/howler"
CLASS.IconColor = Color(180, 45, 0)

local wardenSheet = CreateMaterial("wardensheet", "VertexLitGeneric", {
    ["$basetexture"] = "models/flesh",
    ["$model"] = "1"
})

function CLASS:PrePlayerDrawOverrideModel(pl)
    render.SetColorModulation(0.3, 0, 0)
    render.ModelMaterialOverride(wardenSheet)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
    render.SetColorModulation(1, 1, 1)
    render.ModelMaterialOverride()
end

function CLASS:PrePlayerDraw(pl)
    render.ModelMaterialOverride(wardenSheet)
end

function CLASS:PostPlayerDraw(pl)
    render.ModelMaterialOverride()
end
