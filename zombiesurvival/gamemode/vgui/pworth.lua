function InitialWorthMenu()
	timer.Create("WaitUntilSkillsLoaded", 0, 0, function()
		if GAMEMODE.ReceivedInitialSkills then
			timer.Remove("WaitUntilSkillsLoaded")
			MakepWorth()
		end
	end)
end

local ExtraStartingWorth = 0
function GetStartingWorth()
	return GAMEMODE.StartingWorth + ExtraStartingWorth
end

net.Receive("zs_extrastartingworth", function(len)
	ExtraStartingWorth = net.ReadUInt(6)
end)

local cvarDefaultCart = CreateClientConVar("zs_defaultcart", "", true, false)

local function DefaultDoClick(btn)
	if cvarDefaultCart:GetString() == btn.Name then
		RunConsoleCommand("zs_defaultcart", "")
		surface.PlaySound("buttons/button11.wav")
	else
		RunConsoleCommand("zs_defaultcart", btn.Name)
		surface.PlaySound("buttons/button14.wav")
	end

	timer.Simple(0.1, MakepWorth)
end

local remainingworth = 0
local WorthButtons = {}

local function Checkout(tobuy)
	if tobuy and #tobuy > 0 then
		gamemode.Call("SuppressArsenalUpgrades", 1)

		RunConsoleCommand("worthcheckout", unpack(tobuy))

		if pWorth and pWorth:IsValid() then
			pWorth:Close()
		end
	else
		surface.PlaySound("buttons/combine_button_locked.wav")
	end
end

local function CheckoutDoClick(self)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, btn.ID)
		end
	end

	if remainingworth >= 0 then
		Checkout(tobuy)
	else
		surface.PlaySound("buttons/button8.wav")
	end
end

local function RandDoClick(self)
	gamemode.Call("SuppressArsenalUpgrades", 1)

	RunConsoleCommand("worthrandom")

	if pWorth and pWorth:IsValid() then
		pWorth:Close()
	end
end

GM.SavedCarts = {}
hook.Add("Initialize", "LoadCarts", function()
	if file.Exists(GAMEMODE.CartFile, "DATA") then
		GAMEMODE.SavedCarts = Deserialize(file.Read(GAMEMODE.CartFile)) or {}
	end
end)

local function ClearCartDoClick()
	for _, btn in ipairs(WorthButtons) do
		if btn.On then
			btn:DoClick(true, true)
		end
	end

	surface.PlaySound("buttons/button11.wav")
end

local function ClickWorthButton(id)
	local result = true
	for _, btn in pairs(WorthButtons) do
		if not btn then continue end

		if btn.ID == id or btn.Signature == id then
			result = btn:DoClick(true, true)
			break
		end
	end
	return result
end

local function LoadCart(cartid, silent)
	if not GAMEMODE.SavedCarts[cartid] then return end

	MakepWorth()

	for _, id in pairs(GAMEMODE.SavedCarts[cartid][2]) do
		if not ClickWorthButton(id) then
			surface.PlaySound("buttons/button8.wav")
			return false
		end
	end

	if not silent then
		surface.PlaySound("buttons/combine_button1.wav")
	end

	return true
end

local function LoadDoClick(self)
	LoadCart(self.ID)
end

