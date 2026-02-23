INC_CLIENT()

include("shared.lua")
include("animations.lua")

SWEP.ShowWorldModel = false
SWEP.ShowViewModel = true

SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 70

SWEP.Slot = 0
SWEP.SlotPos = 0

function SWEP:TranslateFOV(fov)
	return GAMEMODE.FOVLerp * fov
end

function SWEP:Reload()
end

function SWEP:DrawHUD()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and owner.ShadowMan then return end

	self:Anim_DrawWorldModel()
end

function SWEP:GetViewModelPosition(pos, ang)
	return pos, ang + self:ViewBob(self.Owner)
end

local wm, pos, ang
local GetBonePosition = debug.getregistry().Entity.GetBonePosition
function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and owner.ShadowMan then return end
	
	if (self.ShowWorldModel == nil or self.ShowWorldModel) then
		if self.DrawTraditionalWorldModel then
			self:DrawModel()
		else
			wm = self.WMEnt
			
			if IsValid(wm) then
				if IsValid(owner) then
					pos, ang = GetBonePosition(owner, owner:LookupBone("ValveBiped.Bip01_R_Hand"))
					
					if pos and ang then
						RotateAroundAxis(ang, Right(ang), self.WMAng[1])
						RotateAroundAxis(ang, Up(ang), self.WMAng[2])
						RotateAroundAxis(ang, Forward(ang), self.WMAng[3])

						pos = pos + self.WMPos[1] * Right(ang) 
						pos = pos + self.WMPos[2] * Forward(ang)
						pos = pos + self.WMPos[3] * Up(ang)
						
						wm:SetRenderOrigin(pos)
						wm:SetRenderAngles(ang)
						wm:DrawModel()
					end
				else
					wm:SetRenderOrigin(self:GetPos())
					wm:SetRenderAngles(self:GetAngles())
					wm:DrawModel()
					wm:DrawShadow()
				end
			else
				self:DrawModel()
			end
		end
	end

	self:Anim_DrawWorldModel()
end