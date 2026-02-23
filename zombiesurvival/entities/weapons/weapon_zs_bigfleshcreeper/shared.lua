SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Матка"

SWEP.MeleeDelay = 0.7
SWEP.MeleeReach = 74
SWEP.MeleeDamage = 40
SWEP.MeleeForceScale = 1.25
SWEP.MeleeSize = 4.5
SWEP.MeleeDamageType = DMG_SLASH
SWEP.Primary.Delay = 1.5

SWEP.Secondary.Automatic = false

AccessorFuncDT(SWEP, "RightClickStart", "Float", 2)
AccessorFuncDT(SWEP, "AttackAnimTime", "Float", 3)


SWEP.ChargeDamage = 185
SWEP.ChargeDamageVsPlayerMul = 0.4
SWEP.ChargeReach = 26
SWEP.ChargeSize = 12
SWEP.ChargeStartDelay = 0.35
SWEP.ChargeDelay = 2
SWEP.ChargeRecovery = 0.75
SWEP.ChargeTime = 5
SWEP.ChargeAccel = 0.5
SWEP.ChargeKnockdown = 1.75
SWEP.NextAllowCharge = 0

SWEP.BotMeleeReach = 135
SWEP.BotSecondaryReach = 0
SWEP.BotReloadReach = 900

function SWEP:Think()
	self.BaseClass.Think(self)

	if self:GetHoldingRightClick() and not self:GetOwner():KeyDown(IN_ATTACK2) then
		self:SetRightClickStart(0)

		if self.BuildSoundPlaying then
			self.BuildSoundPlaying = false
			self.BuildSound:ChangeVolume(0, 0.5)
		end
	elseif self:IsBuilding() then
		if not self.BuildSoundPlaying then
			self.BuildSoundPlaying = true
			self.BuildSound:ChangeVolume(0.45, 0.5)
		end

		if SERVER then
			self:BuildingThink()
		end
	end

	local owner = self:GetOwner()

	if self:IsCharging() then
		if owner:WaterLevel() >= 2 or CurTime() > self:GetChargeStart() + self.ChargeTime  then
			self:StopCharge()
		elseif IsFirstTimePredicted() then
			local dir = owner:GetVelocity()
			dir:Normalize()

			local chargemul = math.min(self:GetCharge(), owner:GetVelocity():LengthSqr() / 193600)
			local traces = owner:CompensatedZombieMeleeTrace(self.ChargeReach, self.ChargeSize, owner:WorldSpaceCenter(), dir)
			local damage = self:GetDamage(self:GetTracesNumPlayers(traces), self.ChargeDamage * chargemul)

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
					if ent and ent:IsValid() and not ent:IsProjectile() then
						hit = true
						self:MeleeHit(ent, trace, damage * (ent:IsPlayer() and self.ChargeDamageVsPlayerMul or ent.PounceWeakness or 1) * (self:IsChargeCritical() and not ent:IsPlayer() and 2 or 1), 1)
						if ent:IsPlayer() then
							ent:ThrowFromPositionSetZ(trace.StartPos, 240 * chargemul + owner:GetVelocity():Length() * 0.5)
							if CurTime() >= (ent.NextKnockdown or 0) and self:IsChargeCritical() then
								ent:GiveStatus("knockdown", self.ChargeKnockdown * chargemul)
								ent.NextKnockdown = CurTime() + 4 * chargemul
							end
						end
					end
				end
			end

			if not self.CriticalCharge and self:IsChargeCritical() then
				self:PlayCriticalChargeStartSound()
				self.CriticalCharge = true
			end

			if hit then
				self:PlayChargeHitSound()
				self:StopCharge()
			end
		end
	elseif self:GetChargeStart() > 0 and CurTime() > self:GetChargeStart() then
		self:StartCharge()
	elseif self.m_ViewAngles then
		self.m_ViewAngles = nil
	end

	self:NextThink(CurTime())
	return true
end

function SWEP:StartCharge()
	if self:IsCharging() then return end

	local owner = self:GetOwner()
	if owner:IsOnGround() then
		self:SetCharging(true)

		self.m_ViewAngles = owner:EyeAngles()

		if IsFirstTimePredicted() then
			self:PlayChargeSound()
		end
		owner:SetAnimation(PLAYER_JUMP)
	else
		self:SetNextSecondaryFire(CurTime())
		self.m_ViewAngles = nil
		self.NextAllowJump = CurTime()
		self.NextAllowCharge = CurTime() + self.ChargeDelay
		self:SetNextPrimaryFire(CurTime() + self.ChargeRecovery)
		self:GetOwner():ResetJumpPower()
	end
end

function SWEP:StopCharge()
	if not self:IsCharging() then return end

	self:SetChargeStart(0)
	self:SetCharging(false)
	self:SetNextSecondaryFire(CurTime())
	self.m_ViewAngles = nil
	self.NextAllowJump = CurTime() + 0.25
	self.NextAllowCharge = CurTime() + self.ChargeDelay
	self:SetNextPrimaryFire(CurTime() + self.ChargeRecovery)
	self:GetOwner():ResetJumpPower()
	self.CriticalCharge = nil
