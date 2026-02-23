INC_SERVER()

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Bleed = self
end

function ENT:Think()
	local owner = self:GetOwner()

	if self:GetDamage() <= 0 then
		self:Remove()
		return
	end

	local dmg = math.Clamp(self:GetDamage(), 1, 2)

	owner:TakeDamage(dmg, self.Damager and self.Damager:IsValid() and self.Damager:IsPlayer() and self.Damager:Team() ~= owner:Team() and self.Damager or owner, self)
	self:AddDamage(-dmg)

	local dir = VectorRand()
	dir:Normalize()
	util.Blood(owner:WorldSpaceCenter(), 3, dir, 32)

	local ticktime = 1.4 / (owner.BleedSpeedMul or 1)
	self:NextThink(CurTime() + ticktime)
	return true
end
