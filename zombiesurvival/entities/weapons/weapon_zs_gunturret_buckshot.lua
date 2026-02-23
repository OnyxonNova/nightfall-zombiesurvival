AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "Турель-Дробовик"
SWEP.Description = "Автоматическая турель, которая стреляет разнесенными выстрелами.\nНажмите ЛКМ, чтобы поставить турель.\nНажмите ПКМ или R, чтобы повернуть турель.\nНажмите E на развернутой турели, чтобы дать ей часть ваших патронов для картечи."

SWEP.Primary.Damage = 6.75

SWEP.GhostStatus = "ghost_gunturret_buckshot"
SWEP.DeployClass = "prop_gunturret_buckshot"
SWEP.TurretAmmoType = "buckshot"
SWEP.TurretAmmoStartAmount = 25
SWEP.TurretSpread = 5

SWEP.Primary.Ammo = "turret_buckshot"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.9)
