SWEP.Base = "weapon_zs_zombietorso"

SWEP.PrintName = "Ледяной Торс"

SWEP.MeleeDelay = 0.25
SWEP.MeleeDamage = 28

SWEP.BotMeleeReach = 75
SWEP.BotSecondaryReach = 250
SWEP.BotReloadReach = 250

SWEP.Reloading = false
SWEP.ReloadDelay = 2.2

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

function SWEP:PlayHitSound()
    self:EmitSound("NPC_FastZombie.AttackHit", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
    self:EmitSound("NPC_FastZombie.AttackMiss", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlayAttackSound()
    self:EmitSound("npc/zombie_poison/pz_warn"..math.random(2)..".wav", 70, math.random(200, 210), nil, CHAN_AUTO)
end

function SWEP:PlayIdleSound()
    self:GetOwner():EmitSound("npc/antlion/idle"..math.random(5)..".wav", 70, math.random(60, 66))
end

function SWEP:PlayAlertSound()
    self:GetOwner():EmitSound("npc/stalker/breathing3.wav", 70, math.random(80, 90))
end
