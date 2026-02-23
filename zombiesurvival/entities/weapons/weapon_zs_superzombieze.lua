AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Супер Зомби"

SWEP.MeleeDamage = 45

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end