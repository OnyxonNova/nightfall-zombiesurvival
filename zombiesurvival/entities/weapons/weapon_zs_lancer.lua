AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Лансер"

SWEP.MeleeDamage = 15
SWEP.MeleeDamageVsProps = 24
SWEP.MeleeForceScale = 0.5
SWEP.SlowDownScale = 0.65
SWEP.EnfeebleDurationMul = 6 / SWEP.MeleeDamage

SWEP.BotMeleeReach = 140
SWEP.BotSecondaryReach = 290
SWEP.BotReloadReach = 700

SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

function SWEP:ApplyMeleeDamage(ent, trace, damage)
    local owner = self:GetOwner()

    if ent:IsPlayer() then
        if self.BaseClass and self.BaseClass.ApplyMeleeDamage then
            self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage * 0.25)
        end

        ent:PoisonDamage(damage * 1.25, owner, self, trace.HitPos)

        if SERVER then
            local gt = ent:GiveStatus("enfeeble", damage * self.EnfeebleDurationMul)
            if gt and gt:IsValid() then
                gt.Applier = owner
            end
        end
    else
        if self.BaseClass and self.BaseClass.ApplyMeleeDamage then
            self.BaseClass.ApplyMeleeDamage(self, ent, trace, self.MeleeDamageVsProps)
        end
    end
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
	self:GetOwner():EmitSound("npc/fast_zombie/leap1.wav", 75, math.Rand(35, 55))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound


function SWEP:PlayAttackSound()
	self:EmitSound("npc/fast_zombie/wake1.wav", 70, math.random(115, 140))
end


local Spread = {
    {0, 0},
    {0, 0.75},
	{0, 0},
    {0, 0.75},
    {-0, -1},
    {-0, -2}

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

				local ent = ents.Create("projectile_poisonflesh")
				if ent:IsValid() then
					ent:SetPos(startpos)
					ent:SetOwner(pl)
					ent:Spawn()

					local phys = ent:GetPhysicsObject()
					if phys:IsValid() then
						phys:SetVelocityInstantaneous(ang:Forward() * 530)
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

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local render_SetColorModulation = render.SetColorModulation
local matSheet = Material("models/weapons/v_zombiearms/ghoulsheet")
function SWEP:PreDrawViewModel(vm)
	render_SetColorModulation(0.5, 0, 0)
	render.ModelMaterialOverride(matSheet)
end
