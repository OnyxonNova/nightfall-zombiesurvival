local function ScrapLabelThink(self)
	local scrap = MySelf:GetAmmoCount("scrap")
	if self.m_LastScrap ~= scrap then
		self.m_LastScrap = scrap

		self:SetText(translate.Get("r_scrap")..scrap)
		self:SizeToContents()
	end
end

local function SelectedInv()
	return GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu.SelInv
end

local function DismantleClick()
	DEXDerma_Query("Разобрать оружие? Это не может быть отменено.", "Подтвердить разборку оружия",
	"Разобрать", function()
		RunConsoleCommand("zs_dismantle", SelectedInv())

		GAMEMODE.RemantlerInterface:Close()
		GAMEMODE.RemantlerInterface = nil
	end,
	"Отмена", function()
	end)
end

hook.Add("Think", "RemantlerMenuThink", function()
	local pan = GAMEMODE.RemantlerInterface
	if pan and pan:IsValid() and pan:IsVisible() then
		local mx, my = gui.MousePos()
		local x, y = pan:GetPos()
		if mx < x - 16 or my < y - 16 or mx > x + pan:GetWide() + 16 or my > y + pan:GetTall() + 16 then
			pan:SetVisible(false)
		end
	end
end)

local function RemantlerCenterMouse(self)
	local x, y = self:GetPos()
	local w, h = self:GetSize()
	gui.SetMousePos(x + w * 0.5, y + h * 0.5)
end

-- Miniature version of the skill tree code
local PANEL = {}
local hovquality
local hovbranch

AccessorFunc( PANEL, "vCamPos",			"CamPos" )
AccessorFunc( PANEL, "fFOV",			"FOV" )
AccessorFunc( PANEL, "vLookatPos",		"LookAt" )
AccessorFunc( PANEL, "aLookAngle",		"LookAng" )
AccessorFunc( PANEL, "colAmbientLight",	"AmbientLight" )

PANEL.CreationTime = 0

function PANEL:UpdateNodes(curqua, curbra)
    for no, H in pairs(self.RemantleNodes) do
        for I, node in pairs(H) do
			curbra = curbra or 0
			if curbra == no then
            	node.Unlocked = I == 0 or curqua and curqua >= I
        	else
           		node.Unlocked = nil
        	end

        	if curqua and curqua >= 1 and curbra ~= no then
            	if curqua > I then
    				node.Locked = true
            	else
                	node.Locked = true
            	end
        	else
        		node.Locked = nil
    		end
        end
    end
end

