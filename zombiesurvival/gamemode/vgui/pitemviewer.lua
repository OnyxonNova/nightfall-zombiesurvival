function GM:SupplyItemViewerDetail(viewer, sweptable, shoptbl)
	shoptbl = shoptbl or {SWEP = sweptable.ClassName}

	local titletext = sweptable and sweptable.PrintName or shoptbl.Name or ""
	local titlecolor = COLOR_GRAY
	local desctext = shoptbl.Description or ""

	if self.ZSInventoryItemData[shoptbl.SWEP] then
        titletext = translate.Get(titletext)
    end

	viewer.m_Title:SetText(titletext)
	viewer.m_Title:SetTextColor(titlecolor)
	viewer.m_Title:PerformLayout()

	viewer.ModelPanel:SetModel("")
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

	local screenscale = BetterScreenScale()

	if not sweptable then
		viewer.ModelPanel:SetModel("")
		viewer.m_VBG:SetVisible(false)

		viewer.m_DescScroll:SetTall(viewer:GetTall() * 0.4)
		viewer.m_DescScroll:MoveBelow(viewer.m_Title, 20 * screenscale)
		viewer.m_Desc:MoveBelow(viewer.m_Title, 20 * screenscale)
		viewer.m_Desc:SetFont("ZSBodyTextFontBig")
		viewer.m_Desc:SetText(desctext)

		viewer.m_AmmoType:SetText("")
		viewer.m_AmmoType:SetContentAlignment(8)
		viewer.m_AmmoIcon:SetVisible(false)
		viewer.m_AmmoIconSecond:SetVisible(false)

		self:ViewerStatBarUpdate(viewer, true)
	elseif not self.ZSInventoryItemData[shoptbl.SWEP] then
		viewer.m_VBG:SetVisible(true)

		if sweptable.Branch and sweptable.Branch ~= 0 then
			local getwep = weapons.Get(sweptable.BaseQuality)
    	    desctext = getwep.RemantleDescs[sweptable.Branch][sweptable.QualityTier or sweptable.Tier][1]
		end

		if sweptable.Culinary then
			desctext = desctext .. "\nЯвляется кулинарным оружием."
		end

		if sweptable.NoDismantle then
			desctext = desctext .. "\nНе может быть разобран на металл."
		end

		viewer.m_DescScroll:MoveBelow(viewer.m_VBG, 8 * screenscale)
		viewer.m_DescScroll:SetTall(viewer:GetTall() * 0.131)
		viewer.m_Desc:MoveBelow(viewer.m_VBG, 8 * screenscale)
		viewer.m_Desc:SetFont("ZSBodyTextFont")
		viewer.m_Desc:SetText(desctext)
		
		viewer.m_Title:SetTextColor(titlecolor)
	else
		viewer.ModelPanel:SetModel("")
		viewer.m_VBG:SetVisible(false)
		
		local Inventory = self.InventoryMenu and self.InventoryMenu:IsVisible()
		local Remantler = self.RemantlerInterface and self.RemantlerInterface:IsVisible()
		local Arsenal = self.ArsenalInterface and self.ArsenalInterface:IsVisible()

		local upgradeviewer = Remantler and not (Arsenal or Inventory)
		local itemdata = self.ZSInventoryItemData[shoptbl.SWEP]
		local trinketquality = MySelf:GetInventoryItemTier(shoptbl.SWEP)

		if (upgradeviewer or Arsenal) and trinketquality and trinketquality > 0 and itemdata.Upgradable then
			local basetrinket = self:GetBaseItemName(shoptbl.SWEP)
			local upgradedtrinket = self.ZSInventoryItemData[basetrinket .. "_q" .. trinketquality]
			titletext = self:GetTrinketName(upgradedtrinket)
			desctext = upgradedtrinket.Description
			titlecolor = self.WeaponQualityColors[trinketquality][itemdata.AlternativeColors and 2 or 1]
		end

		viewer.m_Title:SetText(titletext)
		viewer.m_Title:SetTextColor(titlecolor)

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
			self:SupplyNextTrinketViewer(sweptable, viewer, shoptbl)
		end
	end

	if not sweptable then return end

	self:ViewerStatBarUpdate(viewer, shoptbl.Category ~= ITEMCAT_GUNS and shoptbl.Category ~= ITEMCAT_MELEE and shoptbl.Category ~= ITEMCAT_TOOLS, sweptable)

	if self:HasPurchaseableAmmo(sweptable) and self.AmmoNames[string.lower(sweptable.Primary.Ammo)] then
		local lower = string.lower(sweptable.Primary.Ammo)
 
		viewer.m_AmmoType:SetText(self.AmmoNames[lower])
		viewer.m_AmmoType:SetContentAlignment(8)
		viewer.m_AmmoType:PerformLayout()

		local ki = killicon.Get(self.AmmoIcons[lower])

		viewer.m_AmmoIcon:SetImage(ki[1])
		if ki[2] then viewer.m_AmmoIcon:SetImageColor(ki[2]) end

		viewer.m_AmmoIcon:SetVisible(true)

		if sweptable.Secondary.Ammo ~= "dummy" then
			local lowersecond = string.lower(sweptable.Secondary.Ammo)

			viewer.m_AmmoType:SetText(self.AmmoNames[lower].."/"..self.AmmoNames[lowersecond])
			viewer.m_AmmoType:SetContentAlignment(7)
			viewer.m_AmmoType:PerformLayout()

			local kis = killicon.Get(self.AmmoIcons[lowersecond])

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

