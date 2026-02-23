INC_SERVER()

function ENT:Hit(vHitPos, vHitNormal, eHitEntity)
	if self.Exploded then return end
	self.Exploded = true
	self.DeathTime = 0

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = vHitNormal or Vector(0, 0, 1)

	if eHitEntity:IsValidLivingPlayer() and gamemode.Call("PlayerShouldTakeDamage", eHitEntity, owner) then
		eHitEntity:GiveStatus("frost", 8)
		eHitEntity:GiveStatus("dimvision", 8)
		eHitEntity:AddArmDamage(30)
		eHitEntity:AddLegDamage(30)
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(8)
		dmginfo:SetAttacker(owner)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamageType(DMG_GENERIC)
		eHitEntity:TakeDamageInfo(dmginfo)
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(vHitPos)
		effectdata:SetNormal(vHitNormal)
	util.Effect("explosion_cold", effectdata)
end

