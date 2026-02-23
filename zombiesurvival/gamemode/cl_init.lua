-- Sometimes persistent ones don't get created.
local dummy = CreateClientConVar("_zs_dummyconvar", 1, false, false)
local oldCreateClientConVar = CreateClientConVar
function CreateClientConVar(...)
	return oldCreateClientConVar(...) or dummy
end

include("sh_globals.lua")
include("cl_hud.lua")
include("cl_weaponselector.lua")

include("obj_entity_extend_cl.lua")
include("obj_player_extend_cl.lua")
include("obj_weapon_extend_cl.lua")

include("loader.lua")

include("shared.lua")
include("cl_draw.lua")
include("cl_util.lua")
include("cl_options.lua")
include("cl_scoreboard.lua")
include("cl_targetid.lua")
include("cl_postprocess.lua")
include("cl_voicesets.lua")
include("cl_net.lua")
include("skillweb/cl_skillweb.lua")

include("vgui/dteamcounter.lua")
include("vgui/dmodelpanelex.lua")
include("vgui/dteamheading.lua")
include("vgui/dmodelkillicon.lua")

include("vgui/dexroundedpanel.lua")
include("vgui/dexroundedframe.lua")
include("vgui/dexrotatedimage.lua")
include("vgui/dexnotificationslist.lua")
include("vgui/dexchanginglabel.lua")
include("vgui/voicenotify.lua")

include("vgui/dexcheckbox.lua")
include("vgui/dexcombobox.lua")
include("vgui/dexmenu.lua")
include("vgui/dextooltip.lua")
include("vgui/dexpropertysheet.lua")

include("vgui/mainmenu.lua")
include("vgui/pmainmenu.lua")
include("vgui/poptions.lua")
include("vgui/phelp.lua")
include("vgui/pclassselect.lua")
include("vgui/pdatabase.lua")
include("vgui/pendboard.lua")
include("vgui/pworth.lua")
include("vgui/parsenal.lua")
include("vgui/premantle.lua")
include("vgui/dpingmeter.lua")
include("vgui/dspawnmenu.lua")
include("vgui/zsgamestate.lua")
include("vgui/zshealtharea.lua")
include("vgui/zsstatusarea.lua")
include("vgui/pplayermodel.lua")
include("vgui/ppropmaker.lua")
include("vgui/pitemviewer.lua")
include("vgui/pitemdisplay.lua")

include("cl_dermaskin.lua")
include("cl_deathnotice.lua")
include("cl_floatingscore.lua")
include("cl_hint.lua")
include("cl_thirdperson.lua")

include("itemstocks/cl_stock.lua")

include("cl_zombieescape.lua")

w, h = ScrW(), ScrH()

MySelf = MySelf or NULL
hook.Add("InitPostEntity", "GetLocal", function()
	MySelf = LocalPlayer()

	GAMEMODE.HookGetLocal = GAMEMODE.HookGetLocal or function(g) end
	gamemode.Call("HookGetLocal", MySelf)
	RunConsoleCommand("initpostentity")

	MySelf:ApplySkills()
end)

-- Remove when model decal crash is fixed.
--[[function util.Decal()
end]]
-- Save on global lookup time.
local collectgarbage = collectgarbage
local render = render
local surface = surface
local draw = draw
local cam = cam
local player = player
local ents = ents
local util = util
local math = math
local string = string
local bit = bit
local gamemode = gamemode
local hook = hook
local Vector = Vector
local VectorRand = VectorRand
local Angle = Angle
local AngleRand = AngleRand
local Entity = Entity
local Color = Color
local FrameTime = FrameTime
local RealTime = RealTime
local CurTime = CurTime
local SysTime = SysTime
local EyePos = EyePos
local EyeAngles = EyeAngles
local pairs = pairs
local ipairs = ipairs
local tostring = tostring
local tonumber = tonumber
local type = type
local ScrW = ScrW
local ScrH = ScrH
local Lerp = Lerp
local EF_DIMLIGHT = EF_DIMLIGHT
local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_LEFT = TEXT_ALIGN_LEFT
local TEXT_ALIGN_RIGHT = TEXT_ALIGN_RIGHT
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM
local TEXT_ALIGN_TOP_REAL = TEXT_ALIGN_TOP_REAL
local TEXT_ALIGN_BOTTOM_REAL = TEXT_ALIGN_BOTTOM_REAL

local TEAM_HUMAN = TEAM_HUMAN
local TEAM_UNDEAD = TEAM_UNDEAD
local translate = translate

local COLOR_PURPLE = COLOR_PURPLE
local COLOR_GRAY = COLOR_GRAY
local COLOR_RED = COLOR_RED
local COLOR_DARKRED = COLOR_DARKRED
local COLOR_DARKGREEN = COLOR_DARKGREEN
local COLOR_GREEN = COLOR_GREEN
local COLOR_WHITE = COLOR_WHITE

local vector_up = Vector(0, 0, 1)
local vector_down = Vector(0, 0, 1)

--local surface_SetFont = surface.SetFont
--local surface_SetTexture = surface.SetTexture
local surface_SetMaterial = surface.SetMaterial
local surface_SetDrawColor = surface.SetDrawColor
--local surface_DrawLine = surface.DrawLine
local surface_DrawRect = surface.DrawRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawTexturedRectRotated = surface.DrawTexturedRectRotated
local surface_DrawTexturedRectUV = surface.DrawTexturedRectUV
local surface_PlaySound = surface.PlaySound

local render_SetBlend = render.SetBlend
local render_ModelMaterialOverride = render.ModelMaterialOverride
local render_SetColorModulation = render.SetColorModulation
local render_SuppressEngineLighting = render.SuppressEngineLighting
local cam_IgnoreZ = cam.IgnoreZ
local render_SetMaterial = render.SetMaterial
local render_DrawQuadEasy = render.DrawQuadEasy
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

local draw_GetFontHeight = draw.GetFontHeight

local MedicalAuraDistance = 800 ^ 2

local M_Player = FindMetaTable("Player")
local P_Team = M_Player.Team

GM.LifeStatsBrainsEaten = 0
GM.LifeStatsHumanDamage = 0
GM.LifeStatsBarricadeDamage = 0
GM.InputMouseX = 0
GM.InputMouseY = 0
GM.LastTimeDead = 0
GM.LastTimeAlive = 0
GM.HeartBeatTime = 0
GM.FOVLerp = 1
GM.HurtEffect = 0
GM.PrevHealth = 0
GM.SuppressArsenalTime = 0
GM.ZombieThirdPerson = false
GM.Beats = {}
GM.CurrentRound = 1

