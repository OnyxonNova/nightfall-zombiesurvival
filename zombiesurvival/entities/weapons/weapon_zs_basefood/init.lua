INC_SERVER()

function SWEP:Eat()
	local owner = self:GetOwner()
	local healing = self.FoodHealth * (owner:GetTotalAdditiveModifier("FoodRecoveryMul", "HealingReceived"))
	
	if owner:IsSkillActive(SKILL_SUGARRUSH) then
		local sta = owner:GiveStatus("regeneration")
		sta:AddRegeneration(healing)
	else
		owner:SetHealth(math.min(owner:Health() + healing, owner:GetMaxHealth()))
	end

	self:TakePrimaryAmmo(1)
	if self:GetPrimaryAmmoCount() <= 0 then
		owner:StripWeapon(self:GetClass())
	end
end
