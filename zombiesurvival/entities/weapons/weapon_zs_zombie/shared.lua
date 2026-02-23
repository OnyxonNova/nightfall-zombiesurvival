AddCSLuaFile("cl_init.lua")
AddCSLuaFile("animations.lua")

SWEP.PrintName = "Зомби"

SWEP.ViewModel = Model("models/Weapons/v_zombiearms.mdl")
SWEP.WorldModel = "models/weapons/w_grenade.mdl"

SWEP.NoItemRender = true

SWEP.MeleeDelay = 0.74
SWEP.MeleeReach = 48
SWEP.MeleeSize = 4.5
SWEP.MeleeDamage = 35
SWEP.MeleeForceScale = 1
SWEP.MeleeDamageType = DMG_SLASH

SWEP.BotMeleeReach = 140
SWEP.BotSecondaryReach = 300
SWEP.BotReloadReach = 0

SWEP.AlertDelay = 2.5

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.2

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.IsMelee = true
SWEP.ZombieOnly = true

SWEP.HoldType = "melee"
SWEP.SwingHoldType = "grenade"

SWEP.DamageType = DMG_SLASH

SWEP.BloodDecal = "Blood"
SWEP.HitDecal = "Impact.Concrete"

SWEP.HitAnim = ACT_VM_HITCENTER
SWEP.MissAnim = ACT_VM_HITCENTER

SWEP.SwingTime = 0
SWEP.SwingRotation = Angle(0, 0, 0)
SWEP.SwingOffset = Vector(0, 0, 0)

function SWEP:StopMoaningSound()
	local owner = self:GetOwner()
	owner:StopSound("NPC_BaseZombie.Moan1")
	owner:StopSound("NPC_BaseZombie.Moan2")
	owner:StopSound("NPC_BaseZombie.Moan3")
	owner:StopSound("NPC_BaseZombie.Moan4")
end

function SWEP:StartMoaningSound()
	self:GetOwner():EmitSound("NPC_BaseZombie.Moan"..math.random(4))
end

function SWEP:PlayHitSound()
	self:EmitSound("npc/zombie/claw_strike"..math.random(3)..".wav", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
	self:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie/zo_attack"..math.random(2)..".wav")
end

function SWEP:Initialize()
	self:SetDeploySpeed(1.1)
	self:SetWeaponHoldType(self.HoldType)
	self:SetWeaponSwingHoldType(self.SwingHoldType)
	
	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:SetWeaponSwingHoldType(t)
	local old = self.ActivityTranslate
	self:SetWeaponHoldType(t)
	local new = self.ActivityTranslate
	self.ActivityTranslate = old
	self.ActivityTranslateSwing = new
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self.Owner, self)
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	return true
end

function SWEP:CheckIdleAnimation()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end

function SWEP:CheckAttackAnimation()
	if self.NextAttackAnim and self.NextAttackAnim <= CurTime() then
		self.NextAttackAnim = nil
		self:SendAttackAnim()
	end
end

function SWEP:CheckMoaning()
	if self:IsMoaning() and self:GetOwner():Health() < self:GetMoanHealth() then
		self:SetNextSecondaryFire(CurTime() + 1)
		self:StopMoaning()
	end
end

function SWEP:CheckMeleeAttack()
	local swingend = self:GetSwingEndTime()
	if swingend == 0 or CurTime() < swingend then return end
	self:StopSwinging(0)

	self:Swung()
end

function SWEP:GetTracesNumPlayers(traces)
	local numplayers = 0

	local ent
	for _, trace in pairs(traces) do
		ent = trace.Entity
		if ent and ent:IsValidPlayer() then
			numplayers = numplayers + 1
		end
	end

	return numplayers
end

function SWEP:GetDamage(numplayers, basedamage)
	basedamage = basedamage or self.MeleeDamage

	if numplayers then
		return basedamage * math.Clamp(1.1 - numplayers * 0.1, 0.666, 1)
	end

	return basedamage
end

