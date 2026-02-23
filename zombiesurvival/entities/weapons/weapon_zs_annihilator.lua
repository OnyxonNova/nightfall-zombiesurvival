AddCSLuaFile()

SWEP.PrintName = "Аннигилятор"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 42

SWEP.AlertDelay = 3.5

SWEP.BotMeleeReach = 150
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
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(40,55))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(40,55))
end

if not CLIENT then return end

local render_SetColorModulation = render.SetColorModulation
function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/charple/charple4_sheet.vtf")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
    render_SetColorModulation(0.4, 0, 0)
end