GM.DeathFog = 0
GM.FogStart = 0
GM.FogEnd = 8000
GM.FogRed = 30
GM.FogGreen = 30
GM.FogBlue = 30

function GM:ClickedPlayerButton(pl, button)
end

function GM:ClickedEndBoardPlayerButton(pl, button)
end

function GM:_InputMouseApply(cmd, x, y, ang)
	if MySelf:KeyDown(IN_WALK) and MySelf:IsHolding() then
		self.InputMouseX = math.NormalizeAngle(self.InputMouseX - x * 0.02 * GAMEMODE.PropRotationSensitivity)
		self.InputMouseY = math.NormalizeAngle(self.InputMouseY - y * 0.02 * GAMEMODE.PropRotationSensitivity)

		local snap = GAMEMODE.PropRotationSnap
		local snapanglex, snapangley = self.InputMouseX, self.InputMouseY
		if snap > 0 then
			snapanglex = Angle(self.InputMouseX, 0, 0):SnapTo("p", snap).p
			snapangley = Angle(self.InputMouseY, 0, 0):SnapTo("p", snap).p
		end

		RunConsoleCommand("_zs_rotateang", snapanglex, snapangley)
		return true
	end

	if self:UseOverTheShoulder() and P_Team(MySelf) == TEAM_HUMAN then
		self:InputMouseApplyOTS(cmd, x, y, ang)
	end
end

function GM:_GUIMousePressed(mc)
end

function GM:TryHumanPickup(pl, entity)
end

function GM:AddExtraOptions(list, window)
end

function GM:SpawnMenuEnabled()
	return false
end

function GM:SpawnMenuOpen()
	return false
end

function GM:ContextMenuOpen()
	return false
end

function GM:_HUDWeaponPickedUp(wep)
	if P_Team(MySelf) == TEAM_HUMAN and not wep.NoPickupNotification then
		self:Rewarded(wep:GetClass())
	end
end

function GM:HUDItemPickedUp(itemname)
end

function GM:HUDAmmoPickedUp(itemname, amount)
end

function GM:InitPostEntity()
	self:CreateLateVGUI()

	self:AssignItemProperties()
	self:FixWeaponBase()

	self:LocalPlayerFound()

	gamemode.Call("EvaluateFilmMode")

	timer.Simple(2, function() GAMEMODE:GetFogData() end)

	RunConsoleCommand("pp_bloom", "0")
end

local fogstart = 0
local fogend = 0
local fogr = 0
local fogg = 0
local fogb = 0

function GM:SetupFog()
	local power = self.DeathFog
	local rpower = 1 - self.DeathFog

	fogstart = self.FogStart * rpower
	fogend = self.FogEnd * rpower + 150 * power
	fogr = self.FogRed * rpower
	fogg = self.FogGreen * rpower + 40 * power
	fogb = self.FogBlue * rpower

	local dimvision = MySelf.DimVision
	if dimvision and dimvision:IsValid() then
		power = dimvision:GetDim()

		fogstart = Lerp(power, fogstart, 1)
		fogend = Lerp(power, fogend, math.min(148 / math.max(0.01, MySelf.DimVisionEffMul), fogend))
		fogr = Lerp(power, fogr, 0)
		fogg = Lerp(power, fogg, 0)
		fogb = Lerp(power, fogb, 0)
	end
end

function GM:_SetupWorldFog()
	if self.DeathFog == 0 and not MySelf.DimVision then return end

	self:SetupFog()

	render_FogMode(1)

	render_FogStart(fogstart)
	render_FogEnd(fogend)
	render_FogColor(fogr, fogg, fogb)
	render_FogMaxDensity(1)

	return true
end

function GM:_SetupSkyboxFog(skyboxscale)
	if self.DeathFog == 0 and not MySelf.DimVision then return end

	self:SetupFog()

	render_FogMode(1)

	render_FogStart(fogstart * skyboxscale)
	render_FogEnd(fogend * skyboxscale)
	render_FogColor(fogr, fogg, fogb)
	render_FogMaxDensity(1)

	return true
end

function GM:PreDrawSkyBox()
	self.DrawingInSky = true
end

local matSky = CreateMaterial("SkyOverride", "UnlitGeneric", {["$basetexture"] = "color/white", ["$vertexcolor"] = 1, ["$vertexalpha"] = 1, ["$model"] = 1})
local colSky = Color(0, 30, 0)
function GM:PostDrawSkyBox()
	self.DrawingInSky = false

	local dimvision = MySelf.DimVision
	dimvision = dimvision and dimvision:IsValid() and dimvision:GetDim()
	if self.DeathFog > 0 or dimvision then
		colSky.a = math.max(self.DeathFog, dimvision or 0) * 230
		colSky.g = self.DeathFog * 30

		cam_Start3D(EyePos(), EyeAngles())
			render_SuppressEngineLighting(true)

			render_SetMaterial(matSky)

			render_DrawQuadEasy(Vector(0, 0, 10240), Vector(0, 0, -1), 20480, 20480, colSky, 0)
			render_DrawQuadEasy(Vector(0, 10240, 0), Vector(0, -1, 0), 20480, 20480, colSky, 0)
			render_DrawQuadEasy(Vector(0, -10240, 0), Vector(0, 1, 0), 20480, 20480, colSky, 0)
			render_DrawQuadEasy(Vector(10240, 0, 0), Vector(-1, 0, 0), 20480, 20480, colSky, 0)
			render_DrawQuadEasy(Vector(-10240, 0, 0), Vector(1, 0, 0), 20480, 20480, colSky, 0)

			render_SuppressEngineLighting(false)
		cam_End3D()
	end
end

function GM:GetFogData()
	local _fogstart, _fogend = render_GetFogDistances()
	local _fogr, _fogg, _fogb = render_GetFogColor()

	self.FogStart = _fogstart
	self.FogEnd = _fogend
	self.FogRed = _fogr
	self.FogGreen = _fogg
	self.FogBlue = _fogb
end

function GM:ShouldDraw3DWeaponHUD()
	return GAMEMODE.WeaponHUDMode ~= 1
end

function GM:ShouldDraw2DWeaponHUD()
	return GAMEMODE.WeaponHUDMode >= 1 or self:UseOverTheShoulder()
end

