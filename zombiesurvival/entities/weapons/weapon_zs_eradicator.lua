AddCSLuaFile()

SWEP.PrintName = "Искоренитель"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 43

SWEP.AlertDelay = 3.5

SWEP.BotMeleeReach = 140
SWEP.BotSecondaryReach = 350
SWEP.BotReloadReach = 350

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


function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(70,75))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(75,80))
end

if not CLIENT then return end

local matSheet = Material("Models/charple/charple4_sheet.vtf")
local color = Color(60, 15, 25)

function SWEP:PreDrawViewModel(vm, wep, ply)
    render.ModelMaterialOverride(matSheet)
end

local matSheet = Material("Models/charple/charple4_sheet.vtf")

function SWEP:PostDrawViewModel(vm, wep, ply)
    render.ModelMaterialOverride(nil)
end
