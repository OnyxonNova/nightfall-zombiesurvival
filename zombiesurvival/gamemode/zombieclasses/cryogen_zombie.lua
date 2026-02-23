CLASS.Name = "Cryogen Revenant"
CLASS.TranslationName = "class_cryogen_skeleton"
CLASS.Description = "description_cryogen_skeleton"
CLASS.Help = "controls_cryogen_skeleton"

CLASS.SWEP = "weapon_zs_cryogenzombie"
CLASS.Model = Model("models/player/skeleton.mdl")
CLASS.CanTaunt = true
CLASS.Wave = 6 / 6
CLASS.ClassType = 1

CLASS.Health = 345
CLASS.HealthPerWave = 20

CLASS.KnockbackScale = 0.20
CLASS.Speed = 182
CLASS.Revives = true
CLASS.Points = CLASS.Health / GM.HumanoidZombiePointRatio
CLASS.ResistFrost = true

CLASS.VoicePitch = 0.6

CLASS.CanFeignDeath = true
CLASS.Skeletal = true
CLASS.TorsoClass = "Cryogen Lurker"

local math_random = math.random
local math_min = math.min
local math_max = math.max
local math_Clamp = math.Clamp
local bit_band = bit.band
local DMG_BULLET = DMG_BULLET
local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_FIST = ACT_HL2MP_IDLE_CROUCH_FIST
local ACT_HL2MP_IDLE_KNIFE = ACT_HL2MP_IDLE_KNIFE
local ACT_HL2MP_WALK_CROUCH_KNIFE = ACT_HL2MP_WALK_CROUCH_KNIFE
local ACT_HL2MP_RUN_KNIFE = ACT_HL2MP_RUN_KNIFE

function CLASS:PlayPainSound(pl)
    pl:EmitSound("npc/antlion/pain2.wav", 70, math_random(190, 200))
    pl.NextPainSound = CurTime() + 0.5

    return true
end

function CLASS:PlayDeathSound(pl)
    pl:EmitSound("npc/antlion/pain"..math_random(2)..".wav", 70, math_random(190, 200))

    return true
end

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

            local effectdata = EffectData()
            effectdata:SetOrigin(pl:GetPos())
            effectdata:SetEntity(pl)
            util.Effect("hit_ice", effectdata)

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

function CLASS:CalcMainActivity(pl, velocity)
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
    local feign = pl.FeignDeath
    if feign and feign:IsValid() then
        local stateEndTime = feign:GetStateEndTime() - CurTime()
        if feign:GetState() == 1 then
            pl:SetCycle(1 - math_max(stateEndTime, 0) * 0.666)
        else
            pl:SetCycle(math_max(stateEndTime, 0) * 0.666)
        end
        pl:SetPlaybackRate(0)
        return true
    end

    local len = velocity:Length()
    pl:SetPlaybackRate(len > 1 and math_min(len / maxseqgroundspeed, 3) or 1)
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
        if dmginfo:GetInflictor().IsMelee then
            dmginfo:SetDamage(dmginfo:GetDamage() * 0.55)
        end
    end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
CLASS.IconColor = Color(0, 100, 90)

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local render_ModelMaterialOverride = render.ModelMaterialOverride
local vecEyeLeft = Vector(5, -3.5, -1)
local vecEyeRight = Vector(5, -3.5, 1)
local colGlow = Color(255, 255, 255)
local matGlow = Material("sprites/glow04_noz")
local matSheet = Material("models/props_combine/portalball001_sheet")

function CLASS:PrePlayerDraw(pl)
    render_ModelMaterialOverride(matSheet)
    render_SetColorModulation(1, 1, 1)
end

function CLASS:PostPlayerDraw(pl)
    render_ModelMaterialOverride(matSheet)
    if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    local pos, ang = pl:GetBonePositionMatrixed(6)
    if pos then
        render_SetMaterial(matGlow)
        render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 10, 0.5, colGlow)
        render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 6, 6, colGlow)
        render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 10, 0.5, colGlow)
        render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 6, 6, colGlow)
    end
    render_ModelMaterialOverride(nil)
end
