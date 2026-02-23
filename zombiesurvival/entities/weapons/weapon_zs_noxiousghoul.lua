AddCSLuaFile()

SWEP.PrintName = "Ядовитый Вурдалак"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 23
SWEP.MeleeDamageVsProps = 32
SWEP.MeleeForceScale = 0.5
SWEP.SlowDownScale = 0.25
SWEP.EnfeebleDurationMul = 10 / SWEP.MeleeDamage
SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

SWEP.BotMeleeReach = 130
SWEP.BotSecondaryReach = 250
SWEP.BotReloadReach = 500

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
	self:GetOwner():EmitSound("npc/fast_zombie/fz_alert_close1.wav", 75, math.Rand(40, 55))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/fast_zombie/leap1.wav", 74, math.Rand(110, 130))
end

local PoisonPattern = {
	{-0.66, 0},
	{-0.33, 0},
	{0, 0},
	{0, 1},
	{0, -1},
	{0.33, 0},
	{0.66, 0},
}

local function DoFleshThrow(owner, self)
	local startpos = owner:GetShootPos()
	local aimang = owner:EyeAngles()
	local ang

	for k, spr in pairs(PoisonPattern) do
		if k == "BaseClass" then continue end

		ang = Angle(aimang.p, aimang.y, aimang.r)
		ang:RotateAroundAxis(ang:Up(), spr[1] * 12.5)
		ang:RotateAroundAxis(ang:Right(), spr[2] * 5)
		local heading = ang:Forward()

		local ent = ents.Create(k % 3 == 1 and "projectile_ghoulfleshno" or "projectile_poisonflesh")
		if ent:IsValid() then
			ent:SetPos(startpos + heading * 8)
			ent:SetOwner(owner)
			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocityInstantaneous(heading * 400)
			end
		end
	end

	owner:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.Rand(105, 115))
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

	if SERVER then
		timer.Simple(0.7, function() DoFleshThrow(owner, self) end)
	end
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
	render.SetColorModulation(1, 1, 1)
end

local matSheet = Material("models/weapons/v_zombiearms/ghoulsheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
	render.SetColorModulation(0.9, 0.55, 0.9)
end
