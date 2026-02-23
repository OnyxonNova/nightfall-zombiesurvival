AddCSLuaFile()

SWEP.PrintName = "Аптечка база"
SWEP.Slot = 4
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFOV = 57
	SWEP.ViewModelFlip = false

	SWEP.BobScale = 2
	SWEP.SwayScale = 1.5
end

SWEP.Base = "weapon_zs_base"

SWEP.WorldModel = "models/weapons/w_medkit.mdl"
SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.UseHands = true

SWEP.Heal = 15
SWEP.Primary.HealCoolDown = 10

SWEP.Primary.DefaultClip = 150
SWEP.Primary.Ammo = "Battery"

SWEP.Secondary.DelayMul = 20 / SWEP.Primary.HealCoolDown
SWEP.Secondary.HealMul = 10 / SWEP.Heal

SWEP.Secondary.StrongerHealMul = 12 / SWEP.Heal

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"

SWEP.PrimaryHealingSound = "items/medshot4.wav"
SWEP.SecondaryHealingSound = "items/smallmedkit1.wav"

SWEP.ConsumptionMultiplier = 1

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.HealRange = 36

SWEP.NoMagazine = true
SWEP.AllowQualityWeapons = true

SWEP.HoldType = "slam"

SWEP.HudColor = COLOR_GREEN

AccessorFuncDT(SWEP, "ChargeTime", "Float", 0)
AccessorFuncDT(SWEP, "SelfHealCooldown", "Float", 2)

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	GAMEMODE:DoChangeDeploySpeed(self)
	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	local bloodhealing = self.BloodHealing or false
	local owner = self:GetOwner()

	local trtbl = owner:CompensatedPenetratingMeleeTrace(self.HealRange, 2, nil, nil, true)
	local ent
	for _, tr in pairs(trtbl) do
		local test = tr.Entity
		if test and test:IsValidLivingHuman() and (bloodhealing and gamemode.Call("PlayerCanBeHealedBlood", test) or gamemode.Call("PlayerCanBeHealed", test)) then
			ent = test

			break
		end
	end

	if not ent then return end

	local multiplier = self.MedicHealMul or 1
	local cooldownmultiplier = self.MedicCooldownMul or 1
	local healed = bloodhealing and owner:HealBloodPlayer(ent, math.min(self:GetCombinedPrimaryAmmo(), self.Heal)) or owner:HealPlayer(ent, math.min(self:GetCombinedPrimaryAmmo(), self.Heal))
	local totake = math.ceil(healed / multiplier)

	local sta = ent:GiveStatus("regeneration")
	if sta and sta:IsValid() and self.RegenHealing then
		sta:AddRegeneration(math.Clamp(healed * 1.25, 8, 30))
	end

	if totake > 0 then
		local cooldown = self.Primary.HealCoolDown * math.min(1, healed / self.Heal) * cooldownmultiplier

		self:SetChargeTime(CurTime() + cooldown)
		self:SetSelfHealCooldown(cooldown)

		owner.NextMedKitUse = self:GetChargeTime()
		owner.MedkitCooldownuse = self:GetSelfHealCooldown()

		self:TakeCombinedPrimaryAmmo(math.Round(totake * self.ConsumptionMultiplier))

		self:EmitSound(self.PrimaryHealingSound)

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		owner:DoAttackEvent()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	local bloodhealing = self.BloodHealing or false

	if self.NoSelfHealing or (not self:CanPrimaryAttack() or not (bloodhealing and gamemode.Call("PlayerCanBeHealedBlood", owner) or gamemode.Call("PlayerCanBeHealed", owner))) then return end

	local multiplier = self.MedicHealMul or 1
	local cooldownmultiplier = self.MedicCooldownMul or 1
	local healed = bloodhealing and owner:HealBloodPlayer(owner, math.min(self:GetCombinedPrimaryAmmo(), self.Heal * self.Secondary.StrongerHealMul)) or owner:HealPlayer(owner, math.min(self:GetCombinedPrimaryAmmo(), self.Heal * self.Secondary.HealMul))
	local totake = math.ceil(healed / multiplier)

	local sta = owner:GiveStatus("regeneration")
	if sta and sta:IsValid() and self.RegenHealing then
		sta:AddRegeneration(math.Clamp(healed * 1.25, 8, 30))
	end

	if totake > 0 then
		local cooldown = self.Primary.HealCoolDown * self.Secondary.DelayMul * math.min(1, healed / self.Heal * self.Secondary.HealMul) * cooldownmultiplier

		self:SetChargeTime(CurTime() + cooldown)
		self:SetSelfHealCooldown(cooldown)

		owner.NextMedKitUse = self:GetChargeTime()
		owner.MedkitCooldownuse = self:GetSelfHealCooldown()

		self:TakeCombinedPrimaryAmmo(math.Round(totake * self.ConsumptionMultiplier))

		self:EmitSound(self.SecondaryHealingSound)

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		owner:DoAttackEvent()
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self:GetOwner(), self)

	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if CLIENT then
		if not self.BloodHealing then
			GAMEMODE.MedicalAura = true
			hook.Add("PostPlayerDraw", "PostPlayerDrawMedical", GAMEMODE.PostPlayerDrawMedical)
		end
	end

	return true
