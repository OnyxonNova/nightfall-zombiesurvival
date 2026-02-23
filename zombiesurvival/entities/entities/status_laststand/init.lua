INC_SERVER()

function ENT:SetDie(fTime)
	if fTime == 0 or not fTime then
		self.DieTime = 0
	elseif fTime == -1 then
		self.DieTime = 999999999
	else
		self.DieTime = CurTime() + fTime
		self:SetDuration(fTime)
	end
end

function ENT:EntityTakeDamage(ent, dmginfo)
	local attacker, inflictor, dmgtype = dmginfo:GetAttacker(), dmginfo:GetInflictor()
	if attacker ~= self:GetOwner() then return end
	local wep = attacker:GetActiveWeapon()
	if attacker:IsValidLivingHuman() and inflictor:IsValid() and wep.IsMelee then
		local dmg = dmginfo:GetDamage()
		dmginfo:SetDamage(dmg * 2)
	end
end
