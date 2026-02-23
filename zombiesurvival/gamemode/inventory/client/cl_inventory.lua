GM.ZSInventory = {}
GM.ZSInventoryTimeReceived = {}

INVCAT_TRINKETS = 1

local meta = FindMetaTable("Player")
function meta:GetInventoryItems()
	return GAMEMODE.ZSInventory
end

function GM:GetBaseItemName(item)
    return string.gsub(item, "_q%d$", "", 1)
end

function GM:GetTrinketName(data)
	local basetext = translate.Get(GAMEMODE:GetBaseItemName(data.PrintName))
	local qualitytext = GAMEMODE:GetQualityText(data.QualityTier)

    return basetext .. qualitytext
end

function GM:GetQualityText(quality)
	local qualities = {[0] = {""}, [1] = {" +1"}, [2] = {" +2"}, [3] = {" +3"}}
	local txtquality = qualities[quality]

    return txtquality[1] or txtquality[3]
end

function GM:GetNextTrinketQuality(item)
	local newi = ""
	if string.sub(item, #item - 1, #item - 1) ~= "q" then
		newi = item.."_q1"
	else
		newi = string.sub(item, 0, #item - 1)..(tonumber(string.sub(item , #item, #item)) + 1)
	end

    return newi
end

function meta:GetInventoryItemTier(item)
    local basename = GAMEMODE:GetBaseItemName(item)
    local inventory = GAMEMODE.ZSInventory
    if inventory then
        return inventory[basename] and inventory[basename] > 0 and 0 
		or inventory[basename .. "_q1"] and inventory[basename .. "_q1"] > 0 and 1 
		or inventory[basename .. "_q2"] and inventory[basename .. "_q2"] > 0 and 2 
		or inventory[basename .. "_q3"] and inventory[basename .. "_q3"] > 0 and 3
    end
end

function meta:HasInventoryItem(item)
	return GAMEMODE.ZSInventory[item] and GAMEMODE.ZSInventory[item] > 0
end

function meta:HasInventoryItemTier(item)
	local newi = ""
	local newi2 = ""
	local newi3 = ""

	if string.sub(item ,#item-1,#item-1) ~= "q" then
		newi = item.."_q1"
		newi2 = item.."_q2"
		newi3 = item.."_q3"
	else
		newi  = string.sub(item,  0, #item - 1)..(tonumber(string.sub(item ,#item,#item)) + 1)
		newi2 = string.sub(item, 0, #item - 1)..(tonumber(string.sub(item ,#item,#item)) + 2)
		newi3 = string.sub(item, 0, #item - 1)..(tonumber(string.sub(item ,#item,#item)) + 3)
	end
	local inventory = GAMEMODE.ZSInventory

	return inventory[newi] and inventory[newi] > 0 or inventory[newi2] and inventory[newi2] > 0 or inventory[newi3] and inventory[newi3] > 0
end

net.Receive("zs_inventoryitem", function()
	local item = net.ReadString()
	local count = net.ReadInt(5)
	local prevcount = GAMEMODE.ZSInventory[item] or 0

	GAMEMODE.ZSInventory[item] = count
	GAMEMODE.ZSInventoryTimeReceived[GAMEMODE:GetBaseItemName(item)] = CurTime()

	if GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() then
		if count > prevcount then
			GAMEMODE:InventoryAddGridItem(item, GAMEMODE:GetInventoryItemType(item))
		else
			GAMEMODE:InventoryRemoveGridItem(item)
		end
	end

	if MySelf and MySelf:IsValid() then
		MySelf:ApplyTrinkets()
	end
end)

net.Receive("zs_wipeinventory", function()
	GAMEMODE.ZSInventory = {}
	GAMEMODE.ZSInventoryTimeReceived = {}

	if GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() then
		GAMEMODE:InventoryWipeGrid()
	end

	MySelf:ApplyTrinkets()
end)

function GM:SupplyNextTrinketViewer(sweptable, viewer, shoptbl)
	local screenscale = BetterScreenScale()

	local Inventory = GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsVisible()
	local Remantler = GAMEMODE.RemantlerInterface and GAMEMODE.RemantlerInterface:IsVisible()

	local item = shoptbl.SWEP == nil and shoptbl or shoptbl.SWEP

	local trinketquality = MySelf:GetInventoryItemTier(item)
	local basetrinket = self:GetBaseItemName(item)
	local baseitemdata = self.ZSInventoryItemData[basetrinket]
	local upgradeddata = self.ZSInventoryItemData[basetrinket .. "_q" .. trinketquality + 1]

	local desctext = upgradeddata.Description or ""

	viewer.m_UpgradeButton:CenterHorizontal(0.5)
    viewer.m_UpgradeButton:MoveBelow(viewer.m_Title, viewer:GetTall() * (Inventory and 0.4 or 0.35))
    viewer.m_UpgradeButton:SetSize(viewer:GetWide(), draw.GetFontHeight("ZSHUDFontSmall") * screenscale)
	viewer.m_UpgradeButton:SetText(translate.Format("upgrade_inv", GAMEMODE:GetUpgradeScrapTrinket(sweptable, trinketquality, baseitemdata.ScrapMultiplier)))
	viewer.m_UpgradeButton.DoClick = function()
		local minquality = math.min(trinketquality, 2)
		local toupgrade = minquality < 1 and item or basetrinket .. "_q" .. minquality

		if not MySelf.CurrentlyUpgrading then
			RunConsoleCommand("zs_upgrade_trinket", toupgrade)
			MySelf.CurrentlyUpgrading = true
		
			timer.Simple(0.25, function()
				if Inventory then
					for _, v in pairs(GAMEMODE.InventoryMenu.Grid:GetChildren()) do
						if self:GetNextTrinketQuality(item) == v.Item and GAMEMODE.InventoryMenu:IsVisible() and not Remantler then
							v:DoClick()
						end
					end
				elseif Remantler then
					GAMEMODE:SupplyItemViewerDetail(GAMEMODE.RemantlerInterface.TrinketsFrame.Viewer, sweptable, shoptbl)
				end
			
				MySelf.CurrentlyUpgrading = nil
			end)
		end
	end

	viewer.m_TitleUpg:SetText(GAMEMODE:GetTrinketName(upgradeddata))
	viewer.m_TitleUpg:SizeToContents()
	viewer.m_TitleUpg:CenterHorizontal(0.5)
	viewer.m_TitleUpg:PerformLayout()
	viewer.m_TitleUpg:SetTextColor(self.WeaponQualityColors[trinketquality + 1][baseitemdata.AlternativeColors and 2 or 1])
	viewer.m_TitleUpg:MoveBelow(viewer.m_UpgradeButton)

	viewer.m_DescScrollUpg:SetTall(viewer:GetTall() * 0.3)
	viewer.m_DescScrollUpg:MoveBelow(viewer.m_TitleUpg, 20 * screenscale)
	viewer.m_DescUpg:MoveBelow(viewer.m_TitleUpg, 20 * screenscale)
	viewer.m_DescUpg:SetText(translate.Get(desctext))
end

local function SupplyTrinketViewer(viewer, sweptable, item)
	local screenscale = BetterScreenScale()

	local Inventory = GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsVisible()
	local Remantler = GAMEMODE.RemantlerInterface and GAMEMODE.RemantlerInterface:IsVisible()

	local upgradeviewer = (Inventory or Remantler)
	local itemdata = GAMEMODE.ZSInventoryItemData[item]
	local itemdatabase = GAMEMODE.ZSInventoryItemData[GAMEMODE:GetBaseItemName(item)]
	local trinketquality = MySelf:GetInventoryItemTier(item)

	local desctext = sweptable.Description or ""

	viewer.m_Title:SetText(GAMEMODE:GetTrinketName(sweptable))
	viewer.m_Title:SetTextColor(sweptable.QualityTier > 0 and GAMEMODE.WeaponQualityColors[sweptable.QualityTier][itemdatabase.AlternativeColors and 2 or 1] or COLOR_GRAY)
	viewer.m_Title:PerformLayout()
	
	viewer.m_DescScroll:SetTall(viewer:GetTall() * 0.3)
	viewer.m_DescScroll:MoveBelow(viewer.m_Title, 20 * screenscale)
	viewer.m_Desc:MoveBelow(viewer.m_Title, 20 * screenscale)
	viewer.m_Desc:SetFont("ZSBodyTextFontBig")
	viewer.m_Desc:SetText(translate.Get(desctext))

	local Upgradable = upgradeviewer and trinketquality and trinketquality < 3 and itemdata.Upgradable

	viewer.m_UpgradeButton:SetVisible(Upgradable)
	viewer.m_TitleUpg:SetVisible(Upgradable)
	viewer.m_DescScrollUpg:SetVisible(Upgradable)
	viewer.m_DescUpg:SetVisible(Upgradable)

	if Upgradable then
		GAMEMODE:SupplyNextTrinketViewer(sweptable, viewer, item)
	else
		viewer.m_UpgradeButton:SetVisible(false)
        viewer.m_TitleUpg:SetVisible(false)
        viewer.m_DescScrollUpg:SetVisible(false)
        viewer.m_DescUpg:SetVisible(false)
	end
end

local function ItemPanelDoClick(self)
	local item = self.Item
	if not item then return end

	local category, sweptable = self.Category
	sweptable = GAMEMODE.ZSInventoryItemData[item]
	local viewer = GAMEMODE.m_InvViewer
	local screenscale = BetterScreenScale()

	if self.On then
		if viewer and viewer:IsValid() then
			viewer:SetVisible(false)
		end

		self.On = false

		GAMEMODE.InventoryMenu.SelInv = false
		GAMEMODE:DoAltSelectedItemUpdate()
		return
	else
		for _, v in pairs(self:GetParent():GetChildren()) do
			v.On = false
		end
		self.On = true

		GAMEMODE.InventoryMenu.SelInv = item
		GAMEMODE:DoAltSelectedItemUpdate()
	end

	if not GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() and GAMEMODE.InventoryMenu:IsVisible() then return end

	GAMEMODE:CreateInventoryInfoViewer()

	viewer = GAMEMODE.m_InvViewer

	SupplyTrinketViewer(viewer, sweptable, item)
end

local function TrinketPaint(item, self, sweptable)
	local quality = sweptable.QualityTier
	local baseitemdata = GAMEMODE.ZSInventoryItemData[GAMEMODE:GetBaseItemName(item)]

	local colors = GAMEMODE.WeaponQualityColors[quality][baseitemdata.AlternativeColors and 2 or 1]
	
    local ColorLight = quality >= 1 and colors or COLOR_GRAY
    local ColorDark = quality >= 1 and Color(colors.r / 1.75, colors.g / 1.75, colors.b / 1.75) or COLOR_DARKGRAY
	
    return (self.Depressed or self.On) and ColorLight or ColorDark
end

local colBG = Color(10, 10, 10, 252)
local colBGH = Color(200, 200, 200, 5)
local function ItemPanelPaint(self, w, h)
    local sweptable = GAMEMODE.ZSInventoryItemData[self.Item]

    draw.RoundedBox(2, 0, 0, w, h, TrinketPaint(self.Item, self, sweptable))
    draw.RoundedBox(2, 2, 2, w - 4, h - 4, colBG)

    if self.On or self.Hovered then
        draw.RoundedBox(2, 2, 2, w - 4, h - 4, colBGH)
    end

    return true
end

function GM:CreateInventoryInfoViewer()
	if self.m_InvViewer and self.m_InvViewer:IsValid() then
		self.m_InvViewer:SetVisible(true)
		return
	end

	local leftframe = self.InventoryMenu
	local viewer = vgui.Create("DFrame")

	local screenscale = BetterScreenScale()

	viewer:SetDeleteOnClose(false)
	viewer:SetTitle(" ")
	viewer:SetDraggable(false)

	if viewer.btnClose and viewer.btnClose:IsValid() then viewer.btnClose:SetVisible(false) end
	if viewer.btnMinim and viewer.btnMinim:IsValid() then viewer.btnMinim:SetVisible(false) end
	if viewer.btnMaxim and viewer.btnMaxim:IsValid() then viewer.btnMaxim:SetVisible(false) end

	viewer:SetSize(leftframe:GetWide() / 1.25, leftframe:GetTall() * 0.6)
	viewer:MoveRightOf(leftframe, 32 * screenscale)
	viewer:MoveAbove(leftframe, (-leftframe:GetTall() * 0.6))

	self.m_InvViewer = viewer

	self:CreateItemViewerGenericElems(viewer)
end

function GM:InventoryAddGridItem(item, category)
	local screenscale = BetterScreenScale()
	local grid = self.InventoryMenu.Grid
	local data = GAMEMODE.ZSInventoryItemData[item]
	local basedata = GAMEMODE.ZSInventoryItemData[self:GetBaseItemName(item)]

	local itempan = vgui.Create("DButton")
	itempan:SetText("")
	itempan:SetSize(193 * screenscale, 80 * screenscale)
	itempan.Paint = ItemPanelPaint
	itempan.DoClick = ItemPanelDoClick
	itempan.DoRightClick = function()
		local menu = ZSDermaMenu(itempan)

		local drop = menu:AddOption(translate.Get("button_drop"), function() RunConsoleCommand("zsdropweapon", item) end)
		drop:SetIcon("icon16/arrow_down.png")

		if not data.PermitDismantle then
			local distext = translate.Format("inventory_button_dismantle_item", GAMEMODE:GetDismantleScrap(data, item, MySelf))
			local dismantle = menu:AddOption(distext, function() RunConsoleCommand("zs_dismantle", item) end)
			dismantle:SetIcon("icon16/cog_go.png")
		end

		if data.Upgradable and data.QualityTier <= 2 then
			local upgtext = translate.Format("upgrade_trinket_inv", GAMEMODE:GetUpgradeScrapTrinket(data, data.QualityTier, basedata.ScrapMultiplier))
			local upgrade = menu:AddOption(upgtext, function() RunConsoleCommand("zs_upgrade_trinket", item) end)
			upgrade:SetIcon("icon16/joystick_add.png")
		end

		menu:Open()
	end
	itempan.Item = item
	itempan.Category = category

	local baseitem = self:GetBaseItemName(item)
    itempan.TimeAcquired = GAMEMODE.ZSInventoryTimeReceived[baseitem] or CurTime()
    itempan.SortKey = baseitem .. "_" .. itempan.TimeAcquired

	grid:AddItem(itempan)
	grid:SortByMember("SortKey")

	local mdlframe = vgui.Create("DPanel", itempan)
	mdlframe:SetSize(75 * screenscale, 45 * screenscale)
	mdlframe:Center()
	mdlframe:CenterVertical(0.4)
	mdlframe:SetMouseInputEnabled(false)
	mdlframe.Paint = function() end
	
	local kitbl = killicon.Get(data.Icon or "weapon_zs_trinket")
	if kitbl then
		self:AttachKillicon(kitbl, itempan, mdlframe)
	end

	local trinketname = EasyLabel(itempan, GAMEMODE:GetTrinketName(data),"ZSHUDFontSmallest", COLOR_WHITE)
	trinketname:Center()
	trinketname:CenterVertical(0.8)
end

function GM:InventoryRemoveGridItem(item)
	local grid = self.InventoryMenu.Grid
	for k, v in pairs(grid:GetChildren()) do
		if v.Item == item then
			grid:RemoveItem(v)
			break
		end
	end

	if self.InventoryMenu.SelInv == item and not MySelf.CurrentlyUpgrading then
		if self.m_InvViewer and self.m_InvViewer:IsValid() and self.InventoryMenu.SelInv then
			self.m_InvViewer:SetVisible(false)
		end

		self.InventoryMenu.SelInv = nil
		self:DoAltSelectedItemUpdate()
	end
end

function GM:InventoryWipeGrid()
	local grid = self.InventoryMenu.Grid
	for k, v in pairs(grid:GetChildren()) do
		grid:RemoveItem(v)
	end

	if self.m_InvViewer and self.m_InvViewer:IsValid() then
		self.m_InvViewer:SetVisible(false)
	end

	self.InventoryMenu.SelInv = nil
	self:DoAltSelectedItemUpdate()
end

function AltSelItemUpd()
	local activeweapon = MySelf:GetActiveWeapon()
	if not activeweapon or not activeweapon:IsValid() or GAMEMODE.InventoryMenu == nil then return end

	local actwclass = activeweapon:GetClass()
	GAMEMODE.InventoryMenu.SelectedItemLabel:SetText(weapons.Get(actwclass).PrintName)
	GAMEMODE.InventoryMenu.SelectedItemLabel:SizeToContents()
	GAMEMODE.InventoryMenu.SelectedItemLabel:CenterHorizontal()
	
	if activeweapon.NoDismantle or not (activeweapon.AllowQualityWeapons or activeweapon.PermitDismantle) then
		GAMEMODE.InventoryMenu.dropweapon:SetText(translate.Get("inventory_button_cannot_dismantle_item"))
		GAMEMODE.InventoryMenu.dropweapon:SetTextColor(COLOR_DARKRED)
		return
	end

	local distext = translate.Format("inventory_button_dismantle_item", GAMEMODE:GetDismantleScrap(activeweapon, nil, MySelf))
	GAMEMODE.InventoryMenu.dropweapon:SetText(distext)
	GAMEMODE.InventoryMenu.dropweapon:SetTextColor(COLOR_GRAY)
end

function GM:DoAltSelectedItemUpdate()
	if self.InventoryMenu.SelInv then
		self.InventoryMenu.SelectedItemLabel:SetText(self:GetTrinketName(self.ZSInventoryItemData[self.InventoryMenu.SelInv]))
		self.InventoryMenu.SelectedItemLabel:SizeToContents()
		self.InventoryMenu.SelectedItemLabel:CenterHorizontal()
		local data = self.ZSInventoryItemData[self.InventoryMenu.SelInv]

		if GAMEMODE:GetInventoryItemType(self.InventoryMenu.SelInv) ~= INVCAT_TRINKETS or data.PermitDismantle then
			self.InventoryMenu.dropweapon:SetText(translate.Get("inventory_button_cannot_dismantle_item"))
			self.InventoryMenu.dropweapon:SetTextColor(COLOR_DARKRED)
			return
		end
				
		local distext = translate.Format("inventory_button_dismantle_item", self:GetDismantleScrap(data, self.InventoryMenu.SelInv, MySelf))
		self.InventoryMenu.dropweapon:SetText(distext)
		self.InventoryMenu.dropweapon:SetTextColor(COLOR_GRAY)
	else
		timer.Simple(0.25, AltSelItemUpd)
	end
end

local function GiveWeapon()
	if GAMEMODE.HumanMenuLockOn then
		RunConsoleCommand("zsgiveweapon", GAMEMODE.HumanMenuLockOn:EntIndex(), GAMEMODE.InventoryMenu.SelInv)
		GAMEMODE:DoAltSelectedItemUpdate()
	end
end

local function GiveWeaponClip()
	if GAMEMODE.HumanMenuLockOn then
		RunConsoleCommand("zsgiveweaponclip", GAMEMODE.HumanMenuLockOn:EntIndex(), GAMEMODE.InventoryMenu.SelInv)
		GAMEMODE:DoAltSelectedItemUpdate()
	end
end

local function DropWeapon()
	RunConsoleCommand("zsdropweapon", GAMEMODE.InventoryMenu.SelInv)
	GAMEMODE:DoAltSelectedItemUpdate()
end

local function EmptyClip()
	RunConsoleCommand("zsemptyclip")
	GAMEMODE:DoAltSelectedItemUpdate()
end

local function DismantleWeapon()
	RunConsoleCommand("zs_dismantle", GAMEMODE.InventoryMenu.SelInv)
	GAMEMODE:DoAltSelectedItemUpdate()
end

local function GetTargetEntIndex()
	return GAMEMODE.HumanMenuLockOn and GAMEMODE.HumanMenuLockOn:IsValid() and GAMEMODE.HumanMenuLockOn:EntIndex() or 0
end

function GM:CreateAmmoViewer()
	if self.AmmoViewer and self.AmmoViewer:IsValid() then
		self.AmmoViewer:SetVisible(true)
		return
	end
	local screenscale = BetterScreenScale()
	local inventory = self.InventoryMenu

	local ammoframeviewer = vgui.Create("DFrame")
	ammoframeviewer:SetDeleteOnClose(false)
	ammoframeviewer:SetTitle(" ")
	ammoframeviewer:SetDraggable(false)

	if ammoframeviewer.btnClose and ammoframeviewer.btnClose:IsValid() then ammoframeviewer.btnClose:SetVisible(false) end
	if ammoframeviewer.btnMinim and ammoframeviewer.btnMinim:IsValid() then ammoframeviewer.btnMinim:SetVisible(false) end
	if ammoframeviewer.btnMaxim and ammoframeviewer.btnMaxim:IsValid() then ammoframeviewer.btnMaxim:SetVisible(false) end

	ammoframeviewer:SetSize(inventory:GetWide() / 3, inventory:GetTall())
	ammoframeviewer:MoveLeftOf(inventory, 32 * screenscale)
	ammoframeviewer:MoveBelow(inventory, -inventory:GetTall())

	self.AmmoViewer = ammoframeviewer
	ammoframeviewer.AmmoIndicators = {}

	local ammos = {
        "pistol",
        "buckshot",
        "smg1",
        "ar2",
        "357",
        "pulse",
        "chemical",
        "impactmine",
        "battery",
        "gaussenergy",
        "scrap"
    }

	for _, v in pairs(ammos) do
		local ki = killicon.Get(self.AmmoIcons[v])
		if !ki then continue end

		local resupbut = vgui.Create("DButton", ammoframeviewer)
		resupbut:SetText(" ")
		resupbut:SetSize(46 * screenscale, 46 * screenscale)
		resupbut:SetTooltipPanelOverride("DExTooltip")
		resupbut:SetTooltip(self.AmmoNames[v])
		resupbut.Paint = function(self, w, h)
            if v == MySelf.ResupplyChoice then
                surface.SetDrawColor(150, 250, 150, math.abs(math.sin(CurTime() * 2)) * 70)
                surface.DrawRect(0, 0, w, h)
            end
        end
		resupbut.DoClick = function()
        	if MySelf.ResupplyChoice == v then
        	    MySelf.ResupplyChoice = nil
			else
              	MySelf.ResupplyChoice = v
         	end
           	RunConsoleCommand("zs_resupplyammotype", MySelf.ResupplyChoice or "default")
		end

		if ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators] then
            resupbut:MoveBelow(ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators], 20 * screenscale)
        else
            local pos = resupbut:GetPos()
            resupbut:SetPos(pos, 4 * screenscale)
        end
		resupbut:CenterHorizontal(0.2)

		local col = vgui.Create("DImage", resupbut)
		col:SetSize(46 * screenscale, 46 * screenscale)
        col:SetImage(ki[1])
		if ki[2] then
			col:SetImageColor(ki[2]) 
		end

		local give = vgui.Create("DImageButton", ammoframeviewer)
		give:SetImage("icon16/user_go.png")
		give:SetTooltipPanelOverride("DExTooltip")
		give:SetTooltip(translate.Get("button_give"))
		give:SetSize(16 * screenscale, 16 * screenscale)
		give:SetVisible(false)
		give.DoClick = function(me) 
			RunConsoleCommand("zsgiveammo", v, GetTargetEntIndex())
		end

		local drop = vgui.Create("DImageButton", ammoframeviewer)
		drop:SetImage("icon16/arrow_down.png")
		drop:SetTooltipPanelOverride("DExTooltip")
		drop:SetTooltip(translate.Get("button_drop"))
		drop:SetSize(16 * screenscale, 16 * screenscale)
		drop:SetVisible(false)
		drop.DoClick = function(me) RunConsoleCommand("zsdropammo", v) end

		local num = EasyLabel(ammoframeviewer, "0", "ZSHUDFontSmall", noammo)
		num:SetContentAlignment(5)

        if ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators] then
            num:MoveBelow(ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators], 21 * screenscale)
            drop:MoveBelow(ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators], 20 * screenscale)
            give:MoveBelow(ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators], 47 * screenscale)
        else
            local pos = num:GetPos()
            num:SetPos(pos, 7 * screenscale)
            drop:SetPos(pos, 7 * screenscale)
            give:SetPos(pos, 32 * screenscale)
        end
        num:CenterHorizontal(0.64)
        drop:CenterHorizontal(0.92)
        give:CenterHorizontal(0.92)

		function num:Think()
			if self.StartChecking3 and RealTime() < self.StartChecking3 then
				return
			end
			self.StartChecking3 = RealTime() + 0.001
			local ammo = MySelf:GetAmmoCount(v)
			num:SetText(ammo)
			num:CenterHorizontal(0.64)
			num:SizeToContents()
			num:SetColor(ammo > 0 and COLOR_WHITE or Color(150, 150, 150, 75))

			drop:SetVisible(ammo > 0)
			give:SetVisible(ammo > 0)
		end

		ammoframeviewer.AmmoIndicators[#ammoframeviewer.AmmoIndicators + 1] = resupbut
	end
end

function GM:OpenInventory()
	if self.InventoryMenu and self.InventoryMenu:IsValid() then
		self.InventoryMenu:SetVisible(true)

		if self.m_InvViewer and self.m_InvViewer:IsValid() and self.InventoryMenu.SelInv then
			self.m_InvViewer:SetVisible(true)
		end

		if self.AmmoViewer and self.AmmoViewer:IsValid() then
            self.AmmoViewer:SetVisible(true)
        end
		
		return
	end

	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW() / 2, 415) * screenscale, math.min(ScrH(), 715) * screenscale

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetDeleteOnClose(false)
	frame:SetTitle(" ")
	frame:SetDraggable(false)
	
	if frame.btnClose and frame.btnClose:IsValid() then frame.btnClose:SetVisible(false) end
	if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end

	self.InventoryMenu = frame

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid - 16 * screenscale)

	local title = EasyLabel(topspace, translate.Get("inventory_title"), "ZSHUDFont", COLOR_WHITE)
	title:CenterHorizontal(0.5)
	title:CenterHorizontal()

	local _, y = title:GetPos()
	topspace:SetTall(y + title:GetTall() + 2 * screenscale)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()
	
	local invListPanel = vgui.Create("DScrollPanel", frame)
	invListPanel:Dock( FILL )
	local sbar = invListPanel:GetVBar()
	sbar.Enabled = true
	invListPanel:DockMargin(0, topspace:GetTall() - 16 * screenscale, 0, 170 * screenscale)
	invListPanel:InvalidateParent(true)

	local invgrid = vgui.Create("DGrid", invListPanel)
	invgrid:SetSize(invListPanel:GetWide() - sbar:GetWide(), invListPanel:GetTall())
	invgrid:SetCols(2)
	invgrid:SetColWide(198 * screenscale)
	invgrid:SetRowHeight(85 * screenscale)
	frame.Grid = invgrid

	for item, count in pairs(self.ZSInventory) do
		if count > 0 then
			for i = 1, count do
				self:InventoryAddGridItem(item, self:GetInventoryItemType(item))
			end
		end
	end
	
	invgrid:SortByMember("TimeAcquired")

	self:CreateAmmoViewer()
	self:DoAltSelectedItemUpdate()

	local buttonspanel = vgui.Create("DPanel", frame)
    buttonspanel:SetSize(frame:GetWide() - 16 * screenscale, 198 * screenscale)
    buttonspanel:SetPos(8 * screenscale, frame:GetTall() - 204 * screenscale)
    buttonspanel:SetPaintBackground(false)

	local selectedtitle = EasyLabel(buttonspanel, translate.Get("inventory_selected_item_title"), "ZSHUDFontSmall", color_white)
    selectedtitle:SetContentAlignment(5)
    selectedtitle:CenterHorizontal()
	frame.SelectedItemTitle = selectedtitle

	local selecteditem = EasyLabel(buttonspanel, translate.Get("inventory_selected_item_label"), "ZSHUDFontSmall", color_white)
    selecteditem:SetContentAlignment(5)
    selecteditem:CenterHorizontal()
    selecteditem:MoveBelow(selectedtitle)
	frame.SelectedItemLabel = selecteditem

	local giveitem = vgui.Create("DButton", buttonspanel)
    giveitem:SetFont("ZSHUDFontSmall")
    giveitem:SetText(translate.Get("inventory_button_give_item"))
    giveitem:SetSize((buttonspanel:GetWide() - 8 * screenscale) / 2, draw.GetFontHeight("ZSHUDFont") - 16 * screenscale)
    giveitem:MoveBelow(selecteditem, 4 * screenscale)
    giveitem.DoClick = GiveWeapon

	local giveitemclips = vgui.Create("DButton", buttonspanel)
    giveitemclips:SetFont("ZSHUDFontSmaller")
    giveitemclips:SetText(translate.Get("inventory_button_give_item_with_clips"))
    giveitemclips:SetSize((buttonspanel:GetWide() - 8 * screenscale) / 2, draw.GetFontHeight("ZSHUDFont") - 16 * screenscale)
    giveitemclips:MoveBelow(selecteditem, 4 * screenscale)
	giveitemclips:MoveRightOf(giveitem, 4 * screenscale)
    giveitemclips.DoClick = GiveWeaponClip

	local dropitem = vgui.Create("DButton", buttonspanel)
    dropitem:SetFont("ZSHUDFontSmall")
    dropitem:SetText(translate.Get("inventory_button_drop_item"))
    dropitem:SetSize((buttonspanel:GetWide() - 8 * screenscale) / 2, draw.GetFontHeight("ZSHUDFont") - 16 * screenscale)
    dropitem:MoveBelow(giveitemclips, 4 * screenscale)
    dropitem.DoClick = DropWeapon

	local emptygun = vgui.Create("DButton", buttonspanel)
    emptygun:SetFont("ZSHUDFontSmall")
    emptygun:SetText(translate.Get("inventory_button_empty_item"))
    emptygun:SetSize((buttonspanel:GetWide() - 8 * screenscale) / 2, draw.GetFontHeight("ZSHUDFont") - 16 * screenscale)
    emptygun:MoveBelow(giveitemclips, 4 * screenscale)
	emptygun:MoveRightOf(dropitem, 4 * screenscale)
    emptygun.DoClick = EmptyClip

	local dismantle = vgui.Create("DButton", buttonspanel)
    dismantle:SetFont("ZSHUDFontSmall")
    dismantle:SetText(translate.Get("inventory_button_cannot_dismantle_item"))
	dismantle:SetColor(COLOR_DARKRED)
    dismantle:SetSize(buttonspanel:GetWide() - 8 * screenscale, draw.GetFontHeight("ZSHUDFont") - 16 * screenscale)
    dismantle:MoveBelow(emptygun, 4 * screenscale)
    dismantle.DoClick = DismantleWeapon
	frame.dropweapon = dismantle

	frame:MakePopup()
end