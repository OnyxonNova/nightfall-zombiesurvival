SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Дерьмовый Шлепок"

SWEP.MeleeDelay = 0.25
SWEP.MeleeReach = 74
SWEP.MeleeDamage = 38
SWEP.MeleeSize = 16
SWEP.SwingAnimSpeed = 2.82

SWEP.DelayWhenDeployed = true

SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 300
SWEP.BotReloadReach = 300

SWEP.Reloading = false
SWEP.ReloadDelay = 2.6

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

        if status1 and status1:IsValid() then
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

function SWEP:PlayHitSound()
	self:EmitSound("npc/zombie/claw_strike"..math.random(3)..".wav", 75, math.random(80, 90), nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
	self:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 75, math.random(80, 90), nil, CHAN_AUTO)
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie/zo_attack"..math.random(2)..".wav", 75, math.random(80, 90))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav", 75, math.random(80, 90))
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav", 75, math.random(80, 90))
end
