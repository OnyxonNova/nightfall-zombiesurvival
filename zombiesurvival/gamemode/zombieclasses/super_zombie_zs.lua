CLASS.Base = "freshdead"

CLASS.Hidden = true

CLASS.Name = "Super Zombie ZS"
CLASS.TranslationName = "class_super_zombie"

CLASS.Health = 1500
CLASS.HealthPerHuman = 0
CLASS.Speed = SPEED_ZOMBIEESCAPE_ZOMBIE
CLASS.Points = 0

CLASS.SWEP = "weapon_zs_superzombiezs"

CLASS.UsePlayerModel = true
CLASS.UsePreviousModel = false
CLASS.NoFallDamage = true

local ACT_ZOMBIE_CLIMB_UP = ACT_ZOMBIE_CLIMB_UP
local ACT_ZOMBIE_LEAP_START = ACT_ZOMBIE_LEAP_START
local ACT_ZOMBIE_LEAPING = ACT_ZOMBIE_LEAPING

local math_Clamp = math.Clamp

function CLASS:Move(pl, mv)
    local wep = pl:GetActiveWeapon()
    if wep:IsValid() and wep.Move and wep:Move(mv) then
        return true
    end
end

function CLASS:CalcMainActivity(pl, velocity)
	local wep = pl:GetActiveWeapon()
	if not wep:IsValid() or not wep.GetClimbing or not wep.GetPounceTime then return end

	if wep:IsValid() and wep.GetClimbing and wep:GetClimbing() then
        return ACT_ZOMBIE_CLIMB_UP, -1
    end
    
    if wep:GetPounceTime() > 0 then
        return ACT_ZOMBIE_LEAP_START, -1
    end

    if wep:GetPouncing() then
        return ACT_ZOMBIE_LEAPING, -1
    end

	return self.BaseClass.CalcMainActivity(self, pl, velocity)
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
    local wep = pl:GetActiveWeapon()
    if wep:IsValid() and wep.GetClimbing and wep:GetClimbing() then
        local vel = pl:GetVelocity()
        local speed = vel:LengthSqr()
        if speed > 64 then
            pl:SetPlaybackRate(math_Clamp(speed / 3600, 0, 1) * (vel.z < 0 and -1 or 1) * 0.25)
        else
            pl:SetPlaybackRate(0)
        end
        return true
    end

    if wep.GetPounceTime and wep:GetPounceTime() > 0 then
        pl:SetPlaybackRate(0.25)
        if not pl.PrevFrameCycle then
            pl.PrevFrameCycle = true
            pl:SetCycle(0)
        end
        return true
    elseif pl.PrevFrameCycle then
        pl.PrevFrameCycle = nil
    end

    if wep.GetPouncing and wep:GetPouncing() then
        pl:SetPlaybackRate(1)
        if pl:GetCycle() >= 1 then
            pl:SetCycle(pl:GetCycle() - 1)
        end
        return true
    end

    return self.BaseClass.UpdateAnimation(self, pl, velocity, maxseqgroundspeed)
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/fresh_dead"
