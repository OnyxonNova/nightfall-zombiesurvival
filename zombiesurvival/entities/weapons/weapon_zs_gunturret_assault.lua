AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "Штурмовая Турель"
SWEP.Description = "Более тяжелая турель, в которой используются патроны для штурмовой винтовки.\nНажмите ЛКМ, чтобы поставить турель.\nНажмите ПКМ или R, чтобы повернуть турель.\nНажмите E на развернутой турели, чтобы дать ей часть ваших штурмовых патронов."

SWEP.Primary.Damage = 22.5

SWEP.GhostStatus = "ghost_gunturret_assault"
SWEP.DeployClass = "prop_gunturret_assault"

SWEP.TurretAmmoType = "ar2"
SWEP.TurretAmmoStartAmount = 100
SWEP.TurretSpread = 2

SWEP.Tier = 4

SWEP.Primary.Ammo = "turret_assault"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.5)
