INC_CLIENT()
include("shared.lua")
include("cl_animations.lua")

ENT.ColorModulation = Color(1, 0.5, 0)

function ENT:Think()
	local itype = self:GetInventoryItemType()
	if itype ~= self.LastInvItemType then
		self.LastInvItemType = itype

		self:RemoveModels()

		local invdata = GAMEMODE.ZSInventoryItemData[itype]
 
		if invdata then
			local droppedeles = invdata.DroppedEles
			self.ShowBaseModel = not istable(droppedeles)

			if istable(droppedeles) then
				self.WElements = table.FullCopy(droppedeles)
				self:CreateModels(self.WElements)
			end

			self.ColorModulation = invdata.DroppedColorModulation or self.ColorModulation
			self.PropWeapon = true
			self.QualityTier = invdata.QualityTier > 0 and invdata.QualityTier
			self.Branch = GAMEMODE.ZSInventoryItemData[GAMEMODE:GetBaseItemName(itype)].AlternativeColors
			self.PrintName = GAMEMODE:GetTrinketName(invdata) or "?"
			self.CustomIcon = invdata.Icon or "weapon_zs_trinket"
		end
	end
end

function ENT:OnRemove()
	self:RemoveModels()
end