local matAura = Material("models/debug/debugwhite")
local skip = false
function GM.PostPlayerDrawMedical(pl)
	if not skip and P_Team(pl) == TEAM_HUMAN and pl ~= MySelf then
		local eyepos = EyePos()
		local dist = pl:NearestPoint(eyepos):DistToSqr(eyepos)
		if dist < MedicalAuraDistance then
			local green = pl:Health() / pl:GetMaxHealth()

			pl.SkipDrawHooks = true
			skip = true

			render_SuppressEngineLighting(true)
			render_ModelMaterialOverride(matAura)
			render_SetBlend((1 - dist / MedicalAuraDistance) * 0.1 * (1 + math.abs(math.sin((CurTime() + pl:EntIndex()) * 4)) * 0.05))
			render_SetColorModulation(1 - green, green, 0)
				pl:DrawModel()
			render_SetColorModulation(1, 1, 1)
			render_SetBlend(1)
			render_ModelMaterialOverride()
			render_SuppressEngineLighting(false)

			skip = false
			pl.SkipDrawHooks = false
		end
	end
end

function GM:OnReloaded()
	self.BaseClass.OnReloaded(self)

	self:LocalPlayerFound()
end

-- The whole point of this is so we don't need to check if the local player is valid 1000 times a second.
-- Empty functions get filled when the local player is found.
function GM:Think() 
end
GM.HUDWeaponPickedUp = GM.Think
GM.Think = GM._Think
GM.HUDShouldDraw = GM.Think
GM.CachedFearPower = GM.Think
GM.CalcView = GM.Think
GM.ShouldDrawLocalPlayer = GM.Think
GM.PostDrawOpaqueRenderables = GM.Think
GM.PostDrawTranslucentRenderables = GM.Think
GM.HUDPaint = GM.Think
GM.HUDPaintBackground = GM.Think
GM.CreateMove = GM.Think
GM.PrePlayerDraw = GM.Think
GM.PostPlayerDraw = GM.Think
GM.InputMouseApply = GM.Think
GM.GUIMousePressed = GM.Think
GM.HUDWeaponPickedUp = GM.Think
function GM:LocalPlayerFound()
	self.Think = self._Think
	self.HUDShouldDraw = self._HUDShouldDraw
	self.CachedFearPower = self._CachedFearPower
	self.CalcView = self._CalcView
	self.ShouldDrawLocalPlayer = self._ShouldDrawLocalPlayer
	self.PostDrawTranslucentRenderables = self._PostDrawTranslucentRenderables
	self.HUDPaint = self._HUDPaint
	self.HUDPaintBackground = self._HUDPaintBackground
	self.CreateMove = self._CreateMove
	self.PrePlayerDraw = self._PrePlayerDraw
	self.PostPlayerDraw = self._PostPlayerDraw
	self.InputMouseApply = self._InputMouseApply
	self.GUIMousePressed = self._GUIMousePressed
	self.HUDWeaponPickedUp = self._HUDWeaponPickedUp
	self.RenderScene = self._RenderScene
	self.SetupSkyboxFog = self._SetupSkyboxFog
	self.SetupWorldFog = self._SetupWorldFog

	LocalPlayer().LegDamage = 0
	LocalPlayer().ArmDamage = 0

	if render.GetDXLevel() >= 80 then
		self.RenderScreenspaceEffects = self._RenderScreenspaceEffects
	end
end

function GM:GetDynamicSpawning()
	return not GetGlobalBool("DynamicSpawningDisabled", false)
end

function GM:TrackLastDeath()
	if MySelf:Alive() then
		self.LastTimeAlive = CurTime()
	else
		self.LastTimeDead = CurTime()
	end
end

function GM:IsClassicMode()
	return false
end

function GM:IsBabyMode()
	return false
end

function GM:PostRender()
end

local lastwarntim = -1
function GM:_Think()
	local time = CurTime()

	if self:GetEscapeStage() == ESCAPESTAGE_DEATH then
		self.DeathFog = math.min(self.DeathFog + FrameTime() / 5, 1)
	elseif self.DeathFog > 0 then
		self.DeathFog = math.max(self.DeathFog - FrameTime() / 5, 0)
	end

	local health = MySelf:Health()
	if self.PrevHealth and health < self.PrevHealth then
		self.HurtEffect = math.min(self.HurtEffect + (self.PrevHealth - health) * 0.02, 1.5)
	elseif self.HurtEffect > 0 then
		self.HurtEffect = math.max(0, self.HurtEffect - FrameTime() * 0.65)
	end
	self.PrevHealth = health

	self:TrackLastDeath()

	local endtime = self:GetWaveActive() and self:GetWaveEnd() or self:GetWaveStart()
	if endtime ~= -1 then
		local timleft = math.max(0, endtime - time)
		if timleft <= 10 and lastwarntim ~= math.ceil(timleft) then
			lastwarntim = math.ceil(timleft)
			if 0 < lastwarntim then
				LocalPlayer():EmitSound("buttons/lightswitch2.wav", 100, 110 - lastwarntim * 2)
			end
		end
	end

	local myteam = P_Team(MySelf)

	self:PlayBeats(myteam, self:CachedFearPower())

	local thirdperson
	if myteam == TEAM_HUMAN then
		local wep = MySelf:GetActiveWeapon()
		if wep:IsValid() and wep.GetIronsights and wep:GetIronsights() then
			self.FOVLerp = math.Approach(self.FOVLerp, wep.IsScoped and not self.DisableScopes and wep.IronsightsMultiplier or not wep.IsScoped and wep.IronsightsMultiplier or 0.6, FrameTime() * 4)
		elseif self.FOVLerp ~= 1 then
			self.FOVLerp = math.Approach(self.FOVLerp, 1, FrameTime() * 5)
		end

		if MySelf:GetBarricadeGhosting() then
			MySelf:BarricadeGhostingThink()
		end
		thirdperson = self.OverTheShoulder
	else
		self.HeartBeatTime = self.HeartBeatTime + (6 + self:CachedFearPower() * 5) * FrameTime()
		thirdperson = self.ZombieThirdPerson

		--[[if not MySelf:Alive() then
			self:ToggleZombieVision(false)
		end]]
	end
	self.TransparencyRadius = thirdperson and self.TransparencyRadius3p or self.TransparencyRadius1p

	local tab

	for _, pl in pairs(player.GetAll()) do
		if P_Team(pl) == TEAM_UNDEAD then
			tab = pl:GetZombieClassTable()
			if tab.BuildBonePositions then
				if not pl.WasBuildingBonePositions then
					pl.BuildingBones = pl:GetBoneCount() - 1
					pl.WasBuildingBonePositions = true
				end
				pl:ResetBones()
				tab.BuildBonePositions(tab, pl)
			elseif pl.WasBuildingBonePositions then
				pl.WasBuildingBonePositions = nil
				pl:ResetBones()
			end
		elseif pl.WasBuildingBonePositions then
			pl.WasBuildingBonePositions = nil
			pl:ResetBones()
		end
	end
