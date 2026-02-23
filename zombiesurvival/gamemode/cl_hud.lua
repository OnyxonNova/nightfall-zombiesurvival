local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
local surface_PlaySound = surface.PlaySound

local cam_IgnoreZ = cam.IgnoreZ
local cam_Start3D = cam.Start3D
local cam_End3D = cam.End3D
local cam_Start3D2D = cam.Start3D2D
local cam_End3D2D = cam.End3D2D

local render_FogMode = render.FogMode
local render_FogStart = render.FogStart
local render_FogEnd = render.FogEnd
local render_FogColor = render.FogColor
local render_FogMaxDensity = render.FogMaxDensity
local render_GetFogDistances = render.GetFogDistances
local render_GetFogColor = render.GetFogColor
local render_GetFogMode = render.GetFogMode

local M_Player = FindMetaTable("Player")
local P_Team = M_Player.Team

local draw_GetFontHeight = draw.GetFontHeight

function GM:_HUDPaint()
	if self.FilmMode then return end

	local screenscale = BetterScreenScale()
	local myteam = P_Team(MySelf)

	self:HUDDrawTargetID(myteam, screenscale)
	self:DrawSigilsHud(screenscale)
	self:DrawTotalDamageHUD(screenscale)

	if self:GetWave() > 0 and not self.ZombieEscape then
		self:DrawFearMeter(self:CachedFearPower(), screenscale)
	end

	if myteam == TEAM_UNDEAD then
		self:ZombieHUD()
	elseif myteam == TEAM_HUMAN then
		self:HumanHUD(screenscale)
	end
end

TotalDamage = 0
TotalDamageFade = 0
function GM:DrawTotalDamageHUD(screenscale)
	if not self.DrawTotalDamage or TotalDamageFade < CurTime() - 1 then
		TotalDamage = 0
		return
	end
	
	local opacity = TotalDamageFade - CurTime() + 1

	surface.SetFont("ZSHUDFontTotalDamage")
	surface.SetTextPos(8 * screenscale, ScrH() * 0.4)
	surface.SetTextColor(Color(255, 128, 0, (255 * opacity / 2)))
	surface.DrawText(translate.Get("total_damage") .. TotalDamage)
end

local currentpower = 0
local fearcount = 0
local smoothopacity = 0
local feartext = {}
local texDownEdge = surface.GetTextureID("gui/gradient_down")
local matGlow = Material("sprites/glow04_noz")
feartext[0] = "human_fear_text_0"
feartext[1] = "human_fear_text_1"
feartext[2] = "human_fear_text_2"
feartext[3] = "human_fear_text_3"
feartext[4] = "human_fear_text_4"
feartext[5] = "human_fear_text_5"
feartext[6] = "human_fear_text_6"
feartext[7] = "human_fear_text_7"
feartext[8] = "human_fear_text_8"
feartext[9] = "human_fear_text_9"
feartext[10] = "human_fear_text_10"
feartext[11] = "human_fear_text_10"
function GM:DrawFearMeter(power, screenscale)
	fearcount = Lerp(FrameTime() * 3, fearcount, power)
	smoothopacity = Lerp(FrameTime() * 10, smoothopacity, power > 0.005 and 1 or 0)

	local neardangertext = translate.Get(feartext[math.floor(fearcount * 11)])
	local resisttext = translate.Format("resist_x", math.ceil(self:GetDamageResistance(fearcount) * 100))
	
	local text = P_Team(MySelf) == TEAM_HUMAN and neardangertext or resisttext

	local w, h = ScrW(), ScrH()
	local fearmeterxsize = 220 * screenscale
	local fearmeterysize = 25 * screenscale
	local half_fearmeterxsize = fearmeterxsize * 0.5
	local mx, my = w * 0.5 - half_fearmeterxsize, h - 100 * screenscale

	local fearprogress = fearcount * fearmeterxsize
	local textcolor = Color(200, 200, 200, 225 * smoothopacity)

	if smoothopacity > 0.01 then
		surface.SetDrawColor(0, 0, 0, 100 * smoothopacity)
		surface_DrawRect(mx, my, fearmeterxsize, fearmeterysize)
	
		surface_SetDrawColor(fearcount * 200, 200 - fearcount * 200, 0, 200 * smoothopacity)
		surface.SetTexture(texDownEdge)
		surface_DrawTexturedRect(mx, my, fearprogress, fearmeterysize)

		surface_SetDrawColor(fearcount * 200, 200 - fearcount * 200, 0, 60 * smoothopacity)
		surface_DrawRect(mx, my, fearprogress, fearmeterysize)
	
		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255 * smoothopacity)
		surface_DrawTexturedRect(mx + (4 * screenscale) + fearprogress - (6 * screenscale), my - fearmeterysize * 0.5, 4 * screenscale, fearmeterysize * 2)

		draw.SimpleTextBlurry(text, "ZSDamageResistance", w * 0.5, my - 3 * screenscale, textcolor, TEXT_ALIGN_CENTER)
	end
