AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Морозный Череп"
end

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 30
SWEP.MeleeDamageShielded = 45

SWEP.BotMeleeReach = 130
SWEP.BotSecondaryReach = 400
SWEP.BotReloadReach = 600

SWEP.Reloading = false
SWEP.ReloadDelay = 2

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	local owner = self:GetOwner()
	if owner:GetStatus("redmarrow") then
		damage = self.MeleeDamageShielded
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

local Spread = {
    {0, 0},
    {-0.5, 0},
    {0.5, 0}
}

local function DoFleshThrow(pl, wep)
    if pl:IsValid() and pl:Alive() and wep:IsValid() then
        pl:ResetSpeed()
        pl.LastRangedAttack = CurTime()

        if SERVER then
            local startpos = pl:GetShootPos()
            local aimang = pl:EyeAngles()
            local ang

            for _, spr in pairs(Spread) do
                ang = Angle(aimang.p, aimang.y, aimang.r)
                ang:RotateAroundAxis(ang:Up(), spr[1] * 5)
                ang:RotateAroundAxis(ang:Right(), spr[2] * 5)

                local ent = ents.Create("projectile_frostmarrow")
                if ent:IsValid() then
                    ent:SetPos(startpos)
                    ent:SetOwner(pl)
                    ent:Spawn()

                    local phys = ent:GetPhysicsObject()
                    if phys:IsValid() then
                        phys:SetVelocity(ang:Forward() * 1000) -- увеличиваем скорость в 3 раза
                    end
                end
            end

            pl:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))
        end
    end
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
    if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end

    self:SetNextSecondaryFire(CurTime() + 3)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    self:GetOwner():DoZombieEvent()
    self:EmitSound("npc/fast_zombie/leap1.wav", 74, math.Rand(110, 130))
    self:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(85, 95))
    self:SendWeaponAnim(ACT_VM_HITCENTER)
    self.IdleAnimation = CurTime() + self:SequenceDuration()

    timer.Simple(0.7, function() DoFleshThrow(owner, self) end)
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
        local status1 = owner:GiveStatus("zombieshield", 15)

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
	self:GetOwner():EmitSound("npc/fast_zombie/fz_scream1.wav", 75, math.random(60,70), 0.5)
	self:GetOwner():EmitSound("npc/fast_zombie/fz_scream1.wav", 75, math.random(70,80), 0.5)
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:GetOwner():EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 75, math.random(70,75), 0.5)
	self:GetOwner():EmitSound("npc/combine_soldier/die"..math.random(1,3)..".wav", 75, math.random(78,90), 0.5)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/flesh")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
