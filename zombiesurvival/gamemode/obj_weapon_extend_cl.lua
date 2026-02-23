local meta = FindMetaTable("Weapon")

function meta:DrawWeaponCrosshair()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end

	self:DrawCrosshairCross()
	self:DrawCrosshairDot()
end

--local CrossHairScale = 1
local matGrad = Material("VGUI/gradient-r")
local function DrawLine(x, y, rot)
	local thickness = GAMEMODE.CrosshairThickness

	rot = 270 - rot
	surface.SetMaterial(matGrad)
	surface.SetDrawColor(0, 0, 0, GAMEMODE.CrosshairColor.a)
	surface.DrawTexturedRectRotated(x, y, 14, math.max(4 * thickness, 2 + 2 * thickness), rot)
	surface.SetDrawColor(GAMEMODE.CrosshairColor)
	surface.DrawTexturedRectRotated(x, y, 12, 2 * thickness, rot)
end

local baserot = 0
function meta:DrawCrosshairCross()
	local x = ScrW() * 0.5
	local y = ScrH() * 0.5

	local ironsights = self.GetIronsights and self:GetIronsights()

	local cone = self:GetCone()

	if cone <= 0 then return end

	--cone = ScrH() / 76.8 * cone
	cone = ScrH() * 0.0003125 * cone
	cone = cone * 90 / MySelf:GetFOV()

	--CrossHairScale = cone --math.Approach(CrossHairScale, cone, FrameTime() * math.max(5, math.abs(CrossHairScale - cone) * 0.02))

	local midarea = 40 * cone --CrossHairScale

	local vel = MySelf:GetVelocity()
	local len = vel:LengthSqr()
	vel:Normalize()
	if GAMEMODE.NoCrosshairRotate then
		baserot = GAMEMODE.CrosshairOffset
	else
		baserot = math.NormalizeAngle(baserot + vel:Dot(EyeAngles():Right()) * math.min(10, len / 40000))
	end

	local ang = Angle(0, 0, baserot)
	for i=0, 359, 360 / GAMEMODE.CrosshairLines do
		ang.roll = baserot + i
		local p = ang:Up() * midarea
		DrawLine(math.Round(x + p.y), math.Round(y + p.z), ang.roll)
	end
end

function meta:DrawCrosshairDot()
	local x = ScrW() * 0.5
	local y = ScrH() * 0.5
	local thickness = GAMEMODE.CrosshairThickness
	local size = 4 * thickness
	local hsize = size/2

	surface.SetDrawColor(GAMEMODE.CrosshairColor2)
	surface.DrawRect(x - hsize, y - hsize, size, size)
	surface.SetDrawColor(0, 0, 0, GAMEMODE.CrosshairColor2.a)
	surface.DrawOutlinedRect(x - hsize, y - hsize, size, size)

	if GAMEMODE.LastOTSBlocked and MySelf:Team() == TEAM_HUMAN and GAMEMODE:UseOverTheShoulder() then
		GAMEMODE:DrawCircle(x, y, 8, COLOR_RED)
	end

end

local matScope = Material("zombiesurvival/scope")
function meta:DrawRegularScope()
	local scrw, scrh = ScrW(), ScrH()
	local size = math.min(scrw, scrh)
	surface.SetMaterial(matScope)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
	surface.SetDrawColor(0, 0, 0, 255)
	if scrw > size then
		local extra = (scrw - size) * 0.5
		surface.DrawRect(0, 0, extra, scrh)
		surface.DrawRect(scrw - extra, 0, extra, scrh)
	end
	if scrh > size then
		local extra = (scrh - size) * 0.5
		surface.DrawRect(0, 0, scrw, extra)
		surface.DrawRect(0, scrh - extra, scrw, extra)
	end
end

local texGradientU = Material("vgui/gradient-u")
local texGradientD = Material("vgui/gradient-d")
local texGradientR = Material("vgui/gradient-r")
function meta:DrawFuturisticScope()
	local scrw, scrh = ScrW(), ScrH()
	local size = math.min(scrw, scrh)
	local hw,hh = scrw * 0.5, scrh * 0.5
	local screenscale = BetterScreenScale()
	local gradsize = math.ceil(size * 0.14)
	local line = 38 * screenscale

	for i=0,6 do
		local rectsize = math.floor(screenscale * 44) + i * math.floor(130 * screenscale)
		local hrectsize = rectsize * 0.5
		surface.SetDrawColor(0,145,255,math.max(35,25 + i * 30)/2)
		surface.DrawOutlinedRect(hw-hrectsize,hh-hrectsize,rectsize,rectsize)
	end
	if scrw > size then
		local extra = (scrw - size) * 0.5
		for i=0,12 do
			surface.SetDrawColor(0,145,255, math.max(10,255 - i * 21.25)/2)
			surface.DrawLine(hw,i*line,hw,i*line+line)
			surface.DrawLine(hw,scrh-i*line,hw,scrh-i*line-line)
			surface.DrawLine(i*line+extra,hh,i*line+line+extra,hh)
			surface.DrawLine(scrw-i*line-extra,hh,scrw-i*line-line-extra,hh)
		end
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, extra, scrh)
		surface.DrawRect(scrw - extra, 0, extra, scrh)
	end
	if scrh > size then
		local extra = (scrh - size) * 0.5
		for i=0,12 do
			surface.SetDrawColor(0,145,255, math.max(10,255 - i * 21.25)/2)
			surface.DrawLine(hw,i*line+extra,hw,i*line+line+extra)
			surface.DrawLine(hw,scrh-i*line-extra,hw,scrh-i*line-line-extra)
			surface.DrawLine(i*line,hh,i*line+line,hh)
			surface.DrawLine(scrw-i*line,hh,scrw-i*line-line,hh)
		end
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, scrw, extra)
		surface.DrawRect(0, scrh - extra, scrw, extra)
	end

	surface.SetMaterial(texGradientU)
	surface.SetDrawColor(0,0,0,255)
	surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, gradsize)
	surface.SetMaterial(texGradientD)
	surface.DrawTexturedRect((scrw - size) * 0.5, scrh - (scrh - size) * 0.5 - gradsize, size, gradsize)
	surface.SetMaterial(texGradientR)
	surface.DrawTexturedRect(scrw - (scrw - size) * 0.5 - gradsize, (scrh - size) * 0.5, gradsize, size)
	surface.DrawTexturedRectRotated((scrw - size) * 0.5 + gradsize / 2, (scrh - size) * 0.5 + size / 2, gradsize, size, 180)
