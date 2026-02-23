AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "Ракетная Турель"
SWEP.Description = "Автоматическая турель, которая запускает взрывчатки.\nНажмите ЛКМ, чтобы поставить турель.\nНажмите ПКМ или R, чтобы повернуть турель.\nНажмите E на развернутой турели, чтобы дать ей часть взрычатки."

SWEP.Primary.Damage = 91

SWEP.GhostStatus = "ghost_gunturret_rocket"
SWEP.DeployClass = "prop_gunturret_rocket"
SWEP.TurretAmmoType = "impactmine"
SWEP.TurretAmmoStartAmount = 12
SWEP.TurretSpread = 1

SWEP.Primary.Ammo = "turret_rocket"

SWEP.Tier = 4

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.45)
