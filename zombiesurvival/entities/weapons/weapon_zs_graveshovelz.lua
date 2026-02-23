AddCSLuaFile()

SWEP.PrintName = "Могильщик"

SWEP.Base = "weapon_zs_graveshovel"

function SWEP:DrawHUD()
    local x = ScrW() - 435
    local y = ScrH() - 350

    local cooldownRemaining = math.max(0, self:GetNextSecondaryFire() - CurTime())
    if cooldownRemaining > 0 then
        draw.SimpleText(string.format("ВТОРИЧНАЯ АТАКА ЧЕРЕЗ: %d СЕКУНД", cooldownRemaining), "ZSHUDFontSmallest", x + 30, y + 100, Color(255, 0, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    else
        draw.SimpleText("ВТОРИЧНАЯ АТАКА ГОТОВА!", "ZSHUDFontSmallest", x + 30, y + 100, Color(255, 0, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end

SWEP.MeleeDamage = 45
SWEP.MeleeKnockBack = 0
SWEP.SlowDownScale = 0.5

SWEP.Primary.Delay = 1.25
SWEP.SwingTime = 0.65
SWEP.MeleeRange = 70

SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 700

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
    if not owner:IsValid() or not owner:IsPlayer() then
        return
    end

    local tr = owner:TraceLine(60)
    if tr.HitWorld or (tr.Entity:IsValid() and not tr.Entity:IsPlayer()) then
        return
    end

    if not self:CanPrimaryAttack() then
        return
    end

    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + 18)

    self:SendWeaponAnim(ACT_VM_MISSCENTER)
    owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)

    if SERVER then
        local ent = ents.Create("projectile_gravedigger")
        if ent:IsValid() then
            ent:SetPos(owner:GetShootPos())
            ent:SetAngles(owner:EyeAngles())
            ent:SetOwner(owner)
            ent.ProjDamage = self.MeleeDamage
            ent.BaseWeapon = self:GetClass()
            ent:Spawn()
            ent.Team = owner:Team()
            local phys = ent:GetPhysicsObject()
            if phys:IsValid() then
                phys:Wake()
                phys:SetVelocityInstantaneous(self:GetOwner():GetAimVector() * 950)
            end
        end
    end
end

