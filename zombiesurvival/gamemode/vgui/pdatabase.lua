local function fontcolor(node)
	node.Label:SetFont("ZSHUDFontTinier")
    node.Label:SetTextColor(COLOR_WHITE)
end

local function WeaponButtonDoClick(self)
	local swep = self.SWEP
	if swep then
		self.Frame:SetWeaponViewerSWEP(self.SWEP, self.Category, self.descript)
	end
end

local function TrinketButtonDoClick(self)
	local swep = self.SWEP
	if swep then
		self.Frame:SetTrinketViewerSWEP(self.SWEP)
	end
end

local function SetTrinketViewerSWEP(self, swep)
	if self.Viewer then
		if self.Viewer:IsValid() then
			self.Viewer:Remove()
		end
		self.Viewer = nil
	end

	local wid, hei = self:GetWide() * 0.6 - 16, self:GetTall() - self.ViewerY - 8
	local screenscale = BetterScreenScale()

	local viewer = vgui.Create("DPanel", self)
	viewer:SetPaintBackground(false)
	viewer:SetSize(wid, hei)
	viewer:SetPos(self:GetWide() - viewer:GetWide() - 8 * screenscale, self.ViewerY)
	self.Viewer = viewer
	
	if not swep then return end
	local sweptable = GAMEMODE.ZSInventoryItemData[swep]
	if not sweptable then return end

	GAMEMODE:CreateItemViewerGenericElems(viewer)

	viewer.m_Title:SetText(GAMEMODE:GetTrinketName(sweptable))

	local color = COLOR_GRAY
	local data = GAMEMODE.ZSInventoryItemData[GAMEMODE:GetBaseItemName(swep)]
	if GAMEMODE.ZSInventoryItemData[swep].QualityTier > 0 then
		color = GAMEMODE.WeaponQualityColors[GAMEMODE.ZSInventoryItemData[swep].QualityTier][data.AlternativeColors and 2 or 1]
	end

	viewer.m_Title:SetTextColor(color)
	viewer.m_Title:PerformLayout()

	local desctext = translate.Get(sweptable.Description) or ""

	if sweptable.NoDismantle then
		desctext = desctext .. "\nНе может быть разобран на металл."
	end

	viewer.m_DescScroll:MoveBelow(viewer.m_Title, 8 * screenscale)
	viewer.m_DescScroll:SetTall(viewer:GetTall() * 0.25)

	viewer.m_Desc:MoveBelow(viewer.m_Title, 8 * screenscale)
	viewer.m_Desc:SetFont("ZSBodyTextFontBig")
	viewer.m_Desc:SetText(desctext)

	viewer.m_AmmoType:SetText("")
	viewer.m_VBG:SetVisible(false)
	viewer.m_AmmoIcon:SetVisible(false)
end

