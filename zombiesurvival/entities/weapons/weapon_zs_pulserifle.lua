AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Горицвет' Импульсная Пушка"
SWEP.Description = "Наносит огромный урон и замедляет цель."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Vent"
	SWEP.HUD3DPos = Vector(1, 0, 0)
	SWEP.HUD3DScale = 0.018
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Airboat.FireGunHeavy")
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 8
SWEP.ConeMin = 0.6

SWEP.WalkSpeed = SPEED_SLOW

SWEP.IronSightsPos = Vector(-3, 1, 1)

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.TracerName = "AR2Tracer"

SWEP.FireAnimSpeed = 0.4
SWEP.LegDamage = 5.5

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.014, 1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Слуга' Импульсная Винтовка", "Увеличивает скорость перезарядки и урон по ногам, но снижает точность", function(wept)
	wept.ConeMin = 2.25
	wept.ConeMax = 3.75
	wept.ReloadSpeed = wept.ReloadSpeed * 0.85
	wept.LegDamage = 8

	wept.OnZombieKilled = function(self)
		local killer = self:GetOwner()

		if killer:IsValid() then
			for _,v in pairs(ents.FindByClass("prop_zapper*")) do
				if v:GetObjectOwner() == killer then
					v:SetNextZap(0)
				end
			end
		end
	end
end)
branch.NewNames = {[0]="Слуга"}

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValidZombie() then
		local activ = attacker:GetActiveWeapon()
		ent:AddLegDamageExt(activ.LegDamage, attacker, activ, SLOWTYPE_PULSE)
	end

	if IsFirstTimePredicted() then
		util.CreatePulseImpactEffect(tr.HitPos, tr.HitNormal)
	end
end
