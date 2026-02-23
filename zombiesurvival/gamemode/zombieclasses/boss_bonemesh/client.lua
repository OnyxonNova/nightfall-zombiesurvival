CLASS = CLASS or {}

include("shared.lua")

CLASS.Icon = "zombiesurvival/killicons/bonemesh"
CLASS.IconColor = Color(255, 20, 0)

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local matFlesh = Material("models/flesh")

function CLASS:PrePlayerDraw(pl)
	render_SetBlend(0)
	render_SetColorModulation(0.2, 0.2, 0.2)
end

function CLASS:PostPlayerDraw(pl)
	render_SetBlend(1)
	render_SetColorModulation(1, 1, 1)
end

function CLASS:PrePlayerDrawOverrideModel(pl)
	render.SetColorModulation(0.5, 0, 0)
	render.ModelMaterialOverride(matFlesh)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()
end