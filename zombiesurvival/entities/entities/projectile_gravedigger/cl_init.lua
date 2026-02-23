INC_CLIENT()

local matOverride = Material("models/shiny")
function ENT:Draw()
	local alt = self:GetDTBool(0)
	render.SetColorModulation(alt and 0 or 255, 0, alt and 0 or 0)
	render.ModelMaterialOverride(matOverride)

	self:DrawModel()

	render.ModelMaterialOverride()
	render.SetColorModulation(1, 1, 1)

	local pos = self:GetPos()

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)

	local particle = emitter:Add("particles/smokey", pos)
	particle:SetDieTime(0.35)
	particle:SetStartAlpha(185)
	particle:SetEndAlpha(0)
	particle:SetStartSize(5)
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 255))
	particle:SetRollDelta(math.Rand(-10, 10))
	particle:SetColor(alt and 0 or 255, 0, alt and 255 or 0)

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end