function GM:CreateNextTrinketElements(viewer)
	local screenscale = BetterScreenScale()
	
	local upgradebutton = vgui.Create("DButton", viewer)
	upgradebutton:SetFont("ZSHUDFontSmall")
	upgradebutton:SetText(translate.Get("upgrade_trinket"))
	upgradebutton:CenterHorizontal(0)
	upgradebutton:SetSize(viewer:GetWide(), draw.GetFontHeight("ZSHUDFontSmall") * screenscale)
    upgradebutton:SetPos(0, viewer:GetTall() * 0.4)
	upgradebutton:SetVisible(false)
    viewer.m_UpgradeButton = upgradebutton

	local vtitleupg = EasyLabel(viewer, "", "ZSHUDFontSmaller", COLOR_GRAY)
    vtitleupg:SizeToContents()
    vtitleupg:SetContentAlignment(5)
	vtitleupg:SetVisible(false)
    viewer.m_TitleUpg = vtitleupg

	local itemdescscrollupg = vgui.Create("DScrollPanel", viewer)
    itemdescscrollupg:SetWide(viewer:GetWide() - 16 * screenscale)
    itemdescscrollupg:SetTall(viewer:GetTall() * 0.15 * screenscale)
    itemdescscrollupg:MoveBelow(vtitleupg, 8 * screenscale)
	itemdescscrollupg:SetVisible(false)
    viewer.m_DescScrollUpg = itemdescscrollupg

	local itemdescupg = vgui.Create("DLabel", itemdescscrollupg)
	itemdescupg:SetFont("ZSBodyTextFontBig")
	itemdescupg:SetTextColor(COLOR_GRAY)
	itemdescupg:SetMultiline(true)
	itemdescupg:SetWrap(true)
	itemdescupg:SetText("")
	itemdescupg:Dock(TOP)
	itemdescupg:DockMargin(8, 2, 8, 2)
	itemdescupg:SetAutoStretchVertical(true)
	itemdescupg:SetVisible(false)
	viewer.m_DescUpg = itemdescupg
end

