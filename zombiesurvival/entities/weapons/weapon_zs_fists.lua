AddCSLuaFile()

SWEP.PrintName = "Кулаки"

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel	= ""
SWEP.UseHands = true
SWEP.NoItemRender = true

SWEP.HoldType = "fist"

SWEP.WalkSpeed = SPEED_FASTEST
SWEP.OldWalkSpeed = 0

SWEP.MeleeDamage = 21
SWEP.DamageType = DMG_CLUB
SWEP.UppercutDamageMultiplier = 2
SWEP.HitDistance = 50
SWEP.MeleeKnockBack = 0

SWEP.ViewModelFOV = 52

SWEP.AutoSwitchFrom = true

SWEP.Unarmed = true

SWEP.Undroppable = true
SWEP.NoPickupNotification = true
SWEP.NoDismantle = true

SWEP.Primary.Delay = 0.57

SWEP.UppercutSlowDown = 11

SWEP.Weight = 2 -- This is the second crappiest weapon you could hope for, besides food
SWEP.SlotPos = 100

SWEP.IsFistWeapon = true
SWEP.SwingSound = Sound( "weapons/slam/throw.wav" )
SWEP.HitSound = Sound( "Flesh.ImpactHard" )

function SWEP:PreDrawViewModel(vm, wep, pl)
	vm:SetMaterial("engine/occlusionproxy")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextIdle")
	self:NetworkVar("Float", 2, "NextIdleHoldType")
	self:NetworkVar("Bool", 0, "HitPrevious")
	--self:NetworkVar("Bool", 0, "HitPrevious")
	self:NetworkVar("Int", 0, "PowerCombo")
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle( CurTime() + vm:SequenceDuration() )
end

SWEP.LastSwingHit = 0
SWEP.LastSwingStart = 0

function SWEP:PrimaryAttack(right)
	local owner = self:GetOwner()
	local time = CurTime()

	self:SetNextIdleHoldType(time + 1.5)
	owner:SetAnimation(PLAYER_ATTACK1)
	self.OldWalkSpeed = math.max(self.OldWalkSpeed, self.WalkSpeed)

	local anim = "fists_left"
	if ( right ) then anim = "fists_right" end
	if self:GetDTInt(5) >= 4 then
		anim = "fists_uppercut"
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self:EmitSound( self.SwingSound )

	self:UpdateNextIdle()

	local armdelay = owner:GetMeleeSpeedMul()
	local hitdelay = self.Primary.Delay / 3 * (owner.MeleeSwingDelayMul or 1) * armdelay
	owner:GetViewModel():SetPlaybackRate(1 / armdelay)
	if time < self.LastSwingStart + 1 and owner:IsSkillActive(SKILL_COMBOKNUCKLE) then
		if time < self.LastSwingHit + 0.75 then
			hitdelay = hitdelay / 1.2
			owner:GetViewModel():SetPlaybackRate(1.25 / armdelay)
		else
			hitdelay = hitdelay * 1.5
			owner:GetViewModel():SetPlaybackRate((1 / 1.75) / armdelay)
		end
	end

	self:SetNextMeleeAttack( time + hitdelay )

	self:SetNextPrimaryFire( time + self.Primary.Delay * armdelay )
	self:SetNextSecondaryFire( time + self.Primary.Delay * armdelay )

	self.LastSwingStart = time
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack( true )
end

function SWEP:GenerateDamageInfo(damage, hitpos)
	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(self:GetOwner())
	dmginfo:SetInflictor(self)
	dmginfo:SetDamageType(self.DamageType)
	dmginfo:SetDamagePosition(hitpos)
	dmginfo:SetDamage(damage)
	return dmginfo
end

