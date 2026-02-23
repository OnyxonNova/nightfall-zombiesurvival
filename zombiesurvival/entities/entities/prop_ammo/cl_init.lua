include("shared.lua")
DEFINE_BASECLASS("prop_baseoutlined")

ENT.ColorModulation = Color(0.25, 1, 0.25)

function ENT:Think()
	local isammo = string.lower(self:GetAmmoType())
	if isammo then
		local ammonames = GAMEMODE.AmmoNames[isammo]
		if ammonames then
			self.PrintName = ammonames
		end
		local icon = killicon.Get(self.GetAmmoType and (GAMEMODE.AmmoIcons[isammo] or self:GetAmmoType()))
		local icon2 = icon and icon[#icon]
        if icon and icon2 then
            self.ColorModulation = Color(icon2.r / 255, icon2.g / 255, icon2.b / 255, 255)
        end
	end
end