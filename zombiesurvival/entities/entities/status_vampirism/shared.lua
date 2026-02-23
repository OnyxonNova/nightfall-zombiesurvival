ENT.Type = "anim"
ENT.Base = "status__base"

ENT.Ephemeral = true

function ENT:Initialize()
	self:DrawShadow(false)
	if self:GetDTFloat(1) == 0 then
		self:SetDTFloat(1, CurTime())
	end
end

function ENT:AddVampirism(damage, attacker)
	local owner = self:GetOwner()

	self:SetVampirism(self:GetVampirism() + damage)
end

function ENT:SetVampirism(damage)
	self:SetDTFloat(0, math.min(GAMEMODE.MaxVampirism, damage))
end

function ENT:GetVampirism()
	return self:GetDTFloat(0)
end
