AddCSLuaFile()

DEFINE_BASECLASS("weapon_zs_fastzombie")

SWEP.PrintName = "Разрыватель"

SWEP.ViewModel = Model("models/weapons/v_fza.mdl")
SWEP.WorldModel = ""

if CLIENT then
	SWEP.ViewModelFOV = 42
end

sound.Add({
	name = "Weapon_Lacerator.Swinging",
	channel = CHAN_AUTO,
	volume = 0.55,
	level = 75,
	pitch = 100,
	sound = "npc/antlion_guard/confused1.wav"
})

SWEP.MeleeDamage = 9

SWEP.BotMeleeReach = 100
SWEP.BotSecondaryReach = 0
SWEP.BotReloadReach = 500

SWEP.SlowMeleeDelay = 0.8
SWEP.SlowMeleeDamage = 22
SWEP.PounceDamage = 30

SWEP.Reloading = false
SWEP.ReloadDelay = 2.3

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

        if status1 and status1:IsValid() and status2 and status2:IsValid() then
        end
    end 

    self.Reloading = true

    self:SetNextSecondaryFire(CurTime() + self.ReloadDelay)

    self:DoAlert()

    timer.Simple(self.ReloadDelay, function()
        self.Reloading = false
    end)
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = math.floor(damage * 18/22)
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:PlayPounceHitSound()
	self:EmitSound("physics/flesh/flesh_strider_impact_bullet1.wav")
	self:EmitSound("npc/fast_zombie/wake1.wav", 75, math.random(75, 80), nil, CHAN_AUTO)
end

function SWEP:PlayPounceStartSound()
	self:EmitSound("npc/fast_zombie/leap1.wav", 75, math.random(75, 80), nil, CHAN_AUTO)
end

function SWEP:PlayPounceSound()
	self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 75, math.random(100, 116), nil, CHAN_AUTO)
end

function SWEP:PlaySwingEndSound()
	self:EmitSound("npc/zombie_poison/pz_alert2.wav", 75, nil, nil, CHAN_AUTO)
end

function SWEP:StartSwingingSound()
	self:EmitSound("Weapon_Lacerator.Swinging")
end

function SWEP:StopSwingingSound()
	self:StopSound("Weapon_Lacerator.Swinging")
end

function SWEP:PlaySlowSwingSound()
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav")
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie/zombie_alert"..math.random(1, 3)..".wav", 75, math.random(80, 85))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound
