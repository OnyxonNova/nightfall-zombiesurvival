SWEP.PrintName = "Мерзкий Зомби"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 32
SWEP.PoisonDmgMul = 0.5
SWEP.MeleeForceScale = 1.25

SWEP.Primary.Delay = 1.4

SWEP.BotMeleeReach = 125
SWEP.BotSecondaryReach = 245
SWEP.BotReloadReach = 500

SWEP.Reloading = false
SWEP.ReloadDelay = 2.6

SWEP.NextPuke = 0
SWEP.PukeLeft = 0

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() then
		ent:PoisonDamage(damage / 2, self:GetOwner(), self, trace.HitPos)
		self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage / 2)
	else
		self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
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
	self:PlayAttackSound()
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end

function SWEP:PlayAttackSound()
	if SERVER then
		local owner = self:GetOwner()
		local sndname = "npc/ichthyosaur/attack_growl"..math.random(3)..".wav"
		for i = 1, 4 do
			timer.Simple(0.04 * i,
				function() if owner:IsValid() then owner:EmitSound(sndname, 75, 170 + i*8, 0.4, CHAN_AUTO) end
			end)
		end
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end

	self:SetNextSecondaryFire(CurTime() + 3.5)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	owner:DoReloadEvent()
	self:PlayAttackSound()
	self:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 72, math.random(70, 83))

	if SERVER then
		timer.Simple(0.8, function()
			if self:IsValid() then
				self.PukeLeft = 4

				if owner:IsValidLivingZombie() then
					owner:EmitSound("npc/barnacle/barnacle_die2.wav")
					owner:EmitSound("npc/barnacle/barnacle_digesting1.wav")
					owner:EmitSound("npc/barnacle/barnacle_digesting2.wav")
				end
			end
		end)
	end
end