function SWEP:DealDamage()
	local owner = self:GetOwner()
	local aimvector = owner:GetAimVector()
	local anim = self:GetSequenceName(owner:GetViewModel():GetSequence())
	local time = CurTime()

	local tr = owner:CompensatedMeleeTrace(self.HitDistance * (owner.MeleeRangeMul or 1), 3)

	local hitent = tr.Entity

	-- We need the second part for single player because SWEP:Think is ran shared in SP.
	if tr.Hit and not ( game.SinglePlayer() and CLIENT ) then
		self:EmitSound( self.HitSound, 75, 100, 1, CHAN_WEAPON + 1)
	end

	if self.OnMeleeHit and self:OnMeleeHit(hitent, hitflesh, tr) then
		return
	end

	local armdelay = owner:GetMeleeSpeedMul()
	local delay = self.Primary.Delay * (owner.UnarmedDelayMul or 1) * armdelay
	if tr.Hit then
		self.LastSwingHit = time
		if owner:IsSkillActive(SKILL_COMBOKNUCKLE) then
			delay = delay / 1.2
		end
	else
		if owner:IsSkillActive(SKILL_COMBOKNUCKLE) then
			delay = delay * 1.5
		end

		self:SetDTInt(5, math.max(0, self:GetDTInt(5) - 1))

		if owner.MeleePowerAttackMul and owner.MeleePowerAttackMul > 1 then
			self:SetPowerCombo(0)
		end
	end
	self:SetNextPrimaryFire( time + delay )
	self:SetNextSecondaryFire( time + delay )

	if hitent:IsValid() then
		local damagemultiplier = owner:GetTotalAdditiveModifier("UnarmedDamageMul", "MeleeDamageMultiplier")

		if anim == "fists_uppercut" then
			damagemultiplier = self.UppercutDamageMultiplier
		end

		local damage = self.MeleeDamage * damagemultiplier
		local dmginfo = self:GenerateDamageInfo(damage, tr.HitPos)

		local vel
		if hitent:IsPlayer() then
			self:PlayerHitUtil(owner, damage, hitent, dmginfo)

			if SERVER then
				hitent:SetLastHitGroup(tr.HitGroup)
				if tr.HitGroup == HITGROUP_HEAD then
					hitent:SetWasHitInHead()
				end

				if hitent:WouldDieFrom(dmginfo:GetDamage(), dmginfo:GetDamagePosition()) then
					if anim == "fists_left" then
						dmginfo:SetDamageForce(owner:GetRight() * 4912 + owner:GetForward() * 9998)
					elseif anim == "fists_right" then
						dmginfo:SetDamageForce(owner:GetRight() * -4912 + owner:GetForward() * 9989)
					elseif anim == "fists_uppercut" then
						dmginfo:SetDamageForce(owner:GetUp() * 5158 + owner:GetForward() * 10012)
					end
				else
					if owner:IsSkillActive(SKILL_CRITICALKNUCKLE) then
						hitent:ThrowFromPositionSetZ(tr.StartPos, 240 * (owner.MeleeKnockbackMultiplier or 1), nil, true)
					end

					self:SetDTInt(5, self:GetDTInt(5) + 1)

					if self:GetDTInt(5) >= 5 then
						self:SetDTInt(5, 0)

						hitent:AddLegDamage(self.UppercutSlowDown)
						hitent:AddArmDamage(self.UppercutSlowDown)
						hitent:EmitSound("weapons/crowbar/crowbar_impact1.wav", 75, math.random(60, 65))
					end
				end
			end

			vel = hitent:GetVelocity()
		else
			if owner.MeleePowerAttackMul and owner.MeleePowerAttackMul > 1 then
				self:SetPowerCombo(0)
			end
		end

		if IsFirstTimePredicted() then
			self:PostHitUtil(owner, hitent, dmginfo, tr, vel)
		end

		if SERVER and hitent:GetMoveType() == MOVETYPE_VPHYSICS then
			local phys = hitent:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:ApplyForceOffset( aimvector * 2000, tr.HitPos )
				hitent:SetPhysicsAttacker(owner)
			end
		end
	end
end

function SWEP:OnRemove()
	if CLIENT and self:GetOwner():IsValid() and self:GetOwner():IsPlayer() then
		local vm = self:GetOwner():GetViewModel()
		if IsValid(vm) then vm:SetMaterial("") end
	end
end

function SWEP:Holster(wep)
	if CurTime() >= self:GetNextPrimaryFire() then
		self:OnRemove()
		if CLIENT then
			self:Anim_Holster()
		end

		return true
	end

	return false
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_draw"))

	self:UpdateNextIdle()

	self:GetOwner():ResetSpeed()
	return true
end

function SWEP:Think()
	local idletime = self:GetNextIdle()
	local idle_holdtype_time = self:GetNextIdleHoldType()

	if idle_holdtype_time > 0 and CurTime() >= idle_holdtype_time then
		--self:SetWeaponHoldType("normal")
		self:SetNextIdleHoldType(0)
		self.WalkSpeed = self.OldWalkSpeed
		self:GetOwner():ResetSpeed()
	end

	if idletime > 0 and CurTime() >= idletime then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence("fists_idle_0"..math.random(2)))

		self:UpdateNextIdle()
	end

	local meleetime = self:GetNextMeleeAttack()

	if meleetime > 0 and CurTime() >= meleetime then
		self:DealDamage()
		self:SetNextMeleeAttack( 0 )
	end
end

function SWEP:TranslateActivity( act )
	return self.ActivityTranslate and self.ActivityTranslate[act] or -1
end

if not CLIENT then return end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end

function SWEP:DrawHUD()
	self:DrawCrosshairDot()
end

function SWEP:GetViewModelPosition(pos, ang)
	pos = pos - ang:Up()

	return pos, ang + self:ViewBob(self.Owner)
end
