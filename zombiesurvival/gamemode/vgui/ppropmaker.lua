local GAMEMODE = GM or GAMEMODE

local function PriceSort( i1, i2 )
	local aprice = i1.ShopTabl.Price
	local bprice = i2.ShopTabl.Price

	return aprice < bprice
end

hook.Add("Think", "PropMakerThink", function()
	local pan = GAMEMODE.PropMakerInterface
	if pan and pan:IsValid() and pan:IsVisible() then
		local mx, my = gui.MousePos()
		local x, y = pan:GetPos()
		if mx < x - 16 or my < y - 16 or mx > x + pan:GetWide() + 16 or my > y + pan:GetTall() + 16 then
			pan:SetVisible( false )
		end
	end
end)

local function PropMakerMenuCenterMouse(self)
	local x, y = self:GetPos()
	local w, h = self:GetSize()
	gui.SetMousePos( x + w / 2, y + h / 2 )
end

local function pointslabelThink(self)
	local points = MySelf:GetAmmoCount("scrap")
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points

		self:SetText(translate.Get("pm_scrap") .. points)
		self:SizeToContents()
	end
end

local function PropMakerMenuThink()
end

local function CanBuy(item, pan)
	local interface = pan
	for i = 1, 6 do
		interface = interface:GetParent()
	end

	local ent = MySelf.PropMaker
	local intent = interface.m_PropMaker
	if intent.PropCreating and intent.PropCreating > CurTime() then
		return false
	end

	if GAMEMODE.TestingMode then return true end

	if item.Tier and GAMEMODE.LockItemTiers and not GAMEMODE.ZombieEscape and not GAMEMODE.ObjectiveMap then
		if not GAMEMODE:GetWaveActive() then
			if GAMEMODE:GetWave() + 1 < item.Tier then
				return false
			end
		elseif GAMEMODE:GetWave() < item.Tier then
			return false
		end
	end

	if item.MaxStock and not GAMEMODE:HasItemStocks(item.Signature) then
		return false
	end

	if MySelf:GetAmmoCount("scrap") < math.floor(item.Price * (MySelf.ArsenalDiscount or 1)) and MySelf:GetInfo("zs_enablemetalpointbuy") == "0" then
		return false
	end

	if MySelf:GetAmmoCount("scrap") + (MySelf:GetPoints() * 2) < math.floor(item.Price * (MySelf.ArsenalDiscount or 1)) and MySelf:GetInfo("zs_enablemetalpointbuy") == "1" then
		return false
	end

	return true
end

local function ItemPanelThink(self)
	local itemtab = FindItem(self.ID)
	if itemtab then
		local newstate = CanBuy(itemtab, self)
		if newstate ~= self.m_LastAbleToBuy then
			self.m_LastAbleToBuy = newstate
			if newstate then
				self.NameLabel:SetTextColor(COLOR_WHITE)
				self.NameLabel:InvalidateLayout()
			else
				self.NameLabel:SetTextColor(COLOR_RED)
				self.NameLabel:InvalidateLayout()
			end
		end

		if self.StockLabel then
			local stocks = GAMEMODE:GetItemStocks(self.ID)
			if stocks ~= self.m_LastStocks then
				self.m_LastStocks = stocks

				self.StockLabel:SetText(stocks .. translate.Get("ars_remaining"))
				self.StockLabel:SizeToContents()
				self.StockLabel:AlignRight(10)
				self.StockLabel:SetTextColor(stocks > 0 and COLOR_GRAY or COLOR_RED)
				self.StockLabel:InvalidateLayout()
			end
		end
	end
end

local colBG = Color(20, 20, 20)
local function ItemPanelPaint(self, w, h)
	if self.Hovered or self.On then
		local outline
		if self.m_LastAbleToBuy then
			outline = self.Depressed and COLOR_GREEN or COLOR_DARKGREEN
		else
			outline = self.Depressed and COLOR_RED or COLOR_DARKRED
		end

		draw.RoundedBox(8, 0, 0, w, h, outline)
	end

	if self.ShopTabl.SWEP and MySelf:HasInventoryItem(self.ShopTabl.SWEP) then
		draw.RoundedBox(8, 2, 2, w - 4, h - 4, COLOR_RORANGE)
	end

	draw.RoundedBox(2, 4, 4, w - 8, h - 8, colBG)

	return true
end

local function ViewerStatBarUpdate(viewer, health)

	viewer.ItemStatBars[1].Stat = health
	viewer.ItemStatBars[1].StatMin = 200
	viewer.ItemStatBars[1].StatMax = 1567
	viewer.ItemStatBars[1].BadHigh = false
	viewer.ItemStatBars[1]:SetVisible(true)

	viewer.ItemStats[1]:SetText(translate.Get("pm_durability"))
	viewer.ItemStatValues[1]:SetText(health)