end

function SWEP:Holster()
	if CLIENT and self:GetOwner() == MySelf then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_Holster()
	end

	return true
end

function SWEP:OnRemove()
	if CLIENT and self:GetOwner() == MySelf then
		hook.Remove("PostPlayerDraw", "PostPlayerDrawMedical")
		GAMEMODE.MedicalAura = false
		self:Anim_OnRemove()
	end
end

function SWEP:Reload()
end

function SWEP:CanPrimaryAttack()
	local owner = self:GetOwner()
	if owner:IsHolding() or owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:EmitSound("items/medshotno1.wav")

		self:SetChargeTime(CurTime() + 0.75)
		return false
	end

	return self:GetChargeTime() <= CurTime() and (owner.NextMedKitUse or 0) <= CurTime()
end

if not CLIENT then return end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end

local texDownEdge = surface.GetTextureID("gui/gradient_down")
local matGlow = Material("sprites/glow04_noz")
local medpower = Material("zombiesurvival/killicons/medpower_ammo_icon")
function SWEP:DrawHUD()
	local screenscale = BetterScreenScale()
	local wid, hei = 360 * screenscale, 18 * screenscale
	local x, y = ScrW() - wid - 32 * screenscale, ScrH() - hei - 64 * screenscale
	local font = "ZSHUDFontSmall"
	local texty = y - 4 - draw.GetFontHeight("ZSHUDFontSmall")
	local owner = self:GetOwner()

	local timeleft = (owner.NextMedKitUse or self:GetChargeTime()) - CurTime()
	if 0 < timeleft then
		local getcooldown = owner.MedkitCooldownuse or self:GetSelfHealCooldown()
		local CoolDown = math.Clamp(timeleft / getcooldown , 0, 1)
		local subwidth = CoolDown * wid

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x, y, wid, hei)

		surface.SetDrawColor(self.HudColor.r, self.HudColor.g, self.HudColor.b, 160)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 2 , y + 1, subwidth - 4, hei - 2)

		surface.SetDrawColor(self.HudColor.r, self.HudColor.g, self.HudColor.b, 30)
		surface.DrawRect(x + 2, y + 1, subwidth - 4, hei - 2)
		
		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + 2 + subwidth - 6, y - hei/2, 4, hei * 2)

		local percent = timeleft / getcooldown
		draw.SimpleText(math.Round(percent * 100) .. "%", font, x - 5 * screenscale, y - hei/2, self.HudColor, TEXT_ALIGN_RIGHT)
	end

	draw.SimpleText(self.PrintName, font, ScrW() - wid / 2 - 40 * screenscale, texty, self.HudColor, TEXT_ALIGN_CENTER)

	local charges = self:GetPrimaryAmmoCount()
	
	draw.SimpleText(charges, font, ScrW() - wid / 2 - 40 * screenscale, texty - 35 * screenscale, charges > 0 and self.HudColor or COLOR_DARKRED, TEXT_ALIGN_LEFT)

	surface.SetMaterial(medpower)
	surface.SetDrawColor(self.HudColor)
	surface.DrawTexturedRect(ScrW() - wid / 2 - 86 * screenscale, texty - 35 * screenscale, 34 * screenscale, 34 * screenscale)

	if GetConVar("crosshair"):GetInt() == 1 then
		self:DrawCrosshairDot()
	end
end