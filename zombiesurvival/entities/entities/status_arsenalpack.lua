AddCSLuaFile()

ENT.Type = "anim"

ENT.IgnoreMelee = true
ENT.IgnoreBullets = true
ENT.IgnoreTraces = true
ENT.NoNails = true

if CLIENT then
	function ENT:Initialize()
		self:DrawShadow(false)
		self:SetModelScale(0, 0)
	end
end

if not SERVER then return end

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetNotSolid(true)
	self:SetModelScale(0, 0)

	self:SetModel("models/Items/item_item_crate.mdl")
end

function ENT:Think()
	local owner = self:GetOwner()
	if not (owner:IsValid() and owner:Alive() and owner:HasTrinket("arsenalpack")) then self:Remove() end
end