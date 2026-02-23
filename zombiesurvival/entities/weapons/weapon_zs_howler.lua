AddCSLuaFile()

SWEP.PrintName = "Крикун"

function SWEP:DrawHUD()
	local screenscale = BetterScreenScale() / 2
	local wid, hei = ScrW() - 300 * screenscale, ScrH() - 300 * screenscale

    local cooldownRemaining = math.max(0, self:GetNextHowl() - CurTime())
    draw.SimpleText(cooldownRemaining > 0 and string.format("РЁВ ДОСТУПЕН ЧЕРЕЗ: %d СЕКУНД", math.ceil(cooldownRemaining)) or "РЁВ ГОТОВ!", "ZSHUDFontSmallest", wid, hei, Color(255, 0, 50), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

    local battlecryRemaining = math.max(0, self:GetBattlecry() - CurTime())
    draw.SimpleText(string.format("ДЕЙСТВИЕ СПОСОБНОСТИ: %d СЕКУНД", math.ceil(battlecryRemaining)), "ZSHUDFontSmallest", wid, hei + draw.GetFontHeight("ZSHUDFontSmallest"), Color(0, 255, 50, battlecryRemaining > 0 and 255 or 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end

SWEP.Base = "weapon_zs_zombie"

if CLIENT then
	SWEP.ViewModelFOV = 48
end

SWEP.ViewModel = Model("models/weapons/v_pza.mdl")

SWEP.MeleeReach = 65
SWEP.MeleeForceScale = 1.45
SWEP.MeleeSize = 2.5
SWEP.Primary.Delay = 1.2
SWEP.MeleeDamage = 38
SWEP.AlertDelay = 3.2

SWEP.BotMeleeReach = 155
SWEP.BotSecondaryReach = 290
SWEP.BotReloadReach = 700

SWEP.SwingAnimSpeed = 0.58

SWEP.HowlDelay = 10

SWEP.BattlecryInterval = 0

SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

function SWEP:Reload()
    local owner = self:GetOwner()

    if self:GetNextSecondaryFire() > CurTime() then
        return
    end

    if self.Reloading then
        return
    end

    if owner:GetActiveWeapon() == self and owner:KeyDown(IN_ATTACK2) then
        return
    end

    if owner:IsValid() and owner:IsPlayer() then
        local status1 = owner:GiveStatus("zombie_battlecry", 1)

        if status1 and status1:IsValid() and status2 and status2:IsValid() then
        end
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end

local function Battlecry(pos)
	if SERVER then
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(Vector(0,0,1))
		util.Effect("zombie_battlecry", effectdata, true)
	end
end

function SWEP:Think()
	self.BaseClass.Think(self)

	if self:GetBattlecry() > CurTime() then
		if self.BattlecryInterval < CurTime() then
			self.BattlecryInterval = CurTime() + 0.25
			local owner = self:GetOwner()
			local center = owner:GetPos() + Vector(0, 0, 32)
			if SERVER then
				for _, ent in pairs(ents.FindInSphere(center, 80)) do
					if ent:IsValidLivingZombie() and WorldVisible(ent:WorldSpaceCenter(), center)then
						ent:GiveStatus("zombie_battlecry", 1)
					end
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self:GetNextHowl() then return end

	local owner = self:GetOwner()
	local pos = owner:GetPos()

	owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)

	self:SetBattlecry(CurTime() + 5)

	if SERVER then
		owner:EmitSound("npc/stalker/go_alert2a.wav", 100, math.random(50, 54))
		util.ScreenShake(pos, 5, 5, 3, 560)

		local center = owner:WorldSpaceCenter()
		timer.Simple(0, function() Battlecry(center) end)

		for _, ent in pairs(ents.FindInSphere(center, 150)) do
			if ent:IsValidLivingHuman() and WorldVisible(ent:WorldSpaceCenter(), center) then
				ent:GiveStatus("frightened", 10)
			end
		end
	end
	self:SetNextHowl(CurTime() + self.HowlDelay)
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 70, math.random(85, 95))
end

SWEP.PlayAlertSound = SWEP.PlayIdleSound

function SWEP:PlayAttackSound()
	self:GetOwner():EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(80, 85))
end

function SWEP:SetBattlecry(time)
	self:SetDTFloat(1, time)
end

function SWEP:GetBattlecry()
	return self:GetDTFloat(1)
end

function SWEP:SetNextHowl(time)
	self:SetDTFloat(2, time)
end

function SWEP:GetNextHowl()
	return self:GetDTFloat(2)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.SetColorModulation(1, 1, 1)
end

function SWEP:PreDrawViewModel(vm)
	render.SetColorModulation(1, 0.9, 0.6)
end