function PANEL:Init()
	local node
	local screenscale = BetterScreenScale()

	self.DirectionalLight = {}
	self.FarZ = 32000

	self.MainMenu = GAMEMODE.RemantlerInterface
	self.RemantleNodes = {}
	self.RemantleNodes[0] = {}

	if not SelectedInv() and self.MainMenu.m_WepClass then
		self.GunTab = weapons.Get(self.MainMenu.m_WepClass)
		local gtbl = self.GunTab
		local curqua = gtbl.QualityTier
		local curbra = gtbl.Branch
		self.CurBranch = curbra

		if gtbl.AllowQualityWeapons then
			local branches = gtbl.Branches

			if branches then
				for no, _ in pairs(branches) do
					self.RemantleNodes[no] = {}
				end
			end

			self.OrigTab = gtbl.BaseQuality and weapons.Get(gtbl.BaseQuality) or gtbl

			for i = 0, #GAMEMODE.WeaponQualities do
				node = ClientsideModel("models/props/cs_italy/orange.mdl", RENDER_GROUP_OPAQUE_ENTITY)
				if IsValid(node) then
					node:SetNoDraw(true)
					node:SetPos(Vector(0, -48 + i * 30, 0))

					if curbra == no then
            			node.Unlocked = i == 0 or curqua and curqua >= i
        			else
           				node.Unlocked = nil
        			end

        			if curqua and curqua >= 1 and curbra ~= no then
            			if curqua > i then
                			node.Locked = true
            			else
                			node.Locked = true
            			end
        			else
            			node.Locked = nil
        			end

					local qualitycolortext = not node.Locked and (br and br.Colors and br.Colors[i]) or GAMEMODE.WeaponQualityColors[i][1]

					node.Color = qualitycolortext
					
					self.RemantleNodes[0][i] = node
				end

				if branches then
					for no, br in pairs(branches) do
						node = ClientsideModel("models/props/cs_italy/orange.mdl", RENDER_GROUP_OPAQUE_ENTITY)
						if IsValid(node) then
							node:SetNoDraw(true)
							node:SetPos(Vector(0, -48 + i * 30, 0 - ((#branches == 1 and 16 or 20)/#branches)*no))

							if curbra == no then
            					node.Unlocked = i == 0 or curqua and curqua >= i
        					else
           						node.Unlocked = nil
        					end

        					if curqua and curqua >= 1 and curbra ~= no then
            					if curqua > i then
                					node.Locked = true
            					else
                					node.Locked = true
            					end
        					else
            					node.Locked = nil
        					end

							local qualitycolortext = not node.Locked and (br and br.Colors and br.Colors[i]) or GAMEMODE.WeaponQualityColors[i][2]

							node.Color = qualitycolortext

							node.Name = br and br.NewNames and br.NewNames[i] or nil
							self.RemantleNodes[no][i] = node
						end
					end
				end
			end
		end
	end

	self:SetCamPos( Vector( 20000, 0, 0 ) )
	self:SetLookAt( Vector( 0, 0, 0 ) )
	self:SetFOV( 5 )

	self:SetAmbientLight( Color( 50, 50, 50 ) )

	self:SetDirectionalLight( BOX_TOP, color_white )
	self:SetDirectionalLight( BOX_FRONT, color_white )

	local top = vgui.Create("Panel", self)
	top:SetSize(ScrW(), 256)
	top:SetMouseInputEnabled(false)

	local qualityname = vgui.Create("DLabel", top)
	qualityname:SetFont("ZSHUDFont")
	qualityname:SetTextColor(COLOR_WHITE)
	qualityname:SetContentAlignment(8)
	qualityname:Dock(TOP)

	local desc = {}
	for i=1, 5 do
		local qualityd = vgui.Create("DLabel", top)
		qualityd:SetFont("ZSHUDFontTiny")
		qualityd:SetTextColor(COLOR_GRAY)
		qualityd:SetContentAlignment(8)
		qualityd:Dock(TOP)
		table.insert(desc, qualityd)
	end

	local bottom = vgui.Create("Panel", self)
	bottom:SetSize(ScrW(), 36 * screenscale)
	bottom:SetMouseInputEnabled(false)

	local scrapcost = vgui.Create("DLabel", bottom)
	scrapcost:SetFont("ZSHUDFontSmaller")
	scrapcost:SetTextColor(COLOR_WHITE)
	scrapcost:SetContentAlignment(2)
	scrapcost:Dock(TOP)

	self.Top = top
	self.QualityName = qualityname
	self.QualityDesc = desc
	self.Bottom = bottom
	self.ScrapCost = scrapcost

	top:SetAlpha(0)
	bottom:SetAlpha(0)

	self:DockMargin(0, 0, 0, 0)
	self:DockPadding(0, 0, 0, 0)
	self:Dock(FILL)
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()

	self.Top:AlignTop(4)
	self.Top:CenterHorizontal()

	self.Bottom:AlignBottom(10 * screenscale)
	self.Bottom:CenterHorizontal()
end

function PANEL:SetDirectionalLight(iDirection, color)
	self.DirectionalLight[iDirection] = color
end

local matBeam = Material("trails/laser")
local matGlow = Material("sprites/glow04_noz")
local matWhite = Material("models/debug/debugwhite")
local colBeam = Color(0, 0, 0)
local colBeam2 = Color(255, 255, 255)
local colGlow = Color(0, 0, 0)
function PANEL:Paint(w, h)
	local realtime = RealTime()
	local nodepos, selected
	local col, othernodepos
	local add, pos_a, pos_b, sat
	local size, ang

	local campos = self.vCamPos
	campos.x = 1450
	campos.y = math.Clamp(campos.y, -262, 262)
	campos.z = math.Clamp(campos.z, -262, 262)

	self:SetCamPos(campos)
	self.vLookatPos:Set(campos)
	self.vLookatPos.x = 0

	self:SetCamPos(campos)

	surface.SetDrawColor(15, 20, 25, 230)
	surface.DrawRect(0, 0, w, h)

	ang = self.aLookAngle
	if not ang then
		ang = (self.vLookatPos - self.vCamPos):Angle()
	end
	local to_camera = ang:Forward() * -1

	local x, y = self:LocalToScreen(0, 0)

	local mx, my = gui.MousePos()
	local aimvector = util.AimVector(ang, self.fFOV, mx - x, my - y, w, h)
	local intersectpos = util.IntersectRayWithPlane(self.vCamPos, aimvector, self:GetLookAt(), Vector(-1, 0, 0))

	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )
	cam.IgnoreZ( true )

	render.SuppressEngineLighting( true )
	render.SetLightingOrigin( vector_origin )
	render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )

	for i=0, 6 do
		col = self.DirectionalLight[ i ]
		if col then
			render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
		end
	end

	render.SetMaterial(matBeam)
	for branch, nodes in pairs(self.RemantleNodes) do
		for id, node in pairs(nodes) do
			if IsValid(node) then
				nodepos = node:GetPos()
				othernodes = {}

				othernodes[#othernodes+1] = nodes[id + 1]

				for _, othernode in pairs(othernodes) do
					if IsValid(othernode) then
						othernodepos = othernode:GetPos()

						local beamsize = 4
						if othernode.Unlocked then
							colBeam.r = 32
							colBeam.g = 128
							colBeam.b = 255
						elseif node.Unlocked then
							colBeam.r = 255
							colBeam.g = 192
							colBeam.b = 0
						else
							colBeam.r = 128
							colBeam.g = 40
							colBeam.b = 40

							beamsize = 2
						end

						if hovquality and hovquality >= id - 1 and hovquality <= id + 1 and hovbranch == branch then
							add = math.abs(math.sin(realtime * math.pi)) * 120
							colBeam.r = math.min(colBeam.r + add, 255)
							colBeam.g = math.min(colBeam.g + add, 255)
							colBeam.b = math.min(colBeam.b + add, 255)

							colBeam.a = 180
							colBeam2.a = 190
						else
							colBeam.a = 110
							colBeam2.a = 110
						end

						pos_a = nodepos + Vector(-16, 0, 0)
						pos_b = othernodepos + Vector(-16, 0, 0)

						render.DrawBeam(pos_a, pos_b, beamsize, 0, 1, colBeam2)
						render.DrawBeam(pos_a, pos_b, 8, 0, 1, colBeam)
					end
				end
			end
		end
	end

	local oldquality = hovquality
	local oldbranch = hovbranch
	hovquality = nil
	hovbranch = nil

	local angle = (realtime * 180) % 360

	for branch, nodes in pairs(self.RemantleNodes) do
		for id, node in pairs(nodes) do
			if IsValid(node) then
				nodepos = node:GetPos()
				selected = intersectpos and nodepos:DistToSqr(intersectpos) <= 36

				cam.Start3D2D(node:GetPos() - to_camera * 8, Angle(0, 90, 90), 0.08)
				surface.DisableClipping(true)
				DisableClipping(true)

				if selected then
					hovquality = id
					hovbranch = branch

					sat = 1 - math.abs(math.sin(realtime * math.pi)) * 0.25
				else
					sat = 1
				end

				local prevnode = nodes[id - 1] or {Unlocked = true}
				if node.Locked then
					render.SetColorModulation(sat / 4, sat / 4, sat / 4)
				elseif node.Unlocked then
					render.SetColorModulation(sat / 4, sat / 4, sat)
				elseif prevnode.Unlocked and not node.Unlocked then
					render.SetColorModulation(sat, sat / 2, 0)
				else
					render.SetColorModulation(sat / 2, 0, 0)
				end
				render.ModelMaterialOverride(matWhite)

				node:DrawModel()

				render.ModelMaterialOverride()
				render.SetColorModulation(1, 1, 1)

				local txt = translate.Get("rh_standard")

				if branch ~= 0 then
					txt = self.OrigTab.Branches[branch].PrintName
				end

				if branch ~= 0 and self.OrigTab.Branches[branch].NewNames ~= nil then
					txt = self.OrigTab.Branches[branch].NewNames[0]
				end

				local quals = GAMEMODE.WeaponQualities[id]
				if quals then
					txt = node.Name or branch == 0 and quals[1] or quals[3]
				end

				local col = color_white
				local qualitycolor = GAMEMODE.WeaponQualityColors[id]
				self.GunTab = weapons.Get(self.MainMenu.m_WepClass)
				local gtbl = self.GunTab
				if qualitycolor then
					col = node.Color
					local del = 3 - id / 2
					col = Color(235 - (235 - col.r) / del, 235 - (235 - col.g) / del, 235 - (235 - col.b) / del)
				end
				
				draw.SimpleText(txt, "ZS3D2DFont2", -x, -y, node.Locked and COLOR_MIDGRAY or col or COLOR_NEARGRAY, TEXT_ALIGN_CENTER)

				DisableClipping(false)
				surface.DisableClipping(false)
				cam.End3D2D()

				if not node.Locked then
					render.SetMaterial(matGlow)
					colGlow.r = sat * 255 colGlow.g = sat * 255 colGlow.b = sat * 255
					if node.Unlocked then
						colGlow.r = colGlow.r / 4
						colGlow.g = colGlow.g / 4
					elseif not node.Unlocked then
						if prevnode.Unlocked then
							colGlow.g = colGlow.g / 1.5
							colGlow.b = 0
						else
							colGlow.r = colGlow.r / 1.5
							colGlow.g = 0
							colGlow.b = 0
						end
					end
					size = selected and 30 or 20
					render.DrawQuadEasy(nodepos, to_camera, size, size, colGlow, angle)
					angle = angle + 45
				end
			end
		end
	end

	if intersectpos then
		intersectpos = intersectpos + Vector(16, 0, 0)
		render.SetMaterial(matGlow)
		render.DrawQuadEasy(intersectpos, to_camera, 12, 12, color_white, realtime * 90)
	end

	render.SuppressEngineLighting(false)

	cam.IgnoreZ(false)
	cam.End3D()

	if oldquality ~= hovquality or oldbranch ~= hovbranch then
		self.Top:Stop()
		self.Bottom:Stop()

		if hovquality and hovbranch then
			local txt, scost = translate.Get("rh_standard"), ""
			if hovbranch ~= 0 then
				txt = self.OrigTab.Branches[hovbranch].PrintName
			end
			local scost = 0

			local quals = GAMEMODE.WeaponQualities[hovquality]
			if quals then
				txt = self.RemantleNodes[hovbranch][hovquality].Name or hovbranch == 0 and quals[1] or quals[3]
				scost = GAMEMODE:GetUpgradeScrap(self.GunTab, hovquality)
			end

			local qualitycolor = GAMEMODE.WeaponQualityColors[hovquality]

			local gtbl = self.GunTab
			local color = self.RemantleNodes[hovbranch][hovquality].Color or COLOR_WHITE

			self.QualityName:SetText(txt)
			self.QualityName:SetTextColor(color)
			self.QualityName:SizeToContents()

			local scrapcosttext = scost ~= "" and translate.Get("r_scrapcost") .. scost or ""
            if scost > 0 then
                scrapcosttext = scrapcosttext .. translate.Format("r_scrapcostmiss", math.max(scost - MySelf:GetAmmoCount("scrap"), 0))
            end
			local remaining = MySelf:GetAmmoCount("scrap") + (MySelf:GetPoints() * 2)
			self.ScrapCost:SetText(scrapcosttext)
			self.ScrapCost:SetTextColor(scost ~= "" and MySelf:GetAmmoCount("scrap") >= scost and COLOR_WHITE or (MySelf:GetInfo("zs_enablemetalpointbuy") == "1" and remaining >= scost) and COLOR_WHITE or COLOR_RED)
			self.ScrapCost:SizeToContents()

			local qtext
			local classname
			local lvl
			local branch

			if MySelf:GetActiveWeapon().QualityTier then
				qtext = string.len(MySelf:GetActiveWeapon():GetClass())
				qtext = qtext - 3
				classname = string.Left(MySelf:GetActiveWeapon():GetClass(), qtext)
			else
				classname = MySelf:GetActiveWeapon():GetClass()
			end
			
			GAMEMODE:SupplyItemViewerDetail(GAMEMODE.RemantlerInterface.RemantlerFrame.Viewer, weapons.Get(GAMEMODE:GetWeaponClassOfQuality(classname, hovquality, hovbranch)) or weapons.Get(classname), nil, false)
			GAMEMODE:ViewerStatBarUpdate(GAMEMODE.RemantlerInterface.RemantlerFrame.Viewer, false, weapons.Get(GAMEMODE:GetWeaponClassOfQuality(classname, hovquality, hovbranch)) or weapons.Get(classname))

			local dtxt
			local altdesc = self.OrigTab.RemantleDescs
			local altdescs = altdesc and altdesc[hovbranch][hovquality]
			local nodesc = (hovquality == 0 and hovbranch ~= 0) and 2 or hovbranch ~= 0 and 1 or 0

			for i=1, 5 do
				dtxt = " "
				if txt ~= translate.Get("rh_standard") and altdesc and altdescs and altdescs[i + nodesc] then
					dtxt = altdescs[i + nodesc]
				end

				self.QualityDesc[i]:SetTextColor(COLOR_GREEN)
				self.QualityDesc[i]:SetText(dtxt)
				self.QualityDesc[i]:SizeToContents()
			end

			surface.PlaySound("zombiesurvival/ui/misc1.ogg")

			self.Top:SetAlpha(0)
			self.Top:AlphaTo(195, 0.1)

			self.Bottom:SetAlpha(0)
			self.Bottom:AlphaTo(140, 0.1)
		else
			self.Top:AlphaTo(0, 0.1)
			self.Bottom:AlphaTo(0, 0.1)
		end
	end

	return true
end

net.Receive("zs_remantleconf", function()
	local weapon = net.ReadString()
	if not (GAMEMODE.RemantlerInterface and GAMEMODE.RemantlerInterface:IsValid() and hovquality and hovbranch) then return end

	local ri = GAMEMODE.RemantlerInterface
	local path = ri.RemantlePath

	local contentsqua = GAMEMODE.GunTab.QualityTier
	local desiredqua = contentsqua and contentsqua + 1 or 1
	local upgclass = weapon

	GAMEMODE.GunTab = weapons.Get(upgclass)
	local gtbl = GAMEMODE.GunTab
	local scost = GAMEMODE:GetUpgradeScrap(gtbl, desiredqua)

	path.GunTab = gtbl
	path:UpdateNodes(GAMEMODE.GunTab.QualityTier, GAMEMODE.GunTab.Branch)
	path.m_WepClass = upgclass
    path.CurBranch = gtbl.Branch

	local remaining = MySelf:GetAmmoCount("scrap") + (MySelf:GetPoints() * 2)
	path.ScrapCost:SetTextColor((MySelf:GetAmmoCount("scrap") - scost) >= scost and COLOR_WHITE or (MySelf:GetInfo("zs_enablemetalpointbuy") == "1" and remaining >= scost) and COLOR_WHITE or COLOR_RED)

	ri.m_ContentsLabel:SetText(gtbl.PrintName)
	ri.m_ContentsLabel:SizeToContents()
	ri.m_ContentsLabel:CenterHorizontal(0.325) 

	local retscrap = GAMEMODE:GetDismantleScrap(gtbl)
	local disscraptxt = gtbl.NoDismantle and translate.Get("r_cantdisinto") or translate.Get("r_disinto") .. retscrap .. translate.Get("ars_scrap")

	ri.m_Dismantle:SetText(disscraptxt)
	ri.m_Dismantle:SizeToContents()
	ri.m_Dismantle:CenterHorizontal(0.325) 

	ri.m_DisaButton:SetDisabled(gtbl.NoDismantle)
	ri.m_DisaButton:SetTextColor(gtbl.NoDismantle and COLOR_DARKGRAY or COLOR_WHITE)
end)

function PANEL:OnMousePressed(mc)
	if mc == MOUSE_LEFT and hovquality and hovbranch and self.GunTab then
		local gtbl = self.GunTab
		local cqua = gtbl.QualityTier or 0
		local cbra = GAMEMODE.RemantlerInterface.RemantlePath.CurBranch or 0

		local current = self.RemantleNodes[hovbranch][hovquality]
        local prev = self.RemantleNodes[hovbranch][hovquality - 1]

        local zeroorprev = hovquality == 0 or prev and prev.Unlocked
        local biggerhov = hovquality > cqua and hovbranch == cbra
        local zeroqual = hovquality == cqua and hovbranch ~= cbra

        if cqua and (biggerhov or zeroqual) and zeroorprev and not current.Locked then
			local scost = GAMEMODE:GetUpgradeScrap(self.GunTab, hovquality)
			if MySelf:GetAmmoCount("scrap") >= scost or (MySelf:GetInfo("zs_enablemetalpointbuy") == "1" and MySelf:GetAmmoCount("scrap") < scost) then
				RunConsoleCommand(zeroqual and "zs_branchswap" or "zs_upgrade", hovbranch or 0)

				return
			else
				GAMEMODE:CenterNotify(COLOR_RED, translate.Get("r_morescrap"))
				surface.PlaySound("buttons/button8.wav")

				return
			end
		else
			GAMEMODE:CenterNotify(COLOR_RED, translate.Get("r_correctqual"))
			surface.PlaySound("buttons/button8.wav")

			return
		end
	end
end

vgui.Register("ZSRemantlePath", PANEL, "Panel")

function GM:OpenRemantlerMenu(remantler)
    if self.RemantlerInterface and self.RemantlerInterface:IsVisible() then
        return
    end

    local mywep = MySelf:GetActiveWeapon()
    local wep = mywep and mywep:IsValid() and mywep:GetClass() or "weapon_zs_fists"
    local mytarget = SelectedInv() or wep

    if self.RemantlerInterface and self.RemantlerInterface:IsValid() and self.RemantlerInterface.m_WepClass == mytarget then
        self.RemantlerInterface:Remove()
        self.RemantlerInterface = nil
    end

	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 1000) * screenscale, math.min(ScrH(), 800) * screenscale
	local tabhei = 30 * screenscale

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(false)
	frame:SetTitle(" ")
	frame:SetDraggable(false)
	if frame.btnClose and frame.btnClose:IsValid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end
	frame.CenterMouse = RemantlerCenterMouse
	self.RemantlerInterface = frame

	frame.m_Remantler = remantler
	frame.m_WepClass = mytarget

	if not SelectedInv() then
		self.GunTab = weapons.Get(frame.m_WepClass)
	else
		self.GunTab = GAMEMODE.ZSInventoryItemData[frame.m_WepClass]
	end

	local gtbl = self.GunTab
	if not SelectedInv() and not (gtbl.AllowQualityWeapons or gtbl.PermitDismantle) then
		frame.m_WepClass, gtbl = nil, nil
	elseif SelectedInv() and ((gtbl.PermitDismantle ~= nil and not gtbl.PermitDismantle) or (self:GetInventoryItemType(mytarget) ~= INVCAT_TRINKETS)) then
		frame.m_WepClass, gtbl = nil, nil
	end

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16)

	local title = EasyLabel(topspace, translate.Get("r_title"), "ZSHUDFontSmall", COLOR_WHITE)
	title:CenterHorizontal()
	local subtitle = EasyLabel(topspace, translate.Get("r_subtitle"), "ZSHUDFontTiny", COLOR_WHITE)
	subtitle:CenterHorizontal()
	subtitle:MoveBelow(title, 4)

	local _, y = subtitle:GetPos()
	topspace:SetTall(y + subtitle:GetTall() + 4)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()

	local fastbuy = vgui.Create("DEXCheckBoxLabel", topspace)
	fastbuy:SetText(translate.Get("ars_qp"))
    fastbuy:SetConVar("zs_alwaysquickbuy")
    fastbuy:SetFont("ZSHUDFontSmallest")
    fastbuy:SizeToContents()
	fastbuy:AlignLeft(10)
	fastbuy:CenterVertical(0.25)

	local metalbuy = vgui.Create("DEXCheckBoxLabel", topspace)
	metalbuy:SetText(translate.Get("r_missingscrap"))
    metalbuy:SetConVar("zs_enablemetalpointbuy")
    metalbuy:SetFont("ZSHUDFontSmallest")
    metalbuy:SizeToContents()
	metalbuy:AlignLeft(10)
	metalbuy:CenterVertical(0.75)

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())

	local pointslabel = EasyLabel(bottomspace, translate.Get("r_scrap").."0", "ZSHUDFontTiny", COLOR_GREEN)
	pointslabel:AlignTop(4)
	pointslabel:AlignLeft(8)
	pointslabel.Think = ScrapLabelThink

	local lab = EasyLabel(bottomspace, translate.Get("r_disam"), "ZSHUDFontTiny")
	lab:AlignTop(4)
	lab:AlignRight(4)
	frame.m_AdviceLabel = lab

	_, y = lab:GetPos()
	bottomspace:SetTall(y + lab:GetTall() + 4)
	bottomspace:AlignBottom(8)
	bottomspace:CenterHorizontal()

	local __, topy = topspace:GetPos()
	local ___, boty = bottomspace:GetPos()

	local remprop = vgui.Create("DEXPropertySheet", frame)
	remprop:SetSize(wid - 8, boty - topy - 8 - topspace:GetTall())
	remprop:MoveBelow(topspace, 4)
	remprop:CenterHorizontal()
	remprop.Paint = function() end
	remprop:SetPadding(0)

	local remantleframe = vgui.Create("DPanel", remprop)
	local sheet = remprop:AddSheet(translate.Get("r_remantling"), remantleframe, "icon16/arrow_up.png", false, false)
	sheet.Panel:SetPos(0, tabhei + 2)
	remantleframe.Paint = function(me, w, h) surface.SetDrawColor(31, 33, 35, 255) surface.DrawRect(0, 0, w, h) end
	remantleframe:SetSize(wid - 8, boty - topy - 8 - topspace:GetTall())
	frame.RemantlerFrame = remantleframe

	local trinketsframe = vgui.Create("DPanel")
	sheet = remprop:AddSheet(translate.Get("r_trinkets"), trinketsframe, GAMEMODE.ItemCategoryIcons[ITEMCAT_TRINKETS], false, false)
	sheet.Panel:SetPos(0, tabhei + 2)
	trinketsframe:SetSize(wid - -8, boty - topy - 8 - topspace:GetTall())
	trinketsframe:SetPaintBackground(false)
	frame.TrinketsFrame = trinketsframe

	local ammoframe = vgui.Create("DPanel")
	sheet = remprop:AddSheet(translate.Get("r_ammunition"), ammoframe, GAMEMODE.ItemCategoryIcons[ITEMCAT_AMMO], false, false)
	sheet.Panel:SetPos(0, tabhei + 2)
	ammoframe:SetSize(wid - 8, boty - topy - 8 - topspace:GetTall())
	ammoframe:SetPaintBackground(true)
	frame.m_AmmoFrame = ammoframe

	local subpropertysheet
	for frameindex = 0, 1 do
		local curframe = frameindex == 0 and trinketsframe or ammoframe

		if frameindex == 0 then
			local tabpane = vgui.Create("DPanel", curframe)

			tabpane.Grids = {}
			tabpane.Buttons = {}
			tabpane:SetSize(curframe:GetWide(), curframe:GetTall())

			local offset = 64 * screenscale
			local itemframe = vgui.Create("DScrollPanel", tabpane)
			itemframe:SetSize(curframe:GetWide(), curframe:GetTall() - offset - 32)
			itemframe:SetPos(0, offset)

			local mkgrid = function()
				local list = vgui.Create("DGrid", itemframe)
				list:SetPos(0, 0)
				list:SetSize(curframe:GetWide() - 312, curframe:GetTall())
				list:SetCols(2)
				list:SetColWide(333 * screenscale)
				list:SetRowHeight(100 * screenscale)

				return list
			end

			local subcats = GAMEMODE.ItemSubCategories
			local tbn
			for j = 1, #subcats do
				local ispacer = ((j-1) % 3)+1

				tbn = EasyButton(tabpane, subcats[j], 8, 4)
				tbn:SetFont("ZSHUDFontSmallest")
				tbn:SetAlpha(j == 1 and 255 or 70)
				tbn:SetColor(j == 1 and SELECT_COLOR or COLOR_WHITE)
				tbn:SetContentAlignment(5)
				tbn:SetSize(130 * screenscale, 30 * screenscale)
				tbn:AlignRight(810 * screenscale - (ispacer - 1) * 190 * screenscale)
				tbn:AlignTop(j <= 3 and 0 or 30 * screenscale)

				tbn.DoClick = function(me)
					for k, v in pairs(tabpane.Grids) do
						v:SetVisible(k == j)
						tabpane.Buttons[k]:SetColor(k == j and SELECT_COLOR or COLOR_WHITE)
						tabpane.Buttons[k]:SetAlpha(k == j and 255 or 70)
					end
				end

				tabpane.Grids[j] = mkgrid()
				tabpane.Grids[j]:SetVisible(j == 1)
				tabpane.Buttons[j] = tbn
			end

			for j, tab in ipairs(GAMEMODE.Items) do
				if tab.PointShop and tab.Category == ITEMCAT_TRINKETS then
					self:AddShopItem(tabpane.Grids[tab.SubCategory], j, tab, false, true)
				end
			end
		else
			local list = vgui.Create("DGrid", curframe)
			list:SetPos(0, 0)
			list:SetSize(curframe:GetWide() - 312, curframe:GetTall())
			list:SetCols(2)
			list:SetColWide(333 * screenscale)
			list:SetRowHeight(100 * screenscale)

			list:SetPos(8, 16)
			list:SetWide(ammoframe:GetWide() - 16)
			list:SetTall(ammoframe:GetTall() - 32)

			for j, tab in ipairs(GAMEMODE.Items) do
				if tab.PointShop and tab.Category == ITEMCAT_AMMO and not tab.CantMakeFromScrap then
					self:AddShopItem(list, j, tab, false, true)
				end
			end
		end
	end
	frame.m_SubProp = subpropertysheet

	self:CreateItemInfoViewer(trinketsframe, frame, topspace, bottomspace, MENU_REMANTLER)

	local scroller = remprop:GetChildren()[1]
	local dragbase = scroller:GetChildren()[1]
	local tabs = dragbase:GetChildren()

	self:ConfigureMenuTabs(tabs, tabhei)

	local contents = EasyLabel(remantleframe, gtbl and gtbl.PrintName or translate.Get("r_empty"), "ZSHUDFontSmall", COLOR_WHITE)
	contents:AlignTop(16 * screenscale)
	contents:CenterHorizontal(0.325) 
	frame.m_ContentsLabel = contents

	local upgpathf = vgui.Create("DPanel", remantleframe)
	upgpathf:SetSize(wid / 1.55, remantleframe:GetTall() / 1.75)
	upgpathf:MoveBelow(contents, 24 * screenscale)
	upgpathf:CenterHorizontal(0.325)

	if gtbl and gtbl.AllowQualityWeapons then
		self:CreateItemInfoViewer(remantleframe, frame, topspace, bottomspace, MENU_REMANTLER)
		self:SupplyItemViewerDetail(remantleframe.Viewer, MySelf:GetActiveWeapon(), nil, false)
		self:ViewerStatBarUpdate(remantleframe.Viewer, false, MySelf:GetActiveWeapon())
	end

	frame.RemantlePath = vgui.Create("ZSRemantlePath", upgpathf)

	local disabtn = EasyButton(remantleframe, translate.Get("r_diswep"), 8, 4)
	disabtn:SetFont("ZSHUDFont")
	disabtn:SizeToContents()
	disabtn:MoveBelow(upgpathf, 32 * screenscale)
	disabtn:CenterHorizontal(0.325)
	disabtn.DoClick = function() RunConsoleCommand("zs_dismantle", SelectedInv()) GAMEMODE.RemantlerInterface:Close() GAMEMODE.RemantlerInterface = nil end
	if not gtbl then
		disabtn:SetDisabled(true)
	else
		disabtn:SetDisabled(gtbl.NoDismantle)
	end
	disabtn:SetTextColor(gtbl and gtbl.NoDismantle and COLOR_DARKGRAY or gtbl and COLOR_WHITE or COLOR_DARKGRAY)
	frame.m_DisaButton = disabtn

	local disscraptxt = ""
	if gtbl then
		local retscrap = self:GetDismantleScrap(gtbl, SelectedInv())
		disscraptxt = gtbl.NoDismantle and translate.Get("r_cantdisinto") or translate.Get("r_disinto") .. retscrap .. translate.Get("ars_scrap")
	end

	local disscrap = EasyLabel(remantleframe, disscraptxt, "ZSHUDFontSmaller", COLOR_WHITE)
	disscrap:MoveBelow(disabtn, 4 * screenscale)
	disscrap:CenterHorizontal(0.325)
	frame.m_Dismantle = disscrap

	frame:MakePopup()
	frame:CenterMouse()
end
