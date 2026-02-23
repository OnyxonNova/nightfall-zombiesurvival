INC_CLIENT()

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.NextEmit = 0

function ENT:Initialize()
	self:DrawShadow(false)

	self.AmbientSound = CreateSound(self, "zombiesurvival/skilltree_ambiance.ogg")
	self.AmbientSound:PlayEx(100, 100)
end

function ENT:OnRemove()
	self.AmbientSound:Stop()
end

function ENT:Think()
	local owner = self:GetOwner()
	if owner:IsValid() then
		self.AmbientSound:PlayEx(100, 200 + math.sin(RealTime()))
	end
end

function ENT:Draw()
	local owner = self:GetOwner()
	if not owner:IsValid() or owner.SpawnProtection then return end

	local pos = owner:WorldSpaceCenter()
	pos.z = pos.z + 5

	if CurTime() < self.NextEmit then return end
	self.NextEmit = CurTime() + 0.045

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 24)

	local particle = emitter:Add("particle/smokestack", pos + VectorRand() * 16)
	particle:SetDieTime(math.Rand(2, 5.35))
	particle:SetStartAlpha(56)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(21, 65))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 0))
	particle:SetRollDelta(math.Rand(0, 0))
	particle:SetVelocity(Vector(0, 0, 0))
	particle:SetGravity(Vector(0, 0, 10))
	particle:SetCollide(false)
	particle:SetBounce(0.45)
	particle:SetAirResistance(12)
	particle:SetColor(175, 0, 175)
	particle:SetLighting(false)

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 24)

	local particle = emitter:Add("particle/smokestack", pos + VectorRand() * 16)
	particle:SetDieTime(math.Rand(0.6, 1.5))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize(math.Rand(5, 15))
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 340))
	particle:SetRollDelta(math.Rand(0, 20))
	particle:SetVelocity(Vector(0, 0, 0))
	particle:SetGravity(Vector(0, 0, 20))
	particle:SetCollide(false)
	particle:SetBounce(0.45)
	particle:SetAirResistance(12)
	particle:SetColor(0, 0, 0)
	particle:SetLighting(false)

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end
