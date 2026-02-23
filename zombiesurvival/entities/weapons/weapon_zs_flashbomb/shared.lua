SWEP.PrintName = "Светошумовая Граната"
SWEP.Description = "Не наносит урона, но оглушает всех зомби вокруг вспышки, особенно если они смотрят на нее."

SWEP.Base = "weapon_zs_basethrown"

SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"

SWEP.Primary.Ammo = "flashbomb"
SWEP.Primary.Sound = Sound("weapons/pinpull.wav")

SWEP.MaxStock = 12

function SWEP:Precache()
	util.PrecacheSound("weapons/pinpull.wav")
end