function SWEP:Swung()
	if not IsFirstTimePredicted() then return end

	local owner = self:GetOwner()

	local hit = false
	local traces = owner:CompensatedZombieMeleeTrace(self.MeleeReach, self.MeleeSize)
	local prehit = self.PreHit
	if prehit then
		local ins = true
		for _, tr in pairs(traces) do
			if tr.HitNonWorld then
				ins = false
				break
			end
		end
		if ins then
			local eyepos = owner:EyePos()
			if prehit.Entity:IsValid() and prehit.Entity:NearestPoint(eyepos):DistToSqr(eyepos) <= self.MeleeReach * self.MeleeReach then
				table.insert(traces, prehit)
			end
		end
		self.PreHit = nil
	end

	local damage = self:GetDamage(self:GetTracesNumPlayers(traces))
	local effectdata = EffectData()
	local ent

	for _, trace in ipairs(traces) do
		if not trace.Hit then continue end

		ent = trace.Entity

		hit = true

		if trace.HitWorld then
			self:MeleeHitWorld(trace)
		elseif ent and ent:IsValid() then
			self:MeleeHit(ent, trace, damage)
		end

		--if IsFirstTimePredicted() then
			effectdata:SetOrigin(trace.HitPos)
			effectdata:SetStart(trace.StartPos)
			effectdata:SetNormal(trace.HitNormal)
			util.Effect("RagdollImpact", effectdata)
			if not trace.HitSky then
				effectdata:SetSurfaceProp(trace.SurfaceProps)
				effectdata:SetDamageType(self.MeleeDamageType) --effectdata:SetDamageType(DMG_BULLET)
				effectdata:SetHitBox(trace.HitBox)
				effectdata:SetEntity(ent)
				util.Effect("Impact", effectdata)
			end
		--end
	end

	--if IsFirstTimePredicted() then
		if hit then
			self:PlayHitSound()
		else
			self:PlayMissSound()
		end
	--end

	if self.FrozenWhileSwinging then
		owner:ResetSpeed()
	end
end

function SWEP:Think()
	self:CheckIdleAnimation()
	self:CheckAttackAnimation()
	self:CheckMoaning()
	self:CheckMeleeAttack()
end

function SWEP:MeleeHitWorld(trace)
end

function SWEP:Reload()
	return false
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if ent:IsPlayer() then
		self:MeleeHitPlayer(ent, trace, damage, forcescale)
	else
		self:MeleeHitEntity(ent, trace, damage, forcescale)
	end

	self:ApplyMeleeDamage(ent, trace, damage)
end

function SWEP:MeleeHitEntity(ent, trace, damage, forcescale)
	local phys = ent:GetPhysicsObject()
	if phys:IsValid() and phys:IsMoveable() then
		local forcehit = 950
		phys:ApplyForceOffset(damage * forcehit * (forcescale or self.MeleeForceScale) * self:GetOwner():GetAimVector(), (ent:NearestPoint(trace.StartPos) + ent:GetPos() * 5) / 6)
		ent:SetPhysicsAttacker(self:GetOwner())
	end
end

function SWEP:MeleeHitPlayer(ent, trace, damage, forcescale)
	ent:ThrowFromPositionSetZ(self:GetOwner():GetPos(), damage * 2.5 * (forcescale or self.MeleeForceScale))
	ent:MeleeViewPunch(damage)
	local nearest = ent:NearestPoint(trace.StartPos)
	util.Blood(nearest, math.Rand(damage * 0.5, damage * 0.75), (nearest - trace.StartPos):GetNormalized(), math.Rand(damage * 5, damage * 10), true)
end

function SWEP:ApplyMeleeDamage(hitent, tr, damage)
	if not IsFirstTimePredicted() then return end

	local owner = self:GetOwner()

	local dmginfo = DamageInfo()
	dmginfo:SetDamagePosition(tr.HitPos)
	dmginfo:SetAttacker(owner)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamageType(self.MeleeDamageType)
	dmginfo:SetDamage(damage)
	dmginfo:SetDamageForce(math.min(damage, 50) * 50 * owner:GetAimVector())

	local vel
	if hitent:IsPlayer() then
		if SERVER then
			hitent:SetLastHitGroup(tr.HitGroup)
			if tr.HitGroup == HITGROUP_HEAD then
				hitent:SetWasHitInHead()
			end

			if hitent:WouldDieFrom(damage, tr.HitPos) then
				dmginfo:SetDamageForce(math.min(damage, 50) * 400 * owner:GetAimVector())
			end
		end

		vel = hitent:GetVelocity()
	end

	hitent:DispatchTraceAttack(dmginfo, tr, owner:GetAimVector())

	-- No knockback vs. players
	if vel then
		hitent:SetLocalVelocity(vel)
	end
end

function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextPrimaryFire() or IsValid(self:GetOwner().FeignDeath) then return end

	local owner = self:GetOwner()
	local armdelay = owner:GetMeleeSpeedMul()

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)
	self:SetNextSecondaryFire(self:GetNextPrimaryFire() + 0.5)

	self:StartSwinging()
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()

    if owner:IsValid() and owner:IsPlayer() then
        local status1 = owner:GiveStatus("zombie_battlecry", 1)

        if status1 and status1:IsValid() and status2 and status2:IsValid() then
        end
    end 

 
    if CurTime() < self:GetNextSecondaryFire() then return end
    self:SetNextSecondaryFire(CurTime() + self.AlertDelay)

    self:DoAlert()
