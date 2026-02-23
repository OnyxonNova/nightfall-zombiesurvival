AddCSLuaFile()

SWEP.PrintName = "Кровавый Зомби"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 21
SWEP.BleedDamageMul = 10 / SWEP.MeleeDamage
SWEP.MeleeDamageVsProps = 28

SWEP.AlertDelay = 2.75

SWEP.ReloadPressed = false

function SWEP:Reload()
    if not self.ReloadPressed then
        self.ReloadPressed = true
        
        local owner = self:GetOwner()
        if owner:IsValid() and owner:IsPlayer() then
            owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE) -- Воспроизводим анимацию
            
            self:SecondaryAttack() -- Вызываем SecondaryAttack
            
            timer.Simple(5, function()
                self.ReloadPressed = false
            end)
        end
    end
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie/zo_attack"..math.random(2)..".wav", 70, math.random(87, 92))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(3)..".wav", 70, math.random(87, 92))
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_voice_idle"..math.random(14)..".wav", 70, math.random(87, 92))
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = self.MeleeDamageVsProps
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if SERVER and ent:IsPlayer() then
		local bleed = ent:GiveStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(damage * self.BleedDamageMul)
			bleed.Damager = self:GetOwner()
		end
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

function SWEP:PreDrawViewModel(vm)
	render.SetColorModulation(1, 0, 0)
end
