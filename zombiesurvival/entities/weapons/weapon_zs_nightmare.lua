AddCSLuaFile()

SWEP.PrintName = "Ночной Кошмар"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 26
SWEP.BleedDamage = 15
SWEP.SlowDownScale = 4
SWEP.MeleeDamageVsProps = 45
SWEP.EnfeebleDurationMul = 10 / SWEP.MeleeDamage

SWEP.BotMeleeReach = 150
SWEP.BotSecondaryReach = 550
SWEP.BotReloadReach = 190

SWEP.HowlDelay = 20

SWEP.BattlecryInterval = 0

local function Battlecry(pos)
	if SERVER then
		local effectdata = EffectData()
		effectdata:SetOrigin(pos)
		effectdata:SetNormal(Vector(0,0,1))
		util.Effect("zombie_battlecry", effectdata, true)
	end
end

function SWEP:Think()
	self.BaseClass.Think(self)

	if self:GetBattlecry() > CurTime() then
		if self.BattlecryInterval < CurTime() then
			self.BattlecryInterval = CurTime() + 0.25
			local owner = self:GetOwner()
			local center = owner:GetPos() + Vector(0, 0, 32)
			if SERVER then
				for _, ent in pairs(ents.FindInSphere(center, 80)) do
					if ent:IsValidLivingZombie() and WorldVisible(ent:WorldSpaceCenter(), center)then
						ent:GiveStatus("zombieshield", 1)
					end
				end
			end
		end
	end
end

function SWEP:Reload()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self:GetNextHowl() then return end

	local owner = self:GetOwner()
	local pos = owner:GetPos()

	owner:DoAnimationEvent(ACT_GMOD_GESTURE_TAUNT_ZOMBIE)

	self:SetBattlecry(CurTime() + 5)

	if SERVER then
		owner:EmitSound("npc/stalker/go_alert2a.wav", 100, math.random(100, 67))
		util.ScreenShake(pos, 5, 5, 3, 560)

		local center = owner:WorldSpaceCenter()
		timer.Simple(0, function() Battlecry(center) end)

		for _, ent in pairs(ents.FindInSphere(center, 150)) do
			if ent:IsValidLivingHuman() and WorldVisible(ent:WorldSpaceCenter(), center) then
				ent:GiveStatus("dimvision", 10)
				ent:GiveStatus("nightmarescare", 10)
			end
		end
	end
	self:SetNextHowl(CurTime() + self.HowlDelay)
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

function SWEP:SetBattlecry(time)
	self:SetDTFloat(1, time)
end

function SWEP:GetBattlecry()
	return self:GetDTFloat(1)
end

function SWEP:SetNextHowl(time)
	self:SetDTFloat(2, time)
end

function SWEP:GetNextHowl()
	return self:GetDTFloat(2)
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(3)..".wav")
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/barnacle/barnacle_bark"..math.random(2)..".wav")
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = self.MeleeDamageVsProps
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if SERVER and ent:IsPlayer() then
		local gt = ent:GiveStatus("enfeeble", damage * self.EnfeebleDurationMul)
		if gt and gt:IsValid() then
			gt.Applier = self:GetOwner()
		end

		ent:GiveStatus("dimvision", 10)
		ent:GiveStatus("nightmarescare", 10)

		local bleed = ent:GiveStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(self.BleedDamage)
			bleed.Damager = self:GetOwner()
		end
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("Models/Charple/Charple1_sheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
