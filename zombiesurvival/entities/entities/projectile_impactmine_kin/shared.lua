ENT.Base = "projectile_impactmine"

AccessorFuncDT(ENT, "HitTime", "Float", 0)

function ENT:IsActive()
	local hittime = self:GetHitTime()
	return hittime > 0 and CurTime() >= hittime + 0.5
end

function ENT:GetStartPos()
	return self:GetPos() + self:GetUp() * 5
end
