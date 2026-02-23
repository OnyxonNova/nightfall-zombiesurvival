CLASS.Base = "elder_ghoul"

CLASS.Wave = 6 / 6

CLASS.Name = "Formidable Ghoul"
CLASS.TranslationName = "class_formidableghoul"
CLASS.Description = "description_formidableghoul"
CLASS.Help = "controls_formidableghoul"

CLASS.Health = 345
CLASS.Speed = 185
CLASS.ClassType = 1

CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio
CLASS.NoPlayerColor = true

CLASS.SWEP = "weapon_zs_formidableghoul"

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/ghoul"
CLASS.IconColor = Color(120, 40, 100)

local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld

local colGlow = Color(155, 0, 155)
local matSkin = Material("Models/charple/charple4_sheet.vtf")
local matGlow = Material("sprites/glow04_noz")
local vecEyeLeft = Vector(4, -4.6, -1)
local vecEyeRight = Vector(4, -4.6, 1)

function CLASS:PrePlayerDraw(pl)
	render.ModelMaterialOverride(matSkin)
	render.SetColorModulation(0.9, 0.55, 0.9)
end

function CLASS:PostPlayerDraw(pl)
	render.ModelMaterialOverride()
	render.SetColorModulation(1, 1, 1)

	if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

	local pos, ang = pl:GetBonePositionMatrixed(6)
	if pos then
		render_SetMaterial(matGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 10, 0.5, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 3, 3, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 10, 0.5, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 3, 3, colGlow)
	end
end
