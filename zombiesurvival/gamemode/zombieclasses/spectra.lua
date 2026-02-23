CLASS.Base = "wraith"

CLASS.Name = "Spectra"
CLASS.TranslationName = "class_spectra"
CLASS.Description = "description_spectra"
CLASS.Help = "controls_spectra"

CLASS.Health = 220
CLASS.HealthPerWave = 15
CLASS.ClassType = 3
CLASS.Points = CLASS.Health/GM.NoHeadboxZombiePointRatio
CLASS.Speed = 175

CLASS.Wave = 5 / 6

CLASS.Model = Model("models/player/zelpa/stalker.mdl")
CLASS.SWEP = "weapon_zs_spectra"

CLASS.NoShadow = true
CLASS.IgnoreTargetAssist = true
CLASS.RenderMode = RENDERMODE_TRANSALPHA

CLASS.BloodColor = BLOOD_COLOR_MECH

local math_min = math.min
local math_Clamp = math.Clamp
local IN_SPEED = IN_SPEED
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_FIST = ACT_HL2MP_IDLE_CROUCH_FIST
local ACT_HL2MP_IDLE_KNIFE = ACT_HL2MP_IDLE_KNIFE
local ACT_HL2MP_WALK_CROUCH_KNIFE = ACT_HL2MP_WALK_CROUCH_KNIFE
local ACT_HL2MP_WALK_KNIFE = ACT_HL2MP_WALK_KNIFE
local ACT_HL2MP_RUN_KNIFE = ACT_HL2MP_RUN_KNIFE
local PLAYERANIMEVENT_ATTACK_PRIMARY = PLAYERANIMEVENT_ATTACK_PRIMARY
local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD
local ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL = ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL
local ACT_GMOD_GESTURE_TAUNT_ZOMBIE = ACT_GMOD_GESTURE_TAUNT_ZOMBIE
local ACT_INVALID = ACT_INVALID

function CLASS:Move(pl, move)
	local wep = pl:GetActiveWeapon()
	if not wep.GetTormented then return end

	if CurTime() < wep:GetTormented() + 2 then
		move:SetMaxSpeed(225)
		move:SetMaxClientSpeed(225)
	end

	if pl:KeyDown(IN_SPEED) then
		move:SetMaxSpeed(40)
		move:SetMaxClientSpeed(40)
	end
end

function CLASS:PlayDeathSound(pl)
	for i=1, 4 do
		pl:EmitSound("zombiesurvival/wraithdeath4.ogg", 75, math.random(40, 70), 0.6, CHAN_AUTO + i)
	end

	return true
end


function CLASS:CalcMainActivity(pl, velocity)
	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_PISTOL, -1
	end

	if pl:WaterLevel() >= 3 then
		return ACT_HL2MP_SWIM_PISTOL, -1
	end

	local len = velocity:Length2DSqr()
	if len <= 1 then
		if pl:Crouching() and pl:OnGround() then
			return ACT_HL2MP_IDLE_CROUCH_FIST, -1
		end

		return ACT_HL2MP_IDLE_KNIFE, -1
	end

	if pl:Crouching() and pl:OnGround() then
		return ACT_HL2MP_WALK_CROUCH_KNIFE, -1
	end

	if len < 2800 then
		return ACT_HL2MP_WALK_KNIFE, -1
	end

	return ACT_HL2MP_RUN_KNIFE, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local len2d = velocity:Length()
	if len2d > 1 then
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 3))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL, true)
		return ACT_INVALID
	elseif event == PLAYERANIMEVENT_RELOAD then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		return ACT_INVALID
	end
end

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	return true
end

function CLASS:GetAlpha(pl)
	local wep = pl:GetActiveWeapon()
	if not wep.IsAttacking then wep = NULL end

	if wep:IsValid() and wep:IsAttacking() then
		return 0.7
	end

	local eyepos = EyePos()
	local nearest = pl:WorldSpaceCenter()
	local norm = nearest - eyepos
	norm:Normalize()
	local dot = EyeVector():Dot(norm)

	local vis = (dot * 0.4 + pl:GetVelocity():Length() / self.Speed / 2 - eyepos:Distance(nearest) / 400) * dot

	return math_Clamp(vis, MySelf:IsValid() and MySelf:Team() == TEAM_UNDEAD and 0.137 or 0, 0.7)
end

if SERVER then
function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo, assister)
	local effectdata = EffectData()
		effectdata:SetOrigin(pl:GetPos())
		effectdata:SetNormal(pl:GetForward())
		effectdata:SetEntity(pl)
	util.Effect("death_wraith", effectdata, nil, true)

	return true
end

if SERVER then
	function CLASS:ProcessDamage(pl, dmginfo)
		local activ = pl:GetActiveWeapon()
		if not activ.GetTormented then return end

		local attacker, dmg = dmginfo:GetAttacker(), dmginfo:GetDamage()
		if not attacker:IsValidLivingHuman() or CurTime() < activ:GetTormented() + 8 then return end

		if pl:Health() - dmg < 90 then
			for i = 0, 3 do
				timer.Simple(0.04 * i,
					function() if pl:IsValidLivingZombie() then pl:EmitSound("npc/stalker/go_alert2a.wav", 75, 120 + i*12, 0.4, CHAN_WEAPON + i) end
				end)
			end

			activ:SetTormented(CurTime())
		end
	end
end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/wraithv2"
CLASS.IconColor = Color(102, 0, 102)


function CLASS:PrePlayerDraw(pl)
	--pl:RemoveAllDecals()

	local alpha = self:GetAlpha(pl)
	if alpha == 0 then return true end

	render.SetBlend(alpha)
	render.SetColorModulation(0.25, 0, 0.25)
	render.SuppressEngineLighting(true)
end

function CLASS:PostPlayerDraw(pl)
	render.SuppressEngineLighting(false)
	render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)
end