end

function SWEP:DoAlert()
	self:GetOwner():DoReloadEvent()

	if SERVER then
		local ent = self:GetOwner():CompensatedMeleeTrace(4096, 24).Entity
		if ent:IsValidPlayer() then
			self:PlayAlertSound()
		else
			self:PlayIdleSound()
		end
	end
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav")
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav")
end

function SWEP:SendAttackAnim()
	local owner = self:GetOwner()
	local armdelay = self.MeleeAnimationMul

	if self.SwapAnims then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	else
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	end
	self.SwapAnims = not self.SwapAnims
	if self.SwingAnimSpeed then
		owner:GetViewModel():SetPlaybackRate(self.SwingAnimSpeed * armdelay)
	else
		owner:GetViewModel():SetPlaybackRate(1 * armdelay)
	end
end

function SWEP:DoSwingEvent()
	self:GetOwner():DoZombieEvent()
end

function SWEP:StartSwinging()
	if not IsFirstTimePredicted() then return end

	local owner = self:GetOwner()
	local armdelay = owner:GetMeleeSpeedMul()

	self.MeleeAnimationMul = 1 / armdelay
	if self.MeleeAnimationDelay then
		self.NextAttackAnim = CurTime() + self.MeleeAnimationDelay * armdelay
	else
		self:SendAttackAnim()
	end

	self:DoSwingEvent()

	self:PlayAttackSound()

	self:StopMoaning()

	if self.FrozenWhileSwinging then
		self:GetOwner():SetSpeed(1)
	end

	if self.MeleeDelay > 0 then
		self:SetSwingEndTime(CurTime() + self.MeleeDelay * armdelay)

		local trace = owner:CompensatedMeleeTrace(self.MeleeReach, self.MeleeSize)
		if trace.HitNonWorld and not trace.Entity:IsPlayer() then
			trace.IsPreHit = true
			self.PreHit = trace
		end

		self.IdleAnimation = CurTime() + (self:SequenceDuration() + (self.MeleeAnimationDelay or 0)) * armdelay
	else
		self:Swung()
	end
end

function SWEP:StopSwinging()
	self:SetSwingEndTime(0)
end

function SWEP:KnockedDown(status, exists)
	self:StopSwinging()
end

function SWEP:StopMoaning()
	if not self:IsMoaning() then return end
	self:SetMoaning(false)

	self:StopMoaningSound()
end

function SWEP:StartMoaning()
	if self:IsMoaning() or IsValid(self:GetOwner().Revive) or IsValid(self:GetOwner().FeignDeath) then return end
	self:SetMoaning(true)

	self:SetMoanHealth(self:GetOwner():Health())

	self:StartMoaningSound()
end

function SWEP:Deploy()
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if self.DelayWhenDeployed and self.Primary.Delay > 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(self:GetNextPrimaryFire() + 0.5)
	end

	return true
end

function SWEP:OnRemove()
	if IsValid(self:GetOwner()) then
		self:StopMoaning()
	end
end
SWEP.Holster = SWEP.OnRemove

function SWEP:SetMoaning(moaning)
	self:SetDTBool(0, moaning)
end

function SWEP:GetMoaning()
	return self:GetDTBool(0)
end
SWEP.IsMoaning = SWEP.GetMoaning

function SWEP:SetMoanHealth(health)
	self:SetDTInt(0, health)
end

function SWEP:GetMoanHealth()
	return self:GetDTInt(0)
end

function SWEP:SetSwingEndTime(time)
	self:SetDTFloat(0, time)
end

function SWEP:GetSwingEndTime()
	return self:GetDTFloat(0)
end

function SWEP:IsSwinging()
	return self:GetSwingEndTime() > 0
end
SWEP.IsAttacking = SWEP.IsSwinging

function SWEP:CanPrimaryAttack()
	if self.Owner:IsHolding() or self.Owner:GetBarricadeGhosting() then return false end

	return self:GetNextPrimaryFire() <= CurTime() and not self:IsSwinging()
end

/*
function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end


	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if self.SwingTime == 0 then
		self:MeleeSwing()
	else
		self:StartSwinging()
	end
	
end
*/
function SWEP:Holster()
	if CurTime() >= self:GetSwingEndTime() then
		if CLIENT then
			self:Anim_Holster()
		end

		return true
	end

	return false
end


