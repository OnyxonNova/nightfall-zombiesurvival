local default_animations = { "idle_all_01", "menu_walk", "pose_standing_02", "pose_standing_03", "idle_fist" }

function GM:MakePlayerModelMenu()
	PlayMenuOpenSound()

	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 700) * screenscale

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:SetTitle(" ")
	frame:Center()
	ModelSelectionPanel = frame

	if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end

	local mdl = frame:Add("DModelPanel")
	mdl:Dock( FILL )
	mdl:SetFOV(36)
	mdl:SetCamPos(Vector(0, 0, 0))
	mdl:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
	mdl:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
	mdl:SetAmbientLight(Vector(-64, -64, -64))
	mdl:SetAnimated(true)
	mdl:SetLookAt(Vector(-100, 0, -22))
	function mdl.DefaultPos()
		mdl.Angles = Angle(0, 0, 0)
		mdl.Pos = Vector(-100, 0, -61)
	end
	mdl.DefaultPos()

	local sheet = frame:Add("DEXPropertySheet")
	sheet:Dock(RIGHT)
	sheet:SetSize(430 * screenscale, 0)

	local PanelSelect = sheet:Add("DPanelSelect")

	for name, model in SortedPairs(player_manager.AllValidModels() ) do
        if table.HasValue(self.RestrictedModels, string.lower(model)) then
        	continue
        end
		local icon = vgui.Create("SpawnIcon")
		icon:SetModel(model)
		icon:SetSize(64 * screenscale, 64 * screenscale)
		icon:SetTooltip(name)
		icon:SetTooltipPanelOverride("DExTooltip")
		icon.playermodel = name

		PanelSelect:AddPanel(icon, { cl_playermodel = name })
	end

	sheet:AddSheet(translate.Get("pcm_menu_model"), PanelSelect, "icon16/user.png")

	local controls = frame:Add("DPanel")
	controls:DockPadding(8, 8, 8, 8)

	local lbl = controls:Add("DLabel")
	lbl:SetFont("ZSHUDFontSmallest")
	lbl:SetText(translate.Get("pcm_menu_plcolor"))
	lbl:SetDark(false)
	lbl:Dock(TOP)

	local plycol = controls:Add("DColorMixer")
	plycol:SetAlphaBar(false)
	plycol:SetPalette(false)
	plycol:Dock(TOP)
	plycol:SetSize(200 * screenscale, math.min(frame:GetTall() / 3, 260) * screenscale)

	local lbl = controls:Add("DLabel")
	lbl:SetFont("ZSHUDFontSmallest")
	lbl:SetText(translate.Get("pcm_menu_phcolor"))
	lbl:SetDark(false)
	lbl:DockMargin(0, 32, 0, 0)
	lbl:Dock(TOP)

	local wepcol = controls:Add("DColorMixer")
	wepcol:SetAlphaBar(false)
	wepcol:SetPalette(false)
	wepcol:Dock(TOP)
	wepcol:SetSize(200 * screenscale, math.min(frame:GetTall() / 3, 260) * screenscale)
	wepcol:SetVector(Vector(GetConVarString("cl_weaponcolor")))

	sheet:AddSheet(translate.Get("pcm_menu_color"), controls, "icon16/color_wheel.png")

	local function PlayPreviewAnimation(panel, playermodel)
		if (!panel or !IsValid(panel.Entity)) then return end

		local anims = list.Get("PlayerOptionsAnimations")

		local anim = default_animations[math.random(1, #default_animations)]
		if (anims[playermodel]) then
			anims = anims[playermodel]
			anim = anims[ math.random(1, #anims)]
		end

		local iSeq = panel.Entity:LookupSequence(anim)
		if (iSeq > 0) then panel.Entity:ResetSequence(iSeq) end
	end

	local function UpdateFromConvars()
		local model = LocalPlayer():GetInfo("cl_playermodel")
		local modelname = player_manager.TranslatePlayerModel( model )
		util.PrecacheModel( modelname )
		mdl:SetModel( modelname )
		mdl.Entity.GetPlayerColor = function() return Vector( GetConVarString( "cl_playercolor" ) ) end
		mdl.Entity:SetPos( Vector( -100, 0, -61 ) )

		plycol:SetVector(Vector( GetConVarString("cl_playercolor")))
		wepcol:SetVector(Vector( GetConVarString("cl_weaponcolor")))

		PlayPreviewAnimation( mdl, model )
	end

	local function UpdateFromControls()
		RunConsoleCommand("cl_playercolor", tostring( plycol:GetVector()))
		RunConsoleCommand("cl_weaponcolor", tostring( wepcol:GetVector()))
	end

	plycol.ValueChanged = UpdateFromControls
	wepcol.ValueChanged = UpdateFromControls

	UpdateFromConvars()

	function PanelSelect:OnActivePanelChanged( old, new )
		if ( old != new ) then
			RunConsoleCommand("cl_playerbodygroups", "0")
			RunConsoleCommand("cl_playerskin", "0")
		end

		timer.Simple( 0.1, function() UpdateFromConvars() end )
	end

	function mdl:DragMousePress()
		self.PressX, self.PressY = gui.MousePos()
		self.Pressed = true
	end

	function mdl:DragMouseRelease() self.Pressed = false end

	function mdl:LayoutEntity( Entity )
		if (self.bAnimated) then self:RunAnimation() end

		if (self.Pressed) then
			local mx, my = gui.MousePos()
			self.Angles = self.Angles - Angle(0, ( self.PressX or mx) - mx, 0)
				
			self.PressX, self.PressY = gui.MousePos()
		end

		Entity:SetAngles(self.Angles)
	end

	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.15, 0)
	frame:MakePopup()
end