INC_SERVER()

function ENT:PlayerSet(pPlayer, bExists)
	pPlayer.Vampirism = self
end

function ENT:Think()
	local owner = self:GetOwner()
	if self:GetVampirism() <= 0 then
		self:Remove()
		return
	end
	
	local vampirismspeed = (0.175 * (math.max(0, owner.VampirismSpeedMul) or 1))
	if owner:IsSkillActive(SKILL_IMPATIENCE) then
		if owner:Health() <= math.floor(owner:GetMaxHealth() * 0.5) then
			vampirismspeed = (vampirismspeed / 1.5)
		else
			vampirismspeed = (0.175 * (math.max(0, owner.VampirismSpeedMul + 0.3) or 1))
		end
	end

	owner:SetBloodArmor(math.min(owner:GetBloodArmor() + 1, owner:GetMaxBloodArmor()))
	self:NextThink(CurTime() + vampirismspeed)

	self:AddVampirism(-1)
	return true
end