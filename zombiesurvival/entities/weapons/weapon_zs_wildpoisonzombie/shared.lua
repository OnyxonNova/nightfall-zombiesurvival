DEFINE_BASECLASS("weapon_zs_poisonzombie")

SWEP.PrintName = "Дикий Ядовитый Зомби"

SWEP.MeleeDamage = 45
SWEP.PoisonThrowSpeed = 440

SWEP.BotMeleeReach = 125
SWEP.BotSecondaryReach = 250
SWEP.BotReloadReach = 450

SWEP.Reloading = false
SWEP.ReloadDelay = 2.2

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie_poison/pz_warn"..math.random(2)..".wav", 74, math.random(88, 95), 0.5, CHAN_AUTO)
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 74, math.random(112, 115), 0.5, CHAN_AUTO)
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