function SWEP:MeleeSwing()
	local owner = self.Owner

	owner:DoAttackEvent()

	owner:LagCompensation(true)

	local tr = owner:CompensatedMeleeTrace(self.MeleeRange, self.MeleeSize)
	if tr.Hit then
		local damage = self.MeleeDamage
		local hitent = tr.Entity
		local hitflesh = tr.MatType == MAT_FLESH or tr.MatType == MAT_BLOODYFLESH or tr.MatType == MAT_ANTLION or tr.MatType == MAT_ALIENFLESH

		if self.HitAnim then
			self:SendWeaponAnim(self.HitAnim)
		end
		self.IdleAnimation = CurTime() + self:SequenceDuration()


		if hitflesh then
			util.Decal(self.BloodDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			self:PlayHitFleshSound()
			if SERVER and not (hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == owner:Team()) then
				util.Blood(tr.HitPos, math.Rand(damage * 0.25, damage * 0.6), (tr.HitPos - owner:GetShootPos()):GetNormalized(), math.Rand(damage * 6, damage * 12), true)
			end
			if not self.NoHitSoundFlesh then
				self:PlayHitSound()
			end
		else
			util.Decal(self.HitDecal, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			self:PlayHitSound()
		end


		if self.OnMeleeHit and self:OnMeleeHit(hitent, hitflesh, tr) then
			owner:LagCompensation(false)
			return
		end

		if SERVER and hitent:IsValid() then
		 timer.Simple(0.32, function()
			damage = self.MeleeDamage * damagemultiplier

			if hitent:GetClass() == "func_breakable_surf" then
				hitent:Fire("break", "", 0.01) -- Delayed because no way to do prediction.
			else
				local dmginfo = DamageInfo()
				dmginfo:SetDamagePosition(tr.HitPos)
				dmginfo:SetDamage(damage)
				dmginfo:SetAttacker(owner)
				dmginfo:SetInflictor(self)
				dmginfo:SetDamageType(self.DamageType)
				dmginfo:SetDamageForce(self.MeleeDamage * 20 * owner:GetAimVector())
				if hitent:IsPlayer() then
					hitent:MeleeViewPunch(damage)
					gamemode.Call("ScalePlayerDamage", hitent, tr.HitGroup, dmginfo)

					if self.MeleeKnockBack > 0 then
						hitent:ThrowFromPositionSetZ(tr.HitPos, self.MeleeKnockBack, nil, true)
					end
				end

				if hitent:IsPlayer() then
					hitent:TakeDamageInfo(dmginfo)
				else
					-- Again, no way to do prediction.
					timer.Simple(0, function()
						if hitent:IsValid() then
							-- Workaround for propbroken not calling.
							local h = hitent:Health()

							hitent:TakeDamageInfo(dmginfo)

							if hitent:Health() <= 0 and h ~= hitent:Health() then
								gamemode.Call("PropBroken", hitent, owner)
							end

							local phys = hitent:GetPhysicsObject()
							if hitent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
								hitent:SetPhysicsAttacker(owner)
							end
						end
					end)
				end
			end
			end)
		end

		if self.PostOnMeleeHit then self:PostOnMeleeHit(hitent, hitflesh, tr) end
	else
		if self.MissAnim then
			self:SendWeaponAnim(self.MissAnim)
		end
		self.IdleAnimation = CurTime() + self:SequenceDuration()
		self:PlaySwingSound()

		if self.PostOnMeleeMiss then self:PostOnMeleeMiss(tr) end
	end
				
	owner:LagCompensation(false)
end
/*
function SWEP:StopSwinging()
	self:SetSwingEnd(0)
end

function SWEP:IsSwinging()
	return self:GetSwingEnd() > 0
end

function SWEP:SetSwingEnd(swingend)
	self:SetDTFloat(0, swingend)
end

function SWEP:GetSwingEnd()
	return self:GetDTFloat(0)
end
*/

local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]      = ACT_HL2MP_IDLE_DUEL
}

function SWEP:SetWeaponHoldType( t )

	t = string.lower( t )
	local index = ActIndex[ t ]
	
	if ( index == nil ) then
		Msg( "SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set! (defaulting to normal)\n" )
		t = "normal"
		index = ActIndex[ t ]
	end

	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM_IDLE ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM ] 						= index+9
	
	-- "normal" jump animation doesn't exist
	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end
	
	-- these two aren't defined in ACTs for whatever reason
	if t == "knife" || t == "melee2" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = nil
	end
end

SWEP:SetWeaponHoldType("pistol")

function SWEP:TranslateActivity( act )
	if self:GetSwingEndTime() ~= 0 and self.ActivityTranslateSwing[act] then
		return self.ActivityTranslateSwing[act] or -1
	end

	return self.ActivityTranslate and self.ActivityTranslate[act] or -1
end
