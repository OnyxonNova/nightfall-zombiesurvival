GM.FavoriteWeapons = {}
hook.Add( "Initialize", "LoadFavoriteWeapons", function()
	if file.Exists( GAMEMODE.FavoriteFile, "DATA" ) then
		GAMEMODE.FavoriteWeapons = Deserialize( file.Read( GAMEMODE.FavoriteFile ) ) or {}
	end
end)

local function SaveWeaponFavorite( swepclass )
	if not table.HasValue(GAMEMODE.FavoriteWeapons, swepclass) then
		GAMEMODE.FavoriteWeapons[#GAMEMODE.FavoriteWeapons + 1] = swepclass

		file.Write(GAMEMODE.FavoriteFile, Serialize(GAMEMODE.FavoriteWeapons))
		if swepclass and GAMEMODE.ArsenalInterface.Favorites then
			GAMEMODE:AddShopItem(GAMEMODE.ArsenalInterface.Favorites.Grid, swepclass, GAMEMODE.Items[swepclass])
		end
	end
end

local function DeleteWeaponFavorite(swepclass)
	for i, classname in pairs(GAMEMODE.FavoriteWeapons) do
		if GAMEMODE.Items[swepclass] and GAMEMODE.Items[swepclass].Signature == classname then
			table.remove(GAMEMODE.FavoriteWeapons, i)
			file.Write(GAMEMODE.FavoriteFile, Serialize(GAMEMODE.FavoriteWeapons))
			if GAMEMODE.ArsenalInterface.Favorites then
				for i, item in pairs(GAMEMODE.ArsenalInterface.Favorites.Grid:GetItems()) do
					if item.ID == swepclass then
						GAMEMODE.ArsenalInterface.Favorites.Grid:RemoveItem(item)
					end
				end
			end
		end
	end
end

local function pointslabelThink(self)
	local points = MySelf:GetPoints()
	if self.m_LastPoints ~= points then
		self.m_LastPoints = points

		self:SetText(translate.Get("ars_pointsm")..points)
		self:SizeToContents()
	end
end

hook.Add("Think", "ArsenalMenuThink", function()
	local pan = GAMEMODE.ArsenalInterface
	if pan and pan:IsValid() and pan:IsVisible() then
		local mx, my = gui.MousePos()
		local x, y = pan:GetPos()
		if mx < x - 16 or my < y - 16 or mx > x + pan:GetWide() + 16 or my > y + pan:GetTall() + 16 then
			pan:SetVisible(false)
		end
	end
end)

local function ArsenalMenuCenterMouse(self)
	local x, y = self:GetPos()
	local w, h = self:GetSize()
	gui.SetMousePos(x + w / 2, y + h / 2)
end

local function worthmenuDoClick()
	MakepWorth()
	GAMEMODE.ArsenalInterface:Close()
end

local function CanBuy(item, pan)
	if GAMEMODE.TestingMode then return true end
	
	if item.Tier and GAMEMODE.LockItemTiers and not GAMEMODE.ZombieEscape and not GAMEMODE.ObjectiveMap then
		if not GAMEMODE:GetWaveActive() then -- We can buy during the wave break before hand.
			if GAMEMODE:GetWave() + (1 + (GAMEMODE.LockItemsTierPlus or 0)) < item.Tier then
				return false
			end
		elseif GAMEMODE:GetWave() + (GAMEMODE.LockItemsTierPlus or 0) < item.Tier then
			return false
		end
	end

	if item.MaxStock and not GAMEMODE:HasItemStocks(item.Signature) then
		return false
	end

	if not pan.NoPoints and MySelf:GetPoints() < math.floor(item.Price * (MySelf.ArsenalDiscount or 1)) then
		return false
	elseif pan.NoPoints and MySelf:GetAmmoCount("scrap") < math.ceil(GAMEMODE:PointsToScrap(item.Price)) and MySelf:GetInfo("zs_enablemetalpointbuy") == "0" then
		return false
	end

	if pan.NoPoints and MySelf:GetAmmoCount("scrap") + (MySelf:GetPoints() * 2) < math.ceil(GAMEMODE:PointsToScrap(item.Price)) and MySelf:GetInfo("zs_enablemetalpointbuy") == "1" then
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

				self.StockLabel:SetText(stocks..translate.Get("ars_remaining"))
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
	elseif self.ShopTabl.SWEP and MySelf:HasInventoryItemTier(self.ShopTabl.SWEP) and ITEMCAT_TRINKETS then
		local alternate = GAMEMODE.ZSInventoryItemData[self.ShopTabl.SWEP].AlternativeColors
		draw.RoundedBox(8, 2, 2, w - 4, h - 4, GAMEMODE.WeaponQualityColors[MySelf:GetInventoryItemTier(self.ShopTabl.SWEP) - 1 + 1][alternate and 2 or 1])
	end
	
	draw.RoundedBox(2, 4, 4, w - 8, h - 8, colBG)

	return true
end

function GM:HasPurchaseableAmmo(sweptable)
	if sweptable.Primary and self.AmmoToPurchaseNames[sweptable.Primary.Ammo] then
		return true
	end
end

local function ItemPanelDoClick(self)
	local shoptbl = self.ShopTabl
	local viewer = self.NoPoints and GAMEMODE.RemantlerInterface.TrinketsFrame.Viewer or GAMEMODE.ArsenalInterface.Viewer

	if not shoptbl then return end

	local sweptable = GAMEMODE.ZSInventoryItemData[shoptbl.SWEP] or weapons.Get(shoptbl.SWEP)
    if not sweptable and shoptbl.Category == ITEMCAT_AMMO then
        RunConsoleCommand("zs_pointsshopbuy", self.ID, self.NoPoints and "scrap")
        return
    end

	local remantler = GAMEMODE.RemantlerInterface and GAMEMODE.RemantlerInterface:IsVisible()
    local trinketupg = GAMEMODE.ZSInventoryItemData[shoptbl.SWEP] and sweptable.Upgradable and (MySelf:HasInventoryItemTier(shoptbl.SWEP) or MySelf:HasInventoryItem(shoptbl.SWEP))
    if not sweptable or GAMEMODE.AlwaysQuickBuy then
        if shoptbl.Category == ITEMCAT_TRINKETS and trinketupg and remantler then
            local nextqual = math.min(MySelf:GetInventoryItemTier(shoptbl.SWEP), 2)
            local toupg = nextqual < 1 and shoptbl.SWEP or GAMEMODE:GetBaseItemName(shoptbl.SWEP) .. "_q" .. nextqual
            RunConsoleCommand("zs_upgrade_trinket", toupg)

			timer.Simple(0.25, function() GAMEMODE:SupplyItemViewerDetail(viewer, sweptable, shoptbl) end)

            return
        end
        RunConsoleCommand("zs_pointsshopbuy", self.ID, self.NoPoints and "scrap")

		if GAMEMODE.ZSInventoryItemData[shoptbl.SWEP] and sweptable.Upgradable then
			timer.Simple(0.25, function() GAMEMODE:SupplyItemViewerDetail(viewer, sweptable, shoptbl) end)
		end
    end

	for _, v in pairs(self:GetParent():GetChildren()) do
		v.On = false
	end
	self.On = true

	GAMEMODE:SupplyItemViewerDetail(viewer, sweptable, shoptbl)

	local screenscale = BetterScreenScale()
	local canammo = GAMEMODE:HasPurchaseableAmmo(sweptable)
	
	local favbut = viewer.m_FavB
	local favl = viewer.m_FavLabel

	favl:SetText(table.HasValue(GAMEMODE.FavoriteWeapons, self.ID) and translate.Get("ars_unfav") or translate.Get("ars_fav"))
	favl:SizeToContents()
	favbut.ID = self.ID
	favbut:SetPos(viewer:GetWide() * 0.25, viewer:GetTall() - 128 * screenscale)
	favbut.DoClick = function() 
		if table.HasValue(GAMEMODE.FavoriteWeapons, self.ID) then
			DeleteWeaponFavorite(self.ID)
			favl:SetText(translate.Get("ars_fav"))
		else
			SaveWeaponFavorite(self.ID)
			favl:SetText(translate.Get("ars_unfav"))
		end
		favl:SizeToContents()
		favl:SetPos(favbut:GetWide() * 0.5 - favl:GetWide() * 0.5, favbut:GetTall() * 0.5 - favl:GetTall() * 0.5)
	end
	
	favl:SetPos(favbut:GetWide() * 0.5 - favl:GetWide() * 0.5, favbut:GetTall() * 0.5 - favl:GetTall() * 0.5)
	favl:SetVisible(true)
	favbut:SetVisible(true)

	local purb = viewer.m_PurchaseB
	purb.ID = self.ID
	purb.DoClick = function() 
		RunConsoleCommand("zs_pointsshopbuy", self.ID, self.NoPoints and "scrap")
		if shoptbl.Category == ITEMCAT_TRINKETS then 
			timer.Simple(0.25, function() ItemPanelDoClick(self) end)
		end
	end
	purb:SetPos(canammo and viewer:GetWide() / 4 - viewer:GetWide() / 8 - 20 or viewer:GetWide() / 4, viewer:GetTall() - 64 * screenscale)
	purb:SetVisible(true)

	local purl = viewer.m_PurchaseLabel
	purl:SetPos(purb:GetWide() / 2 - purl:GetWide() / 2, purb:GetTall() * 0.35 - purl:GetTall() * 0.5)
	purl:SetVisible(true)

	local ppurbl = viewer.m_PurchasePrice
	local price = self.NoPoints and math.ceil(GAMEMODE:PointsToScrap(shoptbl.Worth)) or math.floor(shoptbl.Worth * (MySelf.ArsenalDiscount or 1))
	ppurbl:SetText(price .. (self.NoPoints and translate.Get("ars_scrap") or translate.Get("ars_points")))
	ppurbl:SizeToContents()
	ppurbl:SetPos(purb:GetWide() / 2 - ppurbl:GetWide() / 2, purb:GetTall() * 0.75 - ppurbl:GetTall() * 0.5)
	ppurbl:SetVisible(true)

	purb = viewer.m_AmmoB
	if canammo then
		purb.AmmoType = GAMEMODE.AmmoToPurchaseNames[sweptable.Primary.Ammo]
		purb.DoClick = function() RunConsoleCommand("zs_pointsshopbuy", "ps_"..purb.AmmoType) end
	end
	purb:SetPos(viewer:GetWide() * (3/4) - purb:GetWide() / 2, viewer:GetTall() - 64 * screenscale)
	purb:SetVisible(canammo)

	purl = viewer.m_AmmoL
	purl:SetPos(purb:GetWide() / 2 - purl:GetWide() / 2, purb:GetTall() * 0.35 - purl:GetTall() * 0.5)
	purl:SetVisible(canammo)

	ppurbl = viewer.m_AmmoPrice
	price = math.floor(6 * (MySelf.ArsenalDiscount or 1))
	ppurbl:SetText(price .. translate.Get("ars_points"))
	ppurbl:SizeToContents()
	ppurbl:SetPos(purb:GetWide() / 2 - ppurbl:GetWide() / 2, purb:GetTall() * 0.75 - ppurbl:GetTall() * 0.5)
	ppurbl:SetVisible(canammo)
end

local function ArsenalMenuThink(self)
end

function GM:AttachKillicon(kitbl, itempan, mdlframe, ammo, missing_skill)
	local function imgAdj(img, maxWidth, maxHeight)
		img:SizeToContents()
		local width, height = img:GetSize()
		local aspectRatio = width / height
		local maxAspectRatio = maxWidth / maxHeight
		if aspectRatio > maxAspectRatio then
			img:SetSize(maxWidth, maxWidth / aspectRatio)
		else
			img:SetSize(maxHeight * aspectRatio, maxHeight)
		end

		img:Center()
	end

	if #kitbl == 2 then
		local img = vgui.Create("DImage", mdlframe)
		img:SetImage(kitbl[1])
		if kitbl[2] then
			img:SetImageColor(kitbl[2])
		end
		if missing_skill then img:SetAlpha(50) end

		imgAdj(img, mdlframe:GetWide() - 6, mdlframe:GetTall() - 3)
		if ammo then img:SetSize(img:GetWide() + 3, img:GetTall() + 3) end

		img:Center()
		itempan.m_Icon = img
	elseif #kitbl == 3 then
		local label = vgui.Create("DLabel", mdlframe)
		label:SetText(kitbl[2])
		label:SetFont(kitbl[1] .. "pa" or DefaultFont)
		label:SetTextColor(kitbl[3] or color_white)
		label:SizeToContents()
		label:SetContentAlignment(8)
		label:DockMargin(0, label:GetTall() * 0.05, 0, 0)
		label:Dock(FILL)
		itempan.m_Icon = label
	end

	if missing_skill then
		local img = vgui.Create("DImage", mdlframe)
		img:SetImage("zombiesurvival/padlock.png")
		img:SetImageColor(Color(255, 30, 30))
		imgAdj(img, mdlframe:GetWide(), mdlframe:GetTall())

		img:Center()
		itempan.m_Padlock = img
	end
end

function GM:AddShopItem(list, i, tab, issub, nopointshop)
	local screenscale = BetterScreenScale()

	local nottrinkets = tab.Category ~= ITEMCAT_TRINKETS
	local missing_skill = tab.SkillRequirement and not MySelf:IsSkillActive(tab.SkillRequirement) and not GAMEMODE.TestingMode
	local wid = 333

	local itempan = vgui.Create("DButton")
	itempan:SetText("")
	itempan:SetSize(wid * screenscale, 100 * screenscale)
	itempan.ID = tab.Signature or i
	itempan.NoPoints = nopointshop
	itempan.ShopTabl = tab
	itempan.Cat = tab.Category
	itempan.Think = ItemPanelThink
	itempan.Paint = ItemPanelPaint
	itempan.DoClick = ItemPanelDoClick

	itempan.OnCursorEntered = function(itempan)
        local itemid = FindItem(itempan.ID)
        if not itemid then
            return
        end
        local update = GAMEMODE.ZSInventoryItemData[tab.SWEP] or weapons.Get(tab.SWEP)
        if GAMEMODE.AlwaysQuickBuy then
            local viewer = nopointshop and self.RemantlerInterface.TrinketsFrame.Viewer or self.ArsenalInterface.Viewer
            GAMEMODE:SupplyItemViewerDetail(viewer, update, itemid)
        end
    end

	itempan.DoRightClick = function()
		local menu = ZSDermaMenu(itempan)
		local getwep = GAMEMODE.ZSInventoryItemData[tab.SWEP] or weapons.Get(tab.SWEP)

		local buy
		if tab.Category == ITEMCAT_AMMO then
			buy = menu:AddOption(translate.Get("ars_buy").." x5", function() timer.Create("x5ammo".. math.random(20), 0, 5, function() RunConsoleCommand("zs_pointsshopbuy", itempan.ID, itempan.NoPoints and "scrap") end) end)
			buy:SetIcon("icon16/folder.png")
		else
			local titlename = tab.Category == ITEMCAT_AMMO and tab.Name or (GAMEMODE.ZSInventoryItemData[tab.SWEP] and translate.Get(getwep.PrintName) or getwep.PrintName) or ""
			buy = menu:AddOption(translate.Get("ars_buy").. " " .. titlename, function()
				RunConsoleCommand("zs_pointsshopbuy", itempan.ID, itempan.NoPoints and "scrap")

				local viewer = nopointshop and self.RemantlerInterface.TrinketsFrame.Viewer or self.ArsenalInterface.Viewer
				local update = GAMEMODE.ZSInventoryItemData[tab.SWEP] or weapons.Get(tab.SWEP)

				timer.Simple(0.25, function() GAMEMODE:SupplyItemViewerDetail(viewer, update, FindItem(itempan.ID)) end)
			end)
			buy:SetIcon(GAMEMODE.ItemCategoryIcons[tab.Category])
		end

		if not nopointshop then
			local isfav = table.HasValue(GAMEMODE.FavoriteWeapons, itempan.ID)
			local fav = menu:AddOption(isfav and translate.Get("ars_unfav") or translate.Get("ars_addfav"), function() if isfav then DeleteWeaponFavorite(itempan.ID) else SaveWeaponFavorite(itempan.ID) end end)
			fav:SetIcon(isfav and "icon16/heart_delete.png" or "icon16/heart_add.png")
		end

		local fbuy = menu:AddOption(translate.Get("ars_copyid"), function() SetClipboardText(itempan.ID) end)
		fbuy:SetIcon("icon16/script.png")

		if not (tab.Category == ITEMCAT_AMMO or tab.Category == ITEMCAT_TRINKETS) then
			local branches = getwep.Branches
			if getwep and branches then
				menu:AddSpacer()
				for branchnum, branchdata in ipairs(branches) do
					local branch = menu:AddOption(translate.Get("ars_buy").." "..branchdata.PrintName, function() RunConsoleCommand("zs_branchbuy", itempan.ID, branchnum) end)
					branch:SetIcon(GAMEMODE.ItemCategoryIcons[tab.Category])
				end
			end
		end

		menu:Open()
	end
	list:AddItem(itempan)

	local mdlframe = vgui.Create("DPanel", itempan)
	mdlframe:SetSize(wid/2 * screenscale, 100/2 * screenscale)
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

	local name = GAMEMODE.ZSInventoryItemData[tab.SWEP] and translate.Get(tab.Name) or tab.Name or ""
	local namelab = EasyLabel(itempan, name, "ZSHUDFontSmaller", COLOR_WHITE)
	namelab:SetPos(12 * screenscale, itempan:GetTall() * 0.8 - namelab:GetTall() * 0.5)
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
		pricelabel:SetText(price..(nopointshop and translate.Get("ars_scrap") or translate.Get("ars_points")))
	end
	
	local weapon = weapons.Get(tab.SWEP)
	if weapon and (weapon.ResupplyAmmoType or weapon.TurretAmmoType or weapon.Primary.Ammo) then
		if weapon.Secondary.Ammo == "dummy" then
			local ammo = weapon.ResupplyAmmoType or weapon.TurretAmmoType or weapon.Primary.Ammo
			local AMMO = vgui.Create("DImage", itempan)
			AMMO:SetSize(42 * screenscale, 42 * screenscale)
			AMMO:AlignLeft(40 * screenscale)
			AMMO:AlignTop(20 * screenscale)
			local kit = killicon.Get(GAMEMODE.AmmoIcons[string.lower(ammo)])

			if kit then
				AMMO:SetImage(kit[1])
				if kit[2] then
					AMMO:SetImageColor(kit[2])
				end
			end
		else
			local primaryammo = weapon.Primary.Ammo
			local secondaryammo = weapon.Secondary.Ammo

			local primammo = vgui.Create("DImage", itempan)
			primammo:SetSize(42 * screenscale, 42 * screenscale)
			primammo:AlignLeft(10 * screenscale)
			primammo:AlignTop(20 * screenscale)
			local primkit = killicon.Get(GAMEMODE.AmmoIcons[string.lower(primaryammo)])

			local secondammo = vgui.Create("DImage", itempan)
			secondammo:SetSize(42 * screenscale, 42 * screenscale)
			secondammo:AlignLeft(55 * screenscale)
			secondammo:AlignTop(20 * screenscale)
			local secondkit = killicon.Get(GAMEMODE.AmmoIcons[string.lower(secondaryammo)])

			if primkit and secondkit then
				primammo:SetImage(primkit[1])
				secondammo:SetImage(secondkit[1])
				if primkit[2] and secondkit[2] then
					primammo:SetImageColor(primkit[2])
					secondammo:SetImageColor(secondkit[2])
				end
			end
		end
	end

	pricelabel:SizeToContents()
	pricelabel:AlignRight(alignri)

	if tab.MaxStock then
		local stocklabel = EasyLabel(itempan, tab.MaxStock..translate.Get("ars_remaining"), "ZSHUDFontTiny")
		stocklabel:SizeToContents()
		stocklabel:AlignRight(alignri)
		stocklabel:SetPos(itempan:GetWide() - stocklabel:GetWide(), itempan:GetTall() * 0.40 - stocklabel:GetTall() * 0.5)
		itempan.StockLabel = stocklabel
	end
	pricelabel:SetPos(
		itempan:GetWide() - pricelabel:GetWide() - 12 * screenscale,
		itempan:GetTall() * 0.15 - pricelabel:GetTall() * 0.5
	)

	if missing_skill or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
		itempan:SetAlpha(160)
	end

	if not nottrinkets and tab.SubCategory then
		local catlabel = EasyLabel(itempan, GAMEMODE.ItemSubCategories[tab.SubCategory], "ZSHUDFontTiny")
		catlabel:SizeToContents()
		catlabel:SetPos(10, itempan:GetTall() * 0.15 - catlabel:GetTall() * 0.5)
	end

	return itempan
end

MENU_POINTSHOP = 1
MENU_WORTH = 2
MENU_REMANTLER = 3
MENU_ITEMDISPLAY = 4

function GM:CreateItemInfoViewer(frame, propertysheet, topspace, bottomspace, menutype)
	local __, topy = topspace:GetPos()
	local ___, boty = bottomspace:GetPos()
	local screenscale = BetterScreenScale()

	local worthmenu = menutype == MENU_WORTH
	local remantler = menutype == MENU_REMANTLER
	local cartdisplay = menutype == MENU_ITEMDISPLAY

	local viewer = vgui.Create("DPanel", frame)

	viewer:SetPaintBackground(false)
	viewer:SetSize(
		(remantler or cartdisplay) and 320 * screenscale
			or frame:GetWide() - propertysheet:GetWide() + (worthmenu and 312 or -16) * screenscale,
		boty - topy - 8 - topspace:GetTall() - (worthmenu and 32 or 0)
	)

	viewer:MoveBelow(topspace, 4 + ((worthmenu or cartdisplay) and 32 or 0))
	if menutype == MENU_POINTSHOP or worthmenu then
		viewer:MoveRightOf(propertysheet, 8 - (worthmenu and 328 or 0) * screenscale)
	else
		viewer:Dock(RIGHT)
	end
	frame.Viewer = viewer

	self:CreateItemViewerGenericElems(viewer)

	local purchaseb = vgui.Create("DButton", viewer)
	purchaseb:SetText("")
	purchaseb:SetSize(viewer:GetWide() / 2, 54 * screenscale)
	purchaseb:SetVisible(false)
	viewer.m_PurchaseB = purchaseb

	local namelab = EasyLabel(purchaseb, translate.Get("ars_purchase"), "ZSBodyTextFontBig", COLOR_WHITE)
	namelab:SetVisible(false)
	viewer.m_PurchaseLabel = namelab

	local pricelab = EasyLabel(purchaseb, "", "ZSBodyTextFont", COLOR_WHITE)
	pricelab:SetVisible(false)
	viewer.m_PurchasePrice = pricelab

	local ammopb = vgui.Create("DButton", viewer)
	ammopb:SetText("")
	ammopb:SetSize(viewer:GetWide() / 4, 54 * screenscale)
	ammopb:SetVisible(false)
	viewer.m_AmmoB = ammopb

	namelab = EasyLabel(ammopb, translate.Get("ars_ammo"), "ZSBodyTextFontBig", COLOR_WHITE)
	namelab:SetVisible(false)
	viewer.m_AmmoL = namelab

	pricelab = EasyLabel(ammopb, "", "ZSBodyTextFont", COLOR_WHITE)
	pricelab:SetVisible(false)
	viewer.m_AmmoPrice = pricelab

	local favb = vgui.Create("DButton", viewer)
	favb:SetText("")
	favb:SetSize(viewer:GetWide() / 2, 34 * screenscale)
	favb:SetVisible(false)
	viewer.m_FavB = favb

	local favlab = EasyLabel(favb, " ", "ZSBodyTextFont", COLOR_WHITE)
	favlab:SetVisible(false)
	viewer.m_FavLabel = favlab
end

local function RemantlerOpen()
    GAMEMODE.ArsenalInterface:Close()
    GAMEMODE:OpenRemantlerMenu(true)
end

function GM:OpenArsenalMenu()
	if self.ArsenalInterface and self.ArsenalInterface:IsValid() then
		self.ArsenalInterface:SetVisible(true)
		self.ArsenalInterface:CenterMouse()
		return
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
	frame.CenterMouse = ArsenalMenuCenterMouse
	frame.Think = ArsenalMenuThink
	self.ArsenalInterface = frame

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16)

	local title = EasyLabel(topspace, translate.Get("ars_title"), "ZSHUDFontSmall", COLOR_WHITE)
	title:CenterHorizontal()
	local subtitle = EasyLabel(topspace, translate.Get("ars_subtitle"), "ZSHUDFontTiny", COLOR_WHITE)
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
	fastbuy:CenterVertical()
	
	local wsb = EasyButton(topspace, translate.Get("ars_worth"), 8, 4)
	wsb:SetFont("ZSHUDFontSmaller")
	wsb:SizeToContents()
	wsb:AlignRight(8)
	wsb:AlignTop(8)
	wsb.DoClick = worthmenuDoClick

	local rsb = EasyButton(topspace, translate.Get("ars_remantler"), 8, 4)
    rsb:SetFont("ZSHUDFontSmaller")
    rsb:SizeToContents()
    rsb:AlignTop(8)
    rsb:MoveLeftOf(wsb, 8)
    rsb.DoClick = RemantlerOpen

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())

	local pointslabel = EasyLabel(bottomspace, translate.Get("ars_pointsm").."0", "ZSHUDFontTiny", COLOR_GREEN)
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
	
	local favoritepanel = vgui.Create( "DPanel", propertysheet)
	favoritepanel:SetSize( 0, 0 )
	favoritepanel.Paint = function( self, w, h )
	end
	
	local itemfavoriteframe = vgui.Create("DScrollPanel", favoritepanel)
	itemfavoriteframe:SetSize(propertysheet:GetWide(), propertysheet:GetTall() - 32)
	itemfavoriteframe:SetPos(0, 5)
	
	local list = vgui.Create("DGrid", itemfavoriteframe)
	list:SetPos(-1 * screenscale, 6 * screenscale)
	list:SetSize(propertysheet:GetWide() - 312, propertysheet:GetTall())
	list:SetCols(2)
	list:SetColWide(333 * screenscale)
	list:SetRowHeight(102 * screenscale)
	
	for i, swepclass in pairs(GAMEMODE.FavoriteWeapons) do
		local items_swepclass = swepclass and GAMEMODE.Items[swepclass]
	   	if items_swepclass then
			GAMEMODE:AddShopItem(list, swepclass, items_swepclass)
		end
	end

	frame.Favorites = propertysheet:AddSheet(translate.Get("itemcat_favorites"), favoritepanel, "icon16/heart.png", false, false)
	frame.Favorites.Grid = list

	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		local hasitems = false
		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.PointShop then
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
				list:SetRowHeight(100 * screenscale)

				return list
			end

			local subcats = GAMEMODE.ItemSubCategories
			if usecats then
				local ind, tbn = 1
				for i = ind, (trinkets and #subcats or 6) do
					local ispacer = trinkets and ((i-1) % 3)+1 or i
					local start = i == (catid == ITEMCAT_GUNS and 2 or ind)

					tbn = EasyButton(tabpane, trinkets and subcats[i] or (translate.Get("arsenal_tier") .. i), 2, 8)
					tbn:SetFont(trinkets and "ZSHUDFontSmallest" or "ZSHUDFontSmall")
					tbn:SetAlpha(start and 255 or 70)
					tbn:SetColor(start and SELECT_COLOR or COLOR_WHITE)
					tbn:SetContentAlignment(5)
					tbn:SetSize((trinkets and 130 or 85) * screenscale, (trinkets and 30 or 40) * screenscale)
					tbn:AlignRight((trinkets and -145 or -35) * screenscale -
						(ispacer - ind) * (ind == 1 and (trinkets and 190 or 110) or 145) * screenscale)
					tbn:AlignTop(trinkets and i <= 3 and 0 or trinkets and 30 * screenscale or 12 * screenscale)

					tbn.DoClick = function(me)
						for k, v in pairs(tabpane.Grids) do
							v:SetVisible(k == i)
							tabpane.Buttons[k]:SetColor(k == i and SELECT_COLOR or COLOR_WHITE)
							tabpane.Buttons[k]:SetAlpha(k == i and 255 or 70)
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
				if tab.PointShop and tab.Category == catid then
					self:AddShopItem(
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