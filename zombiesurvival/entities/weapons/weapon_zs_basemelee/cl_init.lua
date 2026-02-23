INC_CLIENT()

include("animations.lua")

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60

SWEP.Slot = 0
SWEP.SlotPos = 0

function SWEP:TranslateFOV(fov)
	return GAMEMODE.FOVLerp * fov
end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end

local colChargeBG = Color(16, 16, 16, 220)
function DrawCharge(self, x, y, wid, hei)
	local screenscale = BetterScreenScale()
	local barheight = 20 * screenscale
	local bary = y + hei * 0.6 

	local mini = 8 * screenscale
	local minidel = mini / 2

	local intd = self:GetOwner():GetActiveWeapon():GetDTInt(DT_PLAYER_INT_ABILITYWEAPON)
	local fullcharge = (intd >= 100 or self.AbilityActive)

	local color = self.ChargeColor
	if fullcharge then
		local sin = math.abs(math.sin(CurTime() * 6)) * 70
		color = Color(color.r + sin, color.g + sin, color.b + sin, color.a)
	end

	local hitnumber = "ZSHUDFontSmallester"
	local chargetext = fullcharge and "ZSHUDFontSmalle" or "ZSHUDFontSlightlySmaller"
	
	surface.SetDrawColor(colChargeBG)
	surface.DrawRect(x, bary, wid, barheight)
	surface.SetDrawColor(color)
	surface.DrawRect(x + minidel, bary + minidel, math.max(0, intd * 1.8 * screenscale - mini), barheight - mini)
	surface.SetDrawColor(Color(color.r * 0.9, color.g * 0.9, color.b * 0.9))
	surface.DrawRect(x + wid - 4 * screenscale, bary - minidel, mini / 1.75, barheight + mini)

	draw.SimpleTextBlurry(fullcharge and self.FullChargeText or self.ChargeText, chargetext, x + wid * 0.5, y + hei * 0.25, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function SWEP:DrawChargeMelee()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72

	local yy = ScrH() - hei * 2 - screenscale * 84
	DrawCharge(self, x + wid * 0.25 - wid/4, yy + hei * 0.2, wid, hei)
end

function SWEP:DrawHUD()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()

	if self.EnableChargingAbility then
		self:DrawChargeMelee()
	end
end

function SWEP:OnRemove()
	self:Anim_OnRemove()
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PreDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and (owner.ShadowMan or owner.SpawnProtection) then return end

	if not GAMEMODE.DrawSCKWeapons or owner == MySelf or owner:Team() == TEAM_ZOMBIE then
		self:Anim_DrawWorldModel()
	else
		self:DrawModel()
	end
end

local ghostlerp = 0
function SWEP:GetViewModelPosition(pos, ang)
	local owner = self:GetOwner()
	if self:IsSwinging() then
		local rot = self.SwingRotation
		local offset = self.SwingOffset
		local armdelay = owner:GetMeleeSpeedMul()
		local swingtime = self.SwingTime * (owner.MeleeSwingDelayMul or 1) * armdelay

		ang = Angle(ang.pitch, ang.yaw, ang.roll) -- Copy

		local swingend = self:GetSwingEnd()
		local delta = swingtime - math.Clamp(swingend - CurTime(), 0, swingtime)
		local power = CosineInterpolation(0, 1, delta / swingtime)

		if power >= 0.9 then
			power = (1 - power) ^ 0.4 * 2
		end

		pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

		ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
		ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
		ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
	end

	local rotate = self.VMPos or Vector(0, 0, 0)
    pos:Add(ang:Right() * rotate.x)
    pos:Add(ang:Forward() * rotate.y)
    pos:Add(ang:Up() * rotate.z)

	local rotateang = self.VMAng
    if rotateang then
        ang:RotateAroundAxis(ang:Right(), rotateang.x)
        ang:RotateAroundAxis(ang:Up(), rotateang.y)
        ang:RotateAroundAxis(ang:Forward(), rotateang.z)
    end

	if owner:GetBarricadeGhosting() then
		ghostlerp = math.min(1, ghostlerp + FrameTime() * 4)
	elseif ghostlerp > 0 then
		ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
	end

	if ghostlerp > 0 then
		pos = pos + 3.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
	end

	return pos, ang + self:ViewBob(self.Owner)
end
