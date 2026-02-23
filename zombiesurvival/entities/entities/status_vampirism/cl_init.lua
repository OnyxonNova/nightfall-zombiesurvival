INC_CLIENT()

function ENT:Draw()
end

function ENT:Initialize()
	self:GetOwner().Vampirism = self
end
