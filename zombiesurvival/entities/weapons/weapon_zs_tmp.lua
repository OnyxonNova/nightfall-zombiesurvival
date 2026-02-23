AddCSLuaFile()

SWEP.PrintName = "'TMP' SMG"
SWEP.Description = "Скрывает ауру от зомби и довольно-таки неточная, но имеет очень высокий урон в секунду для SMG."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55

	SWEP.HUD3DBone = "v_weapon.TMP_Parent"
	SWEP.HUD3DPos = Vector(-1.25, -3.5, -1)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015

	SWEP.VMPos = Vector(-1, -2, 1)
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_TMP.Single")
SWEP.Primary.Damage = 21
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.06

SWEP.Primary.ClipSize = 25
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadSpeed = 0.72
SWEP.FireAnimSpeed = 3

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 6.5
SWEP.ConeMin = 2.9

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.Tier = 3

SWEP.IronSightsPos = Vector(-5.85, 5, 1.25)

SWEP.WalkSpeed = SPEED_NORMAL

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.8125)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.45)

function SWEP:GetAuraRange()
	return 512
end
