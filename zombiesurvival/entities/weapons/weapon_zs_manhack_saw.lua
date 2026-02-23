AddCSLuaFile()

SWEP.Base = "weapon_zs_manhack"

SWEP.PrintName = "Манхак с пилой"
SWEP.Description = "Модифицированный Манхак с насадкой для лезвие пилы.\nСущественно наносит большой урон и более живучий. Немного сложнее контролировать."

SWEP.DeployClass = "prop_manhack_saw"
SWEP.ControlWeapon = "weapon_zs_manhackcontrol_saw"

SWEP.Primary.Ammo = "manhack_saw"

SWEP.HitCooldown = 0.15
SWEP.DamageDrone = 48

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_DAMAGE_DRONE, 8)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HIT_COOLDOWN, -0.03)