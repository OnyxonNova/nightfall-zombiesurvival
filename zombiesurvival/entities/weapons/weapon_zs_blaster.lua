AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "'Бластер' Дробовик"
SWEP.Description = "Базовый дробовик который наносит значительный урон на близкой дистанции."

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(3, -0.6, -1)
	SWEP.HUD3DAng = Angle(90, 0, 0)
	SWEP.HUD3DScale = 0.015
	SWEP.HUD3DBone = "Weapon_Controller"
end

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_blaster/c_blaster.mdl"
SWEP.WorldModel = "models/weapons/w_supershorty.mdl"
SWEP.UseHands = true

SWEP.ReloadDelay = 0.4

SWEP.Primary.Sound = Sound("Weapon_Shotgun.NPC_Single")
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.6
SWEP.HeadshotMulti = 1.5
SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 7
SWEP.ConeMin = 5

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.PumpSound = Sound("Weapon_M3.Pump")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

SWEP.PumpActivity = ACT_SHOTGUN_PUMP

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Бластер' Снайперка", "Стреляет одной точной пулей, но меньший общий урон", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 6.25
	wept.Primary.NumShots = 1
	wept.ConeMin = wept.ConeMin * 0.15
	wept.ConeMax = wept.ConeMax * 0.3
end)
branch.NewNames = {[0]="Снайперка"}

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)

	timer.Simple(0.15, function()
		if IsValid(self) then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
			self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)

			if CLIENT and self:GetOwner() == MySelf then
				self:EmitSound("weapons/m3/m3_pump.wav", 65, 100, 0.4, CHAN_AUTO)
			end
		end
	end)
end
