local colBG = Color(15, 15, 15, 255)
local function ItemPanelPaint(self, w, h)
    if self.Hovered or self.On then
        draw.RoundedBox(8, 0, 0, w, h, self.Depressed and COLOR_MIDGRAY or COLOR_DARKGRAY)
    end
    draw.RoundedBox(2, 4, 4, w - 8, h - 8, colBG)

    return true
end

local function AddItemDisplay(list, id, frame)
    local playerworth = GAMEMODE.StartingWorth 
    local PriceLabel = EasyLabel(frame, translate.Get("worth_menu_worthlab") .. playerworth .. "/" .. GetStartingWorth(), "ZSHUDFontSmall", COLOR_LIMEGREEN)

    PriceLabel:SetPos(8, frame:GetTall() - PriceLabel:GetTall() - 8)
    for _, itemid in pairs(GAMEMODE.SavedCarts[id][2]) do
        local screenscale = BetterScreenScale()
        local tab = FindStartingItem(itemid)
        local missing_skill = tab.SkillRequirement and not MySelf:IsSkillActive(tab.SkillRequirement) and not GAMEMODE.SandboxMode
        local wid = 285
        local itempan = vgui.Create("DButton")
        itempan:SetText("")
        itempan:SetSize(wid * screenscale, 100 * screenscale)
        itempan.Paint = ItemPanelPaint
        itempan.OnCursorEntered = function(itempan)
            local shoptbl = tab
            if not shoptbl then
                return
            end

            local sweptable = GAMEMODE.ZSInventoryItemData[tab.SWEP] or weapons.Get(tab.SWEP)
            local viewerdisplay = GAMEMODE.pItemsDisplay.Viewer

            GAMEMODE:SupplyItemViewerDetail(viewerdisplay, sweptable, shoptbl)
        end

        local desctext = tab.Category == ITEMCAT_AMMO and tab.Name or tab.Description

        if tab.Category == ITEMCAT_TRINKETS then
            desctext = translate.Get(desctext)
        end

        itempan:SetTooltipPanelOverride("DExTooltip")
        itempan:SetTooltip(desctext)

        local name = GAMEMODE.ZSInventoryItemData[tab.SWEP] and translate.Get(tab.Name) or tab.Name or ""
        local itempanname = EasyLabel(itempan, name, "ZSHUDFontSmallest", COLOR_WHITE)
        itempanname:SetPos(12 * screenscale, itempan:GetTall() * 0.8 - itempanname:GetTall() * 0.5)
        
        if missing_skill then
            itempanname:SetAlpha(30)
        end

        local itempanPriceLabel = EasyLabel(itempan, "", "ZSHUDFontTiny")
        itempanPriceLabel:SetContentAlignment(4)
        itempanPriceLabel:DockPadding(0, 0, 0, 0)
        itempanPriceLabel:DockMargin(8, 0, 8 * screenscale, 0)
        if missing_skill then
            itempanPriceLabel:SetTextColor(COLOR_RED)
            itempanPriceLabel:SetText(GAMEMODE.Skills[tab.SkillRequirement].Name)
        elseif tab.Price then
            itempanPriceLabel:SetText(tostring(tab.Price) .. translate.Get("worth_menu_worth"))
        else
            itempanPriceLabel:SetText("")
        end

        itempanPriceLabel:SizeToContents()
        itempanPriceLabel:SetPos(itempan:GetWide() - itempanPriceLabel:GetWide() - 12 * screenscale, itempan:GetTall() * 0.15 - itempanPriceLabel:GetTall() * 0.5)
        list:AddItem(itempan)

        local mdlframe = vgui.Create("DPanel", itempan)
        mdlframe:SetSize(wid / 2 * screenscale, 100 / 2 * screenscale)
        mdlframe:SetPos(wid / 4 * screenscale, 100 / 5 * screenscale)
        mdlframe:SetMouseInputEnabled(false)
        mdlframe.Paint = function()
        end

        if tab.SubCategory then
		    local catlabel = EasyLabel(itempan, GAMEMODE.ItemSubCategories[tab.SubCategory], "ZSHUDFontTiny")
		    catlabel:SizeToContents()
		    catlabel:SetPos(10, itempan:GetTall() * 0.15 - catlabel:GetTall() * 0.5)
	    end

        local killicon = killicon.Get(tab.SWEP or tab.Model)
        if killicon then
            GAMEMODE:AttachKillicon(killicon, itempan, mdlframe, tab.Category == ITEMCAT_AMMO, missing_skill)
        end

        playerworth = playerworth - tab.Price
        PriceLabel:SetText(translate.Get("worth_menu_worthlab") .. playerworth .. "/" .. GetStartingWorth())
        if playerworth <= 0 then
            PriceLabel:SetTextColor(COLOR_RED)
            PriceLabel:InvalidateLayout()
        elseif playerworth < GetStartingWorth() then
            PriceLabel:SetTextColor(COLOR_YELLOW)
            PriceLabel:InvalidateLayout()
        else
            PriceLabel:SetTextColor(COLOR_LIMEGREEN)
            PriceLabel:InvalidateLayout()
        end
        PriceLabel:SizeToContents()
    end
