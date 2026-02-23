AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"
DEFINE_BASECLASS("weapon_zs_zombie")

SWEP.PrintName = "Супер Зомби"

SWEP.ViewModel = Model("models/Weapons/v_zombiearms.mdl")
SWEP.ViewModelFOV = 70

SWEP.MeleeDamage = 45

SWEP.PounceDelay = 1.1
SWEP.PounceVelocity = 900
SWEP.PounceDamage = 6
SWEP.PounceStartDelay = 0.5
SWEP.PounceReach = 26
SWEP.PounceSize = 12

SWEP.MeleeDelay = 0.74
SWEP.Primary.Delay = 1.2

SWEP.Anchor = 6

SWEP.ReloadPressed = false
SWEP.ReloadDelay = 3

SWEP.NextClimbSound = 0
SWEP.NextAllowPounce = 0

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() and self.Anchor then
		ent:GiveStatus("anchor", self.Anchor)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:Reload()
    local owner = self:GetOwner()

    if self:GetNextSecondaryFire() > CurTime() then
        return
    end

    if self.Reloading then
        return
    end

    if owner:GetActiveWeapon() == self and owner:KeyDown(IN_ATTACK2) then
        return
    end

    if owner:IsValid() and owner:IsPlayer() then
        local status1 = owner:GiveStatus("zombie_battlecry", 1)

        if status1 and status1:IsValid() then
        end
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end

function SWEP:Think()
	BaseClass.Think(self)
	
	local curtime = CurTime()
	local owner = self:GetOwner()

	if self.NextAllowJump and self.NextAllowJump <= curtime then
		self.NextAllowJump = nil

		owner:ResetJumpPower()
	end

	if self:GetClimbing() then
		if self:GetClimbSurface() and owner:KeyDown(IN_ATTACK2) then
			if curtime >= self.NextClimbSound and IsFirstTimePredicted() then
				local speed = owner:GetVelocity():LengthSqr()
				if speed >= 2500 then
					if speed >= 10000 then
						self.NextClimbSound = curtime + 0.25
					else
						self.NextClimbSound = curtime + 0.8
					end

					self:EmitSound("player/footsteps/metalgrate"..math.random(4)..".wav")
				end
			end
		else
			self:StopClimbing()
		end
	end

	if self:GetPouncing() then
		if owner:IsOnGround() or owner:WaterLevel() >= 2 then
			self:StopPounce()
		else
			local dir = owner:GetAimVector()
			dir.z = math.Clamp(dir.z, -0.5, 0.9)
			dir:Normalize()

			local traces = owner:CompensatedZombieMeleeTrace(self.PounceReach, self.PounceSize, owner:WorldSpaceCenter(), dir)
			local damage = self:GetDamage(self:GetTracesNumPlayers(traces), self.PounceDamage)

			local hit = false
			for _, trace in ipairs(traces) do
				if not trace.Hit then continue end

				if trace.HitWorld then
					if trace.HitNormal.z < 0.8 then
						hit = true
						self:MeleeHitWorld(trace)
					end
				else
					local ent = trace.Entity
					if ent and ent:IsValid() then
						hit = true
						self:MeleeHit(ent, trace, damage * (ent:IsPlayer() and self.PounceDamageVsPlayerMul or ent.PounceWeakness or 1), ent:IsPlayer() and 1 or 10)

					end
				end
			end

			if hit then
				if IsFirstTimePredicted() then
					self:PlayPounceHitSound()
				end

				self:StopPounce()
			end
		end
	elseif self:GetPounceTime() > 0 and curtime >= self:GetPounceTime() then
		self:StartPounce()
	end

	self:NextThink(curtime)
	return true
end


function SWEP:Move(mv)
	if self:IsPouncing() or self:GetPounceTime() > 0 then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)
	elseif self:GetClimbing() then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)

		local owner = self:GetOwner()
		local tr = self:GetClimbSurface()
		local angs = owner:SyncAngles()
		local dir = tr and tr.Hit and (tr.HitNormal.z <= -0.5 and (angs:Forward() * -1) or math.abs(tr.HitNormal.z) < 0.75 and tr.HitNormal:Angle():Up()) or Vector(0, 0, 1)
		local vel = Vector(0, 0, 4)

		if owner:KeyDown(IN_FORWARD) then
			owner:SetGroundEntity(nil)
			vel = vel + dir * 250 --160
		end
		if owner:KeyDown(IN_BACK) then
			vel = vel + dir * -250 ---160
		end

		if vel.z == 4 then
			if owner:KeyDown(IN_MOVERIGHT) then
				vel = vel + angs:Right() * 100 --60
			end
			if owner:KeyDown(IN_MOVELEFT) then
				vel = vel + angs:Right() * -100 ---60
			end
		end

		mv:SetVelocity(vel)

		return true
	end
end

