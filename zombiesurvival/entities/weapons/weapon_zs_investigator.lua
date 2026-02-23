AddCSLuaFile()

SWEP.PrintName = "Инвестигатор"

SWEP.Base = "weapon_zs_zombie"

function SWEP:DrawHUD()
	local screenscale = BetterScreenScale() / 2
	local wid, hei = ScrW() - 300 * screenscale, ScrH() - 300 * screenscale

    local cooldownRemaining = math.max(0, self:GetNextHowl() - CurTime())
    draw.SimpleText(cooldownRemaining > 0 and string.format("РЁВ ДОСТУПЕН ЧЕРЕЗ: %d СЕКУНД", math.ceil(cooldownRemaining)) or "РЁВ ГОТОВ!", "ZSHUDFontSmallest", wid, hei, Color(255, 0, 50), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

    local battlecryRemaining = math.max(0, self:GetBattlecry() - CurTime())
    draw.SimpleText(string.format("ДЕЙСТВИЕ СПОСОБНОСТИ: %d СЕКУНД", math.ceil(battlecryRemaining)), "ZSHUDFontSmallest", wid, hei + draw.GetFontHeight("ZSHUDFontSmallest"), Color(0, 255, 50, battlecryRemaining > 0 and 255 or 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
end

if CLIENT then
    SWEP.ViewModelFOV = 80
end

SWEP.MeleeReach = 80
SWEP.MeleeSize = 4.5
SWEP.MeleeDamage = 35

SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 200
SWEP.BotReloadReach = 200

SWEP.HowlDelay = 17

SWEP.BattlecryInterval = 0

SWEP.ReloadPressed = false

function SWEP:Reload()
    if not self.ReloadPressed then
        self.ReloadPressed = true
        
        local owner = self:GetOwner()
        if owner:IsValid() and owner:IsPlayer() then
            owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)
            
            self:SecondaryAttack()
            
            timer.Simple(5, function()
                self.ReloadPressed = false
            end)
        end
    end
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
    if ent:IsPlayer() then
        ent:GiveStatus("dimvision", 10)
        ent:GiveStatus("slow", 5)
    end

    self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
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
                for _, ent in pairs(ents.FindInSphere(center, 200)) do
                    if ent:IsValidLivingZombie() and WorldVisible(ent:WorldSpaceCenter(), center)then
                        ent:GiveStatus("zombieshield", 1)
                        ent:GiveStatus("rally", 5)
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

    self:SetBattlecry(CurTime() + 7)

    if SERVER then
        owner:EmitSound("npc/dog/dog_angry1.wav", 100, math.random(100, 90))
        util.ScreenShake(pos, 5, 5, 3, 560)

        local center = owner:WorldSpaceCenter()
        timer.Simple(0, function() Battlecry(center) end)

        for _, ent in pairs(ents.FindInSphere(center, 150)) do
            if ent:IsValidLivingHuman() and WorldVisible(ent:WorldSpaceCenter(), center) then
                ent:GiveStatus("frightened", 10)
                ent:GiveStatus("dimvision", 10)
            end
        end
    end
    self:SetNextHowl(CurTime() + self.HowlDelay)
    self:SetNextSecondaryFire(CurTime() + 0.5)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:PlayIdleSound()
    self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 70, math.random(85, 50))
end

SWEP.PlayAlertSound = SWEP.PlayIdleSound

function SWEP:PlayAttackSound()
    self:GetOwner():EmitSound("npc/dog/dog_angry3.wav", 75, math.random(100, 85))
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
    render.SetColorModulation(0, 0, 0)
end
