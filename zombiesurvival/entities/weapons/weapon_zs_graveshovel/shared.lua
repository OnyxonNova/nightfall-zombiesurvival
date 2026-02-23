SWEP.PrintName = "Лопата Могильщика"
SWEP.Description = "Может замедлить зомби если ударить его по ноге."

DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 137
SWEP.LegDamage = 20
SWEP.MeleeRange = 78
SWEP.MeleeSize = 2.4
SWEP.MeleeKnockBack = 200

SWEP.Primary.Delay = 1.32

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.SwingRotation = Angle(0, -90, -60)
SWEP.SwingOffset = Vector(0, 30, -40)
SWEP.SwingTime = 0.85
SWEP.SwingHoldType = "melee"

SWEP.Tier = 4
SWEP.MaxStock = 3

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.12)

function SWEP:PlayRevupSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(30, 35), 1)

    local sound = CreateSound(self, "physics/concrete/rock_scrape_rough_loop1.wav")

    sound:PlayEx(75, math.random(45, 55))

    timer.Simple(0.15, function()
        if sound then
            sound:Stop()
        end
    end)

    timer.Simple(0.2, function()
        if IsValid(self) then
            self:EmitSound("physics/body/body_medium_impact_soft7.wav", 35, math.random(125, 155), 0.75, CHAN_AUTO)
        end
    end)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and hitLeg then
		hitent:AddLegDamageExt(self.LegDamage, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 70))
end

function SWEP:PlayHitSound()
	self:EmitSound("weapons/melee/shovel/shovel_hit-0"..math.random(4)..".ogg", 75, 80)
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end