end

function meta:BaseDrawWeaponSelection(x, y, wide, tall, alpha)
	local ammotype1 = self:ValidPrimaryAmmo()
	local ammotype2 = self:ValidSecondaryAmmo()

	local ki = killicon.Get(self:GetClass())
	local cols = ki and ki[#ki] or ""

	if ki and #ki == 3 then
		draw.SimpleText(ki[2], ki[1] .. "ws", x + wide * 0.5, y + tall * 0.5 + 26 * BetterScreenScale(), Color(cols.r, cols.g, cols.b, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif ki then
		local material = Material(ki[1])
		local wid, hei = material:Width() * BetterScreenScale(), material:Height() * BetterScreenScale()

		surface.SetMaterial(material)
		surface.SetDrawColor(cols.r, cols.g, cols.b, alpha )
		surface.DrawTexturedRect(x + wide * 0.5 - wid * 0.5, y + tall * 0.5 - hei * 0.5, wid, hei)
	end

	draw.SimpleTextBlur(self:GetPrintName(), "ZSHUDFontSmaller", x + wide * 0.5, y + tall * 0.15, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if ammotype1 then
		local total = self:GetPrimaryAmmoCount()
		local inclip = self:Clip1()
		local zeweapon = self.Primary.KnockbackScale == ZE_KNOCKBACKSCALE
		if self.RequiredClip and self.RequiredClip ~= 1 then
			total = math.floor(total / self.RequiredClip)
			inclip = math.floor(inclip / self.RequiredClip)
		end
		if inclip >= 0 then
			if zeweapon then
				draw.SimpleTextBlur("["..inclip.."]", "ZSHUDFontSmaller", x + wide * 0.05, y + tall * 0.9, total == 0 and COLOR_RED or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM_REAL)
			elseif self.Primary and self.Primary.ClipSize and self.Primary.ClipSize == 1 then
				draw.SimpleTextBlur("["..total.."]", "ZSHUDFontSmaller", x + wide * 0.05, y + tall * 0.9, total == 0 and COLOR_RED or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM_REAL)
			else
				draw.SimpleTextBlur("["..inclip.." / ".. total - inclip .."]", "ZSHUDFontSmaller", x + wide * 0.025, y + tall * 0.9, total == 0 and COLOR_RED or inclip == 0 and COLOR_YELLOW or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM_REAL)
			end
		end
	end

	if ammotype2 then
		local total = self:GetSecondaryAmmoCount()
		local inclip = self:Clip2()
		if self.RequiredClip and self.RequiredClip ~= 1 then
			total = math.floor(total / self.RequiredClip)
			inclip = math.floor(inclip / self.RequiredClip)
		end
		if inclip >= 0 then
			if self.Secondary and self.Secondary.ClipSize and self.Secondary.ClipSize == 1 then
				draw.SimpleTextBlur("["..total.."]", "ZSHUDFontSmaller", x + wide * 0.95, y + tall * 0.9, total == 0 and COLOR_RED or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM_REAL)
			else
				draw.SimpleTextBlur("["..inclip.." / ".. total - inclip .."]", "ZSHUDFontSmaller", x + wide * 0.95, y + tall * 0.9, total == 0 and COLOR_RED or inclip == 0 and COLOR_YELLOW or color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM_REAL)
			end
		end
	end

	return true
end

local function empty() end
function meta:HideWorldModel()
	self:DrawShadow(false)
	self.DrawWorldModel = empty
	self.DrawWorldModelTranslucent = empty
end

local function HiddenViewModel(self, pos, ang)
	return pos + ang:Forward() * -256, ang
end
function meta:HideViewModel()
	self.GetViewModelPosition = HiddenViewModel
end

function meta:ViewBob(owner)
	local frametime, time = FrameTime(), CurTime()
	local velocity, length = debug.getregistry().Entity.GetVelocity, debug.getregistry().Vector.Length
	local Ang0, curang, curviewbob = Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)
	local cos1, cos2
	local ws = owner:GetWalkSpeed()
	local vel = length(velocity(owner))
			
	if owner:OnGround() and vel > ws * 0.3 then
		if vel < ws * 1.2 then
			cos1 = math.cos(time * 15)
			cos2 = math.cos(time * 12)
			curviewbob.p = cos1 * 0.15
			curviewbob.y = cos2 * 0.1
		else
			cos1 = math.cos(time * 20)
			cos2 = math.cos(time * 15)
			curviewbob.p = cos1 * 0.25
			curviewbob.y = cos2 * 0.15
		end
	else
		curviewbob = LerpAngle(frametime * 10, curviewbob, Ang0)
	end


	return (not (self.GetIronsights and self:GetIronsights()) and GAMEMODE.ViewBobToggle) and curviewbob * 3 or Angle(0, 0, 0)
end