local function SetWeaponViewerSWEP(self, swep, category, descript)
	if self.Viewer then
		if self.Viewer:IsValid() then
			self.Viewer:Remove()
		end
		self.Viewer = nil
	end

	local screenscale = BetterScreenScale()
	local wid, hei = self:GetWide() * 0.6 - 16, self:GetTall() - self.ViewerY - 8 * screenscale

	local viewer = vgui.Create("DPanel", self)
	viewer:SetPaintBackground(false)
	viewer:SetSize(wid, hei)
	viewer:SetPos(self:GetWide() - viewer:GetWide() - 8 * screenscale, self.ViewerY)
	self.Viewer = viewer
	
	if not swep then return end
	local sweptable = weapons.Get(swep)
	if not sweptable then return end

	GAMEMODE:CreateItemViewerGenericElems(viewer)

	viewer.m_Title:SetText(sweptable.PrintName)
	viewer.m_Title:SetTextColor(COLOR_GRAY)
	viewer.m_Title:PerformLayout()

	local desctext = sweptable.Description or ""
	if descript then
		desctext = descript
	end

	viewer.ModelPanel:SetModel("")
	viewer.m_VBG:SetVisible(true)

	if viewer.IconFrame then
        if viewer.m_VBG and viewer.m_VBG.m_Icon and viewer.m_VBG.m_Icon:IsValid() then
            viewer.m_VBG.m_Icon:Remove()
        end
        if sweptable then
            local icon = killicon.Get(sweptable.ClassName)
            if icon then
                GAMEMODE:AttachKillicon(icon, viewer.m_VBG, viewer.IconFrame)
            end
        end
    end

	if sweptable.Culinary then
		desctext = desctext .. "\nЯвляется кулинарным оружием."
	end

	if sweptable.NoDismantle then
		desctext = desctext .. "\nНе может быть разобран на металл."
	end

	viewer.m_DescScroll:MoveBelow(viewer.m_VBG, 8 * screenscale)
	viewer.m_DescScroll:SetTall(viewer:GetTall() * 0.125)

	viewer.m_Desc:MoveBelow(viewer.m_VBG, 8 * screenscale)
	viewer.m_Desc:SetFont("ZSBodyTextFont")
	viewer.m_Desc:SetText(desctext)

	GAMEMODE:ViewerStatBarUpdate(viewer, category ~= ITEMCAT_GUNS and category ~= ITEMCAT_MELEE and category ~= ITEMCAT_TOOLS, sweptable)
	
	if GAMEMODE:HasPurchaseableAmmo(sweptable) and GAMEMODE.AmmoNames[string.lower(sweptable.Primary.Ammo)] then
		local lower = string.lower(sweptable.Primary.Ammo)
 
		viewer.m_AmmoType:SetText(GAMEMODE.AmmoNames[lower])
		viewer.m_AmmoType:SetContentAlignment(8)
		viewer.m_AmmoType:PerformLayout()

		local ki = killicon.Get(GAMEMODE.AmmoIcons[lower])

		viewer.m_AmmoIcon:SetImage(ki[1])
		if ki[2] then viewer.m_AmmoIcon:SetImageColor(ki[2]) end

		viewer.m_AmmoIcon:SetVisible(true)

		if sweptable.Secondary.Ammo ~= "dummy" then
			local lowersecond = string.lower(sweptable.Secondary.Ammo)

			viewer.m_AmmoType:SetText(GAMEMODE.AmmoNames[lower].."/"..GAMEMODE.AmmoNames[lowersecond])
			viewer.m_AmmoType:SetContentAlignment(8)
			viewer.m_AmmoType:PerformLayout()

			local kis = killicon.Get(GAMEMODE.AmmoIcons[lowersecond])

			viewer.m_AmmoIconSecond:SetImage(kis[1])
			if kis[2] then viewer.m_AmmoIconSecond:SetImageColor(kis[2]) end
			viewer.m_AmmoIconSecond:SetVisible(true)
		else
			viewer.m_AmmoType:SetContentAlignment(8)
			viewer.m_AmmoIconSecond:SetVisible(false)
		end
	else
		viewer.m_AmmoType:SetText("")
		viewer.m_AmmoType:SetContentAlignment(8)
		viewer.m_AmmoIcon:SetVisible(false)
		viewer.m_AmmoIconSecond:SetVisible(false)
	end
end

