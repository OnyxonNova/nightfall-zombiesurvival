ENT.Type = "anim"

ENT.m_NoNailUnfreeze = true
ENT.NoNails = true

ENT.CanPackUp = true
ENT.PackUpTime = 2
ENT.IgnorePackTimeMul = true

ENT.IsBarricadeObject = true

ENT.IgnoreBullets = true
ENT.IgnoreMeleeTeam = TEAM_HUMAN
ENT.IgnoreTraces = true

function ENT:GetObjectHealth()
	return self:GetDTFloat(0)
end

function ENT:SetMaxObjectHealth(health)
	self:SetDTFloat(1, health)
end

function ENT:GetMaxObjectHealth()
	return self:GetDTFloat(1)
end

function ENT:SetObjectOwner(ent)
	self:SetDTEntity(0, ent)
end

function ENT:GetObjectOwner()
	return self:GetDTEntity(0)
end

function ENT:ClearObjectOwner()
	self:SetObjectOwner(NULL)
end

function ENT:HitByWrench(wep, owner, tr)
	return true
end

function ENT:ShouldNotCollide(ent)
	if ent:IsPlayer() and ent:Team() == TEAM_UNDEAD then return false end
	local colgroup = ent:GetCollisionGroup()
	if ent.IsBarricadeObject or colgroup == COLLISION_GROUP_PLAYER or colgroup == COLLISION_GROUP_WEAPON or colgroup == COLLISION_GROUP_NONE then
		return true
	end

	return false
end