AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Шоковая Дубинка"
SWEP.Description = "У этой дубинки есть способность замедлять зомби с помощью технологии замедления пульса, и она дает +25% дополнительных очков."

if CLIENT then
	SWEP.ViewModelFOV = 50
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.MeleeDamage = 44
SWEP.LegDamage = 15
SWEP.MeleeRange = 49
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.9

SWEP.SwingTime = 0.25
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.AllowQualityWeapons = true

SWEP.WalkSpeed = SPEED_FAST

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.09)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_LEG_DAMAGE, 2)

AccessorFuncDT(SWEP, "SwingCount", "Int", 9)

function SWEP:Deploy()
    BaseClass.Deploy(self)
    if CLIENT then
        self:PlayRevupSound()
    end
    return true
end

function SWEP:PlayRevupSound()
    self:EmitSound("weapons/stunstick/spark"..math.random(1, 3)..".wav")
end

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_StunStick.Swing")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_StunStick.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() then
		hitent:AddLegDamageExt(self.LegDamage, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end