end

function GM:SupplyItemViewerDetailPropMaker(viewer, shoptbl)
	viewer.m_Title:SetText(shoptbl.Name)
	viewer.m_Title:PerformLayout()

	local desctext = ""
	viewer.ModelPanel:SetModel(shoptbl.Model)
	local mins, maxs = viewer.ModelPanel.Entity:GetRenderBounds()
	viewer.ModelPanel:SetCamPos(mins:Distance(maxs) * Vector(1.15, 0.75, 0.5))
	viewer.ModelPanel:SetLookAt((mins + maxs) / 2)
	viewer.m_VBG:SetVisible(true)

	viewer.m_Desc:MoveBelow(viewer.m_VBG, 8)
	viewer.m_Desc:SetFont("ZSBodyTextFont")
	viewer.m_Desc:SetText(desctext)

	ViewerStatBarUpdate(viewer, shoptbl.Health)
end

local function ItemPanelDoClick(self)
	local shoptbl = self.ShopTabl

	local viewer = self.NoPoints and GAMEMODE.PropMakerInterface.TrinketsFrame.Viewer or GAMEMODE.PropMakerInterface.Viewer

	if not shoptbl then return end

	if GAMEMODE.AlwaysQuickBuy then
		RunConsoleCommand( "zs_propshopbuy", self.ID, self.NoPoints and "scrap" )
		return
	end

	for _, v in pairs(self:GetParent():GetChildren()) do
		v.On = false
	end
	self.On = true

	GAMEMODE:SupplyItemViewerDetailPropMaker(viewer, shoptbl)

	local screenscale = BetterScreenScale()

	local purb = viewer.m_PurchaseB
	purb.ID = self.ID
	purb.DoClick = function() RunConsoleCommand("zs_propshopbuy", self.ID, self.NoPoints and "scrap") end
	purb:SetPos(canammo and viewer:GetWide() / 4 - viewer:GetWide() / 8 - 20 or viewer:GetWide() / 4, viewer:GetTall() - 64 * screenscale)
	purb:SetVisible(true)

	local purl = viewer.m_PurchaseLabel
	purl:SetPos(purb:GetWide() / 2 - purl:GetWide() / 2, purb:GetTall() * 0.35 - purl:GetTall() * 0.5)
	purl:SetVisible(true)

	local ppurbl = viewer.m_PurchasePrice
	local price = self.NoPoints and math.ceil(GAMEMODE:PointsToScrap(shoptbl.Worth)) or math.floor(shoptbl.Worth * (MySelf.ArsenalDiscount or 1))
	ppurbl:SetText(price .. " " .. translate.Get("pm_scrapcost"))
	ppurbl:SizeToContents()
	ppurbl:SetPos(purb:GetWide() / 2 - ppurbl:GetWide() / 2, purb:GetTall() * 0.75 - ppurbl:GetTall() * 0.5)
	ppurbl:SetVisible(true)
end

