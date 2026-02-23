AddCSLuaFile()

SWEP.PrintName = "Липкий Зомби"
SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 28
SWEP.MeleeDamageVsProps = 30
SWEP.SlowDownScale = 1.85

SWEP.BotMeleeReach = 140
SWEP.BotSecondaryReach = 350
SWEP.BotReloadReach = 0

SWEP.Reloading = false
SWEP.ReloadDelay = 2.2

function SWEP:MeleeHit(ent, trace, damage, forcescale)
    if not ent:IsPlayer() then
        damage = self.MeleeDamageVsProps
    end

    self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
        if ent:IsPlayer() then
                ent:GiveStatus("sickness", 10)
        end

        self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

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
        owner:GiveStatus("zombie_battlecry", 1)
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/headcrab_poison/ph_scream"..math.random(3)..".wav" ,75, math.random(75,85))
end

SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/headcrab_poison/ph_talk"..math.random(3)..".wav" ,75, math.random(45,65))
end

if not CLIENT then return end
local matSkin = Material("models/flesh")

function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSkin)
	render.SetColorModulation(0, 0, 0)
end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride()
	render.SetColorModulation(0, 0, 0)
end