local function SaveCurrentCart(name)
	local tobuy = {}
	for _, btn in pairs(WorthButtons) do
		if btn and btn.On and btn.ID then
			table.insert(tobuy, FindStartingItem(btn.ID).Signature)
		end
	end

	for i, cart in ipairs(GAMEMODE.SavedCarts) do
		if string.lower(cart[1]) == string.lower(name) then
			cart[1] = name
			cart[2] = tobuy

			file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))

			LoadCart(i, true)
			return
		end
	end

	GAMEMODE.SavedCarts[#GAMEMODE.SavedCarts + 1] = {name, tobuy}

	file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))

	LoadCart(#GAMEMODE.SavedCarts, true)
end

local function MoveDoClick(self, down)
    if GAMEMODE.SavedCarts[self.ID] then
        surface.PlaySound(down and "npc/scanner/scanner_scan2.wav" or "npc/scanner/scanner_scan4.wav")

        local move = (down and -1 or 1)

		local name = nil
        local tobuy = {}
        local pos = nil

        local movedname = nil
        local movedtobuy = {}
        local movedpos = nil

        for i, cart in ipairs(GAMEMODE.SavedCarts) do
            if (down and self.ID == #GAMEMODE.SavedCarts) or (self.ID == 1 and not down) then
                return
            end

            if i == self.ID then
                name = cart[1]
                tobuy = cart[2]
                pos = i - move
            end

            if i == self.ID - move then
                movedname = cart[1]
                movedtobuy = cart[2]
                movedpos = i + move
            end
        end

        GAMEMODE.SavedCarts[pos] = {name, tobuy}
        GAMEMODE.SavedCarts[movedpos] = {movedname, movedtobuy}

        file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
		
        MakepWorth(true)
    end
end

local function n(self, name)
    surface.PlaySound("buttons/button4.wav")

    local defaultcart = cvarDefaultCart:GetString()
    local defaultrenamed = false
	
    local tobuy = {}
    local pos = nil

    for i, savetab in ipairs(GAMEMODE.SavedCarts) do
        if savetab[1] == name then
            MakepWorth()
            return
        end
		
        if i == self.ID then
            tobuy = savetab[2]
            pos = i
            if savetab[1] == defaultcart then
                defaultrenamed = true
            end
        end
    end

    GAMEMODE.SavedCarts[pos] = {name, tobuy}
    file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
	
    if defaultrenamed then
        RunConsoleCommand("zs_defaultcart", name)
        timer.Simple(0.1, MakepWorth)
    else
        MakepWorth()
    end
end

local function RenameDoClick(self)
    local cartname = translate.Get("worth_menu_name")
    for i, cart in ipairs(GAMEMODE.SavedCarts) do
        if i == self.ID then
            cartname = cart[1]
        end
    end

    local frame = DEXDerma_StringRequest(translate.Get("worth_menu_renamecart"), translate.Get("worth_menu_newnamecart"), cartname,
        function(i) n(self, i) end, 
		function(i) end)
end

local function SaveDoClick(self)
	local frame = DEXDerma_StringRequest(translate.Get("worth_menu_savecart"), translate.Get("worth_menu_namecart"), translate.Get("worth_menu_name"),
	function(strTextOut) SaveCurrentCart(strTextOut) end,
	function(strTextOut) end,
	translate.Get("worth_menu_ok"), translate.Get("worth_menu_cancel"))
end

local function DeleteDoClick(self)
	if GAMEMODE.SavedCarts[self.ID] then
		table.remove(GAMEMODE.SavedCarts, self.ID)
		file.Write(GAMEMODE.CartFile, Serialize(GAMEMODE.SavedCarts))
		surface.PlaySound("buttons/button19.wav")
		MakepWorth()
	end
end

local function QuickCheckDoClick(self)
	if GAMEMODE.SavedCarts[self.ID] and LoadCart(self.ID, true) then
		Checkout(GAMEMODE.SavedCarts[self.ID][2])
	end
end

local function WorthThink(self)
	if MySelf:Team() ~= TEAM_HUMAN then
		self:Close()
	end
end

function MakepWorth(noalpha)
	if pWorth and pWorth:IsValid() then
		pWorth:Remove()
		pWorth = nil
	end

	remainingworth = GetStartingWorth()

	local screenscale = BetterScreenScale()
	local wid, hei = math.min(ScrW(), 900) * screenscale, math.min(ScrH(), 800) * screenscale
	local tabhei = 30 * screenscale

	local frame = vgui.Create("DFrame")
	pWorth = frame
	frame:SetSize(wid, hei)
	frame:SetDeleteOnClose(true)
	frame:SetKeyboardInputEnabled(false)
	frame:SetTitle(" ")
	--frame.Think = WorthThink

	if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
	if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end

	local topspace = vgui.Create("DPanel", frame)
	topspace:SetWide(wid * 0.75)
	topspace:SetPaintBackground(false)

	local title = EasyLabel(topspace, translate.Get("worth_menu_title"), "ZSHUDFontSmall", COLOR_WHITE)
	title:CenterHorizontal()
	local subtitle = EasyLabel(topspace, translate.Get("worth_menu_subtitle"), "ZSHUDFontTiny", COLOR_WHITE)
	subtitle:CenterHorizontal()
	subtitle:MoveBelow(title, 4)

	local _, y = subtitle:GetPos()
	topspace:SetTall(y + subtitle:GetTall() + 4)
	topspace:AlignTop(8)
	topspace:CenterHorizontal()

	local bottomspace = vgui.Create("DPanel", frame)
	bottomspace:SetWide(topspace:GetWide())
	bottomspace:SetPaintBackground(false)

	local lab = EasyLabel(bottomspace, " ", "ZSHUDFontTiny")
	lab:AlignTop(4)
	lab:AlignRight(4)
	frame.m_SpacerBottomLabel = lab

	_, y = lab:GetPos()
	bottomspace:SetTall(y + lab:GetTall() + 4)
	bottomspace:AlignBottom(16)
	bottomspace:CenterHorizontal()

	local __, topy = topspace:GetPos()
	local ___, boty = bottomspace:GetPos()

	local propertysheet = vgui.Create("DEXPropertySheet", frame)
	propertysheet:SetSize(wid, boty - topy - 8 - topspace:GetTall())
	propertysheet:MoveBelow(topspace, 4)
	propertysheet:SetPadding(1)
	propertysheet.Paint = function() end

	local list = vgui.Create("DPanelList", propertysheet)
	local sheet = propertysheet:AddSheet(translate.Get("itemcat_favorites"), list, "icon16/heart.png", false, false)
	sheet.Panel:SetPos(0, tabhei + 2)
	list:EnableVerticalScrollbar(true)
	list:SetWide(propertysheet:GetWide() - 16)
	list:SetSpacing(2)
	list:SetPadding(2)

	local savebutton = EasyButton(nil, translate.Get("worth_menu_savebut"), 0, 10)
	savebutton.DoClick = SaveDoClick
	savebutton:SetFont("ZSHUDFontTiny")
	list:AddItem(savebutton)

	local panfont = "ZSHUDFontSmall"
	local panhei = 40 * screenscale

	local defaultcart = cvarDefaultCart:GetString()

	for i, savetab in ipairs(GAMEMODE.SavedCarts) do
		local cartpan = vgui.Create("DEXRoundedPanel")
		cartpan:SetCursor("pointer")
		cartpan:SetSize(list:GetWide(), panhei)

		local cartname = savetab[1]

		local x = 8
		local limitedscale = math.Clamp(screenscale, 1, 1.5)

		if defaultcart == cartname then
			local defimage = vgui.Create("DImage", cartpan)
			defimage:SetImage("icon16/heart.png")
			defimage:SizeToContents()
			defimage:SetSize(19 * limitedscale, 19 * limitedscale)
			defimage:SetMouseInputEnabled(true)
			defimage:SetTooltipPanelOverride("DExTooltip")
			defimage:SetTooltip(translate.Get("worth_menu_default"))
			defimage:SetPos(x, cartpan:GetTall() * 0.5 - defimage:GetTall() * 0.5)
			x = x + defimage:GetWide() + 4
		end

		local cartnamelabel = EasyLabel(cartpan, cartname, panfont)
		cartnamelabel:SetPos(x, cartpan:GetTall() * 0.5 - cartnamelabel:GetTall() * 0.5)

		x = cartpan:GetWide()

		local checkbutton = vgui.Create("DImageButton", cartpan)
		checkbutton:SetImage("icon16/accept.png")
		checkbutton:SizeToContents()
		checkbutton:SetSize(19 * limitedscale, 19 * limitedscale)
		checkbutton:SetTooltipPanelOverride("DExTooltip")
		checkbutton:SetTooltip(translate.Get("worth_menu_checkbut"))
		x = x - checkbutton:GetWide() - 8
		checkbutton:SetPos(x, cartpan:GetTall() * 0.5 - checkbutton:GetTall() * 0.5)
		checkbutton.ID = i
		checkbutton.DoClick = QuickCheckDoClick

		local loadbutton = vgui.Create("DImageButton", cartpan)
		loadbutton:SetImage("icon16/folder_go.png")
		loadbutton:SizeToContents()
		loadbutton:SetSize(19 * limitedscale, 19 * limitedscale)
		loadbutton:SetTooltipPanelOverride("DExTooltip")
		loadbutton:SetTooltip(translate.Get("worth_menu_loadbut"))
		x = x - loadbutton:GetWide() - 8
		loadbutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		loadbutton.ID = i
		loadbutton.DoClick = LoadDoClick

		local defaultbutton = vgui.Create("DImageButton", cartpan)
		defaultbutton:SetImage("icon16/heart.png")
		defaultbutton:SizeToContents()
		defaultbutton:SetSize(19 * limitedscale, 19 * limitedscale)
		defaultbutton:SetTooltipPanelOverride("DExTooltip")
		if cartname == defaultcart then
			defaultbutton:SetTooltip(translate.Get("worth_menu_defdelbut"))
		else
			defaultbutton:SetTooltip(translate.Get("worth_menu_defmakebut"))
		end
		x = x - defaultbutton:GetWide() - 8
		defaultbutton:SetPos(x, cartpan:GetTall() * 0.5 - defaultbutton:GetTall() * 0.5)
		defaultbutton.Name = cartname
		defaultbutton.DoClick = DefaultDoClick

		local renamebutton = vgui.Create("DImageButton", cartpan)
        renamebutton:SetImage("icon16/pencil.png")
        renamebutton:SizeToContents()
        renamebutton:SetSize(19 * screenscale, 19 * screenscale)
        renamebutton:SetTooltipPanelOverride("DExTooltip")
        renamebutton:SetTooltip(translate.Get("worth_menu_renamebut"))
        x = x - renamebutton:GetWide() - 8
        renamebutton:SetPos(x, cartpan:GetTall() * 0.5 - renamebutton:GetTall() * 0.5)
        renamebutton.ID = i
        renamebutton.DoClick = RenameDoClick

		local deletebutton = vgui.Create("DImageButton", cartpan)
		deletebutton:SetImage("icon16/bin.png")
		deletebutton:SizeToContents()
		deletebutton:SetSize(19 * limitedscale, 19 * limitedscale)
		deletebutton:SetTooltipPanelOverride("DExTooltip")
		deletebutton:SetTooltip(translate.Get("worth_menu_defsavebut"))
		x = x - deletebutton:GetWide() - 8
		deletebutton:SetPos(x, cartpan:GetTall() * 0.5 - loadbutton:GetTall() * 0.5)
		deletebutton.ID = i
		deletebutton.DoClick = DeleteDoClick

		local infobutton = vgui.Create("DImageButton", cartpan)
		infobutton:SetImage("icon16/information.png")
        infobutton:SizeToContents()
        infobutton:SetSize(19 * screenscale, 19 * screenscale)
        infobutton:SetTooltipPanelOverride("DExTooltip")
        infobutton:SetTooltip(translate.Get("worth_menu_infobut"))
        x = x - infobutton:GetWide() - 8
        infobutton:SetPos(x, cartpan:GetTall() * 0.5 - infobutton:GetTall() * 0.5)
        infobutton.ID = i
        infobutton.DoClick = function()
            pWorth:Remove()
            GAMEMODE:MakeItemsDisplay(infobutton.ID, cartname)
        end

		local moveupbutton = vgui.Create("DImageButton", cartpan)
        moveupbutton:SetImage("icon16/arrow_up.png")
        moveupbutton:SizeToContents()
        moveupbutton:SetSize(19 * screenscale, 19 * screenscale)
        moveupbutton:SetTooltipPanelOverride("DExTooltip")
        moveupbutton:SetTooltip(translate.Get("worth_menu_moveupbut"))
        x = x - moveupbutton:GetWide() - 8
        moveupbutton:SetPos(x, cartpan:GetTall() * 0.5 - moveupbutton:GetTall() * 0.5)
        moveupbutton.ID = i
        moveupbutton.DoClick = function()
            MoveDoClick(moveupbutton)
        end

        local movedownbutton = vgui.Create("DImageButton", cartpan)
        movedownbutton:SetImage("icon16/arrow_down.png")
        movedownbutton:SizeToContents()
        movedownbutton:SetSize(19 * screenscale, 19 * screenscale)
        movedownbutton:SetTooltipPanelOverride("DExTooltip")
        movedownbutton:SetTooltip(translate.Get("worth_menu_movedownbut"))
        x = x - movedownbutton:GetWide() - 8
        movedownbutton:SetPos(x, cartpan:GetTall() * 0.5 - movedownbutton:GetTall() * 0.5)
        movedownbutton.ID = i
        movedownbutton.DoClick = function()
            MoveDoClick(movedownbutton, true)
        end

		list:AddItem(cartpan)
	end

	local bannedcats = {[ITEMCAT_BUILDING] = true}

	for catid, catname in ipairs(GAMEMODE.ItemCategories) do
		if bannedcats[catid] then continue end

		local tabpane = vgui.Create("DPanel", propertysheet)
		tabpane.Paint = function() end
		tabpane.Grids = {}
		tabpane.Buttons = {}

		local offset = 64 * screenscale
		local trinkets = catid == ITEMCAT_TRINKETS
		
		local itemframe = vgui.Create("DScrollPanel", tabpane)
		itemframe:SetSize(propertysheet:GetWide(), propertysheet:GetTall() - offset - 32)
		itemframe:SetPos(0, trinkets and offset or 0)

		local mkgrid = function()
			list = vgui.Create("DGrid", itemframe)
			list:SetSize(propertysheet:GetWide() - 328, propertysheet:GetTall() - 32)
			list:SetCols(2)
			list:SetColWide(290 * screenscale)
			list:SetRowHeight(100 * screenscale)

			return list
		end

		local subtrink = trinkets and GAMEMODE.ItemSubCategories

		if trinkets then
			local ind, tbn = 1
			for i = ind, #subtrink do
				local ispacer = (i - 1) % 3 + 1
				local start = i == ind

				tbn = EasyButton(tabpane, subtrink[i], 2, 8)
				tbn:SetFont("ZSHUDFontSmallest")
				tbn:SetAlpha(start and 255 or 70)
				tbn:SetColor(start and SELECT_COLOR or COLOR_WHITE)
				tbn:SetContentAlignment(5)
				tbn:SetSize(130 * screenscale, 30 * screenscale)
				tbn:AlignRight(-100 * screenscale - (ispacer - ind) * (ind == 1 and 190 or 145) * screenscale)
				tbn:AlignTop((i <= 3 and 0 or 30) * screenscale)

				tbn.DoClick = function(me)
					for k, v in pairs(tabpane.Grids) do
						v:SetVisible(k == i)
						tabpane.Buttons[k]:SetColor(k == i and SELECT_COLOR or COLOR_WHITE)
						tabpane.Buttons[k]:SetAlpha(k == i and 255 or 70)
					end
				end

				tabpane.Grids[i] = mkgrid()
				tabpane.Grids[i]:SetVisible(i == 1)
				tabpane.Buttons[i] = tbn
			end
		else
			tabpane.Grid = mkgrid()
		end

		sheet = propertysheet:AddSheet(catname, tabpane, GAMEMODE.ItemCategoryIcons[catid], false, false)
		sheet.Panel:SetPos(0, tabhei + 2)

		for i, tab in ipairs(GAMEMODE.Items) do
			if tab.Category == catid and tab.WorthShop then
				local button = vgui.Create("ZSWorthButton")
				button:SetWorthID(i)
				local listeradd = trinkets and tabpane.Grids[tab.SubCategory] or tabpane.Grid or tapbane.Grids[1]
				listeradd:AddItem(button)
				WorthButtons[i] = button
			end
		end
	end

	local worthlab = EasyLabel(frame, translate.Get("worth_menu_worthlab") .. tostring(remainingworth) .. "/" .. GetStartingWorth(), "ZSHUDFontSmall", COLOR_LIMEGREEN)
	worthlab:SetPos(8, frame:GetTall() - worthlab:GetTall() - 8)
	frame.WorthLab = worthlab

	local checkout = vgui.Create("DButton", frame)
	checkout:SetFont("ZSHUDFontSmall")
	checkout:SetText(translate.Get("worth_menu_checkout"))
	checkout:SizeToContents()
	checkout:SetSize(130 * screenscale, 36 * screenscale)
	checkout:AlignBottom(8)
	checkout:CenterHorizontal()
	checkout.DoClick = CheckoutDoClick

	local clearbutton = vgui.Create("DButton", frame)
	clearbutton:SetFont("ZSHUDFontSmallest")
	clearbutton:SetText(translate.Get("worth_menu_clear"))
	clearbutton:SetSize(100 * screenscale, 30 * screenscale)
	clearbutton:AlignBottom(8)
	clearbutton:AlignRight(8)
	clearbutton.DoClick = ClearCartDoClick

	frame:Center()

	if not noalpha then
		frame:SetAlpha(0)
		frame:AlphaTo(255, 0.15, 0)
	end

	frame:MakePopup()

	local scroller = propertysheet:GetChildren()[1]
	local dragbase = scroller:GetChildren()[1]
	local tabs = dragbase:GetChildren()

	GAMEMODE:CreateItemInfoViewer(frame, propertysheet, topspace, bottomspace, MENU_WORTH)
	GAMEMODE:ConfigureMenuTabs(tabs, tabhei, function(tabpanel)
		pWorth.Viewer:SetVisible(tabpanel ~= tabs[1])
	end)

	if #GAMEMODE.SavedCarts == 0 then
		propertysheet:SetActiveTab(propertysheet.Items[math.min(2, #propertysheet.Items)].Tab)
	else
		propertysheet:SwitchToName(translate.Get("itemcat_favorites"))
	end

	return frame
end

local PANEL = {}
PANEL.m_ItemID = 0
PANEL.RefreshTime = 1
PANEL.NextRefresh = 0

function PANEL:Init()
	local screenscale = BetterScreenScale()

	self:SetFont(screenscale > 1.5 and "DefaultFontLargest" or "DefaultFontSmall")
end

function PANEL:Think()
	if CurTime() >= self.NextRefresh then
		self.NextRefresh = CurTime() + self.RefreshTime
		self:RefreshWorth()
	end
end

function PANEL:RefreshWorth()
	local count = GAMEMODE:GetCurrentEquipmentCount(self:GetItemID())
	if count == 0 then
		self:SetText(" ")
	else
		self:SetText(count)
	end

	self:SizeToContents()
end

function PANEL:SetItemID(id) self.m_ItemID = id end
function PANEL:GetItemID() return self.m_ItemID end

vgui.Register("ItemAmountCounter", PANEL, "DLabel")

PANEL = {}

function PANEL:Init()
	self:SetText("")

	local screenscale = BetterScreenScale()

	local wid = 285

	self:SetWide(wid * screenscale)
	self:SetTall(100 * screenscale)

	self.ModelFrame = vgui.Create("DPanel", self)
	self.ModelFrame:SetSize(wid/2 * screenscale, 100/2 * screenscale)
	self.ModelFrame:SetPos(wid/4 * screenscale, 100/5 * screenscale)
	self.ModelFrame:SetVisible(false)
	self.ModelFrame:SetMouseInputEnabled(false)
	self.ModelFrame.Paint = function() end

	self.NameLabel = EasyLabel(self, "", "ZSHUDFontSmallest")
	self.NameLabel:SetContentAlignment(4)
	self.NameLabel:DockPadding(0, 0, 0, 0)
	self.NameLabel:DockMargin(0, 0, 0, 0)
	--self.NameLabel:Dock(FILL)

	self.PriceLabel = EasyLabel(self, "", "ZSHUDFontTiny")
	self.PriceLabel:SetContentAlignment(4)
	self.PriceLabel:DockPadding(0, 0, 0, 0)
	--self.PriceLabel:Dock(RIGHT)
	self.PriceLabel:DockMargin(8, 0, 8 * screenscale, 0)

	self.ItemCounter = vgui.Create("ItemAmountCounter", self)

	self:SetWorthID(nil)
end

function PANEL:SetWorthID(id)
	self.ID = id

	local tab = FindStartingItem(id)
	local screenscale = BetterScreenScale()

	if not tab then
		self.ModelFrame:SetVisible(false)
		self.ItemCounter:SetVisible(false)
		self.NameLabel:SetText("")
		return
	end

	self.Signature = tab.Signature
	self.Price = tab.Price

	local missing_skill = tab.SkillRequirement and not MySelf:IsSkillActive(tab.SkillRequirement) and not GAMEMODE.TestingMode

	local nottrinkets = tab.Category ~= ITEMCAT_TRINKETS
	self:SetTall(100 * screenscale)

	self.ModelFrame:SetVisible(true)
	local kitbl = killicon.Get(tab.SWEP or tab.Model)
	if kitbl then
		GAMEMODE:AttachKillicon(kitbl, self, self.ModelFrame, tab.Category == ITEMCAT_AMMO, missing_skill)
	elseif tab.Model then
		local mdlpanel = vgui.Create("DModelPanel", self.ModelFrame)
		mdlpanel:SetSize(self.ModelFrame:GetSize())
		mdlpanel:SetModel(tab.Model)
		local mins, maxs = mdlpanel.Entity:GetRenderBounds()
		mdlpanel:SetCamPos(mins:Distance(maxs) * Vector(0.75, 0.75, 0.5))
		mdlpanel:SetLookAt((mins + maxs) / 2)
	end

	if tab.SWEP or tab.Countables then
		self.ItemCounter:SetItemID(id)
		self.ItemCounter:SetVisible(true)
	else
		self.ItemCounter:SetVisible(false)
	end

	if missing_skill then
		self.PriceLabel:SetTextColor(COLOR_RED)
		self.PriceLabel:SetText(GAMEMODE.Skills[tab.SkillRequirement].Name)
	elseif tab.Price then
		self.PriceLabel:SetText(tostring(tab.Price)..translate.Get("worth_menu_worth"))
	else
		self.PriceLabel:SetText("")
	end
	self.PriceLabel:SizeToContents()
	self.PriceLabel:SetPos(
		self:GetWide() - self.PriceLabel:GetWide() - 12 * screenscale,
		self:GetTall() * 0.15 - self.PriceLabel:GetTall() * 0.5
	)

	local desctext = tab.Category == ITEMCAT_AMMO and tab.Name or tab.Description
    if not nottrinkets then
        desctext = translate.Get(desctext)
    end

	self:SetTooltipPanelOverride("DExTooltip")
	self:SetTooltip(desctext)

	if missing_skill or tab.NoZombieEscape and GAMEMODE.ZombieEscape then
		self:SetAlpha(120)
		self.Locked = true
	else
		self:SetAlpha(255)
	end

	if tab.SubCategory then
		local catlabel = EasyLabel(self, GAMEMODE.ItemSubCategories[tab.SubCategory], "ZSHUDFontTiny")
		catlabel:SizeToContents()
		catlabel:SetPos(10, self:GetTall() * 0.15 - catlabel:GetTall() * 0.5)
	end

	self.NameLabel:SetText(GAMEMODE.ZSInventoryItemData[tab.SWEP] and translate.Get(tab.Name) or tab.Name or "")
	self.NameLabel:SetPos(12 * screenscale, self:GetTall() * 0.8 - self.NameLabel:GetTall() * 0.5)
	self.NameLabel:SizeToContents()
end

local colBG = Color(15, 15, 15, 255)
local colSel = Color(15, 40, 15, 255)
function PANEL:Paint(w, h)
	local outline
	if self.Hovered then
		outline = self.On and COLOR_MIDGRAY or (self.Locked or not self.On and remainingworth < self.Price) and COLOR_RED or self.Depressed and COLOR_GREEN or COLOR_DARKGREEN

		draw.RoundedBox(8, 0, 0, w, h, outline)
	end

	draw.RoundedBox(2, 4, 4, w - 8, h - 8, self.On and colSel or colBG)

	return true
end

function PANEL:OnCursorEntered()
	local shoptbl = FindStartingItem(self.ID)
	if not shoptbl then return end

	local sweptable = GAMEMODE.ZSInventoryItemData[shoptbl.SWEP] or weapons.Get(shoptbl.SWEP)
	GAMEMODE:SupplyItemViewerDetail(pWorth.Viewer, sweptable, shoptbl, shoptbl.Category == ITEMCAT_AMMO)
end

--[[function PANEL:OnCursorExited()
end]]

function PANEL:DoClick(silent, force)
	local id = self.ID
	local tab = FindStartingItem(id)
	local goodcart = true

	if not tab then return end

	if self.On then
		self.On = nil
		if not silent then
			surface.PlaySound("buttons/button18.wav")
		end
		remainingworth = remainingworth + tab.Price
	elseif tab.SkillRequirement and not MySelf:IsSkillActive(tab.SkillRequirement) then
		surface.PlaySound("buttons/button8.wav")
		return
	else
		if remainingworth < tab.Price then
			if not force then
				surface.PlaySound("buttons/button8.wav")
				return
			else
				goodcart = false
			end
		end
		self.On = true
		if not silent then
			surface.PlaySound("buttons/button17.wav")
		end
		remainingworth = remainingworth - tab.Price
	end

	pWorth.WorthLab:SetText(translate.Get("worth_menu_worthlab") .. remainingworth .. "/" .. GetStartingWorth())
	if remainingworth <= 0 then
		pWorth.WorthLab:SetTextColor(COLOR_RED)
		pWorth.WorthLab:InvalidateLayout()
	elseif remainingworth < GetStartingWorth() then
		pWorth.WorthLab:SetTextColor(COLOR_YELLOW)
		pWorth.WorthLab:InvalidateLayout()
	else
		pWorth.WorthLab:SetTextColor(COLOR_LIMEGREEN)
		pWorth.WorthLab:InvalidateLayout()
	end
	pWorth.WorthLab:SizeToContents()

	return goodcart
end

vgui.Register("ZSWorthButton", PANEL, "DButton")
