ENT.Type = "anim"

ENT.NoNails = true

function ENT:HumanHoldable(pl)
	return false
end

function ENT:ShouldNotCollide(ent)
        return ent:IsPlayer() and ent:Team() == TEAM_HUMAN
end