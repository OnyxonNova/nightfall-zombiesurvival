AddCSLuaFile()

SWEP.PrintName = "Надзиратель"

SWEP.Base = "weapon_zs_zombie"

if CLIENT then
    SWEP.ViewModelFOV = 57
end

SWEP.ViewModel = Model("models/weapons/zombine/v_zombine.mdl")

SWEP.MeleeReach = 58
SWEP.MeleeForceScale = 1.45
SWEP.Primary.Delay = 1.6
SWEP.MeleeDamage = 50
SWEP.MeleeDamageSpeed = 55
SWEP.MeleeDamageVsProps = 42

SWEP.BotMeleeReach = 155
SWEP.BotSecondaryReach = 165
SWEP.BotReloadReach = 5

SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

SWEP.SwingAnimSpeed = 0.87

SWEP.BoostedDamage = false

function SWEP:SendAttackAnim()
    local owner = self:GetOwner()
    local armdelay = self.MeleeAnimationMul
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    
    if self.SwingAnimSpeed then
        owner:GetViewModel():SetPlaybackRate(self.SwingAnimSpeed * armdelay)
    else
        owner:GetViewModel():SetPlaybackRate(1 * armdelay)
    end
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
    if self.BoostedDamage then
        damage = damage * 1.2
        self.BoostedDamage = false
    end
    
    if ent:IsPlayer() then
        ent:GiveStatus("anchor", 6)
    end

    self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
    if not ent:IsPlayer() then
        damage = self.MeleeDamageVsProps
    end

    self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
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
        local status = owner:GiveStatus("zombie_battlecry", 1)
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
    if not owner:IsValid() or not owner:IsPlayer() then return end

    local center = owner:GetPos() + Vector(0, 0, 32)

    if SERVER then
        for _, ent in pairs(ents.FindInSphere(center, 80)) do
            if ent:IsValidLivingZombie() and WorldVisible(ent:WorldSpaceCenter(), center) then
                ent:GiveStatus("rally", 1)
            end
        end
    end

    self:DoAlert()
    self:SetNextSecondaryFire(CurTime() + 4)

    self.BoostedDamage = true

    timer.Simple(1.8, function()
        if IsValid(self) then
            self.BoostedDamage = false
        end
    end)
end

function SWEP:PlayAlertSound()
    self:GetOwner():EmitSound(
        ")npc/combine_soldier/die" .. math.random(3) .. ".wav",
        self.MoanAtten,
        math.random(40, 45),
        CHAN_VOICE2
    )
end

SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
    self:EmitSound(
        ")npc/metropolice/pain" .. math.random(3) .. ".wav",
        self.MoanAtten,
        math.random(45, 50),
        CHAN_VOICE2
    )
    self:EmitSound(
        ")npc/zombie_poison/pz_warn" .. math.random(2) .. ".wav",
        self.MoanAtten,
        math.random(60, 65),
        CHAN_WEAPON + 39
    )
end

if CLIENT then
    function SWEP:ViewModelDrawn()
        render.SetColorModulation(1, 1, 1)
    end

    function SWEP:PreDrawViewModel(vm)
        render.SetColorModulation(0.3, 0, 0)
    end
end
