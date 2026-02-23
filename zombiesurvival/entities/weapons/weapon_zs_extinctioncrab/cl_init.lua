INC_CLIENT()

SWEP.PrintName = "Краб Геноцида"
SWEP.DrawCrosshair = false

function SWEP:DrawHUD()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()
end