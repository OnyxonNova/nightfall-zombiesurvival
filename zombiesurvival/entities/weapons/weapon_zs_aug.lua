AddCSLuaFile()

SWEP.PrintName = "'AUG' Штурмовая Винтовка"
SWEP.Description = "Очень точная винтовка с хорошим уроном и с большим магазином."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	
	SWEP.VMPos = Vector(1, -1, 1.5)

	SWEP.HUD3DBone = "v_weapon.aug_Parent"
	SWEP.HUD3DPos = Vector(-1.1, -3.5, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_AUG.Single")
SWEP.Primary.Damage = 29.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.0965
SWEP.HeadshotMulti = 2.45

SWEP.Primary.ClipSize = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ConeMax = 8.75
SWEP.ConeMin = 0.85

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 4
SWEP.MaxStock = 3

SWEP.IronSightsPos = Vector(-2.32, 10, 2.75)
SWEP.IronSightsAng = Vector(0, 1.766, 0)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Инферно' Зажигательная Винтовка", "Стреляет пылающими пулями, но урон снижен", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.9

	wept.BulletCallback = function(attacker, tr, dmginfo)
		local ent = tr.Entity
		if SERVER and math.random(1) == 1 and ent:IsValidLivingZombie() then
			ent:Ignite(6)
			for __, fire in pairs(ents.FindByClass("entityflame")) do
				if fire:IsValid() and fire:GetParent() == ent then
					fire:SetOwner(attacker)
					fire:SetPhysicsAttacker(attacker)
					fire.AttackerForward = attacker
				end
			end
		end
	end
end)
branch.NewNames = {[0]="Инферно"}