end

local matSigil = Material("zombiesurvival/sigil.png")
local matCrossout = Material("zombiesurvival/crossout.png")
local rad, sigil, health, maxhealth, corrupt, damageflash, sigx, sigy, healthfrac
function GM:DrawSigilsHud(screenscale)
	if self:GetUseSigils() and self.GetMaxSigils() > 0 then
		local sigwid, sighei = screenscale * 29, screenscale * 58
		local mx, my = w * 0.5, h - sighei
		local corruptsigils = 0
		local sigils = GAMEMODE.CachedSigils
		local alignment = self.GetMaxSigils() * sigwid * 2.25

		for i=1, self.GetMaxSigils() do
			sigil = sigils[i]
			health = 0
			maxhealth = 0
			corrupt = false

			if sigil and sigil:IsValid() then
				health = sigil:GetSigilHealth()
				maxhealth = sigil:GetSigilMaxHealth()
				corrupt = sigil:GetSigilCorrupted()
				corruptsigils = corruptsigils + (corrupt and 1 or 0)
			end
			if health >= 0 then
				sigx = mx - alignment / 2 + alignment / self.GetMaxSigils() * (i - 1) + sigwid * 0.5
				sigy = my

				if sigil and sigil:IsValid() then
					damageflash = math.min((CurTime() - sigil:GetSigilLastDamaged()) * 2, 1) * 255
				else
					damageflash = 255
				end
				healthfrac = health / maxhealth
				if corrupt then
					surface_SetDrawColor((255 - damageflash) * healthfrac, damageflash * healthfrac, 0, 220)
				else
					surface_SetDrawColor((255 - damageflash) * healthfrac, damageflash * healthfrac, 220, 220)
				end

				local bounce = (255 - damageflash) * 0.05
				local bouncemax = (255 * 0.05)
				surface_SetMaterial(matSigil)
				surface_DrawTexturedRect(sigx - bounce * 0.5, sigy - bounce * 0.5 - bouncemax * 0.5, sigwid + bounce, sighei + bounce)

				if self.GetMaxSigils() > 1 then
                	draw.SimpleTextBlurry(string.char(64 + i), "ZSSigilLetter", sigx + sigwid * 0.5, sigy + sighei * 0.25 - bouncemax * 0.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
				end

				if corrupt then
					surface_SetMaterial(matCrossout)
					surface_SetDrawColor(220, 0, 0, 220)
					surface_DrawTexturedRect(sigx - bounce * 0.5, sigy - bounce * 0.5 - bouncemax * 0.5, sigwid + bounce, sighei + bounce)
				end
			end
		end
	end
end

local colSigilTeleport = Color(125, 215, 255, 220)
function GM:DrawSigilTeleportBar(x, y, fraction, target, screenscale)
	local maxbarwidth = 270 * screenscale
	local barheight = 11 * screenscale
	local barwidth = maxbarwidth * math.Clamp(fraction, 0, 1)
	local startx = x - maxbarwidth * 0.5

	local letter = ""
	if self.GetMaxSigils() > 1 then
		for i, sigil in pairs(ents.FindByClass("prop_obj_sigil")) do
			if target == sigil then
					letter = string.char(64 + i)
				break
			end
		end
	end
	surface_SetDrawColor(0, 0, 0, 220)
	surface_DrawRect(startx, y, maxbarwidth, barheight)
	surface_SetDrawColor(colSigilTeleport)
	surface_DrawRect(startx + 3, y + 3, barwidth - 6, barheight - 6)
	surface_DrawOutlinedRect(startx, y, maxbarwidth, barheight)
	
	draw.SimpleText(translate.Format("teleporting_to_sigil", letter), "ZSHUDFontSmall", x, y - draw_GetFontHeight("ZSHUDFontSmall") - 2, colSigilTeleport, TEXT_ALIGN_CENTER)
	draw.SimpleText(translate.Get("press_shift_to_cancel"), "ZSHUDFontSmaller", x, y + draw_GetFontHeight("ZSHUDFontSmaller") - 16, colSigilTeleport, TEXT_ALIGN_CENTER)
	local status = MySelf.SigilTeleport
    if self.GetMaxSigils() > 2 or self.GetMaxSigils() > 1 and (status:IsValid() and status:GetFromSigilFragment()) then
        draw.SimpleText(translate.Get("point_at_a_sigil_to_choose_destination"), "ZSHUDFontSmaller", x, y + draw_GetFontHeight("ZSHUDFontSmaller") * 2 - 16, colSigilTeleport, TEXT_ALIGN_CENTER)
    end
end

function GM:_PostDrawTranslucentRenderables()
	if not self.DrawingInSky then
		self:DrawPointWorldHints()
		self:DrawWorldHints()
		self:DrawSigilIndicators()
		self:DrawCrateIndicators()
		self:DrawResupplyIndicators()
		self:DrawRemantlerIndicators()
		self:DrawHumanIndicators()
		self:DrawNestIndicators()
		self:DrawBigNestIndicators()
        self:DrawZombieSpawnIndicators()
	end
end

local matArsenal = Material("zombiesurvival/arsenalcrate.png")
function GM:DrawCrateIndicators()
	if P_Team(MySelf) ~= TEAM_HUMAN then return end

	local pos, distance, ang, deployable, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matArsenal)

	for i, arsenal in pairs(GAMEMODE.CachedArsenalEntities) do
		if not arsenal:IsValid() then continue end
		deployable = arsenal.GetObjectOwner

		pos = arsenal:GetPos()
		pos.z = pos.z + (arsenal:IsPlayer() and 32 or (deployable and 12 or -8))
		distance = eyepos:DistToSqr(pos)

		if (distance >= 6400 and distance <= 1048576) and (not deployable or not WorldVisible(eyepos, pos)) then -- Limited to Scavenger's Eyes distance.
			ang = (eyepos - pos):Angle()
			ang:RotateAroundAxis(ang:Right(), 270)
			ang:RotateAroundAxis(ang:Up(), 90)
			alpha = math.min(220, math.sqrt(distance / 4))

			cam_IgnoreZ(true)
			cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)

			surface_SetDrawColor(255, 255, 255, alpha)
			surface_DrawTexturedRect(-123, -113, 248, 228)

			draw.SimpleTextBlurry("Арсенал", "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)

			cam_End3D2D()
			cam_IgnoreZ(false)
		end
	end
end

local matResupply = Material("zombiesurvival/resupply.png")
function GM:DrawResupplyIndicators()
	if P_Team(MySelf) ~= TEAM_HUMAN then return end

	local pos, distance, ang, deployable, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matResupply)

	for i, resupply in pairs(GAMEMODE.CachedResupplyEntities) do
		if not resupply:IsValid() then continue end
		deployable = resupply.GetObjectOwner

		pos = resupply:GetPos()
		pos.z = pos.z + (resupply:IsPlayer() and 32 or (deployable and 12 or -8))
		distance = eyepos:DistToSqr(pos)

		if (distance >= 6400 and distance <= 1048576) and (not deployable or not WorldVisible(eyepos, pos)) then -- Limited to Scavenger's Eyes distance.
			ang = (eyepos - pos):Angle()
			ang:RotateAroundAxis(ang:Right(), 270)
			ang:RotateAroundAxis(ang:Up(), 90)
			alpha = math.min(220, math.sqrt(distance / 4))

			cam_IgnoreZ(true)
			cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)

			surface_SetDrawColor(255, 255, 255, alpha)
			surface_DrawTexturedRect(-128, -128, 256, 256)

			local timeremain = math.ceil(math.max(0, (MySelf.NextUse or 0) - CurTime()))
			local txt = not MySelf.NextUse and translate.Get("ready") or timeremain > 0 and timeremain or translate.Get("ready")
			draw.SimpleTextBlurry(txt, "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)

			cam_End3D2D()
			cam_IgnoreZ(false)
		end
	end
end

local matRemantler = Material("zombiesurvival/remantler.png")
function GM:DrawRemantlerIndicators()
	if P_Team(MySelf) ~= TEAM_HUMAN then return end

	local pos, distance, ang, deployable, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matRemantler)

	for i, remantler in pairs(GAMEMODE.CachedRemantlerEntities) do
		if not remantler:IsValid() then continue end
		deployable = remantler.GetObjectOwner

		pos = remantler:GetPos()
		pos.z = pos.z + (remantler:IsPlayer() and 32 or (deployable and 12 or -8))
		distance = eyepos:DistToSqr(pos)

		if (distance >= 6400 and distance <= 1048576) and (not deployable or not WorldVisible(eyepos, pos)) then -- Limited to Scavenger's Eyes distance.
			ang = (eyepos - pos):Angle()
			ang:RotateAroundAxis(ang:Right(), 270)
			ang:RotateAroundAxis(ang:Up(), 90)
			alpha = math.min(220, math.sqrt(distance / 4))

			cam_IgnoreZ(true)
			cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)

			surface_SetDrawColor(255, 255, 255, alpha)
			surface_DrawTexturedRect(-128, -128, 256, 256)

			draw.SimpleTextBlurry("Верстак", "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)

			cam_End3D2D()
			cam_IgnoreZ(false)
		end
	end
end

local matNest = Material("zombiesurvival/nest.png")
function GM:DrawNestIndicators()
	if P_Team(MySelf) ~= TEAM_ZOMBIE then return end

	local pos, distance, ang, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matNest)

	for i, nest in pairs(GAMEMODE.CachedNests) do
		if not nest:IsValid() then continue end

		pos = nest:GetPos()
		pos.z = pos.z + 32
		distance = eyepos:DistToSqr(pos)

		ang = (eyepos - pos):Angle()
		ang:RotateAroundAxis(ang:Right(), 270)
		ang:RotateAroundAxis(ang:Up(), 90)
		alpha = math.min(220, math.sqrt(distance / 4))

		cam_IgnoreZ(true)
		cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)

		surface_SetDrawColor(255, 255, 255, alpha)
		surface_DrawTexturedRect(-128, -128, 256, 256)

		draw.SimpleTextBlurry("Гнездо", "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)

		if distance < 80000 then
			local nown = nest:GetNestOwner()
			local ownname = nown:IsValidZombie() and nown:ClippedName() or ""

			draw.SimpleTextBlurry(ownname, "ZS3D2DFont2", 0, 256, COLOR_GRAY, TEXT_ALIGN_CENTER)
		end

		cam_End3D2D()
		cam_IgnoreZ(false)
	end
end

function GM:DrawBigNestIndicators()
	if P_Team(MySelf) ~= TEAM_ZOMBIE then return end

	local pos, distance, ang, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matNest)

	for i, bignest in pairs(GAMEMODE.CachedBigNests) do
		if not bignest:IsValid() then continue end

		pos = bignest:GetPos()
		pos.z = pos.z + 32
		distance = eyepos:DistToSqr(pos)

		ang = (eyepos - pos):Angle()
		ang:RotateAroundAxis(ang:Right(), 270)
		ang:RotateAroundAxis(ang:Up(), 90)
		alpha = math.min(220, math.sqrt(distance / 4))

		cam_IgnoreZ(true)
		cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)

		surface_SetDrawColor(255, 255, 255, alpha)
		surface_DrawTexturedRect(-128, -128, 256, 256)

		draw.SimpleTextBlurry("Большое Гнездо", "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)

		if distance < 80000 then
			local nown = bignest:GetNestOwner()
			local ownname = nown:IsValidZombie() and nown:ClippedName() or ""

			draw.SimpleTextBlurry(ownname, "ZS3D2DFont2", 0, 256, COLOR_RED, TEXT_ALIGN_CENTER)
		end

		cam_End3D2D()
		cam_IgnoreZ(false)
	end
end


local matSkull = Material("zombiesurvival/horderally")
function GM:DrawZombieSpawnIndicators()
	if P_Team(MySelf) == TEAM_ZOMBIE or GAMEMODE:GetWaveActive() then return end

	local pos, distance, ang, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matSkull)

	for i, nest in pairs(GAMEMODE.CachedZSpawns) do
		if not nest:IsValid() then continue end

		local pos = nest:GetPos()
        local heightOffset = math.sin(CurTime()) * 35
        pos.z = pos.z + heightOffset

        local swayOffset = math.cos(CurTime()) * 30
        local angleOffset = Angle(0, swayOffset, 0)

        local distance = eyepos:DistToSqr(pos)

        local ang = (eyepos - pos):Angle() + angleOffset
        ang:RotateAroundAxis(ang:Right(), 270)
        ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Forward(), math.sin(CurTime() * 2) * 15)
        local alpha = math.min(220, math.sqrt(distance / 4))

        cam_IgnoreZ(true)
		cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 7000)

        surface_SetDrawColor(80, 255, 150, alpha)
        surface_DrawTexturedRect(-85, -85, 170, 170)

		cam_End3D2D()
		cam_IgnoreZ(false)
	end
