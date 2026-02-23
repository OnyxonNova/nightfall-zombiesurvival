SWEP.PrintName = "'Преосвященство' Пушка Частиц"
SWEP.Description = "Запускает снаряды, стреляя трассировщиками частиц во время движения."

SWEP.Base = "weapon_zs_baseproj"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "impactmine"
SWEP.Primary.Delay = 0.5
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Damage = 24.5
SWEP.Primary.NumShots = 3

SWEP.ConeMax = 2
SWEP.ConeMin = 0.95

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 4

SWEP.ReloadSpeed = 0.6

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.075)

function SWEP:EmitFireSound()
	self:EmitSound("weapons/grenade_launcher1.wav", 75, math.random(67, 74), 0.4)
	self:EmitSound("npc/attack_helicopter/aheli_mine_drop1.wav", 75, 65, 0.8, CHAN_AUTO + 20)
end

function SWEP:EmitReloadSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/ar2/ar2_reload_rotate.wav", 70, 55)
		self:EmitSound("items/battery_pickup.wav", 70, 77, 0.85, CHAN_AUTO)
	end
end

function SWEP:EmitReloadFinishSound()
	if IsFirstTimePredicted() then
		self:EmitSound("weapons/ar2/ar2_reload_push.wav", pos, 70, math.Rand(130, 140))
	end
end