function GM:CreateItemViewerGenericElems(viewer)
	local screenscale = BetterScreenScale()

	local vtitle = EasyLabel(viewer, "", "ZSHUDFontSmaller", COLOR_GRAY)
	vtitle:SetContentAlignment(8)
	vtitle:SetSize(viewer:GetWide(), 24 * screenscale)
	viewer.m_Title = vtitle

	local vammot = EasyLabel(viewer, "", "ZSBodyTextFontBig", COLOR_GRAY)
	vammot:SetContentAlignment(8)
	vammot:SetSize(viewer:GetWide(), 24 * screenscale)
	vammot:MoveBelow(vtitle, 20 * screenscale)
	viewer.m_AmmoType = vammot

	local vammoi = vgui.Create("DImage", viewer)
	vammoi:SetSize(40 * screenscale, 40 * screenscale)
	vammoi:MoveBelow(vtitle, 8 * screenscale)
	vammoi:CenterHorizontal(0.78)
	viewer.m_AmmoIcon = vammoi

	local vammoii = vgui.Create("DImage", viewer)
	vammoii:SetSize(40 * screenscale, 40 * screenscale)
	vammoii:MoveBelow(vtitle, 8)
	vammoii:CenterHorizontal(0.93)
	viewer.m_AmmoIconSecond = vammoii

	local vbg = vgui.Create("DPanel", viewer)
	vbg:SetSize(200 * screenscale, 100 * screenscale)
	vbg:CenterHorizontal()
	vbg:MoveBelow(vammot, 24 * screenscale)
	vbg:SetBackgroundColor(Color(0, 0, 0, 255))
	vbg:SetVisible(false)
	viewer.m_VBG = vbg

	local modelpanel = vgui.Create("DModelPanelEx", vbg)
	modelpanel:SetModel("")
	modelpanel:AutoCam()
	modelpanel:Dock(FILL)
	modelpanel:SetDirectionalLight(BOX_TOP, Color(100, 255, 100))
	modelpanel:SetDirectionalLight(BOX_FRONT, Color(255, 100, 100))
	viewer.ModelPanel = modelpanel

	local iconpanel = vgui.Create("DPanel", vbg)
    iconpanel:SetSize(200 / 2 * screenscale, 100 / 2 * screenscale)
    iconpanel:SetPos(200 / 4 * screenscale, 100 / 4 * screenscale)
    iconpanel.Paint = function()
    end
    viewer.IconFrame = iconpanel

	local itemdescscroll = vgui.Create("DScrollPanel", viewer)
    itemdescscroll:SetWide(viewer:GetWide() - 16 * screenscale)
    itemdescscroll:SetTall(viewer:GetTall() * 0.131)
    itemdescscroll:MoveBelow(vbg, 8 * screenscale)
    viewer.m_DescScroll = itemdescscroll

	local itemdesc = vgui.Create("DLabel", itemdescscroll)
	itemdesc:SetFont("ZSBodyTextFont")
	itemdesc:SetTextColor(COLOR_GRAY)
	itemdesc:SetMultiline(true)
	itemdesc:SetWrap(true)
	itemdesc:SetText("")
	itemdesc:Dock(TOP)
	itemdesc:DockMargin(8, 2, 8, 2)
	itemdesc:SetAutoStretchVertical(true)
	viewer.m_Desc = itemdesc

	self:CreateNextTrinketElements(viewer)

	local itemstats, itemsbs, itemsvs = {}, {}, {}
	for i = 1, 10 do
		local itemstat = vgui.Create("DLabel", viewer)
		itemstat:SetFont("ZSBodyTextFont")
		itemstat:SetTextColor(COLOR_GRAY)
		itemstat:SetWide(viewer:GetWide() * 0.35)
		itemstat:SetText("")
		itemstat:CenterHorizontal(0.2)
		itemstat:SetContentAlignment(8)
		itemstat:MoveBelow(i == 1 and vbg or itemstats[i-1], (i == 1 and 100 or 8) * screenscale)
		table.insert(itemstats, itemstat)

		local itemsb = vgui.Create("ZSItemStatBar", viewer)
		itemsb:SetWide(viewer:GetWide() * 0.35)
		itemsb:SetTall(8 * screenscale)
		itemsb:CenterHorizontal(0.55)
		itemsb:SetVisible(false)
		itemsb:MoveBelow(i == 1 and vbg or itemstats[i-1], ((i == 1 and 100 or 8) + 6) * screenscale)
		table.insert(itemsbs, itemsb)

		local itemsv = vgui.Create("DLabel", viewer)
		itemsv:SetFont("ZSBodyTextFont")
		itemsv:SetTextColor(COLOR_GRAY)
		itemsv:SetWide(viewer:GetWide() * 0.3)
		itemsv:SetText("")
		itemsv:CenterHorizontal(0.85)
		itemsv:SetContentAlignment(8)
		itemsv:MoveBelow(i == 1 and vbg or itemstats[i-1], (i == 1 and 100 or 8) * screenscale)
		table.insert(itemsvs, itemsv)
	end
	viewer.ItemStats = itemstats
	viewer.ItemStatValues = itemsvs
	viewer.ItemStatBars = itemsbs
end