end

function GM:DrawSigilIndicators()
	if not self:GetUseSigils() then return end

	local health, pos, distance, maxhealth, corrupted, damageflash, missinghealthfrac, ang, alpha
	local eyepos = EyePos()

	surface_SetMaterial(matSigil)

	for i, sigil in pairs(GAMEMODE.CachedSigils) do
		if not sigil:IsValid() then continue end

		health = sigil:GetSigilHealth()
		if health > 0 then
			pos = sigil:GetPos()
			pos.z = pos.z + 48
			distance = eyepos:DistToSqr(pos)

			maxhealth = sigil:GetSigilMaxHealth()
			corrupted = sigil:GetSigilCorrupted()
			damageflash = math.min((CurTime() - sigil:GetSigilLastDamaged()) * 2, 1) * 255
			missinghealthfrac = 1 - health / maxhealth
			alpha = math.min(220, math.sqrt(distance / 4))

			ang = (eyepos - pos):Angle()
			ang:RotateAroundAxis(ang:Right(), 270)
			ang:RotateAroundAxis(ang:Up(), 90)

			cam_IgnoreZ(true)
			cam_Start3D2D(pos, ang, math.max(250, math.sqrt(distance)) / 5000)
			local oldfogmode = render_GetFogMode()
			render_FogMode(0)

			if corrupted then
				surface_SetDrawColor(255 - damageflash, damageflash, 0, alpha)
			else
				surface_SetDrawColor(damageflash, 255, damageflash, alpha)
			end
			surface_DrawTexturedRect(-64, -128, 128, 256)
			if missinghealthfrac > 0 then
				surface_SetDrawColor(40, 40, 40, 255)
				surface_DrawTexturedRectUV(-64, -128, 128, 256 * missinghealthfrac, 0, 0, 1, missinghealthfrac)
			end
			
			if self.GetMaxSigils() > 1 then
				draw.SimpleTextBlurry(string.char(64 + i), "ZS3D2DFont2Big", 0, 128, COLOR_GRAY, TEXT_ALIGN_CENTER)
			end

			render_FogMode(oldfogmode)
			cam_End3D2D()
			cam_IgnoreZ(false)
		end
	end
