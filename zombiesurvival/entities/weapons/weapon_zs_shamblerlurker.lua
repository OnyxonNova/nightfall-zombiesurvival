AddCSLuaFile()

SWEP.Base = "weapon_zs_zombietorso"

SWEP.PrintName = "Торс Воина Скелета"

SWEP.MeleeDelay = 0.25
SWEP.MeleeDamage = 30

SWEP.BotMeleeReach = 75
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 400

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

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound(string.format("npc/strider/creak%d.wav", math.random(4)), 70, math.random(125, 135))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/stalker/breathing3.wav", 70, math.random(120, 130))
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/fast_zombie/wake1.wav", 70, math.random(125, 150))
end

if not CLIENT then return end

local matSheet = Material("models/props_c17/doll01")

function SWEP:PreDrawViewModel(vm, wep, pl)
    render.ModelMaterialOverride(matSheet)
end

function SWEP:PostDrawViewModel(vm, wep, pl)
    render.ModelMaterialOverride(nil)
end