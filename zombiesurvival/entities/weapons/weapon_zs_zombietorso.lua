AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Торс Зомби"

SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 40
SWEP.MeleeDamage = 25
SWEP.SwingAnimSpeed = 2.96

SWEP.BotMeleeReach = 90
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 400

SWEP.DelayWhenDeployed = true

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

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end