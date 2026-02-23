INC_CLIENT()
include("shared.lua")
include("cl_animations.lua")
DEFINE_BASECLASS("prop_baseoutlined")

ENT.ColorModulation = Color(1, 1, 1)

function ENT:Initialize()
    BaseClass.Initialize(self)
    local weapons = weapons.GetStored(self:GetWeaponType())
    if weapons then
        self.PrintName = weapons.PrintName or "?"
    end
end

function ENT:Think()
	local class = self:GetWeaponType()
	if class ~= self.LastWeaponType then
		self.LastWeaponType = class

		self:RemoveModels()

		local weptab = weapons.Get(class)
		if weptab then
			local showmdl = weptab.ShowWorldModel or not self:LookupBone("ValveBiped.Bip01_R_Hand") and not weptab.NoDroppedWorldModel
			self.ShowBaseModel = weptab.ShowWorldModel == nil and true or showmdl

			if weptab.WElements then
				self.WElements = table.FullCopy(weptab.WElements)
				self:CreateModels(self.WElements)
			end
			local geticon = killicon.Get(self:GetWeaponType())
            local getcol = geticon and geticon[#geticon]
            self.ColorModulation = getcol and Color(getcol.r / 255, getcol.g / 255, getcol.b / 255, 255) or weptab.DroppedColorModulation or self.ColorModulation
			self.PropWeapon = true
			self.QualityTier = weptab.QualityTier
			self.Color = weptab.Color
			self.Branch = weptab.Branch
			self.BranchData = weptab.Branches and weptab.Branches[self.Branch]
			self.WepClass = class
			self.NoRender = weptab.NoItemRender
		end
	end
end

function ENT:OnRemove()
	self:RemoveModels()
end
