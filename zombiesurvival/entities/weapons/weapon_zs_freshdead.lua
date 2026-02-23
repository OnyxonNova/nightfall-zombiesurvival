AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.PrintName = "Свежий Зараженный"

SWEP.MeleeDamage = 20

SWEP.ReloadPressed = false

function SWEP:Reload()
    if not self.ReloadPressed then
        self.ReloadPressed = true
        
        local owner = self:GetOwner()
        if owner:IsValid() and owner:IsPlayer() then
            owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)
            
            self:SecondaryAttack()
            
            timer.Simple(5, function()
                self.ReloadPressed = false
            end)
        end
    end
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:IsMoaning()
	return false
end