end

function GM:MakeItemsDisplay(id, cartname)
    local screenscale = BetterScreenScale()
    local w, h = math.min(ScrW(), 900) * screenscale, math.min(ScrH(), 800) * screenscale
    local y = 8 * screenscale
    local frame = vgui.Create("DFrame")
    frame:SetSize(w, h)
    frame:Center()
    frame:SetTitle(" ")

    if frame.btnMinim and frame.btnMinim:IsValid() then frame.btnMinim:SetVisible(false) end
    if frame.btnMaxim and frame.btnMaxim:IsValid() then frame.btnMaxim:SetVisible(false) end

    self.pItemsDisplay = frame
    local title = EasyLabel(frame, "Информация выбора", "ZSScoreBoardTitle", color_white)
    title:SetPos(w * 0.5 - title:GetWide() * 0.5, y)
    y = y + title:GetTall() + 8 * screenscale

    local subtitle = EasyLabel(frame, "Вы просматриваете выбор - " .. cartname, "ZSHUDFontTiny", color_white)
    subtitle:CenterHorizontal()
    subtitle:MoveBelow(title, 4)
    y = y + subtitle:GetTall()

    local itemframe = vgui.Create("DPanel", frame)
    itemframe.Grids = {}
    itemframe:SetSize(w, h - y)
    itemframe:SetPos(0, y)
    itemframe:SetPaintBackground(false)

    local panhei = 64 * screenscale

    local itemframe = vgui.Create("DScrollPanel", itemframe)
    itemframe:SetSize(frame:GetWide(), frame:GetTall() - panhei - 18 * screenscale)
    itemframe:SetPos(0, 20 * screenscale)
    local mkgrid = function()
        local list = vgui.Create("DGrid", itemframe)
        list:SetSize(frame:GetWide() - 285, frame:GetTall() - 140 * screenscale)
        list:SetCols(2)
        list:SetColWide(285 * screenscale)
        list:SetRowHeight(100 * screenscale)
        return list
    end

    itemframe.Grids = mkgrid()

    AddItemDisplay(itemframe.Grids, id, frame)
    
    self:CreateItemInfoViewer(frame, itemframe, itemframe, itemframe, MENU_ITEMDISPLAY)

    local backbutton = vgui.Create("DButton", frame)
    backbutton:SetFont("ZSHUDFontSmall")
    backbutton:SetText("Назад")
    backbutton:SizeToContents()
    backbutton:SetSize(130 * screenscale, 36 * screenscale)
    backbutton:AlignBottom(8)
    backbutton:CenterHorizontal()
    backbutton.DoClick = function()
        frame:Close()
        MakepWorth()
    end

    frame:SetAlpha(0)
    frame:AlphaTo(255, 0.15, 0)
    frame:MakePopup()
end