end

function GM:KeyPress(pl, key)
	if key == self.MenuKey then
		local team = P_Team(pl)
		if team == TEAM_HUMAN and pl:Alive() and not pl:IsHolding() then
			gamemode.Call("HumanMenu")
		elseif team == TEAM_ZOMBIE and not pl:Alive() then
			gamemode.Call("ZombieSpawnMenu")
		end
	elseif key == IN_SPEED then
		if pl:Alive() then
			if P_Team(pl) == TEAM_HUMAN then
				pl:DispatchAltUse()
			elseif P_Team(pl) == TEAM_UNDEAD then
				pl:CallZombieFunction0("AltUse")
			end
		end
	end
end

function GM:KeyRelease(pl, key)
	if key == self.MenuKey then
		if self.InventoryMenu and self.InventoryMenu:IsValid() then
			self.InventoryMenu:SetVisible(false)

			if self.m_InvViewer and self.m_InvViewer:IsValid() then
				self.m_InvViewer:SetVisible(false)
			end

			if self.AmmoViewer and self.AmmoViewer:IsValid() then
				self.AmmoViewer:SetVisible(false)
			end
		end

		if self.HumanMenuSupplyChoice then
			self.HumanMenuSupplyChoice:CloseMenu()
		end

		if self.InventoryMenu ~= nil and self.InventoryMenu:IsValid() and self.InventoryMenu.SelInv then
			self.InventoryMenu.SelInv = nil
			self:DoAltSelectedItemUpdate()

			local grid = self.InventoryMenu.Grid
			for k, v in pairs(grid:GetChildren()) do
				v.On = false
			end
		end
	end
end

function GM:ShouldPlayBeats(teamid, fear)
	return not self.RoundEnded and not self.ZombieEscape and not GetGlobalBool("beatsdisabled", false)
end

local cv_ShouldPlayMusic = CreateClientConVar("zs_playmusic", 1, true, false)
local NextBeat = 0
local LastBeatLevel = 0
function GM:PlayBeats(teamid, fear)
	if RealTime() <= NextBeat or not gamemode.Call("ShouldPlayBeats", teamid, fear) then return end

	if LASTHUMAN and cv_ShouldPlayMusic:GetBool() then
		MySelf:EmitSound(self.LastHumanSound, 0, 100, self.BeatsVolume)
		NextBeat = RealTime() + SoundDuration(self.LastHumanSound) - 60 -- хуета странная почему то звук отстаёт и я так сделал
		return
	end

	if fear <= 0 or not self.BeatsEnabled then return end

	local beats = self.Beats[teamid == TEAM_HUMAN and self.BeatSetHuman or self.BeatSetZombie]
	if not beats then return end

	LastBeatLevel = math.Approach(LastBeatLevel, math.ceil(fear * 10), 3)

	local snd = beats[LastBeatLevel]
	if snd then
		MySelf:EmitSound(snd, 0, 100, self.BeatsVolume)
		NextBeat = RealTime() + (self.SoundDuration[snd] or SoundDuration(snd)) - 0.025
	end
end

function GM:RequestedDefaultCart()
	local defaultcart = GetConVar("zs_defaultcart"):GetString()
	if #defaultcart > 0 then
		defaultcart = string.lower(defaultcart)

		for i, carttab in ipairs(self.SavedCarts) do
			if carttab[1] and string.lower(carttab[1]) == defaultcart then
				gamemode.Call("SuppressArsenalUpgrades", 1)
				RunConsoleCommand("worthcheckout", unpack(carttab[2]))

				return
			end
		end

		RunConsoleCommand("worthrandom")
	end
end

function GM:PlayerInitialSpawn(pl)
end

function GM:RestartRound()
	self.TheLastHuman = nil
	self.RoundEnded = nil
	LASTHUMAN = nil

	if pEndBoard and pEndBoard:IsValid() then
		pEndBoard:Remove()
		pEndBoard = nil
	end

	self:ClearItemStocks()

	self:InitPostEntity()

	self:RevertZombieClasses()
end

function GM:_HUDShouldDraw(name)
	if self.FilmMode and name ~= "CHudWeaponSelection" then return false end

	return name ~= "CHudHealth" and name ~= "CHudBattery"
	and name ~= "CHudAmmo" and name ~= "CHudSecondaryAmmo"
	and name ~= "CHudDamageIndicator"
end

local Current = 0
local NextCalculate = 0
function GM:_CachedFearPower()
	if CurTime() >= NextCalculate then
		NextCalculate = CurTime() + 0.15
		Current = self:GetFearMeterPower(EyePos(), TEAM_UNDEAD, MySelf)
	end

	return Current
end

function surface.CreateLegacyFont(font, size, weight, antialias, additive, name, shadow, outline, blursize)
	surface.CreateFont(name, {font = font, extended = true, size = size, weight = weight, antialias = antialias, additive = additive, shadow = shadow, outline = outline, blursize = blursize})
end

local fontfamily = "Ghoulish Fright AOE_Updated"
local fontfamilysm = "Remington Noiseless_SUNRUST"
local fontfamily3d = "hidden"
local fontsizeadd = 8
local fontweight = 0

