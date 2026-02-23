ENT.Type = "anim"
ENT.Base = "base_anim"
function ENT:ShouldNotCollide(ent)
	return ent:IsPlayer() and ent:Team() == TEAM_UNDEAD
end

ENT.Damage = 30
