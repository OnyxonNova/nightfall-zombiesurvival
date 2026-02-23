INC_CLIENT()

function ENT:DrawTranslucent()
	local delta = math.max(0, self.DieTime - CurTime())
	local size = math.min(2, (0 - delta) * 1)
	local normal = -self:GetUp()

	local icea
	if size == 1 then
		icea = delta * 2.2
	else
		icea = 0.8
		self.Rotation = self.Rotation + FrameTime() * 520
	end
	self:SetAngles(Angle(180, self.Rotation, 0))
	self:SetModelScale(size*0.5, 0)


end

function ENT:Initialize()
	self:DrawShadow(false)
	self.DieTime = CurTime() + 0.75
	self.Rotation = math.Rand(0, 0)
	self:SetColor(Color(255, 255, 255, 100))
	--ExplosiveEffect(self:GetPos(), 48, 100, DMGTYPE_ICE)

	self:EmitSound("ambient/materials/rock4.wav", pos, 77, math.Rand(95, 105))
	self:EmitSound("physics/concrete/concrete_break2.wav", pos, 77, math.Rand(110, 120))

	local emitter = ParticleEmitter(self:GetPos())
	emitter:SetNearClip(40, 48)

	local ang = Angle(0,0,0)
	local up = Vector(0,0,10)
	local pos = self:GetPos()
	for i=1, 120 do
		ang:RotateAroundAxis(up, 3)
		local fwd = ang:Forward()
		local particle = emitter:Add("particle/snow", pos + Vector(0, 0, 25) + fwd * 20)
		particle:SetVelocity(fwd * 50)
		particle:SetAirResistance(-64)
		particle:SetDieTime(1.7)
		particle:SetLifeTime(1)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(50)
		particle:SetEndSize(0)
		particle:SetColor(200, 189, 140)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-3, 3))
	end
	emitter:Finish() emitter = nil collectgarbage("step", 64)
end
