AddCSLuaFile()

SWEP.PrintName = "Мясник"

SWEP.Base = "weapon_zs_basemelee"

function SWEP:DrawHUD()
    local screenscale = BetterScreenScale() / 2
    local wid, hei = ScrW() - 800 * screenscale, ScrH() - 500 * screenscale

    local cooldownRemaining = math.max(0, self:GetNextSecondaryFire() - CurTime())
    local cooldownText = cooldownRemaining > 0 and string.format("ВТОРИЧНАЯ АТАКА ЧЕРЕЗ: %d СЕКУНД", cooldownRemaining) or "ВТОРИЧНАЯ АТАКА ГОТОВА!"
    draw.SimpleText(cooldownText, "ZSHUDFontSmallest", wid + 5, hei + 95, Color(255, 0, 50), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    local combo = self:GetDTInt(2)
    local comboPercent = math.Clamp(combo / 7, 0, 1)
    local filledLength = 200 * comboPercent
    local comboX, comboY = wid + 0, hei + 125

    surface.SetDrawColor(255, 255, 255)
    surface.DrawRect(comboX - 3, comboY - 3, 206, 26)
    surface.SetDrawColor(0, 0, 0)
    surface.DrawRect(comboX, comboY, 200, 20)

    surface.SetDrawColor(255, 0, 0)
    surface.DrawRect(comboX, comboY, filledLength, 20)

    draw.SimpleText(string.format("КОМБО: %d", combo), "ZSHUDFontSmallest", comboX + 100, comboY + 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

if CLIENT then
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -1), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_lab/cleaver.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1, -3.182), angle = Angle(90, 0, 0), size = Vector(0.8, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.ZombieOnly = true
SWEP.MeleeDamage = 21
SWEP.MeleeForceScale = 0.85
SWEP.MeleeSize = 2
SWEP.MeleeRange = 60
SWEP.Primary.Delay = 0.5

SWEP.HitAnim = ACT_VM_MISSCENTER

SWEP.BotMeleeReach = 70
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 1000


local lastHitTime = 0

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
    if hitent:IsValid() and hitent:IsPlayer() then
        local combo = self:GetDTInt(2)
        local owner = self:GetOwner()
        local armdelay = owner:GetMeleeSpeedMul()
        self:SetNextPrimaryFire(CurTime() + math.max(0.16, self.Primary.Delay * (1 - combo / 7)) * armdelay)

        self:SetDTInt(2, combo + 1)

        lastHitTime = CurTime()
    end
end

function SWEP:SetNextAttack()
    local owner = self:GetOwner()
    local armdelay = owner:GetMeleeSpeedMul()
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)
end

function SWEP:PostOnMeleeMiss(tr)
    local combo = self:GetDTInt(2)
    if combo > 0 then
        self:SetDTInt(2, math.floor(combo / 1.5))
    else
        self:SetDTInt(2, 0)
    end
end

function SWEP:Think()
    if CurTime() - lastHitTime >= 15 then
        self:SetDTInt(2, 0)
    end
end

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
    self:SetNextSecondaryFire(CurTime() + 11)

    self:SendWeaponAnim(ACT_VM_MISSCENTER)
    owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_GRENADE)

    if SERVER then
        local ent = ents.Create("projectile_butcherknifez")
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

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav", 72, math.Rand(85, 95))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/knife/knife_hitwall1.wav", 72, math.Rand(75, 85))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav")
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end