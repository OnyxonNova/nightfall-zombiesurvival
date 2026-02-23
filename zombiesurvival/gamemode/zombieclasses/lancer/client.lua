include("shared.lua")

CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
CLASS.IconColor = Color(185, 25, 25)

local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local render_ModelMaterialOverride = render.ModelMaterialOverride
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld
local colGlow = Color(0, 255, 0)
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(5, -4.6, -1.5)
local vecEyeRight = Vector(5, -4.6, 1.5)
local matFlesh = Material("models/flesh")

function CLASS:PrePlayerDrawOverrideModel(pl)
	render.SetColorModulation(0.5, 0, 0)
	render.ModelMaterialOverride(matFlesh)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()

    if pl:IsValid() and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

    local pos, ang = pl:GetBonePositionMatrixed(6)
    if pos then
        render.SetMaterial(matGlow)
        render.DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
        render.DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 10, 0.5, colGlow)
        render.DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
        render.DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 10, 0.5, colGlow)
    end
end