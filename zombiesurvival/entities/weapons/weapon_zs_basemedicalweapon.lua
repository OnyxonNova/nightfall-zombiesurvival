AddCSLuaFile()

SWEP.Base = "weapon_zs_baseproj"
DEFINE_BASECLASS("weapon_zs_baseproj")

SWEP.UseHands = true

SWEP.Secondary.ClipSize = 30
SWEP.Secondary.DefaultClip = 30
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "Battery"
SWEP.Secondary.Automatic = true
SWEP.Secondary.RequiredClip = 3
SWEP.Secondary.Delay = 0.45

SWEP.Heal = 10

SWEP.SecondaryAmmoPurchase = true

if CLIENT then
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
end

function SWEP:CanReload()
	return self:GetNextReload() <= CurTime() and self:GetReloadFinish() == 0 and
		(
			self:GetMaxClip1() > 0 and self:Clip1() < self:GetPrimaryClipSize() and self:ValidPrimaryAmmo() and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) > 0
			or self:GetMaxClip2() > 0 and self:Clip2() < self:GetMaxClip2() and self:ValidSecondaryAmmo() and self:GetOwner():GetAmmoCount(self:GetSecondaryAmmoType()) > 0
		)
end

function SWEP:ShootBulletsNormal(dmg, numbul, cone)
	local owner = self:GetOwner()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()
	if self.Recoil > 0 then
		local r = math.Rand(0.8, 1)
		owner:ViewPunch(Angle(r * -self.Recoil, 0, (1 - r) * (math.random(2) == 1 and -1 or 1) * self.Recoil))
	end

	if self.PointsMultiplier then
		POINTSMULTIPLIER = self.PointsMultiplier
	end

	owner:LagCompensation(true)
	owner:FireBulletsLua(owner:GetShootPos(), owner:GetAimVector(), cone, numbul, dmg, nil, self.Primary.KnockbackScale, self.TracerName, self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)
	owner:LagCompensation(false)

	if self.PointsMultiplier then
		POINTSMULTIPLIER = nil
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local owner = self:GetOwner()

	local damagemultiplier = owner:Team() == TEAM_HUMAN and owner.FireweaponDamageMultiplier or 1

	local damage = self.Primary.Damage * damagemultiplier

	self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

	self:EmitFireSound()
	self:TakeAmmo()
	self:ShootBulletsNormal(damage, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

if SERVER then
	SWEP.Primary.Projectile = "projectile_healdart"
	SWEP.Primary.ProjVelocity = 2000

	function SWEP:EntModify(ent)
		local owner = self:GetOwner()
		local wep = owner:GetActiveWeapon()
		ent.Heal = self.Heal * (owner.MedDartEffMul or 1)
	end

	function SWEP:ShootBullets(damage, numshots, cone)
		local owner = self:GetOwner()
		self:SendWeaponAnimation()
		owner:DoAttackEvent()

		if self.Recoil > 0 then
			local r = math.Rand(0.8, 1)
			owner:ViewPunch(Angle(r * -self.Recoil, 0, (1 - r) * (math.random(2) == 1 and -1 or 1) * self.Recoil))
		end

		local ssfw, ssup
		if self.SameSpread then
			ssfw, ssup = math.Rand(0, 360), math.Rand(-cone, cone)
		end

		local wep = owner:GetActiveWeapon()
		local proj = self.Primary.Projectile
		for i = 0,numshots-1 do
			local ent = ents.Create(proj)
			if ent:IsValid() then
				ent:SetPos(owner:GetShootPos())
				ent:SetAngles(owner:EyeAngles())
				ent:SetOwner(owner)
				ent.ProjDamage = self.Primary.Damage * (owner.ProjectileDamageMul or 1)
				ent.ProjSource = self
				ent.ShotMarker = i
				ent.Team = owner:Team()

				self:EntModify(ent)
				ent:Spawn()

				local phys = ent:GetPhysicsObject()
				if phys:IsValid() then
					phys:Wake()

					local angle = owner:GetAimVector():Angle()
					angle:RotateAroundAxis(angle:Forward(), ssfw or math.Rand(0, 360))
					angle:RotateAroundAxis(angle:Up(), ssup or math.Rand(-cone, cone))

					ent.PreVel = angle:Forward() * self.Primary.ProjVelocity * (owner.ProjectileSpeedMul or 1)
					phys:SetVelocityInstantaneous(ent.PreVel)

					self:PhysModify(phys)
				end
			end
		end
	end
end

function SWEP:EmitFireSoundSecond()
end

function SWEP:CanSecondaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end

	if self:Clip2() < self.Secondary.RequiredClip then
		if self:CanReload() then
			self:Reload()
			return
		end
		self:EmitSound(self.DryFireSound)
		self:SetNextSecondaryFire(CurTime() + math.max(0.25, self.Secondary.Delay))
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	local owner = self:GetOwner()

	local damage = self.Primary.Damage

	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)

	self:EmitFireSoundSecond()
	self:TakeSecondaryAmmo(self.Secondary.RequiredClip)
	self:ShootBullets(damage, self.Primary.NumShots, 0)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

function SWEP:Deploy()
	if CLIENT and not self.SecondProjectile then
		hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		GAMEMODE.MedicalAura = true
	end

	return BaseClass.Deploy(self)
end

function SWEP:Holster()
	if CLIENT and self:GetOwner() == MySelf and not self.SecondProjectile then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_Holster()
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT and self:GetOwner() == MySelf and not self.SecondProjectile then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_OnRemove()
	end
end
