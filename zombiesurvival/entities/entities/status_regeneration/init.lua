INC_SERVER()

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Regeneration = self
end

function ENT:Think()
	local owner = self:GetOwner()
	if self:GetRegeneration() <= 0 then
		self:Remove()
		return
	end

	if owner:Health() < owner:GetMaxHealth() then
		self:AddRegeneration(-1)
		owner:SetHealth(math.min(owner:GetMaxHealth(), owner:Health() + 1))
	end

	self:NextThink(CurTime() + 0.7)
	return true
end