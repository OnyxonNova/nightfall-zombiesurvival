SWEP.PrintName = "Светлячок"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.0001

SWEP.BotMeleeReach = 125
SWEP.BotSecondaryReach = 3000
SWEP.BotReloadReach = 0

SWEP.HealRange = 300
SWEP.Heal = 25

SWEP.ZombieOnly = true
SWEP.IsMelee = true

SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

util.PrecacheSound("npc/scanner/scanner_nearmiss1.wav")
util.PrecacheSound("npc/scanner/scanner_nearmiss2.wav")
util.PrecacheSound("npc/scanner/scanner_talk1.wav")
util.PrecacheSound("npc/scanner/scanner_talk2.wav")

SWEP.NextAmbientSound = 0

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_HEALRANGE, 100, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 0.3)

function SWEP:Initialize()
    self.BaseClass.Initialize(self)

    local owner = self:GetOwner()
    if IsValid(owner) and SERVER then
        self.ChargeSound = CreateSound(owner, Sound("items/medcharge4.wav"))
    end

    self:HideViewAndWorldModel()
end


function SWEP:Think()
end

function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextPrimaryAttack() then return end
	self:SetNextPrimaryAttack(CurTime() + 4)

	local owner = self:GetOwner()

	owner.LastRangedAttack = CurTime()

	if SERVER then
		owner:GodEnable()
		util.BlastDamageEx(self, owner, owner:GetShootPos(), 64, 15, DMG_DISSOLVE)
		owner:GodDisable()
	end

	if IsFirstTimePredicted() then
		local effectdata = EffectData()
			effectdata:SetOrigin(owner:GetShootPos())
			effectdata:SetNormal(owner:GetAimVector())
		util.Effect("explosion_wispball", effectdata)
	end
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end

	local owner = self:GetOwner()
	local hitpos = owner:CompensatedMeleeTrace(self.HealRange, 2).HitPos

	for i = 1, 4 do
		for _, pl in pairs(ents.FindInSphere(hitpos, 90)) do
			if pl:IsValidLivingZombie() and not pl:GetStatus("zombie_regen") then
				local zombieclasstbl = pl:GetZombieClassTable()
				local ehp = zombieclasstbl.Boss and pl:GetMaxHealth() * 0.4 or pl:GetMaxHealth() * 1.25
				if pl:Health() <= ehp then
					local status = pl:GiveStatus("zombie_regen")
					if status and status:IsValid() then
						status:SetHealLeft(75)
					end
					break
				end
			end
		end
	end

	self:SetNextSecondaryFire(CurTime() + 1)

	if SERVER then
		local effectdata = EffectData()
		effectdata:SetStart(owner:GetShootPos())
		effectdata:SetOrigin(hitpos)
		effectdata:SetEntity(self)
		effectdata:SetAttachment(1)
		util.Effect("tracer_wow", effectdata)
	end
end


function SWEP:CanSecondaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetDTEntity(10):IsValid() then return false end

	return self:GetNextSecondaryFire() <= CurTime()
end