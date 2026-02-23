INC_SERVER()

SWEP.Primary.Projectile = "projectile_impactmine_kin"
SWEP.Primary.ProjVelocity = 850

function SWEP:PhysModify(physobj)
	physobj:AddAngleVelocity(VectorRand():GetNormalized() * 90)
end
