INC_CLIENT()

ENT.NextEmit = 0

local Bones = {"ValveBiped.Bip01_Spine1"}
function ENT:Draw()
	if CurTime() < self.NextEmit then return end
	self.NextEmit = CurTime() + 0.2

	local owner = self:GetOwner()
	if not owner:IsValid() or (owner == MySelf and not owner:ShouldDrawLocalPlayer()) then return end

	local boneid, particle, pos

	for _, bonename in pairs(Bones) do
		boneid = owner:LookupBone(bonename)
		if boneid and boneid > 0 then
			pos = owner:GetBonePosition(boneid)
			if pos then
				pos.z = pos.z + 8

				local emitter = ParticleEmitter(pos)
				emitter:SetNearClip(12, 16)

				particle = emitter:Add("particle/smokesprites_0003", pos)
				particle:SetDieTime(math.Rand(1.2, 1.5))
				particle:SetVelocity(Vector(math.Rand(-12, 12), math.Rand(-12, 12), 0))
				particle:SetGravity(Vector(0, 0, -5))
				particle:SetColor(0, 155, 0)
				particle:SetAirResistance(8)
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.Rand(10, 25))
				particle:SetEndSize(0)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetRollDelta(math.Rand(-10, 10))

				emitter:Finish()
				emitter = nil
				collectgarbage("step", 64)
			end
		end
	end
end

function ENT:GetPower()
	return math.Clamp(self:GetStartTime() + self:GetDuration() - CurTime(), 0, 1)
end