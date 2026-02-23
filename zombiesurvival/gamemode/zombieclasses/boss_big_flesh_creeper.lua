CLASS.Name = "Big Flesh Creeper"
CLASS.TranslationName = "class_big_flesh_creeper"
CLASS.Description = "description_big_flesh_creeper"
CLASS.Help = "controls_big_flesh_creeper"

CLASS.Boss = true

CLASS.Health = 2900
CLASS.HealthPerWave = 110
CLASS.HealthPerHuman = 90
CLASS.SWEP = "weapon_zs_bigfleshcreeper"
CLASS.Model = Model("models/antlion_guard.mdl")
CLASS.Speed = 160
CLASS.JumpPower = 275
CLASS.ClassType = 2

CLASS.Points = 40

CLASS.ModelScale = 0.95

CLASS.VoicePitch = 0.55

local math_random = math.random
local CurTime = CurTime

CLASS.PainSounds = {Sound("npc/barnacle/barnacle_pull1.wav"), Sound("npc/barnacle/barnacle_pull2.wav"), Sound("npc/barnacle/barnacle_pull3.wav"), Sound("npc/barnacle/barnacle_pull4.wav")}

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("npc/antlion_guard/antlion_guard_die"..math_random(2)..".wav", 100, math_random(80, 90))

	return true
end

CLASS.Hull = {Vector(-15, -15, 0), Vector(15, 15, 75)}
CLASS.HullDuck = {Vector(-15, -15, 0), Vector(15, 15, 45)}

CLASS.ViewOffset = Vector(0, 0, 64)
CLASS.ViewOffsetDucked = Vector(0, 0, 32)

local CurTime = CurTime
local math_random = math.random
local math_sin = math.sin
local IN_JUMP = IN_JUMP


function CLASS:CanUse(pl)
	return GAMEMODE:GetDynamicSpawning() and not GAMEMODE.ZombieEscape
end

function CLASS:Move(pl, mv)
	local wep = pl:GetActiveWeapon()
	if wep.Move and wep:Move(mv) then
		return true
	end

	if mv:GetForwardSpeed() <= 0 then
		mv:SetMaxSpeed(mv:GetMaxSpeed() * 0.45)
		mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * 0.45)
	end
end

function CLASS:CalcMainActivity(pl, velocity)
    local wep = pl:GetActiveWeapon()
    if wep:IsValid() and wep.IsInAttackAnim then
        if wep:IsInAttackAnim() then
            return 1, 67
        end

        if wep:GetHoldingRightClick() then
            local seq = pl:LookupSequence("fireattack")
            if seq then
                return 1, seq
            end
        end
    end

    if wep.IsCharging and wep:IsCharging() then
        return 1, 37
    end

    local vel = velocity:Length2DSqr()
    if vel > 1 then
        if pl:Crouching() and pl:OnGround() then
            return 1, 17
        end
    elseif pl:Crouching() and pl:OnGround() then
        return 1, 17
    end

	if vel > 1 then
		return 1, 16
	end

    return 1, 1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.IsInAttackAnim then
		if wep:IsInAttackAnim() then
			pl:SetPlaybackRate(0)
			pl:SetCycle(1 - (wep:GetAttackAnimTime() - CurTime()) / wep.Primary.Delay)

			return true
		elseif wep:GetHoldingRightClick() then
			pl:SetPlaybackRate(0)

			local delta = CurTime() - wep:GetRightClickStart()
			if delta > 1 then
				pl:SetCycle(0.5 + math_sin(delta * 12) * 0.05)
			else
				pl:SetCycle(delta / 2)
			end

			return true
		end
	end

	if velocity:Length2DSqr() >= 256 then
		GAMEMODE.BaseClass.UpdateAnimation(GAMEMODE.BaseClass, pl, velocity, maxseqgroundspeed)
		pl:SetPlaybackRate((pl:GetPlaybackRate() / self.ModelScale))
	else
		if pl:Crouching() then
			pl:SetCycle(1 + math.sin(CurTime() * 2) * 0.025)
			pl:SetPlaybackRate(0)
		end
	end

	return true
end


function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		return ACT_INVALID
	end
end

function CLASS:CreateMove(pl, cmd)
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.IsSwinging and wep:IsSwinging() and bit.band(cmd:GetButtons(), IN_JUMP) ~= 0 then
		cmd:SetButtons(cmd:GetButtons() - IN_JUMP)
	end
end

local FootSounds = {
	"npc/antlion_guard/foot_heavy1.wav",
    "npc/antlion_guard/foot_heavy2.wav",
    "npc/antlion_guard/foot_light1.wav",
	"npc/antlion_guard/foot_light2.wav"
}

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
    local volume = pl:Crouching() and 40 or 80
    
    pl:EmitSound(FootSounds[math_random(#FootSounds)], volume, math.random(90, 100))

    return true
end


if SERVER then
	function CLASS:ProcessDamage(pl, dmginfo)
    	if dmginfo:GetInflictor().IsMelee then
    	    dmginfo:SetDamage(dmginfo:GetDamage() / 1.40)
    	end
	end

	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo)
	local pos = pl:WorldSpaceCenter()

	for i=1, 30 do
		local ent = ents.CreateLimited("prop_playergib")
		if ent:IsValid() then
			ent:SetPos(pos + VectorRand() * 12)
			ent:SetAngles(VectorRand():Angle())
			ent:SetGibType(math.random(3, #GAMEMODE.HumanGibs))
			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:ApplyForceOffset(VectorRand():GetNormalized() * math.Rand(8000, 13000), pos)
			end
		end
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(pl:GetUp())
		effectdata:SetEntity(pl)
	util.Effect("death_extinctioncrab", effectdata, nil, true)

	return true
end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/fleshcreeper"
CLASS.IconColor = Color(255, 20, 0)

local matFlesh = Material("models/flesh")
function CLASS:PrePlayerDraw(pl)
	render.ModelMaterialOverride(matFlesh)
end

function CLASS:PostPlayerDraw(pl)
	render.ModelMaterialOverride()
end