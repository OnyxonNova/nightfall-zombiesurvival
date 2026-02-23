AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_drone")

SWEP.Base = "weapon_zs_drone"

SWEP.PrintName = "Импульсный Дрон"
SWEP.Description = "Развертываемое устройство с дистанционным управлением.\nИдеально подходит для разведки, поиска и целенаправленных атак.\nИспользует импульсные снаряды вместо пуль."

SWEP.Primary.Ammo = "pulse_cutter"

SWEP.DeployClass = "prop_drone_pulse"
SWEP.DeployAmmoType = "pulse"
SWEP.ResupplyAmmoType = "pulse"

SWEP.DamageDrone = 35
SWEP.TurretDelay = 0.36

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_DAMAGE_DRONE, 5.8)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_DELAY, -0.08)
