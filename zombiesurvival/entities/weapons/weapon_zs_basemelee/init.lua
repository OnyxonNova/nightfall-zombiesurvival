INC_SERVER()

AddCSLuaFile("animations.lua")

function SWEP:ServerMeleeHitEntity(tr, hitent, damagemultiplier)
	if not hitent or not hitent:IsValid() then return end

	local phys = hitent:GetPhysicsObject()
	if hitent:GetMoveType() == MOVETYPE_VPHYSICS and phys:IsValid() and phys:IsMoveable() then
		hitent:SetPhysicsAttacker(self:GetOwner())
	end
end

function SWEP:ServerHitFleshEffects(hitent, tr, damagemultiplier)
	local owner = self:GetOwner()
	local damage = self.MeleeDamage * damagemultiplier

	if hitent:IsValid() and hitent:IsPlayer() and hitent:Team() == owner:Team() then return end

	util.Blood(tr.HitPos, math.Rand(damage * 0.25, damage * 0.6), (tr.HitPos - owner:GetShootPos()):GetNormalized(), math.min(400, math.Rand(damage * 6, damage * 12)), true)
end