function GM:ViewerStatBarUpdate(viewer, display, sweptable)
	local done, statshow = {}
	local speedtotext = GAMEMODE.SpeedToText
	local wepget = weapons.Get("weapon_zs_base")
	local wepgetmelee = weapons.Get("weapon_zs_basemelee").IsMelee and weapons.Get("weapon_zs_basemelee")
	for i = 1, 10 do
		if display then
			viewer.ItemStats[i]:SetText("")
			viewer.ItemStatValues[i]:SetText("")
			viewer.ItemStatBars[i]:SetVisible(false)
			continue
		end
		local statshowbef = statshow
		for k, stat in pairs(GAMEMODE.WeaponStatBarVals) do
			local statval = stat[6] and sweptable[stat[6]][stat[1]] or sweptable[stat[1]]
			local basestatval = stat[6] and wepget[stat[6]][stat[1]] or wepget[stat[1]]
			local basemeleestatval = stat[6] and wepgetmelee[stat[6]][stat[1]] or wepgetmelee[stat[1]]

			if not done[stat] and statval and statval ~= -1 and (wepget and (basestatval == nil or basestatval ~= statval)) and (wepgetmelee and (basemeleestatval == nil or basemeleestatval ~= statval)) then
				statshow = stat
				done[stat] = true

				break
			end
		end
		if statshowbef and statshowbef[1] == statshow[1] then
			viewer.ItemStats[i]:SetText("")
			viewer.ItemStatValues[i]:SetText("")
			viewer.ItemStatBars[i]:SetVisible(false)
			continue
		end
		local statnum, stattext = statshow[6] and sweptable[statshow[6]][statshow[1]] or sweptable[statshow[1]]
		local required_clip = sweptable.RequiredClip or 1
		local numshots = sweptable.Primary.NumShots or 1
		if statshow[1] == "Damage" and sweptable.Primary.NumShots and sweptable.Primary.NumShots > 1 then
			stattext = statnum .. " x " .. sweptable.Primary.NumShots-- .. " (" .. (statnum * sweptable.Primary.NumShots) .. ")"
		elseif statshow[1] == "WalkSpeed" then
			stattext = speedtotext[SPEED_NORMAL]
			if speedtotext[sweptable[statshow[1]]] then
				stattext = speedtotext[sweptable[statshow[1]]]
			elseif sweptable[statshow[1]] < SPEED_SLOWEST then
				stattext = speedtotext[-1]
			end
		elseif statshow[1] == "ClipSize" then
			stattext = statnum / required_clip
		elseif statshow[1] == "HeadshotMulti" then
			stattext = statnum .. "x"
		else
			stattext = statnum
		end

		viewer.ItemStats[i]:SetText(statshow[2])
		viewer.ItemStatValues[i]:SetText(stattext)

		if statshow[1] == "Damage" then
			statnum = statnum * numshots
		elseif statshow[1] == "ClipSize" then
			statnum = statnum / required_clip
		end

		viewer.ItemStatBars[i].Stat = statnum
		viewer.ItemStatBars[i].StatMin = statshow[3]
		viewer.ItemStatBars[i].StatMax = statshow[4]
		viewer.ItemStatBars[i].BadHigh = statshow[5]
		viewer.ItemStatBars[i]:SetVisible(true)
	end
end

function GM:ConfigureMenuTabs(tabs, tabhei, callback)
	local screenscale = BetterScreenScale()

	for _, tab in pairs(tabs) do
		tab:SetFont(screenscale > 0.85 and "ZSHUDFontTiny" or "DefaultFontAA")
		tab.GetTabHeight = function()
			return tabhei
		end
		tab.PerformLayout = function(me)
			me:ApplySchemeSettings()

			if not me.Image then return end
			me.Image:SetPos(7, me:GetTabHeight()/2 - me.Image:GetTall()/2 + 3)
			me.Image:SetImageColor(Color(255, 255, 255, not me:IsActive() and 155 or 255))
		end
		tab.DoClick = function(me)
			me:GetPropertySheet():SetActiveTab(me)

			if callback then callback(tab) end
		end
	end
end

local PANEL = {}

PANEL.Stat = 50
PANEL.StatMin = 0
PANEL.StatMax = 100
PANEL.BadHigh = false
PANEL.LerpStat = 50
function PANEL:Init()
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
end

local matGradientLeft = CreateMaterial("gradient-l", "UnlitGeneric", {["$basetexture"] = "vgui/gradient-l", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1", ["$ignorez"] = "1", ["$nomip"] = "1"})
function PANEL:Paint(w, h)
	self.LerpStat = Lerp(FrameTime() * 4, self.LerpStat, self.Stat)
	local progress = math.Clamp((self.StatMax - self.LerpStat)/(self.StatMax - self.StatMin), 0, 1)
	if not self.BadHigh then
		progress = 1 - progress
	end

	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawRect(0, 0, w, 5)
	surface.SetDrawColor(250, 250, 250, 20)
	surface.DrawRect(math.min(w * 0.95, w * progress), 0, 1, 5)
	surface.SetDrawColor(200 * (1 - progress), 200 * progress, 10, 160)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(0, 0, w * progress, 4)
end
vgui.Register("ZSItemStatBar", PANEL, "Panel")