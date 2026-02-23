ENT.Type = "anim"
ENT.Base = "status__base"

ENT.Ephemeral = true

function ENT:Initialize()
	self:DrawShadow(false)
	if self:GetDTFloat(1) == 0 then
		self:SetDTFloat(1, CurTime())
	end
end

function ENT:AddRegeneration(damage, attacker)
	local owner = self:GetOwner()

	self:SetRegeneration(self:GetRegeneration() + damage)
end

function ENT:SetRegeneration(damage)
	self:SetDTFloat(0, math.min(GAMEMODE.MaxRegeneration, damage))
end

function ENT:GetRegeneration()
	return self:GetDTFloat(0)
end