local MakepWeaponsDatabase = function(frame)
	local wid, hei = frame:GetWide(), frame:GetTall()
	local screenscale = BetterScreenScale()
	local title = databasepanel.title

	local added = {}
	local addedcat = {}
	local weps = {}

	for _, tab in ipairs(GAMEMODE.Items) do
		if tab.SWEP and not added[tab.SWEP] then
			if weapons.Get(tab.SWEP) then
				weps[#weps + 1] = tab.SWEP
				added[tab.SWEP] = true
				addedcat[tab.SWEP] = tab.Category
			end
		end
	end

	local tree = vgui.Create("DTree", frame)
	tree:SetSize(wid * 0.4 - 8 * screenscale, hei - title:GetTall() - 20 * screenscale)
	tree:MoveBelow(title, -34 * screenscale)
	tree:SetPadding(1)
	tree:SetBackgroundColor(COLOR_DARKGRAY)
	tree:SetIndentSize(4)
	frame.WeaponsTree = tree
	frame.WeaponsPanels = {}
	frame.SetWeaponViewerSWEP = SetWeaponViewerSWEP
	frame.ViewerY = 8 

	local bannedcats = {
		[ITEMCAT_AMMO] = true,
		[ITEMCAT_TRINKETS] = true,
		[ITEMCAT_BUILDING] = true
	}

	for cat, name in pairs(GAMEMODE.ItemCategories) do
		if bannedcats[cat] then continue end
		frame.WeaponsPanels[cat] = frame.WeaponsTree:AddNode(name, GAMEMODE.ItemCategoryIcons[cat])
		fontcolor(frame.WeaponsPanels[cat])
		for t = 1, 6 do
			frame.WeaponsPanels[cat][t] = frame.WeaponsPanels[cat]:AddNode("Ярус "..t, "icon16/wand.png")
			fontcolor(frame.WeaponsPanels[cat][t])
		end
	end

	for _, wep in pairs(weps) do
		local enttab = weapons.Get(wep)
		local wepnode
		if enttab then
			wepnode = frame.WeaponsPanels[addedcat[wep]][enttab.Tier or 1]:AddNode(enttab.PrintName or wep,"icon16/bomb.png")
		else
			wepnode = frame.WeaponsTree:AddNode(wep,"icon16/bomb.png")
		end
		fontcolor(wepnode)
		
		local geticon = killicon.Get(wep)
        local getcol = geticon and geticon[#geticon]
		wepnode.Label:SetTextColor(getcol)

		if enttab.Branches then
			for branchcounts = 1, #enttab.Branches do
				local brancher = enttab.Branches[branchcounts]
				if not brancher then return end

				local brnode = wepnode:AddNode(brancher.PrintName, "icon16/contrast.png")

				fontcolor(brnode)

				brnode.Label:SetTextColor(GAMEMODE.WeaponQualityColors[0][2])

				if brancher.Colors then
					brnode.Label:SetTextColor(brancher.Colors[0])
				end

				brnode.SWEP = GAMEMODE:GetWeaponClassOfQuality(wep, 0, branchcounts)
				brnode.descript = brancher.Desc
				brnode.Frame = frame
				brnode.DoClick = WeaponButtonDoClick
				brnode.Category = addedcat[wep]
			end
		end

		wepnode.SWEP = wep
		wepnode.Frame = frame
		wepnode.DoClick = WeaponButtonDoClick
		wepnode.Category = addedcat[wep]
	end

	for cat, name in pairs(GAMEMODE.ItemCategories) do
		if bannedcats[cat] then continue end
		for t = 1, 6 do
			local tab = frame.WeaponsPanels[cat][t]
			if tab and tab:GetChildNodeCount() == 0 then tab:Remove() end
		end
	end
end

local MakepTrinketsDatabase = function(frame)
	local wid, hei = frame:GetWide(), frame:GetTall()
	local screenscale = BetterScreenScale()
	local title = databasepanel.title

	local trinkets = {}
	local added = {}
	local addedcat = {}

	for _, tab in ipairs(GAMEMODE.Items) do
		if tab.SWEP and not added[tab.SWEP] then
			if GAMEMODE.ZSInventoryItemData[tab.SWEP] then
				trinkets[#trinkets + 1] = tab.SWEP
				added[tab.SWEP] = true
				addedcat[tab.SWEP] = tab.SubCategory
			end
		end
	end

	local tree = vgui.Create("DTree", frame)
	tree:SetSize(wid * 0.4 - 8 * screenscale, hei - title:GetTall() - 20 * screenscale)
	tree:MoveBelow(title, -34 * screenscale)
	tree:SetPadding(1)
	tree:SetBackgroundColor(COLOR_DARKGRAY)
	tree:SetIndentSize(4)
	frame.TrinketsTree = tree
	frame.SetTrinketViewerSWEP = SetTrinketViewerSWEP
	frame.ViewerY = 8
	frame.trinketwep = frame.trinketwep or {}

	for _, cat in pairs(GAMEMODE.ItemSubCategories) do
		frame.trinketwep[cat] = frame.TrinketsTree:AddNode(cat, "icon16/joystick.png")
		fontcolor(frame.trinketwep[cat])
	end
	frame.trinketwep["boss_trinkets"] = frame.TrinketsTree:AddNode(translate.Get("itemsubcat_essences"), "icon16/joystick_delete.png")
	fontcolor(frame.trinketwep["boss_trinkets"])

	for _, id in pairs(trinkets) do
		local trinkit = GAMEMODE.ZSInventoryItemData[id] or id
		local trinketnode

		local icon = trinkit.Icon or "weapon_zs_trinket"
		local kitbl = killicon.Get(icon)
		local theicon = kitbl[1]

		trinketnode = frame.trinketwep[(GAMEMODE.ItemSubCategories[addedcat[id]] or "?")]:AddNode(GAMEMODE:GetTrinketName(trinkit), theicon)
		fontcolor(trinketnode)

		trinketnode.SWEP = id
		trinketnode.Frame = frame
		trinketnode.DoClick = TrinketButtonDoClick

		if trinkit.Upgradable then
			for qual = 1, 3 do
				local newqual = id.."_q"..qual
				local upgid = GAMEMODE.ZSInventoryItemData[newqual]
				local upgtrinketnode

				upgtrinketnode = trinketnode:AddNode(GAMEMODE:GetTrinketName(upgid), theicon)
				fontcolor(upgtrinketnode)

				local colors = GAMEMODE.WeaponQualityColors[qual][1]
				upgtrinketnode.Label:SetTextColor(colors)
				upgtrinketnode.Icon:SetImageColor(colors)

				upgtrinketnode.SWEP = newqual
				upgtrinketnode.Frame = frame
				upgtrinketnode.DoClick = TrinketButtonDoClick
			end
		end
	end

	for _, idb in pairs(GAMEMODE.EssenceTrinkets) do
		local upgidb = GAMEMODE.ZSInventoryItemData[idb]
		local icon = GAMEMODE.ZSInventoryItemData[idb].Icon or "weapon_zs_trinket"
		local kitbl = killicon.Get(icon)
		local theicon = kitbl[1]
		local bossnode

		bossnode = frame.trinketwep["boss_trinkets"]:AddNode(GAMEMODE:GetTrinketName(upgidb), theicon)
		fontcolor(bossnode)

		if upgidb.Upgradable then
            for i = 1, 3 do
                local newqual = idb .. "_q" .. i
                local bossupgdata = GAMEMODE.ZSInventoryItemData[newqual]
                local upgbossnode
                upgbossnode = bossnode:AddNode(GAMEMODE:GetTrinketName(bossupgdata), theicon)
                fontcolor(upgbossnode)
                local upgbosstrinkit = GAMEMODE.ZSInventoryItemData[GAMEMODE:GetBaseItemName(newqual)]
                local upgbossnodecolor = GAMEMODE.WeaponQualityColors[i][upgbosstrinkit.AlternativeColors and 2 or 1]
                upgbossnode.Label:SetTextColor(upgbossnodecolor)
                upgbossnode.Icon:SetImageColor(upgbossnodecolor)
                upgbossnode.SWEP = newqual
                upgbossnode.Frame = frame
                upgbossnode.DoClick = TrinketButtonDoClick
            end
        end

		bossnode.SWEP = idb
		bossnode.Frame = frame
		bossnode.DoClick = TrinketButtonDoClick
	end
end

local texGradDown = surface.GetTextureID("gui/gradient_down")
local statuslist = {}
local function DrawStatusDataBase(mainpan, getstatus)
    local screenscale = BetterScreenScale()
    local statusssize = 48 * screenscale
    local additionalsize = 0
	
	local frame = vgui.Create("DPanel", mainpan)
    frame:SetSize(frame:GetWide(), statusssize + additionalsize / (additionalsize <= 3 and 2.25 or 1.25))
    frame:Dock(TOP)
    frame:DockMargin(0, 0, 0, 2)
    frame.Paint = function()
        local statuscolor = getstatus.Color
        surface.SetDrawColor(statuscolor.r * 0.8, statuscolor.g * 0.8, statuscolor.b * 0.8, statuscolor.a * 0.3)
        surface.DrawRect(3, 5, statusssize * 0.9, statusssize * 0.9)

        if getstatus.Icon then
            surface.SetMaterial(getstatus.Icon)
            surface.SetDrawColor(statuscolor.r * 0.6 + 100, statuscolor.g * 0.6 + 100, statuscolor.b * 0.6 + 100, statuscolor.a * 0.8)
            surface.DrawTexturedRect(3, 5, statusssize * 0.9, statusssize * 0.9)
        end

        draw.SimpleText(getstatus.Name or "", "ZSHUDFontSmallest", statusssize * 1.1, 0, statuscolor)
        draw.DrawText(getstatus.Description or "", "ZSBodyTextFontSlightlyBigger", statusssize * 1.1, statusssize / 2 + draw.GetFontHeight("ZSHUDFontSmallest") / 4, color_white)
    end

    return frame
end

local MakepStatusDatabase = function(frame)
	local wid, hei = frame:GetWide(), frame:GetTall()
	local screenscale = BetterScreenScale()
	local title = databasepanel.title
	local tabhei = 24 * screenscale

    local propsheet = vgui.Create("DEXPropertySheet", frame)
    propsheet:SetSize(wid - 8 * screenscale, hei - tabhei * 3)
    propsheet:SetPos(0, tabhei * 1.25)

	local statuscat = {
		[HUMAN_BUFF] = "Баффы Людей",
		[HUMAN_DEBUFF] = "Дебаффы Людей",
		[ZOMBIE_BUFF] = "Баффы Зомби"
	}
	frame.Lists = {}

	for statcat = 1, 3 do
		local dscroll = vgui.Create("DScrollPanel", propsheet)
        dscroll:CenterHorizontal(0.05)
        dscroll:MoveBelow(title, 16 * screenscale)
        dscroll:SetSize(frame:GetWide() * 0.95, frame:GetTall() * 0.9)

        local propadd = propsheet:AddSheet(statuscat[statcat], dscroll, nil, false, false)
        propadd.Panel:SetPos(0, tabhei)

		frame.Lists[statcat] = dscroll
	end

	local scroller = propsheet:GetChildren()[1]
    local dragbase = scroller:GetChildren()[1]
    local tabs = dragbase:GetChildren()

    GAMEMODE:ConfigureMenuTabs(tabs, tabhei)

	local MakeAllStats = function()
		statuslist = {}
        for _, getstat in pairs(GAMEMODE.StatusDisplays) do
			local lister = frame.Lists[getstat.Category]
            if not statuslist[lister] then
                statuslist[lister] = 0
            end
            statuslist[lister] = (statuslist[lister] or 0) + 1
			if getstat.StatusId ~= "shieldrmarrow" then
            	lister:Add(DrawStatusDataBase(lister, getstat))
			end
        end
    end
	MakeAllStats()
end

function MakepDataBase()
	PlayMenuOpenSound()

	if databasepanel then
		databasepanel:SetAlpha(0)
		databasepanel:AlphaTo(255, 0.15, 0)
		databasepanel:SetVisible(true)
		databasepanel:MakePopup()
		return
	end

	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 800) * screenscale, math.min(ScrH(), 650) * screenscale

	local frame = vgui.Create("DFrame")
	frame:SetDeleteOnClose(false)
	frame:SetSize(wid, hei)
	frame:SetTitle(" ")
	frame:Center()
	databasepanel = frame

	local title = EasyLabel(frame, "Дата База", "ZSHUDFont", color_white)
	title:SetPos(wid * 0.5 - title:GetWide() * 0.5, 14 * screenscale)
	databasepanel.title = title

	if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end

	local tabhei = 24 * screenscale
    local propsheet = vgui.Create("DEXPropertySheet", frame)
    propsheet:SetSize(wid, hei - tabhei * 3)
    propsheet:SetPos(0, tabhei * 3)
    propsheet.Paint = function() end

	local MakeCategory = function(name, icon, script, click)
		local pancat = vgui.Create("DPanel", propsheet)
		pancat:SetPaintBackground(false)
        pancat:SetSize(wid - 5 * screenscale, hei - tabhei * 2.75)

		local cat = propsheet:AddSheet(name, pancat, icon, false, false)
        cat.Panel:SetPos(0, tabhei)

        local tabcat = cat.Tab
		tabcat.OldDoClick = tabcat.OldDoClick or tabcat.DoClick
		tabcat.DoClick = function(me)
            me:OldDoClick(me)
            if not me.AlreadyClicked then
                me.AlreadyClicked = true
				script(pancat)
            end
        end
		if click then
			tabcat:DoClick()
		end

		local scroller = propsheet:GetChildren()[1]
		local dragbase = scroller:GetChildren()[1]
		local tabs = dragbase:GetChildren()

		for _, tab in pairs(tabs) do
			tab:SetFont(screenscale > 0.85 and "ZSHUDFontTiny" or "DefaultFontAA")
			tab.GetTabHeight = function()
				return tabhei + 5 * screenscale
			end
			tab.PerformLayout = function(me)
				me:ApplySchemeSettings()

				if not me.Image then return end

				me.Image:SetPos(7, me:GetTabHeight()/2 - me.Image:GetTall()/2 + 3)
				me.Image:SetImageColor(Color(255, 255, 255, not me:IsActive() and 155 or 255))
			end
		end
	end

	MakeCategory("Предметы", "icon16/package.png", function(category) MakepWeaponsDatabase(category) end, true)
	MakeCategory("Улучшения", "icon16/ruby.png", function(category) MakepTrinketsDatabase(category) end)
	MakeCategory("Статусы", "icon16/wand.png", function(category) MakepStatusDatabase(category) end)

	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.15, 0)
	frame:MakePopup()
end