AddCSLuaFile()

SWEP.PrintName = "'FAMAS' Штурмовая Винтовка"
SWEP.Description = "Штурмовая винтовка которая имеет хороший урон и точность."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
	SWEP.VMPos = Vector(0, 0, 0.5)

	SWEP.HUD3DBone = "v_weapon.famas"
	SWEP.HUD3DPos = Vector(1.1, -3.5, 10)
	SWEP.HUD3DScale = 0.02
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_FAMAS.Clipout")
SWEP.Primary.Sound = Sound("Weapon_FAMAS.Single")
SWEP.Primary.Damage = 16
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.175

SWEP.Primary.ClipSize = 22
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 5.6
SWEP.ConeMin = 1.3

SWEP.ReloadSpeed = 1.1

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-3, 3, 1.5)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.25, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.2, 1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Клерон' Боевая Винтовка", "Теряет автоматическую скорострельность, но получает небольшой урон и точность", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 1.2
	wept.Primary.ClipSize = 15
	wept.ConeMin = wept.ConeMin * 0.8
	wept.Primary.Delay = 0.205
	wept.ConeMax = wept.ConeMax * 0.8
	wept.Primary.Automatic = false
end)
branch.NewNames = {[0]="Клерон"}