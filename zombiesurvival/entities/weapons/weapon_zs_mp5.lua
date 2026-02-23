AddCSLuaFile()

SWEP.PrintName = "'MP5' SMG"
SWEP.Description = "Обыкновенный пистолет-пулемет способный на очень хороший урон на дальней дистанции."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50

	SWEP.HUD3DBone = "v_weapon.MP5_Parent"
	SWEP.HUD3DPos = Vector(-1.25, -3.75, -6)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Damage = 22
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.09

SWEP.Primary.ClipSize = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 7
SWEP.ConeMin = 1.25

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 3

SWEP.IronSightsAng = Vector(0.8, 0, 0)
SWEP.IronSightsPos = Vector(-5.33, 7, 1.8)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Сокрушитель' SMG", "Доп. урон скелетным врагам, но стреляет и перезаряжается медленнее", function(wept)
	wept.Primary.Delay = 0.15
	wept.ReloadSpeed = 0.9

	wept.BulletCallback = function(attacker, tr, dmginfo)
		local trent = tr.Entity

		if SERVER and trent and trent:IsValidZombie() then
			if trent:GetZombieClassTable().Skeletal then
				dmginfo:SetDamage(dmginfo:GetDamage() * 1.2)
			end

			if math.random(6) == 1 then
				trent:ThrowFromPositionSetZ(tr.StartPos, 150, nil, true)
			end
		end
	end
end)
branch.NewNames = {[0]="Сокрушитель"}