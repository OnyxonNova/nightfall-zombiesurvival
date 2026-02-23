AddCSLuaFile()

SWEP.PrintName = "Длинные Когти"

SWEP.Base = "weapon_zs_zombie"
SWEP.MeleeDamage = 24
SWEP.MeleeDamageVsProps = 28
SWEP.MeleeReach = 150
SWEP.MeleeSize = 5

SWEP.BotMeleeReach = 215
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 400

SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

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

        if status1 and status1:IsValid() and status2 and status2:IsValid() then
        end
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end


function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = self.MeleeDamageVsProps
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/barnacle/barnacle_bark"..math.random(2)..".wav")
end

if not CLIENT then return end

local matSkin = Material("models/barnacle/barnacle_sheet")

function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSkin)
	render.SetColorModulation(1, 1, 1)
end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride()
	render.SetColorModulation(1, 1, 1)
end


