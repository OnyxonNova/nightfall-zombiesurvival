SWEP.PrintName = "'Жало' Шоковая Станция"
SWEP.Description = "Убивает всех приближающихся зомби, отдавая приоритет хедкрабам. Имеет длительную перезарядку и использует импульсные патроны.\nНажмите ЛКМ, чтобы поставить жало.\nНажмите ПКМ или R, чтобы повернуть жало."

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = Model("models/props_c17/utilityconnecter006c.mdl")

SWEP.AmmoIfHas = true

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Ammo = "zapper"
SWEP.Primary.Automatic = true
SWEP.Primary.Damage = 25

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "dummy"

SWEP.ModelScale = 0.75

SWEP.MaxStock = 5

SWEP.WalkSpeed = SPEED_NORMAL
SWEP.FullWalkSpeed = SPEED_SLOWEST

SWEP.ResupplyAmmoType = "pulse"

SWEP.GhostStatus = "ghost_zapper"
SWEP.DeployClass = "prop_zapper"

SWEP.NoDeploySpeedChange = true
SWEP.AllowQualityWeapons = true

SWEP.LegDamage = 8

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_LEG_DAMAGE, 1)

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
	self:SetDeploySpeed(1.1)
	self:HideViewAndWorldModel()
end

function SWEP:SetReplicatedAmmo(count)
	self:SetDTInt(0, count)
end

function SWEP:GetReplicatedAmmo()
	return self:GetDTInt(0)
end

function SWEP:GetWalkSpeed()
	if self:GetPrimaryAmmoCount() > 0 then
		return self.FullWalkSpeed
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.DelayD)
		return false
	end

	return true
end

function SWEP:Holster()
	return true
end
