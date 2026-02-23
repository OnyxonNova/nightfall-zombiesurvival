AddCSLuaFile()

ENT.Type = "anim"

if not CLIENT then return end

ENT.RenderGroup = RENDERGROUP_BOTH

ENT.ColorModulation = Color(1, 0.5, 1)
ENT.Seed = 0

function ENT:Initialize()
	self.Seed = math.Rand(0, 10)
end

function ENT:DrawPreciseModel(ble, cmod)
	if self.PropWeapon and not self.ShowBaseModel then
		render.SetBlend(0)
	end
	self:DrawModel()
	if self.PropWeapon and not self.ShowBaseModel then
		render.SetBlend(1)
	end
	if self.RenderModels and not self.NoDrawSubModels then
		self:RenderModels(ble, cmod)
	end
end

function ENT:SetZ()
    if MySelf:IsSkillActive(SKILL_SCAVENGER) then
        cam.IgnoreZ(true)
    end
end

local color = {}
function ENT:ItemColorModulation()
    color[1] = self.ColorModulation.r
    color[2] = self.ColorModulation.g
    color[3] = self.ColorModulation.b

    if self.QualityTier then
        local qual = self.BranchData and self.BranchData.Colors and self.BranchData.Colors[self.QualityTier]
        if qual then
            color[1] = qual.r / 255
            color[2] = qual.g / 255
            color[3] = qual.b / 255
		else
			local qcolt = GAMEMODE.WeaponQualityColors[self.QualityTier][self.Branch and 2 or 1]
			if qcolt then
				color[1] = qcolt.r / 255
           		color[2] = qcolt.g / 255
           		color[3] = qcolt.b / 255
			end
        end
    end

    return color
end

local boxcol = Color(55, 55, 55)
local matLight = Material("zombiesurvival/effects/gradient_up_item.vmt")
function ENT:BeamRender()
    if EyePos():DistToSqr(self:GetPos()) > 250000 then return end

	self:SetZ()

    local primayworldsc = self:WorldSpaceCenter()
    local secondaryworldsc = self:WorldSpaceCenter()
    secondaryworldsc.z = secondaryworldsc.z + 35

	local getcolor = self:ItemColorModulation()

	render.SetMaterial(matLight)
    render.DrawBeam(primayworldsc, secondaryworldsc, 0.75, 0, 1, Color(getcolor[1] * 255, getcolor[2] * 255, getcolor[3] * 255))

    local eyeang = EyeAngles()
    eyeang:RotateAroundAxis(eyeang:Up(), -90)
    eyeang:RotateAroundAxis(eyeang:Forward(), 90)

    cam.Start3D2D(secondaryworldsc, eyeang, 0.1)
    	local text = (self.GetAmmoType and MySelf:IsSkillActive(SKILL_SCAVENGER)) and self.PrintName.." x"..self:GetAmmo() or self.PrintName
		surface.SetFont( "ZS3D2DFont2Smaller" )
    	draw.WordBox(4, -surface.GetTextSize(text) * 0.5, 0, text, "ZS3D2DFont2Smaller", boxcol, Color(getcolor[1] * 255, getcolor[2] * 255, getcolor[3] * 255), true)
    cam.End3D2D()

    cam.IgnoreZ(false)
end

