AddCSLuaFile()


ENT.Type = "anim"
ENT.Base = "status__base"

ENT.Ephemeral = true

AccessorFuncDT(ENT, "Duration", "Float", 0)
AccessorFuncDT(ENT, "StartTime", "Float", 4)

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	if CLIENT then
	    local owner = self:GetOwner()
    	if owner:IsValid() and owner == MySelf then
      		MySelf:EmitSound("physics/metal/metal_box_strain" .. math.random(4) .. ".wav")
    	end
	end
end

function ENT:PlayerSet()
	self:SetStartTime(CurTime())
end

if SERVER then
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
end