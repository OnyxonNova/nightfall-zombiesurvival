INC_CLIENT()

SWEP.PrintName = "Зомбайн"
SWEP.ViewModelFOV = 60
SWEP.DrawCrosshair = false

local matGlow = Material("sprites/glow04_noz")
function SWEP:DrawWorldModel()
	if not self:IsGrenading() then return end
	local owner = self:GetOwner()
	if not owner:IsValid() then return end
	if owner ~= MySelf and owner.ShadowMan then return end
	
	local gen = owner:LookupAttachment( "grenade_attachment" )
	local grenade_data = owner:GetAttachment( gen )
	
	if self:IsGrenading() then
		if CLIENT then
			render.SetMaterial(matGlow)
			render.DrawSprite( grenade_data.Pos, 25, 25, COLOR_RED )
            render.SetMaterial(matGlow)
			render.DrawSprite( grenade_data.Pos, 64, 2, COLOR_RED )
		end
	end
end
SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

function SWEP:DrawHUD()
	if GetConVarNumber("crosshair") ~= 1 then return end
	self:DrawCrosshairDot()
end