end


function SWEP:PlayChargeHitSound()
	self:EmitSound("npc/antlion_guard/shove1.wav")
	self:EmitSound("npc/fast_zombie/wake1.wav", 75, math.random(75, 80), nil, CHAN_AUTO)
end

function SWEP:PlayCriticalChargeStartSound()
	self:EmitSound("npc/zombie_poison/pz_throw3.wav", 75, math.random(85, 90), nil, CHAN_AUTO)
end

function SWEP:PlayChargeSound()
	self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 75, math.random(100,116), nil, CHAN_AUTO)
end

function SWEP:PlayChargeStartSound()
	self:EmitSound("npc/fast_zombie/leap1.wav", 75, math.random(75,80), nil, CHAN_AUTO)
end

function SWEP:Move(mv)
	local charge = self:GetCharge()

	if self:GetChargeStart() > 0 and charge <= 0 then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)
	elseif charge > 0 then
		mv:SetForwardSpeed(10000)
		mv:SetSideSpeed(mv:GetSideSpeed() * 0.1)

		local mul = 1 + charge * 2 + (self:IsChargeCritical() and 0.5 or 0)
		mv:SetMaxSpeed(mv:GetMaxSpeed() * mul)
		mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * mul)
	end
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent.ZombieConstruction then
		damage = damage * 10
	end

	if ent:IsValid() then
		local noknockdown = true
		if CurTime() >= (ent.NextKnockdown or 0) then
			noknockdown = false
			ent.NextKnockdown = CurTime() + 4
			if ent:IsPlayer() then
				ent:GiveStatus("knockdown", 2)
			end
		end
		ent:ThrowFromPositionSetZ(trace.StartPos, ent:IsPlayer() and 300 or 800, nil, noknockdown)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	self.BuildSound = CreateSound(self, "npc/antlion/charge_loop1.wav")
	self.BuildSound:PlayEx(0, 100)

	self.FlySound = CreateSound(self, "npc/antlion/fly1.wav")
end

function SWEP:OnRemove()
	self.BaseClass.OnRemove(self)

	self.BuildSound:Stop()
	self.FlySound:Stop()
end

function SWEP:PrimaryAttack()
	if self:IsCharging() or self:GetChargeStart() > 0 then return end
	if self:GetHoldingRightClick() or not self:GetOwner():OnGround() then return end

	self.BaseClass.PrimaryAttack(self)

	if self:IsSwinging() then
		self:SetAttackAnimTime(CurTime() + self.Primary.Delay)
	end
end

function SWEP:SecondaryAttack()
	if self:IsCharging() or self:GetChargeStart() > 0 then return end
	if self:IsSwinging() or self:IsInAttackAnim() or not self:GetOwner():OnGround() then return end

	self:SetRightClickStart(CurTime())
end

function SWEP:GetHoldingRightClick()
	return self:GetRightClickStart() > 0
end

function SWEP:IsBuilding()
	return self:GetHoldingRightClick() and (CurTime() - self:GetRightClickStart()) >= 1
end

function SWEP:Reload()
	if self:IsCharging() or self:GetChargeStart() > 0 then return end

	if self:GetOwner():IsOnGround() then
		if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self.NextAllowCharge then return end

		self:SetNextPrimaryFire(math.huge)
		self:SetChargeStart(CurTime() + self.ChargeStartDelay)

		self:GetOwner():ResetJumpPower()
		if IsFirstTimePredicted() then
			self:PlayChargeStartSound()
		end
	end
end

function SWEP:IsMoaning()
	return false
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_pull"..math.random(4)..".wav", 70)
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_pull"..math.random(4)..".wav", 70, 85)
end

function SWEP:PlayAttackSound()
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/body/body_medium_impact_hard"..math.random(6)..".wav", 70, math.random(110, 120), nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
	self:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 70, math.random(90, 100), nil, CHAN_AUTO)
end

function SWEP:IsInAttackAnim()
	return self:GetAttackAnimTime() > 0 and CurTime() < self:GetAttackAnimTime()
end

function SWEP:SetChargeStart(time)
	self:SetDTFloat(1, time)
end

function SWEP:GetChargeStart()
	return self:GetDTFloat(1)
end

function SWEP:GetCharge()
	if self:GetChargeStart() == 0 then return 0 end

	return math.Clamp((CurTime() - self:GetChargeStart()) / self.ChargeAccel, 0, 1)
end

function SWEP:IsChargeCritical()
	if not self:IsCharging() then return false end

	return CurTime() >= self:GetChargeStart() + self.ChargeTime * 0.4
end

function SWEP:SetCharging(charging)
	self:SetDTBool(2, charging)
end

function SWEP:GetCharging()
	return self:GetDTBool(2)
end
SWEP.IsCharging = SWEP.GetCharging