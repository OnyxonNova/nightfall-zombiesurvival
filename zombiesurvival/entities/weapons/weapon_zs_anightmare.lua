AddCSLuaFile()

SWEP.PrintName = "Древний Кошмар"
SWEP.Base = "weapon_zs_zombie"
SWEP.MeleeDamage = 52
SWEP.MeleeDamageVsProps = 70
SWEP.SlowDownScale = 1.9
SWEP.MeleeReach = 52
SWEP.MeleeDelay = 0.74
SWEP.Primary.Delay = 1.35

SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 600
SWEP.BotReloadReach = 300

SWEP.Dash = false
SWEP.DashDelay = 8

SWEP.Smock = false
SWEP.SmockDelay = 45

function SWEP:MeleeHit(ent, trace, damage, forcescale)
    if not ent:IsPlayer() then
        damage = self.MeleeDamageVsProps
    end

    self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
    if ent:IsPlayer() then
        ent:GiveStatus("dimvision", 10)
        ent:GiveStatus("nightmarescare", 10)
    end

    self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:SecondaryAttack(ability)
    local owner = self:GetOwner()

    if self.Dash then
        return
    end

    if owner:IsValid() and owner:IsPlayer() then
        local status1 = owner:GiveStatus("nightmare", 3)

        if status1 and status1:IsValid() then
            self:SetInvisible(owner, 2.85)

            self.Dash = true
            self:DoAlert()

            self:SetNextSecondaryFire(CurTime() + 8)

            timer.Simple(3, function()
                self.Dash = false
                self:RestoreVisibility(owner)
            end)
        end
    end 
end

function SWEP:SetInvisible(pl, duration)
    if pl:IsValid() and pl:IsPlayer() then
        pl:SetRenderMode(RENDERMODE_NONE)

        timer.Simple(duration, function()
            if pl:IsValid() and pl:IsPlayer() then
                pl:SetRenderMode(RENDERMODE_NORMAL)
            end
        end)
    end
end

function SWEP:RestoreVisibility(pl)
    if pl:IsValid() and pl:IsPlayer() then
        pl:SetRenderMode(RENDERMODE_NORMAL)
        pl:SetMaterial("")
        pl:SetColor(Color(255, 255, 255, 255))
    end
end

function SWEP:Reload()
    local owner = self:GetOwner()

    if self.Smock then
        return
    end

    if owner:GetActiveWeapon() == self and owner:KeyDown(IN_ATTACK2) then
        return
    end

    if owner:IsValid() and owner:IsPlayer() then
        local status2 = owner:GiveStatus("zombiespawnbuff", 1)
        local status3 = owner:GiveStatus("zombieshield", 20)

        if status1 and status1:IsValid() and status2 and status2 and status3:IsValid() then
        end
    end 

    self.Smock = true

    self.SmockDelay = 35

    timer.Simple(self.SmockDelay, function()
        self.Smock = false
    end)
end



function SWEP:PlayAlertSound()
    self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
    self:EmitSound("npc/barnacle/barnacle_bark"..math.random(2)..".wav", 75, 30, 50, 0.5, CHAN_AUTO)
	self:EmitSound("npc/fast_zombie/wake1.wav", 75, math.random(35, 40, 0.5, CHAN_AUTO))
end

function SWEP:PlayHitSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75, 55, nil, CHAN_AUTO)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/Charple/Charple1_sheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end