function GAMEMODE:AddPShopItem(list, i, tab, issub, nopointshop)
	local screenscale = BetterScreenScale()

	local nottrinkets = tab.Category ~= ITEMCAT_TRINKETS
	local missing_skill = tab.SkillRequirement and not MySelf:IsSkillActive(tab.SkillRequirement) and not GAMEMODE.TestingMode
	local wid = 333

	local itempan = vgui.Create("DButton")
	itempan:SetText("")
	itempan:SetSize(wid * screenscale, (nottrinkets and 100 or 60) * screenscale)
	itempan.ID = tab.Signature or i
	itempan.NoPoints = nopointshop
	itempan.ShopTabl = tab
	itempan.Think = ItemPanelThink
	itempan.Paint = ItemPanelPaint
	itempan.DoClick = ItemPanelDoClick

	itempan.OnCursorEntered = function(itempan)
        local itemid = FindItem(itempan.ID)
        if not itemid then
            return
        end
        if GAMEMODE.AlwaysQuickBuy then
            local viewer = nopointshop and self.PropMakerInterface.TrinketsFrame.Viewer or self.PropMakerInterface.Viewer
            GAMEMODE:SupplyItemViewerDetailPropMaker(viewer, itemid)
        end
    end

	itempan.DoRightClick = function()
		local menu = ZSDermaMenu(itempan)

		local buy = menu:AddOption(translate.Get("pm_buy"), function() RunConsoleCommand( "zs_propshopbuy", itempan.ID, itempan.NoPoints and "scrap" ) end)
		buy:SetIcon(GAMEMODE.ItemCategoryIcons[tab.Category])

		local fbuy = menu:AddOption(translate.Get("ars_copyid"), function() SetClipboardText(itempan.ID) end)
		fbuy:SetIcon("icon16/script.png")

		menu:Open()
	end
	list:AddItem(itempan)

	if nottrinkets then
		local mdlframe = vgui.Create("DPanel", itempan)
		mdlframe:SetSize(wid/2 * screenscale, 90/2 * screenscale)
		mdlframe:SetPos(wid/4 * screenscale, 100/5 * screenscale)
		mdlframe:SetMouseInputEnabled(false)
		mdlframe.Paint = function() end

		local kitbl = killicon.Get(tab.SWEP or tab.Model)
		if kitbl then
			self:AttachKillicon(kitbl, itempan, mdlframe, tab.Category == ITEMCAT_AMMO, missing_skill)
		elseif tab.Model then
			if tab.Model then
				local mdlpanel = vgui.Create("DModelPanel", mdlframe)
				mdlpanel:SetSize(mdlframe:GetSize())
				mdlpanel:SetModel(tab.Model)
				local mins, maxs = mdlpanel.Entity:GetRenderBounds()
				mdlpanel:SetCamPos(mins:Distance(maxs) * Vector(0.75, 0.75, 0.5))
				mdlpanel:SetLookAt((mins + maxs) / 2)
			end
		end
	end

	if tab.SWEP or tab.Countables then
		local counter = vgui.Create("ItemAmountCounter", itempan)
		counter:SetItemID(i)
	end

	local name = tab.Name or ""
	local namelab = EasyLabel(itempan, name, "ZSHUDFontSmaller", COLOR_WHITE)
	namelab:SetPos(12 * screenscale, itempan:GetTall() * (nottrinkets and 0.8 or 0.7) - namelab:GetTall() * 0.5)
	if missing_skill then
		namelab:SetAlpha(30)
	end
	itempan.NameLabel = namelab

	local alignri = (issub and (320 + 32) or (nopointshop and 32 or 20)) * screenscale

	local pricelabel = EasyLabel(itempan, "", "ZSHUDFontTiny")
	if missing_skill then
		pricelabel:SetTextColor(COLOR_RED)
		pricelabel:SetText(GAMEMODE.Skills[tab.SkillRequirement].Name)
	else
		local points = math.floor(tab.Price * (MySelf.ArsenalDiscount or 1))
		local price = tostring(points)
		if nopointshop then
			price = tostring(math.ceil(self:PointsToScrap(tab.Price)))
		end
		pricelabel:SetText(price .. " " .. translate.Get("pm_scrapcost"))
	end
	pricelabel:SizeToContents()
	pricelabel:AlignRight(alignri)

	if tab.MaxStock then
		local stocklabel = EasyLabel(itempan, tab.MaxStock .. translate.Get("pm_remaining"), "ZSHUDFontTiny")
		stocklabel:SizeToContents()
		stocklabel:AlignRight(alignri)
		stocklabel:SetPos(itempan:GetWide() - stocklabel:GetWide(), itempan:GetTall() * 0.45 - stocklabel:GetTall() * 0.5)
		itempan.StockLabel = stocklabel
	end
	pricelabel:SetPos(
		itempan:GetWide() - pricelabel:GetWide() - 12 * screenscale,
		itempan:GetTall() * (nottrinkets and 0.15 or 0.3) - pricelabel:GetTall() * 0.5
	)

	if missing_skill or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
		itempan:SetAlpha(160)
	end

	if not nottrinkets and tab.SubCategory then
		local catlabel = EasyLabel(itempan, GAMEMODE.ItemSubCategories[tab.SubCategory], "ZSBodyTextFont")
		catlabel:SizeToContents()
		catlabel:SetPos(10, itempan:GetTall() * 0.3 - catlabel:GetTall() * 0.5)
	end

	return itempan
end

