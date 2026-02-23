SWEP.PrintName = "'Спаситель' Мед. Пистолет"
SWEP.Description = "Стреляет дротиками, которые исцеляют и дают прирост скорости.\nЗа исцеление даёт вам поинты."
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.Base = "weapon_zs_baseproj"
DEFINE_BASECLASS("weapon_zs_baseproj")

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")

SWEP.Primary.Delay = 0.23

SWEP.Primary.ClipSize = 24
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Ammo = "Battery"
SWEP.RequiredClip = 3

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.ReloadSpeed = 0.85

SWEP.BuffDuration = 10

SWEP.IronSightsPos = Vector(-5.88, 5, 1.5)
SWEP.IronSightsAng = Vector(-1, -1, 10)

SWEP.AllowQualityWeapons = true

SWEP.Heal = 10

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 6)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_BUFF_DURATION, 2)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 0.6)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Усиливающий Пистолет", "Стреляет дротиками, которые дают силу.\nВы получаете поинты за урон, нанесённый теми, кого вы усилили.", function(wept)
	wept.SecondProjectile = true
	wept.StrengthGun = true
	if CLIENT then
		for k,v in pairs(wept.VElements) do
			v.color = Color(255, 50, 50, 255)
		end
		for k,v in pairs(wept.WElements) do
			v.color = Color(255, 50, 50, 255)
		end
	end

end)
branch.Colors = {[0]=Color(240, 70, 70)}
branch.NewNames = {[0]="Сила"}
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "Защищающий Пистолет", "Стреляет дротиками, которые дают защиту.\nПоглощённый урон с защиты даёт вам поинты.", function(wept)
	wept.SecondProjectile = true
	wept.DefenceGun = true
	if SERVER then
		wept.EntModify = function(self, ent)
			ent:SetDTBool(0, true)
			ent:SetSeeked(self:GetSeekedPlayer() or nil)
			ent.BuffDuration = wept.BuffDuration
		end
	else
		for k,v in pairs(wept.VElements) do
			v.color = Color(100, 120, 215, 255)
		end
		for k,v in pairs(wept.WElements) do
			v.color = Color(100, 120, 215, 255)
		end
	end

end)
branch.Colors = {[0]=Color(115, 140, 185)}
branch.NewNames = {[0]="Защита"}

function SWEP:GetFireDelay()
	local owner = self:GetOwner()
	return (self.Primary.Delay * (owner.MedgunFireDelayMul or 1)) / (owner:GetStatus("frost") and 0.7 or 1)
end

function SWEP:GetReloadSpeedMultiplier()
	local owner = self:GetOwner()
	return BaseClass.GetReloadSpeedMultiplier(self) * (owner.MedgunReloadSpeedMul or 1) -- Convention is now BaseClass instead of self.BaseClass
end

function SWEP:CanSecondaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end

	return self:GetNextSecondaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	self:SetNextSecondaryFire(CurTime() + 0.1)

	local owner = self:GetOwner()
	if not owner:IsSkillActive(SKILL_SMARTTARGETING) then return end

	local targetent = owner:CompensatedMeleeTrace(2048, 2, nil, nil, true).Entity
	local locked = targetent and targetent:IsValidLivingHuman()

	if CLIENT then
		self:EmitSound(locked and "npc/scanner/combat_scan4.wav" or "npc/scanner/scanner_scan5.wav", 65, locked and 75 or 200)
	end
	self:SetSeekedPlayer(locked and targetent)
end

function SWEP:SetSeekedPlayer(ent)
	if isbool(ent) then return end
	self:SetDTEntity(6, ent)
end

function SWEP:GetSeekedPlayer()
	return self:GetDTEntity(6)
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	GAMEMODE:DoChangeDeploySpeed(self)
	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:Deploy()
	if CLIENT and not self.SecondProjectile then
		hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		GAMEMODE.MedicalAura = true
	end

	return BaseClass.Deploy(self)
end

function SWEP:Holster()
	if CLIENT and self:GetOwner() == MySelf and not self.SecondProjectile then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_Holster()
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT and self:GetOwner() == MySelf and not self.SecondProjectile then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_OnRemove()
	end
end