local climbtrace = {mask = MASK_SOLID_BRUSHONLY, mins = Vector(-5, -5, -5), maxs = Vector(5, 5, 5)}
function SWEP:GetClimbSurface()
	local owner = self:GetOwner()

	local fwd = owner:SyncAngles():Forward()
	local up = owner:GetUp()
	local pos = owner:GetPos()
	local height = owner:OBBMaxs().z
	local tr
	local ha
	for i=5, height, 5 do
		if not tr or not tr.Hit then
			climbtrace.start = pos + up * i
			climbtrace.endpos = climbtrace.start + fwd * 36
			tr = util.TraceHull(climbtrace)
			ha = i
			if tr.Hit and not tr.HitSky then break end
		end
	end

	if tr.Hit and not tr.HitSky then
		climbtrace.start = pos + up * ha --tr.HitPos + tr.HitNormal
		climbtrace.endpos = climbtrace.start + owner:SyncAngles():Up() * (height - ha)
		local tr2 = util.TraceHull(climbtrace)
		if tr2.Hit and not tr2.HitSky then
			return tr2
		end

		return tr
	end
end

function SWEP:StartClimbing()
	if self:GetClimbing() then return end

	self:SetClimbing(true)

	self:SetNextSecondaryFire(CurTime() + 0.5)
end

function SWEP:StopClimbing()
	if not self:GetClimbing() then return end

	self:SetClimbing(false)
	self:SetNextSecondaryFire(CurTime())
end

local climblerp = 0
function SWEP:GetViewModelPosition(pos, ang)
	climblerp = math.Approach(climblerp, self:IsClimbing() and not self:IsSwinging() and 1 or 0, FrameTime() * ((climblerp + 1) ^ 3))
	ang:RotateAroundAxis(ang:Right(), 64 * climblerp)
	if climblerp > 0 then
		pos = pos + -8 * climblerp * ang:Up() + -12 * climblerp * ang:Forward()
	end

	return pos, ang + self:ViewBob(self.Owner)
end

function SWEP:SecondaryAttack()
	if self:IsPouncing() or self:IsClimbing() or self:GetPounceTime() > 0 then return end

	if self:GetOwner():IsOnGround() then
		if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self.NextAllowPounce then return end

		self:SetNextPrimaryFire(math.huge)
		self:SetPounceTime(CurTime() + self.PounceStartDelay)

		self:GetOwner():ResetJumpPower()

		if IsFirstTimePredicted() then
			self:PlayPounceStartSound()
		end
	elseif self:GetClimbSurface() then
		self:StartClimbing()
	end
end

function SWEP:StartPounce()
	if self:IsPouncing() then return end

	self:SetPounceTime(0)

	local owner = self:GetOwner()
	if owner:IsOnGround() then
		self:SetPouncing(true)

		self.m_ViewAngles = owner:EyeAngles()

		if IsFirstTimePredicted() then
			self:PlayPounceSound()
		end

		local ang = owner:EyeAngles()
		ang.pitch = math.min(-20, ang.pitch)

		owner:SetGroundEntity(NULL)
		owner:SetVelocity((1 - 0.5 * (owner:GetLegDamage() / GAMEMODE.MaxLegDamage)) * self.PounceVelocity * ang:Forward())
		owner:SetAnimation(PLAYER_JUMP)
	else
		self:SetNextSecondaryFire(CurTime())
		self.m_ViewAngles = nil
		self.NextAllowJump = CurTime()
		self.NextAllowPounce = CurTime() + self.PounceDelay
		self:SetNextPrimaryFire(CurTime() + 0.1)
		self:GetOwner():ResetJumpPower()
	end
end

function SWEP:StopPounce()
	if not self:IsPouncing() then return end

	self:SetPouncing(false)
	self:SetNextSecondaryFire(CurTime())
	self.m_ViewAngles = nil
	self.NextAllowJump = CurTime() + 0.25
	self.NextAllowPounce = CurTime() + self.PounceDelay
	self:SetNextPrimaryFire(CurTime() + 0.1)
	self:GetOwner():ResetJumpPower()
end

function SWEP:ResetJumpPower(power)
	if self.Removing then return end

	if self.NextAllowJump and CurTime() < self.NextAllowJump or self:IsPouncing() or self:GetPounceTime() > 0 then
		return 1
	end
end

function SWEP:PlayPounceStartSound()
    self:EmitSound(")npc/fast_zombie/leap1.wav", 75, math.random(75, 80))
end

function SWEP:PlayPounceSound()
    self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 75, math.random(100, 116))
end

function SWEP:PlayPounceHitSound()
	self:EmitSound("physics/flesh/flesh_strider_impact_bullet1.wav")
	self:EmitSound("npc/fast_zombie/wake1.wav", nil, nil, nil, CHAN_AUTO)
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

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav")
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav")
end

function SWEP:StartSwingingSound()
end

function SWEP:StopSwingingSound()
end

function SWEP:PlaySwingEndSound()
end

function SWEP:SetPounceTime(time)
	self:SetDTFloat(2, time)
end

function SWEP:GetPounceTime()
	return self:GetDTFloat(2)
end

function SWEP:SetPouncing(leaping)
	self:SetDTBool(3, leaping)
end

function SWEP:GetPouncing()
	return self:GetDTBool(3)
end
SWEP.IsPouncing = SWEP.GetPouncing

function SWEP:SetClimbing(climbing)
	self:SetDTBool(1, climbing)
end

function SWEP:GetClimbing()
	return self:GetDTBool(1)
end
SWEP.IsClimbing = SWEP.GetClimbing