function GM:Create3DFonts()
	local fontweight3D = 0

	surface.CreateLegacyFont(fontfamily3d, 28 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFontSmaller", false, true)
	surface.CreateLegacyFont(fontfamily3d, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFontSmall", false, true)
	surface.CreateLegacyFont(fontfamily3d, 60 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFontSlightlySmaller", false, true)
	surface.CreateLegacyFont(fontfamily3d, 72 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont", false, true)
	surface.CreateLegacyFont(fontfamily3d, 100 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFontSlightlyBigger", false, true)
	surface.CreateLegacyFont(fontfamily3d, 128 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFontBig", false, true)
	surface.CreateLegacyFont(fontfamily3d, 28 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFontSmallerBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily3d, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFontSmallBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily3d, 72 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFontBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily3d, 128 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFontBigBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 40 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2Smaller", false, true)
	surface.CreateLegacyFont(fontfamily, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2Small", false, true)
	surface.CreateLegacyFont(fontfamily, 58 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2Smallester", false, true)
	surface.CreateLegacyFont(fontfamily, 72 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont2", false, true)
	surface.CreateLegacyFont(fontfamily, 106 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont2SlightlyBigger", false, true)
	surface.CreateLegacyFont(fontfamily, 128 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont2Big", false, true)
	surface.CreateLegacyFont(fontfamily, 40 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallerBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 58 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallesterBlur", false, true, 16)
	surface.CreateLegacyFont(fontfamily, 72 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont2Blur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 128 + fontsizeadd, fontweight3D, false, false, "ZS3D2DFont2BigBlur", false, false, 16)

	surface.CreateLegacyFont(fontfamily, 14 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DUnstyleTiny", false, true)
	surface.CreateLegacyFont(fontfamily, 24 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DUnstyleSmallest", false, true)
	surface.CreateLegacyFont(fontfamily, 36 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DUnstyleSmaller", false, true)

	surface.CreateLegacyFont(fontfamily, 36 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2EvenSmallerWep", true, true)
	surface.CreateLegacyFont(fontfamily, 36 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2EvenSmallerWepBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 40 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallerWep", true, true)
	surface.CreateLegacyFont(fontfamily, 40 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallerWepBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallWep", true, true)
	surface.CreateLegacyFont(fontfamily, 48 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SmallWepBlur", false, false, 16)
	surface.CreateLegacyFont(fontfamily, 54 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SlightlySmallWep", true, true)
	surface.CreateLegacyFont(fontfamily, 54 + fontsizeadd, fontweight3D, false, false,  "ZS3D2DFont2SlightlySmallWepBlur", false, false, 16)

	surface.CreateLegacyFont(fontfamily, 42 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontSmallerNSNon", false, false)
	surface.CreateLegacyFont(fontfamily, 42 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontSmallerNSNonBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, 55 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontNormalNSNon", false, false)
	surface.CreateLegacyFont(fontfamily, 55 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontNormalNSNonBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, 60 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontBigNSNon", false, false)
	surface.CreateLegacyFont(fontfamily, 60 + fontsizeadd, fontweight3D, fontaa, false, "ZSHUDFontBigNSNonBlur", false, false, 8)
end

function GM:CreateNonScaleFonts()
	surface.CreateLegacyFont("tahoma", 96, 1000, true, false, "zshintfont", false, true)

	surface.CreateFont("DefaultFontVerySmall", {font = "tahoma", size = 10, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmall", {font = "tahoma", size = 11, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontSmallDropShadow", {font = "tahoma", size = 11, weight = 0, shadow = true, antialias = false})
	surface.CreateFont("DefaultFont", {font = "tahoma", size = 13, weight = 500, antialias = false})
	surface.CreateFont("DefaultFontAA", {font = "tahoma", size = 13, weight = 500, antialias = true})
	surface.CreateFont("DefaultFontBold", {font = "tahoma", size = 13, weight = 1000, antialias = false})
	surface.CreateFont("DefaultFontLarge", {font = "tahoma", size = 16, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontLargeAA", {font = "tahoma", size = 16, weight = 0, antialias = true})
	surface.CreateFont("DefaultFontLargest", {font = "tahoma", size = 22, weight = 0, antialias = false})
	surface.CreateFont("DefaultFontLargestAA", {font = "tahoma", size = 22, weight = 0, antialias = true})
end


function GM:CreateScalingFonts()
	local fontaa = true
	local fontshadow = false
	local fontoutline = true

	local screenscale = BetterScreenScale()

	surface.CreateLegacyFont("csd", screenscale * 42, 100, true, false, "zsdeathnoticecs", false, false)
	surface.CreateLegacyFont("HL2MP", screenscale * 42, 100, true, false, "zsdeathnotice", false, false)

	surface.CreateLegacyFont("csd", screenscale * 96, 100, true, false, "zsdeathnoticecsws", false, false)
	surface.CreateLegacyFont("HL2MP", screenscale * 96, 100, true, false, "zsdeathnoticews", false, false)

	surface.CreateLegacyFont("csd", screenscale * 72, 100, true, false, "zsdeathnoticecspa", false, false)
	surface.CreateLegacyFont("HL2MP", screenscale * 72, 100, true, false, "zsdeathnoticepa", false, false)

	surface.CreateLegacyFont(fontfamily, screenscale * (30 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTotalDamage", fontshadow, fontoutline)

	surface.CreateLegacyFont(fontfamily, screenscale * (14 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTinier", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (16 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTiny", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (18 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontEvenSmaller", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallest", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (22 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmaller", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (25 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmalle", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (28 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmall", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (32 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallester", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (36 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSlightlySmaller", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (42 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFont", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (72 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBig", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamily, screenscale * (102 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBigger", fontshadow, fontoutline)

	surface.CreateLegacyFont(fontfamily, screenscale * (14 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTinierBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (16 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTinyBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (18 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontEvenSmallerBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallestBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (22 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallerBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (25 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmalleBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (28 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (32 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallesterBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (36 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSlightlySmallerBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (42 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (72 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBigBlur", false, false, 8)
	surface.CreateLegacyFont(fontfamily, screenscale * (102 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBiggerBlur", false, false, 8)

	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd/2), 0, fontaa, false, "ZSAmmoName", false, false)

	local liscreenscale = math.max(0.95, BetterScreenScale())

	surface.CreateLegacyFont(fontfamily, liscreenscale * (32 + fontsizeadd), fontweight, true, false, "ZSScoreBoardTitle", false, true)
	surface.CreateLegacyFont(fontfamily, liscreenscale * (22 + fontsizeadd), fontweight, true, false, "ZSScoreBoardSubTitle", false, true)
	surface.CreateLegacyFont(fontfamily, liscreenscale * (16 + fontsizeadd), fontweight, true, false, "ZSScoreBoardPlayer", false, true)
	surface.CreateLegacyFont(fontfamily, liscreenscale * (24 + fontsizeadd), fontweight, true, false, "ZSScoreBoardHeading", false, false)
	surface.CreateLegacyFont("arial", 30 * liscreenscale, 0, true, false, "ZSScoreBoardPlayerPreview", false, true)
	surface.CreateLegacyFont("arial", 18 * liscreenscale, 0, true, false, "ZSScoreBoardPlayerSmall", false, true)
	surface.CreateLegacyFont("arial", 15 * liscreenscale, 0, true, false, "ZSScoreBoardPlayerSmaller", false, true)
	surface.CreateLegacyFont("tahoma", 11 * liscreenscale, 0, true, false, "ZSScoreBoardPing")

	surface.CreateLegacyFont(fontfamily, screenscale * (16 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontTinyNS", false, false)
	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallestNS", false, false)
	surface.CreateLegacyFont(fontfamily, screenscale * (22 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallerNS", false, false)
	surface.CreateLegacyFont(fontfamily, screenscale * (28 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontSmallNS", false, false)
	surface.CreateLegacyFont(fontfamily, screenscale * (42 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontNS", false, false)
	surface.CreateLegacyFont(fontfamily, screenscale * (72 + fontsizeadd), fontweight, fontaa, false, "ZSHUDFontBigNS", false, false)

	surface.CreateLegacyFont(fontfamilysm, screenscale * 15, fontweight, fontaa, false, "ZSBodyTextFont", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamilysm, screenscale * 17, fontweight, fontaa, false, "ZSBodyTextFontSlightlyBigger", fontshadow, fontoutline)
	surface.CreateLegacyFont(fontfamilysm, screenscale * 20, fontweight, fontaa, false, "ZSBodyTextFontBig", fontshadow, fontoutline)

	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd), 0, true, false, "ZSDamageResistance", false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * (20 + fontsizeadd), 0, true, false, "ZSDamageResistanceBlur", false, true)

	surface.CreateLegacyFont(fontfamily, screenscale * (24 + fontsizeadd), 0, true, false, "ZSSigilLetter", false, true)
	surface.CreateLegacyFont(fontfamily, screenscale * (24 + fontsizeadd), 0, true, false, "ZSSigilLetterBlur", false, true)

	surface.CreateFont("ZSXPBar", {font = "tahoma", size = screenscale * 14, weight = 500, antialias = false, shadow = true})
end

function GM:CreateFonts()
	self:Create3DFonts()
	self:CreateNonScaleFonts()
	self:CreateScalingFonts()
end

function GM:EvaluateFilmMode()
	local visible = not self.FilmMode

	if self.GameStatePanel and self.GameStatePanel:IsValid() then
		self.GameStatePanel:SetVisible(visible)
	end

	if self.TopNotificationHUD and self.TopNotificationHUD:IsValid() then
		self.TopNotificationHUD:SetVisible(visible)
	end

	if self.CenterNotificationHUD and self.CenterNotificationHUD:IsValid() then
		self.CenterNotificationHUD:SetVisible(visible)
	end

	if self.XPHUD and self.XPHUD:IsValid() then
		self.XPHUD:SetVisible(visible and self.DisplayXPHUD)
	end

	if self.HealthHUD and self.HealthHUD:IsValid() then
		self.HealthHUD:SetVisible(visible)
	end

	if self.StatusHUD and self.StatusHUD:IsValid() then
		self.StatusHUD:SetVisible(visible)
	end
end

function GM:CreateVGUI()
	local screenscale = BetterScreenScale()
	self.GameStatePanel = vgui.Create("ZSGameState")
	self.GameStatePanel:SetTextFont("ZSHUDFontSmaller")
	self.GameStatePanel:SetAlpha(220)
	self.GameStatePanel:SetSize(screenscale * 420, screenscale * 80)
	self.GameStatePanel:ParentToHUD()

	self.TopNotificationHUD = vgui.Create("DEXNotificationsList")
	self.TopNotificationHUD:SetAlign(RIGHT)
	self.TopNotificationHUD.PerformLayout = function(pan)
		pan:SetSize(ScrW() * 0.4, ScrH() * 0.6)
		pan:AlignTop(16 * BetterScreenScale())
		pan:AlignRight()
	end
	self.TopNotificationHUD:InvalidateLayout()
	self.TopNotificationHUD:ParentToHUD()

	self.CenterNotificationHUD = vgui.Create("DEXNotificationsList")
	self.CenterNotificationHUD:SetAlign(CENTER)
	self.CenterNotificationHUD:SetMessageHeight(36)
	self.CenterNotificationHUD.PerformLayout = function(pan)
		pan:SetSize(ScrW() / 2, ScrH() * 0.35)
		pan:CenterHorizontal()
		pan:AlignBottom(16 * BetterScreenScale())
	end
	self.CenterNotificationHUD:InvalidateLayout()
	self.CenterNotificationHUD:ParentToHUD()
end

function GM:CreateLateVGUI()
	if not self.HealthHUD then
		self.HealthHUD = vgui.Create("ZSHealthArea")
	end

	if not self.StatusHUD then
		self.StatusHUD = vgui.Create("ZSStatusArea")
	end

	if not self.XPHUD then
		self.XPHUD = vgui.Create("ZSExperienceHUD")
		self.XPHUD:ParentToHUD()
		self.XPHUD:InvalidateLayout()
	end
end

function GM:Initialize()
	self:FixSkillConnections()
	self:CreateFonts()
	self:PrecacheResources()
	self:CreateVGUI()
	self:InitializeBeats()
	self:AddCustomAmmo()
	self:RegisterFood()
	self:CreateWeaponQualities()
	self:CreateSpriteMaterials()

	-- Not sure if this still crashes, but whatever.
	RunConsoleCommand("r_drawmodeldecals", "0")
	-- Flashlight dynamic lights of other players.
	RunConsoleCommand("r_dynamic", "0")

	self:RefreshMapIsObjective()
end

-- These can be accessed without pointing to the IMaterial by using ! before the material string.
function GM:CreateSpriteMaterials()
	local params = {["$translucent"] = "1", ["$vertexcolor"] = "1", ["$vertexalpha"] = "1"}
	for i=1, 8 do
		params["$basetexture"] = "Decals/blood"..i
		CreateMaterial("sprite_bloodspray"..i, "UnlitGeneric", params)
	end
end

function GM:ShutDown()
	RunConsoleCommand("r_drawmodeldecals", "1")
	RunConsoleCommand("r_dynamic", "1")
end

local function FirstOfGoodType(a)
	local ext

	for _, v in pairs(a) do
		ext = string.sub(v, -4)
		if ext == ".ogg" or ext == ".wav" or ext == ".mp3" then
			return v
		end
	end
end

function GM:InitializeBeats()
	local _, dirs = file.Find("sound/zombiesurvival/beats/*", "GAME")
	for _, dirname in pairs(dirs) do
		if dirname == "none" or dirname == "default" then continue end

		self.Beats[dirname] = {}
		local highestexist
		for i=1, 10 do
			local a, __ = file.Find("sound/zombiesurvival/beats/"..dirname.."/"..i..".*", "GAME")
			local a1 = FirstOfGoodType(a)
			if a1 then
				local filename = "zombiesurvival/beats/"..dirname.."/"..a1
				if file.Exists("sound/"..filename, "GAME") then
					self.Beats[dirname][i] = Sound(filename)
					highestexist = filename

					continue
				end
			end

			if highestexist then
				self.Beats[dirname][i] = highestexist
			end
		end
	end
end

function GM:PlayerDeath(pl, attacker)
end

function GM:ScalePlayerDamage(pl, hitgroup, dmginfo)
end

function GM:LastHuman(pl)
	if not IsValid(pl) then pl = nil end

	self.TheLastHuman = pl

	if not LASTHUMAN then
		LASTHUMAN = true
		timer.Simple(0.5, function() GAMEMODE:LastHumanMessage() end)
	end
end

function GM:PlayerShouldTakeDamage(pl, attacker)
	return pl == attacker or not attacker:IsPlayer() or P_Team(pl) ~= P_Team(attacker) or pl.AllowTeamDamage or attacker.AllowTeamDamage
end

function GM:SetWave(wave)
	SetGlobalInt("wave", wave)
end

function GM:_ShouldDrawLocalPlayer(pl)
	return FROM_CAMERA or P_Team(pl) == TEAM_UNDEAD and (self.ZombieThirdPerson or pl:CallZombieFunction0("ShouldDrawLocalPlayer"))
	or P_Team(pl) == TEAM_HUMAN and self:UseOverTheShoulder()
	or pl:IsPlayingTaunt()
	or pl.Revive and pl.Revive:IsValid()
	or pl.KnockedDown and pl.KnockedDown:IsValid()
end

function GM:CalcViewTaunt(pl, origin, angles, fov, znear, zfar)
	local tr = util.TraceHull({start = origin, endpos = origin - angles:Forward() * 72, mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2), mask = MASK_OPAQUE, filter = pl})
	origin:Set(tr.HitPos + tr.HitNormal * 2)
end

function GM:CreateMoveTaunt(cmd)
	cmd:ClearButtons(0)
	cmd:ClearMovement()
end

function GM:PostProcessPermitted(str)
	return false
end

function GM:HUDPaintEndRound()
end

function GM:PreDrawViewModel(vm, pl, wep)
	if pl and pl:IsValid() and (pl:IsHolding() or GAMEMODE.GetHandsDisplay == 2) then return true end

	if wep and wep:IsValid() and wep.PreDrawViewModel then
		return wep:PreDrawViewModel(vm)
	end
end

function GM:PostDrawViewModel(vm, pl, wep)
	if wep and wep:IsValid() then
		if wep.UseHands or not wep:IsScripted() then
			local hands = pl:GetHands()
			if hands and hands:IsValid() and GAMEMODE.GetHandsDisplay == 0 then
				hands:DrawModel()
			end
		end

		if wep.PostDrawViewModel then
			wep:PostDrawViewModel(vm)
		end
	end
end

local undo = false
local matWhite = Material("models/debug/debugwhite")
local lowhealthcolor = GM.AuraColorEmpty
local fullhealthcolor = GM.AuraColorFull
function GM:_PrePlayerDraw(pl)
	local shadowman = false

	if pl ~= MySelf and pl:IsEffectActive(EF_DIMLIGHT) then
		pl:RemoveEffects(EF_DIMLIGHT)
	end

	local myteam = P_Team(MySelf)
	local theirteam = P_Team(pl)

	local radius = self.TransparencyRadius
	if radius > 0 and myteam == theirteam and pl ~= MySelf and not (GAMEMODE.AlwaysDrawFriend and pl:IsFriend()) and not self.MedicalAura then
		local dist = pl:GetPos():DistToSqr(EyePos())
		if dist < radius then
			local blend = (dist / radius) ^ 1.4
			if blend <= 0.1 then
				pl.ShadowMan = true return true
			end
			render_SetBlend(blend)
			if myteam == TEAM_HUMAN and blend < 0.5 then
				render_ModelMaterialOverride(matWhite)
				render_SetColorModulation(0.2, 0.2, 0.2)
				shadowman = true
			end
			undo = true
		end
	end

	pl.ShadowMan = shadowman

	if pl:CallZombieFunction0("PrePlayerDraw") then return true end

	if pl.SpawnProtection and (not (pl.status_overridemodel and pl.status_overridemodel:IsValid()) or pl:GetZombieClassTable().NoHideMainModel) then
		undo = true
		render_ModelMaterialOverride(matWhite)
		render_SetBlend(0.02 + (CurTime() + pl:EntIndex() * 0.2) % 0.05)
		render_SetColorModulation(0, 0.3, 0)
		render_SuppressEngineLighting(true)
	end

	if self.m_ZombieVision and myteam == TEAM_UNDEAD and theirteam == TEAM_HUMAN then
		local dist = pl:GetPos():DistToSqr(EyePos())
		if dist <= pl:GetAuraRangeSqr() then
			undo = true
			local healthfrac = pl:Health() / pl:GetMaxHealth()

			render_SetBlend(1)
			render_ModelMaterialOverride(matWhite)
			render_SetColorModulation(
				Lerp(healthfrac, lowhealthcolor.r, fullhealthcolor.r) / 255,
				Lerp(healthfrac, lowhealthcolor.g, fullhealthcolor.g) / 255,
				Lerp(healthfrac, lowhealthcolor.b, fullhealthcolor.b) / 255
			)
			render_SuppressEngineLighting(true)
			cam_IgnoreZ(true)
		end
	end
end

local colFriend = Color(10, 255, 10, 60)
local matFriendRing = Material("SGM/playercircle")
local matTargetTri = Material("gui/point.png")
function GM:_PostPlayerDraw(pl)
	pl:CallZombieFunction0("PostPlayerDraw")

	if undo then
		render_SetBlend(1)
		render_ModelMaterialOverride()
		render_SetColorModulation(1, 1, 1)
		render_SuppressEngineLighting(false)
		cam_IgnoreZ(false)

		undo = false
	end

	local eyepos, ang, tpos, distance, hpf
	if MySelf.TargetLocus and self.TraceTargetTeam == pl and pl:IsValidLivingZombie() and not pl:GetZombieClassTable().IgnoreTargetAssist then
		tpos = pl:GetPos()
		tpos.z = tpos.z + 80

		eyepos = MySelf:EyePos()
		distance = eyepos:DistToSqr(tpos)

		ang = (eyepos - tpos):Angle()
		ang:RotateAroundAxis(ang:Right(), 270)
		ang:RotateAroundAxis(ang:Up(), 90)

		cam_IgnoreZ(true)
		cam_Start3D2D(tpos, ang, math.max(750, math.sqrt(distance)) / 6500)
			surface_SetMaterial(matTargetTri)

			hpf = pl:Health() / pl:GetMaxZombieHealth()

			surface_SetDrawColor(255 - (255 * hpf), 255 * hpf, 0, 230)
			surface_DrawTexturedRect(-96, -96, 96, 96)
		cam_End3D2D()
		cam_IgnoreZ(false)
	end

	if pl ~= MySelf and P_Team(MySelf) == P_Team(pl) and pl:IsFriend() then
		local pos = pl:GetPos()
		pos.z = pos.z + 2
		render_SetMaterial(matFriendRing)
		render_DrawQuadEasy(pos, vector_up, 32, 32, colFriend)
		render_DrawQuadEasy(pos, vector_down, 32, 32, colFriend)
	end
end

local function EndRoundCalcView(pl, origin, angles, fov, znear, zfar)
	if GAMEMODE.EndTime and CurTime() < GAMEMODE.EndTime + 5 then
		local endposition = GAMEMODE.LastHumanPosition
		local override = GetGlobalVector("endcamerapos", vector_origin)
		if override ~= vector_origin then
			endposition = override
		end
		if endposition then
			local delta = math.Clamp((CurTime() - GAMEMODE.EndTime) * 2, 0, 1)

			local start = endposition * delta + origin * (1 - delta)
			local tr = util.TraceHull({start = start, endpos = start + delta * 64 * Angle(0, CurTime() * 30, 0):Forward(), mins = Vector(-2, -2, -2), maxs = Vector(2, 2, 2), filter = player.GetAll(), mask = MASK_SOLID})
			return {origin = tr.HitPos + tr.HitNormal, angles = (start - tr.HitPos):Angle()}
		end

		return
	end

	hook.Remove("CalcView", "EndRoundCalcView")
end

local function EndRoundShouldDrawLocalPlayer(pl)
	if GAMEMODE.EndTime and CurTime() < GAMEMODE.EndTime + 5 then
		return true
	end

	hook.Remove("ShouldDrawLocalPlayer", "EndRoundShouldDrawLocalPlayer")
end

function GM:EndRound(winner, nextmap)
	if self.RoundEnded then return end
	self.RoundEnded = true

	ROUNDWINNER = winner

	self.EndTime = CurTime()

	RunConsoleCommand("stopsound")

	self.HUDPaint = self.HUDPaintEndRound
	self.HUDPaintBackground = self.HUDPaintBackgroundEndRound

	if winner == TEAM_UNDEAD and GetGlobalBool("endcamera", true) then
		hook.Add("CalcView", "EndRoundCalcView", EndRoundCalcView)
		hook.Add("ShouldDrawLocalPlayer", "EndRoundShouldDrawLocalPlayer", EndRoundShouldDrawLocalPlayer)
	end

	local dvar = winner == TEAM_UNDEAD and self.AllLoseSound or self.HumanWinSound
	local snd = GetGlobalString(winner == TEAM_UNDEAD and "losemusic" or "winmusic", dvar)
	if snd == "default" then
		snd = dvar
	elseif snd == "none" then
		snd = nil
	end
	if snd then
		timer.Simple(0.5, function() surface_PlaySound(snd) end)
	end

	timer.Simple(5, function()
		if not (pEndBoard and pEndBoard:IsValid()) then
			MakepEndBoard(winner)
		end
	end)
end

function GM:WeaponDeployed(pl, wep)
	self:DoChangeDeploySpeed(wep)
end

function GM:PlayerStepSoundTime(pl, iType, bWalking)
	local time = pl:CallZombieFunction2("PlayerStepSoundTime", iType, bWalking)
	if time then
		return time
	end

	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return 520 - pl:GetVelocity():Length()
	end

	if iType == STEPSOUNDTIME_ON_LADDER then
		return 500
	end

	if iType == STEPSOUNDTIME_WATER_KNEE then
		return 650
	end

	return 350
end

function GM:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume)
	return pl:CallZombieFunction4("PlayerFootstep", vFootPos, iFoot, strSoundName, fVolume)
end

function GM:PlayerCanCheckout(pl)
	return pl:IsValid() and P_Team(pl) == TEAM_HUMAN and pl:Alive()
end

function GM:OpenWorth()
	if gamemode.Call("PlayerCanCheckout", MySelf) then
		MakepWorth()
		GM:ClearOptionsMenu()
	end
end

function GM:CloseWorth()
	if pWorth and pWorth:IsValid() then
		pWorth:Remove()
		pWorth = nil
	end
end

function GM:SuppressArsenalUpgrades(suppresstime)
	self.SuppressArsenalTime = math.max(CurTime() + suppresstime, self.SuppressArsenalTime)
end

function GM:Rewarded(class, amount)
	if CurTime() < self.SuppressArsenalTime then return end

	class = class or "0"

	local toptext = translate.Get("arsenal_upgraded")

	local wep = weapons.Get(class)
	if wep and wep.PrintName and #wep.PrintName > 0 then
		if killicon.Get(class) == killicon.Get("default") then
			self:CenterNotify(COLOR_PURPLE, toptext..": ", color_white, wep.PrintName)
		else
			self:CenterNotify({killicon = class}, " ", COLOR_PURPLE, toptext..": ", color_white, wep.PrintName)
		end
	elseif amount then
		self:CenterNotify(COLOR_PURPLE, toptext..": ", color_white, amount.." "..class)
	else
		self:CenterNotify(COLOR_PURPLE, toptext)
	end
end

function PlayMenuOpenSound()
	MySelf:EmitSound("buttons/lightswitch2.wav", 100, 30)
end

function PlayMenuCloseSound()
	MySelf:EmitSound("buttons/lightswitch2.wav", 100, 20)
end