function GAMEMODE:OpenPropMakerMenu( ent )
	if self.PropMakerInterface and self.PropMakerInterface:IsValid() then
		self.PropMakerInterface:Remove()
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
	frame.CenterMouse = PropMakerMenuCenterMouse
	frame.Think = PropMakerMenuThink
	self.PropMakerInterface = frame

	frame.m_PropMaker = ent

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16)

	local title = EasyLabel(topspace, translate.Get("prop_maker"), "ZSHUDFontSmall", COLOR_WHITE)
	title:CenterHorizontal()
	local subtitle = EasyLabel(topspace, translate.Get("prop_subtitle"), "ZSHUDFontTiny", COLOR_WHITE)
	subtitle:CenterHorizontal()
	subtitle:MoveBelow(title, 4)

	local _, y = subtitle:GetPos()
	topspace:SetTall(y + subtitle:GetTall() + 4)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()

	local fastbuy = vgui.Create("DEXCheckBoxLabel", topspace)
	fastbuy:SetText(translate.Get("pm_qb"))
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

	local _, y = subtitle:GetPos()
	topspace:SetTall(y + subtitle:GetTall() + 4)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())

	local pointslabel = EasyLabel(bottomspace, "Points to spend: 0", "ZSHUDFontTiny", COLOR_GREEN)
	pointslabel:AlignTop(4)
	pointslabel:AlignLeft(8)
	pointslabel.Think = pointslabelThink

	local lab = EasyLabel(bottomspace, " ", "ZSHUDFontTiny")
	lab:AlignTop(4)
	lab:AlignRight(4)
	frame.m_SpacerBottomLabel = lab

	_, y = lab:GetPos()
	bottomspace:SetTall(y + lab:GetTall() + 4)
	bottomspace:AlignBottom(8)
	bottomspace:CenterHorizontal()

	local __, topy = topspace:GetPos()
	local ___, boty = bottomspace:GetPos()

	local propertysheet = vgui.Create("DEXPropertySheet", frame)
	propertysheet:SetSize(wid - 320 * screenscale, boty - topy - 8 - topspace:GetTall())
	propertysheet:MoveBelow(topspace, 4)
	propertysheet:SetPadding(1)
	propertysheet:CenterHorizontal(0.35)

	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.PropMakerShop then
				hasitems = true
				break
			end
		end

		if hasitems then
			local tabpane = vgui.Create("DPanel", propertysheet)
			tabpane.Paint = function() end
			tabpane.Grids = {}
			tabpane.Buttons = {}

			local usecats = catid == ITEMCAT_GUNS or catid == ITEMCAT_MELEE or catid == ITEMCAT_TRINKETS
			local trinkets = catid == ITEMCAT_TRINKETS
			local offset = 64 * screenscale

			local itemframe = vgui.Create("DScrollPanel", tabpane)
			itemframe:SetSize(propertysheet:GetWide(), propertysheet:GetTall() - (usecats and (32 + offset) or 32))
			itemframe:SetPos(0, usecats and offset or 0)

			local mkgrid = function()
				local list = vgui.Create("DGrid", itemframe)
				list:SetPos(0, 0)
				list:SetSize(propertysheet:GetWide() - 312, propertysheet:GetTall())
				list:SetCols(2)
				list:SetColWide(333 * screenscale)
				list:SetRowHeight((trinkets and 64 or 100) * screenscale)

				return list
			end

			local subcats = GAMEMODE.ItemSubCategories
			if usecats then
				local ind, tbn = 1
				for i = ind, (trinkets and #subcats or 5) do
					local ispacer = trinkets and ((i-1) % 3)+1 or i
					local start = i == (catid == ITEMCAT_GUNS and 2 or ind)

					tbn = EasyButton(tabpane, trinkets and subcats[i] or ("Tier " .. i), 2, 8)
					tbn:SetFont(trinkets and "ZSHUDFontSmallest" or "ZSHUDFontSmall")
					tbn:SetAlpha(start and 255 or 70)
					tbn:AlignRight((trinkets and -35 or -15) * screenscale -
						(ispacer - ind) * (ind == 1 and (trinkets and 190 or 110) or 145) * screenscale
					)
					tbn:AlignTop(trinkets and i <= 3 and 0 or trinkets and 28 or 16)
					tbn:SetContentAlignment(5)
					tbn:SizeToContents()
					tbn.DoClick = function(me)
						for k, v in pairs(tabpane.Grids) do
							v:SetVisible(k == i)
							tabpane.Buttons[k]:SetAlpha(k == i and 28 or 16)
						end
					end

					tabpane.Grids[i] = mkgrid()
					tabpane.Grids[i]:SetVisible(start)
					tabpane.Buttons[i] = tbn
				end
			else
				tabpane.Grid = mkgrid()
			end

			local sheet = propertysheet:AddSheet(catname, tabpane, GAMEMODE.ItemCategoryIcons[catid], false, false)
			sheet.Panel:SetPos(0, tabhei + 2)

			for i, tab in ipairs(GAMEMODE.Items) do
				if tab.PropMakerShop and tab.Category == catid then
					self:AddPShopItem(
						trinkets and tabpane.Grids[tab.SubCategory] or tabpane.Grid or tabpane.Grids[tab.Tier or 1],
						i, tab
					)
				end
			end 

			local scroller = propertysheet:GetChildren()[1]
			local dragbase = scroller:GetChildren()[1]
			local tabs = dragbase:GetChildren()

			self:ConfigureMenuTabs(tabs, tabhei)
		end
	end

	self:CreateItemInfoViewer(frame, propertysheet, topspace, bottomspace, MENU_POINTSHOP)

	frame:MakePopup()
	frame:CenterMouse()
end