end

local colPackUp = Color(20, 255, 20, 220)
local colPackUpNotOwner = Color(255, 240, 10, 220)
function GM:DrawPackUpBar(x, y, fraction, notowner, screenscale)
	local col = notowner and colPackUpNotOwner or colPackUp

	local maxbarwidth = 270 * screenscale
	local barheight = 11 * screenscale
	local barwidth = maxbarwidth * math.Clamp(fraction, 0, 1)
	local startx = x - maxbarwidth * 0.5

	surface_SetDrawColor(0, 0, 0, 220)
	surface_DrawRect(startx, y, maxbarwidth, barheight)
	surface_SetDrawColor(col)
	surface_DrawRect(startx + 3, y + 3, barwidth - 6, barheight - 6)
	surface_DrawOutlinedRect(startx, y, maxbarwidth, barheight)

	draw.SimpleText(notowner and CurTime() % 2 < 1 and translate.Format("requires_x_people", 4) or notowner and translate.Get("packing_others_object") or translate.Get("packing"), "ZSHUDFontSmall", x, y - draw_GetFontHeight("ZSHUDFontSmall") - 2, col, TEXT_ALIGN_CENTER)
end

function GM:HumanHUD(screenscale)
	local curtime = CurTime()
	local w, h = ScrW(), ScrH()
	local packup = MySelf.PackUp
	local sigiltp = MySelf.SigilTeleport
	if packup and packup:IsValid() then
		self:DrawPackUpBar(w * 0.5, h * 0.55, 1 - packup:GetTimeRemaining() / packup:GetMaxTime(), packup:GetNotOwner(), screenscale)
	elseif sigiltp and sigiltp:IsValid() then
		self:DrawSigilTeleportBar(w * 0.5, h * 0.55, 1 - sigiltp:GetTimeRemaining() / sigiltp:GetMaxTime(), sigiltp:GetTargetSigil(), screenscale)
	end

	if not self.RoundEnded then
		if self:GetWave() == 0 and not self:GetWaveActive() then
			draw.SimpleTextBlurry(translate.Get("waiting_for_players").." "..util.ToMinutesSecondsCD(math.max(0, self:GetWaveStart() - curtime)), "ZSHUDFontSmall", w * 0.5, h * 0.25, COLOR_GRAY, TEXT_ALIGN_CENTER)
		end

		local drown = MySelf.status_drown
		if drown and drown:IsValid() then
			surface_SetDrawColor(0, 0, 0, 60)
			surface_DrawRect(w * 0.4, h * 0.35, w * 0.2, 12)
			surface_SetDrawColor(30, 30, 230, 180)
			surface_DrawOutlinedRect(w * 0.4, h * 0.35, w * 0.2, 12)
			surface_DrawRect(w * 0.4, h * 0.35, w * 0.2 * (1 - drown:GetDrown()), 12)
			draw.SimpleTextBlurry(translate.Get("breath").." ", "ZSHUDFontSmall", w * 0.4, h * 0.35 + 6, COLOR_LBLUE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end

	local lockon = self.HumanMenuLockOn
	if self.InventoryMenu and self.InventoryMenu:IsValid() then
		if lockon and self:ValidMenuLockOnTarget(MySelf, lockon) then
			self.InventoryMenu.SelectedItemTitle:SetText(translate.Format("giving_items_to", lockon:Name()))
			self.InventoryMenu.SelectedItemTitle:SetFont("ZSHUDFontSmalle")
			self.InventoryMenu.SelectedItemTitle:SizeToContents()
			self.InventoryMenu.SelectedItemTitle:CenterHorizontal(0.5)
		end
	
		if not lockon and not self:ValidMenuLockOnTarget(MySelf, lockon) then
			self.InventoryMenu.SelectedItemTitle:SetText(translate.Get("inventory_selected_item_title"))
			self.InventoryMenu.SelectedItemTitle:SetFont("ZSHUDFontSmall")
			self.InventoryMenu.SelectedItemTitle:SizeToContents()
			self.InventoryMenu.SelectedItemTitle:CenterHorizontal(0.5)
		end
	end
	
	if gamemode.Call("PlayerCanPurchase", MySelf) then
		draw.SimpleTextBlurry(translate.Get("press_f2_for_the_points_shop"), "ZSHUDFontSmall", w * 0.5, screenscale * 135, COLOR_GRAY, TEXT_ALIGN_CENTER)
	end
end

function GM:ZombieObserverHUD(obsmode)
	local w, h = ScrW(), ScrH()
	local texh = draw_GetFontHeight("ZSHUDFontSmall")

	if obsmode == OBS_MODE_CHASE then
		local target = MySelf:GetObserverTarget()
		if target and target:IsValid() then
			if target:IsPlayer() and P_Team(target) == TEAM_UNDEAD then
				draw.SimpleTextBlur(translate.Format("observing_x", target:Name(), math.max(0, target:Health())), "ZSHUDFontSmall", w * 0.5, h * 0.75 - texh - 32, COLOR_DARKRED, TEXT_ALIGN_CENTER)
			end

			if target.IsCreeperNest or target.MinionSpawn then
				local txt = target.IsCreeperNest and "Nest" or "Gore Child"

				draw.SimpleTextBlur(translate.Format("observing_x_simple", txt), "ZSHUDFontSmall", w * 0.5, h * 0.75 - texh - 32, COLOR_DARKRED, TEXT_ALIGN_CENTER)
			end

			dyn = self:GetDynamicSpawning() and self:DynamicSpawnIsValid(target)
		end
	end

	local space = texh + 2
	local x, y = w * 0.5, h * 0.68

	if self:GetWaveActive() then
		draw.SimpleTextBlurry(translate.Get("press_lmb_to_spawn"), "ZSHUDFontSmall", x, y, COLOR_GRAY, TEXT_ALIGN_CENTER)
		draw.SimpleTextBlurry(translate.Get("press_rmb_to_spawn_close"), "ZSHUDFontSmall", x, y + space, COLOR_GRAY, TEXT_ALIGN_CENTER)
		draw.SimpleTextBlurry(translate.Get("press_reload_to_spawn_far"), "ZSHUDFontSmall", x, y + space * 2, COLOR_GRAY, TEXT_ALIGN_CENTER)
		draw.SimpleTextBlurry(translate.Get("press_alt_nest_menu"), "ZSHUDFontSmaller", x, y + space * 4, COLOR_GRAY, TEXT_ALIGN_CENTER)
	end

	draw.SimpleTextBlurry(translate.Get("press_jump_to_free_roam"), "ZSHUDFontSmall", x, y + space * 3, COLOR_GRAY, TEXT_ALIGN_CENTER)
end

local colLifeStats = Color(255, 50, 50, 255)
function GM:ZombieHUD()
    if self.LifeStatsEndTime and CurTime() < self.LifeStatsEndTime and (self.LifeStatsBarricadeDamage > 0 or self.LifeStatsHumanDamage > 0 or self.LifeStatsBrainsEaten > 0) then
        colLifeStats.a = math.Clamp((self.LifeStatsEndTime - CurTime()) / (self.LifeStatsLifeTime * 0.33), 0, 1) * 255

        local th = draw_GetFontHeight("ZSHUDFontSmall")
        local x = ScrW() * 0.75
        local y = ScrH() * 0.75

        draw.SimpleTextBlur(translate.Get("that_life"), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
        y = y + th

        if self.LifeStatsBarricadeDamage > 0 then
            draw.SimpleTextBlur(translate.Format("x_damage_to_barricades", self.LifeStatsBarricadeDamage), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
            y = y + th
        end
        if self.LifeStatsHumanDamage > 0 then
            draw.SimpleTextBlur(translate.Format("x_damage_to_humans", self.LifeStatsHumanDamage), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
            y = y + th
        end
        if self.LifeStatsBrainsEaten > 0 then
            draw.SimpleTextBlur(translate.Format("x_brains_eaten", self.LifeStatsBrainsEaten), "ZSHUDFontSmall", x, y, colLifeStats, TEXT_ALIGN_LEFT)
            y = y + th
        end
    end

    local obsmode = MySelf:GetObserverMode()
    if obsmode ~= OBS_MODE_NONE then
        self:ZombieObserverHUD(obsmode)
    elseif not MySelf:Alive() then
        local x = ScrW() * 0.5
        local y = ScrH() * 0.3

        if not self:GetWaveActive() then
            draw.SimpleTextBlur(translate.Get("waiting_for_next_wave"), "ZSHUDFont", x, y, COLOR_DARKRED, TEXT_ALIGN_CENTER)
        end
    end

	if not self:GetWaveActive() and self:GetWave() > 1 then
		local pl = GAMEMODE.NextBossZombie
		if pl and pl:IsValid() then
			local x, y = ScrW() * 0.5, ScrH() * 0.3 + draw_GetFontHeight("ZSHUDFont")
			if pl == MySelf then
				draw.SimpleTextBlur(translate.Format("you_will_be_x_soon", translate.Get(GAMEMODE.ZombieClasses[GAMEMODE.NextBossZombieClass].TranslationName)), "ZSHUDFont", x, y, Color(255, 50, 50), TEXT_ALIGN_CENTER)
			else
				draw.SimpleTextBlur(translate.Format("x_will_be_y_soon", pl:Name(), translate.Get(GAMEMODE.ZombieClasses[GAMEMODE.NextBossZombieClass].TranslationName)), "ZSHUDFont", x, y, COLOR_GRAY, TEXT_ALIGN_CENTER)
			end
		end
	end
end

function GM:CenterNotify(...)
	if self.CenterNotificationHUD and self.CenterNotificationHUD:IsValid() then
		return self.CenterNotificationHUD:AddNotification(...)
	end
end

function GM:TopNotify(...)
	if self.TopNotificationHUD and self.TopNotificationHUD:IsValid() then
		return self.TopNotificationHUD:AddNotification(...)
	end
end

function GM:LastHumanMessage()
	if self.RoundEnded or not MySelf:IsValid() then return end

	local icon = "default"
	if P_Team(MySelf) == TEAM_UNDEAD or not MySelf:Alive() then
		self:CenterNotify({killicon = icon}, {font = "ZSHUDFont"}, " ", COLOR_RED, translate.Get("kill_the_last_human"), {killicon = icon})
	else
		self:CenterNotify({font = "ZSHUDFont"}, " ", COLOR_RED, translate.Get("you_are_the_last_human"))
		self:CenterNotify({killicon = icon}, " ", COLOR_RED, translate.Format("x_zombies_out_to_get_you", team.NumPlayers(TEAM_UNDEAD)), {killicon = icon})
	end
end

function GM:HumanMenu()
	if self.ZombieEscape then return end
	
	local ent = MySelf:MeleeTrace(48, 2, nil, nil, true).Entity
	if self:ValidMenuLockOnTarget(MySelf, ent) then
		self.HumanMenuLockOn = ent
	else
		self.HumanMenuLockOn = nil
	end

	self:OpenInventory()

	self:DoAltSelectedItemUpdate()
end

function GM:ZombieSpawnMenu()
	if self.ZombieEscape then return end

	if self.ZSpawnMenu and self.ZSpawnMenu:IsValid() then
		self.ZSpawnMenu:SetVisible(true)
		self.ZSpawnMenu:OpenMenu()
		self.ZSpawnMenu:RefreshContents()

		return
	end

	local panel = vgui.Create("DZombieSpawnMenu")
	self.ZSpawnMenu = panel

	panel:OpenMenu()
end

function GM:LocalPlayerDied(attackername)
	LASTDEATH = RealTime()

	surface_PlaySound(self.DeathSound)
	if attackername then
		self:CenterNotify(COLOR_RED, {font = "ZSHUDFont"}, translate.Get("you_have_died"))
		self:CenterNotify(COLOR_RED, translate.Format("you_were_killed_by_x", tostring(attackername)))
	else
		self:CenterNotify(COLOR_RED, {font = "ZSHUDFont"}, translate.Get("you_have_died"))
	end
end

function GM:HUDPaintBackgroundEndRound()
	local x, y = ScrW() * 0.5, ScrH() * 0.8
	local timleft = math.max(0, self.EndTime + self.EndGameTime - CurTime())

	if timleft <= 0 then
		draw.SimpleTextBlur(translate.Get("loading"), "ZSHUDFont", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER)
	else
		draw.SimpleTextBlur(translate.Format("next_round_in_x", util.ToMinutesSecondsCD(timleft)), "ZSHUDFontSmall", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER)
	end
end

local matRing = Material("effects/select_ring")
function GM:DrawCircle(x, y, radius, color)
	surface.SetMaterial(matRing)
	surface.SetDrawColor(color)
	surface.DrawTexturedRect(x - radius, y - radius, radius * 2, radius * 2)
end

local matFilmGrain = Material("zombiesurvival/filmgrain/filmgrain")
function GM:_HUDPaintBackground()
	if self.FilmGrainEnabled and P_Team(MySelf) ~= TEAM_UNDEAD then
		surface_SetMaterial(matFilmGrain)
		surface_SetDrawColor(0, 0, 0, (0.25 + 0.75 * self:CachedFearPower()) * self.FilmGrainOpacity)
		surface_DrawTexturedRectUV(0, 0, ScrW(), ScrH(), 2, 2, 0, 0)
	end

	local wep = MySelf:GetActiveWeapon()
	if wep:IsValid() and wep.DrawHUDBackground then
		wep:DrawHUDBackground()
	end
end

function GM:PlayerBindPress(pl, bind, wasin)
	if bind == "gmod_undo" or bind == "undo" then
		RunConsoleCommand("+zoom")
		timer.Create("ReleaseZoom", 1, 1, function() RunConsoleCommand("-zoom") end)
	elseif bind == "+menu_context" then
		if P_Team(pl) == TEAM_UNDEAD then
			self.ZombieThirdPerson = not self.ZombieThirdPerson
		elseif P_Team(pl) == TEAM_HUMAN then
			self:ToggleOTSCamera()
		end
	elseif bind == "impulse 100" then
		if P_Team(pl) == TEAM_UNDEAD and pl:Alive() then
			self:ToggleZombieVision()
		end
	end
end

local roll = 0
function GM:_CalcView(pl, origin, angles, fov, znear, zfar)
	if pl.Confusion and pl.Confusion:IsValid() then
		pl.Confusion:CalcView(pl, origin, angles, fov, znear, zfar)
	end

	if pl.Revive and pl.Revive:IsValid() and pl.Revive.GetRagdollEyes then
		if self.ThirdPersonKnockdown or self.ZombieThirdPerson then
			origin = pl:GetThirdPersonCameraPos(origin, angles)
		else
			local rpos, rang = pl.Revive:GetRagdollEyes(pl)
			if rpos then
				origin = rpos
				angles = rang
			end
		end
	elseif pl.KnockedDown and pl.KnockedDown:IsValid() then
		if self.ThirdPersonKnockdown or self:UseOverTheShoulder() then
			origin = pl:GetThirdPersonCameraPos(origin, angles)
		else
			local rpos, rang = self:GetRagdollEyes(pl)
			if rpos then
				origin = rpos
				angles = rang
			end
		end
	elseif pl:ShouldDrawLocalPlayer() and pl:OldAlive() and not pl:HasWon() then
		if P_Team(pl) == TEAM_UNDEAD then
			origin = pl:GetThirdPersonCameraPos(origin, angles)
		elseif self:UseOverTheShoulder() then
			self:CalcViewOTS(pl, origin, angles, fov, znear, zfar)
		end
	end

	local targetroll = 0
	if self.MovementViewRoll then
		local dir = pl:GetVelocity()
		local speed = dir:Length()
		dir:Normalize()

		targetroll = targetroll + dir:Dot(angles:Right()) * math.min(30, speed / 100)
	end

	if pl:WaterLevel() >= 3 then
		targetroll = targetroll + math.sin(CurTime()) * 7
	end

	roll = math.Approach(roll, targetroll, math.max(0.25, math.sqrt(math.abs(roll))) * 30 * FrameTime())
	angles.roll = angles.roll + roll

	if pl:IsPlayingTaunt() then
		self:CalcViewTaunt(pl, origin, angles, fov, znear, zfar)
	end

	local target = pl:GetObserverTarget()
	if target and target:IsValid() then
		local lasttarget = self.LastObserverTarget
		if lasttarget and lasttarget:IsValid() and target ~= lasttarget then
			if self.LastObserverTargetLerp then
				if CurTime() >= self.LastObserverTargetLerp then
					self.LastObserverTarget = nil
					self.LastObserverTargetLerp = nil
				else
					local delta = math.Clamp((self.LastObserverTargetLerp - CurTime()) / 0.3333, 0, 1) ^ 0.5
					origin:Set(self.LastObserverTargetPos * delta + origin * (1 - delta))
				end
			else
				self.LastObserverTargetLerp = CurTime() + 0.3333
			end
		else
			self.LastObserverTarget = target
			self.LastObserverTargetPos = origin
		end
	end

	if pl:GetObserverMode() ~= OBS_MODE_NONE then
		angles.roll = 0 --Fixes babies tilting the screen
	end

	pl:CallZombieFunction2("CalcView", origin, angles)

	return self.BaseClass.CalcView(self, pl, origin, angles, fov, znear, zfar)
end