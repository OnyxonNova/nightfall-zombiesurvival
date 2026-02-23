SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeReach = 85
SWEP.MeleeDelay = 0.75
SWEP.MeleeSize = 4.5 --1.5
SWEP.MeleeDamage = 35 --28
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeAnimationDelay = 0.50


SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 0
SWEP.BotReloadReach = 350

SWEP.Reloading = false
SWEP.ReloadDelay = 2.2

SWEP.Primary.Delay = 1.45

SWEP.ViewModel = Model("models/weapons/v_fza.mdl")
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

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

function SWEP:CheckMoaning()
end

function SWEP:StopMoaningSound()
end

function SWEP:StartMoaningSound()
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_sheet_impact_bullet"..math.random(2)..".wav", 100, 100, nil, CHAN_AUTO)
end

function SWEP:PlayMissSound()
	self:EmitSound("npc/zombie/claw_miss"..math.random(2)..".wav", 75, 80, nil, CHAN_AUTO)
end

function SWEP:PlayAttackSound()
	self:EmitSound("NPC_PoisonZombie.ThrowWarn")
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, 140)
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:SetSwingAnimTime(time)
	self:SetDTFloat(3, time)
end

function SWEP:GetSwingAnimTime()
	return self:GetDTFloat(3)
end

function SWEP:StartSwinging()
	self.BaseClass.StartSwinging(self)
	self:SetSwingAnimTime(CurTime() + 1)
end

