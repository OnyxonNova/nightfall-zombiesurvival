AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Лом"
SWEP.Description = "Эффективное и быстрое оружие ближнего боя. Способен мгновенно убивать хедкрабов."

if CLIENT then
	SWEP.ViewModelFOV = 65
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.DamageType = DMG_CLUB

SWEP.MeleeDamage = 48
SWEP.OriginalMeleeDamage = SWEP.MeleeDamage
SWEP.MeleeRange = 55
SWEP.MeleeSize = 1.5
SWEP.MeleeKnockBack = 110

SWEP.Primary.Delay = 0.7

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingTime = 0.4
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingHoldType = "grenade"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_RANGE, 3)

function SWEP:PlayRevupSound()
    self:EmitSound("physics/metal/weapon_impact_soft1.wav", 75, math.random(100, 100), 1, CHAN_AUTO)
    self:EmitSound("physics/metal/metal_canister_impact_soft3.wav", 75, math.random(125, 155), 0.75, CHAN_AUTO)
end

function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_Crowbar.Single")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_Crowbar.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_Crowbar.Melee_Hit")
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == TEAM_UNDEAD and hitent:IsHeadcrab() and gamemode.Call("PlayerShouldTakeDamage", hitent, self:GetOwner()) then
		hitent:TakeSpecialDamage(hitent:Health(), DMG_DIRECT, self:GetOwner(), self, tr.HitPos)
	end
end