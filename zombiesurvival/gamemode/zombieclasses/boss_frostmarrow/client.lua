include("shared.lua")

CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
CLASS.IconColor = Color(30, 30, 200)

local matSkin = Material("Models/Barnacle/barnacle_sheet")
function CLASS:PrePlayerDraw(pl)
	render.SetColorModulation(0, 6, 30)
	render.ModelMaterialOverride(matSkin)
end

function CLASS:PostPlayerDraw(pl)
	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()
end