local function IconItemRender(self)
	 if self.PrintName then
		local typeitem = self.SetInventoryItemType
		local data = typeitem and GAMEMODE.ZSInventoryItemData[self:GetInventoryItemType()]
		local geticon = killicon.Get(self.GetAmmoType and (GAMEMODE.AmmoIcons[string.lower(self:GetAmmoType())] or self:GetAmmoType()) 
		or typeitem and (data and data.Icon or "weapon_zs_trinket") or self:GetWeaponType(), true)

		self:SetZ()

		local worldspacecenter = self:WorldSpaceCenter()
    	local eyeangles = EyeAngles()
		eyeangles:RotateAroundAxis(eyeangles:Up(), -90)
    	eyeangles:RotateAroundAxis(eyeangles:Forward(), 90)

		local colorget = self:ItemColorModulation()
        local color = geticon and data and geticon[2] == color_white and Color(colorget[1] * 255, colorget[2] * 255, colorget[3] * 255) or geticon and geticon[#geticon] or ""

        if geticon and #geticon == 3 then
			cam.Start3D2D(worldspacecenter, eyeangles, 0.15)
			local icon = geticon[1] .. "ws"
			surface.SetFont(icon)
			local icon2 = geticon[2]
			local widfont, heifont = surface.GetTextSize(icon2)
			draw.WordBox(0, -widfont * 0.5, -heifont * 0.15, icon2, icon, Color(color.r, color.g, color.b, 0), Color(color.r, color.g, color.b, 255))
			cam.End3D2D()
		elseif geticon then
			local icon = isstring(geticon[1]) and Material(geticon[1]) or geticon[1]
			local wid, hei = icon:Width(), icon:Height()
			cam.Start3D2D(worldspacecenter, eyeangles, self.GetAmmoType and 0.075 or 0.15)
			surface.SetMaterial(icon)
            surface.SetDrawColor(Color(color.r, color.g, color.b, 255))
			surface.DrawTexturedRect(-wid * 0.5, -hei * 0.5, wid, hei)
			cam.End3D2D()
        end
		cam.IgnoreZ(false)
	end
end

local matWireframe = Material("models/wireframe")
local matWhite = Material("models/debug/debugwhite")
local function ModelItemRender(self)
	if not MySelf:IsValid() or MySelf:Team() ~= TEAM_HUMAN then
		self:DrawPreciseModel()
		return
	end
	
	local mul = self.QualityTier and (self.QualityTier + 1) or 1
	local time = (CurTime() * 1.5*mul + self.Seed) % 2/mul
	
	self:DrawPreciseModel()
	
	if time > 1 then return end

	local oldscale = self:GetModelScale()
	local normal = self:GetUp()
	local rnormal = normal * -1
	local mins = self:OBBMins()
	local mdist = self:OBBMaxs().z - mins.z
	mins.x = 0
	mins.y = 0
	local minpos = self:LocalToWorld(mins)

	self:SetModelScale(oldscale * 1.01, 0)

	if render.SupportsVertexShaders_2_0() then
		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(minpos + mdist * time * normal))
		render.PushCustomClipPlane(rnormal, rnormal:Dot(minpos + mdist * time * (1 + 0.25 * mul) * normal))
	end

	local getcolor = self:ItemColorModulation()

	render.SetColorModulation(getcolor[1], getcolor[2], getcolor[3])
	render.SuppressEngineLighting(true)

	render.SetBlend(0.1 + 0.05 * mul)
	render.ModelMaterialOverride(matWhite)
	self:SetZ()
	self:DrawPreciseModel(0.1 + 0.05 * mul, getcolor)

	render.SetBlend(0.05 + 0.1 * mul)
	render.ModelMaterialOverride(matWireframe)
	self:DrawPreciseModel(0.05 + 0.1 * mul, getcolor)

	cam.IgnoreZ(false)

	render.ModelMaterialOverride(0)
	render.SuppressEngineLighting(false)
	render.SetBlend(1)
	render.SetColorModulation(1, 1, 1)

	if render.SupportsVertexShaders_2_0() then
		render.PopCustomClipPlane()
		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end
	self:SetModelScale(oldscale, 0)
end

function ENT:DrawTranslucent()
	self:DrawShadow(false)

	if self.NoRender then
		return
	end

	if EyePos():DistToSqr(self:GetPos()) > 1048576 then return end

	if GAMEMODE.GetLootsDisplay > 0 then
		ModelItemRender(self)
	else
		IconItemRender(self)
	end

	if GAMEMODE.EnableLootDrawBox and MySelf:IsValid() and MySelf:Team() == TEAM_HUMAN then
		self:BeamRender()
	end
end

function ENT:Draw()
	self:DrawTranslucent()
end
