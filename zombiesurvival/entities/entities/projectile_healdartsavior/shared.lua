ENT.Type = "anim"

function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == TEAM_UNDEAD
end

AccessorFuncDT(ENT, "HitTime", "Float", 0)
AccessorFuncDT(ENT, "Seeked", "Entity", 0)
