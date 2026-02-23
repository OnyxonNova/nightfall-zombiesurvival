local ammonames = {
	["pistol"] = "pistolammo",
	["buckshot"] = "shotgunammo",
	["smg1"] = "smgammo",
	["ar2"] = "assaultrifleammo",
	["357"] = "rifleammo",
	["pulse"] = "pulseammo",
	["battery"] = "25mkit",
	["xbowbolt"] = "crossbowammo",
	["impactmine"] = "impactmine",
	["chemical"] = "chemical",
	["scrap"] = "scrapammo",
	["gaussenergy"] = "nail"
}

concommand.Add("zs_quickbuyammo", function()
	if ammonames[GAMEMODE.CachedResupplyAmmoType] then
		RunConsoleCommand("zs_pointsshopbuy", "ps_"..ammonames[GAMEMODE.CachedResupplyAmmoType])
	end
end)

local function GetViewModelPosition(self, pos, ang)
	return pos + ang:Forward() * -256, ang
end

function DontDrawViewModel()
	if SWEP then
		SWEP.GetViewModelPosition = GetViewModelPosition
	end
end

-- Scales the screen based around 1080p but doesn't make things TOO tiny on low resolutions.
function BetterScreenScale()
	return math.max(ScrH() / 1080, 0.851) * GAMEMODE.InterfaceSize
end

function render.GetLightRGB(pos)
	local vec = render.GetLightColor(pos)
	return vec.r, vec.g, vec.b
end

function EasyLabel(parent, text, font, textcolor)
	local dpanel = vgui.Create("DLabel", parent)
	if font then
		dpanel:SetFont(font or "DefaultFont")
	end
	dpanel:SetText(text)
	dpanel:SizeToContents()
	if textcolor then
		dpanel:SetTextColor(textcolor)
	end
	dpanel:SetKeyboardInputEnabled(false)
	dpanel:SetMouseInputEnabled(false)

	return dpanel
end

function EasyButton(parent, text, xpadding, ypadding)
	local dpanel = vgui.Create("DButton", parent)
	if textcolor then
		dpanel:SetFGColor(textcolor or color_white)
	end
	if text then
		dpanel:SetText(text)
	end
	dpanel:SizeToContents()

	if xpadding then
		dpanel:SetWide(dpanel:GetWide() + xpadding * 2)
	end

	if ypadding then
		dpanel:SetTall(dpanel:GetTall() + ypadding * 2)
	end

	return dpanel
end

function DEXDerma_Query(strText, strTitle, ...)
    local screenscale = BetterScreenScale()

    local Window = vgui.Create("DFrame")
    Window:SetTitle(" ")
    Window:SetDraggable(false)
    Window:ShowCloseButton(false)
    Window:SetBackgroundBlur(true)
    Window:SetDrawOnTop(true)

    local TitlePanel = vgui.Create("DLabel", Window)
    TitlePanel:SetText(strTitle)
    TitlePanel:SetFont(screenscale > 0.85 and "ZSBodyTextFont" or "DefaultFontAA")
    TitlePanel:SizeToContents()

    local InnerPanel = vgui.Create("DPanel", Window)
    InnerPanel:SetPaintBackground(false)

    local Text = vgui.Create("DLabel", InnerPanel)
    Text:SetFont("ZSHUDFontSmall")
    Text:SetText(strText)
    Text:SizeToContents()
    Text:SetContentAlignment(5)
    Text:SetTextColor(color_white)

    local ButtonPanel = vgui.Create("DPanel", Window)
    ButtonPanel:SetTall(50 * screenscale)
    ButtonPanel:SetPaintBackground(false)

    local NumOptions = 0
    local x = 5 * screenscale

    for o = 1, 8, 2 do
        local txt = select(o, ...)
        if txt == nil then
            break
        end

        local Func = select(o + 1, ...) or function() end

        local Button = vgui.Create("DButton", ButtonPanel)
        Button:SetFont("ZSHUDFontSmall")
        Button:SetText(txt)
        Button:SizeToContents()
        Button:SetTall(40 * screenscale)
        Button:SetWide(Button:GetWide() + 50 * screenscale)
        Button.DoClick = function()
            Window:Close()
            Func()
        end
        Button:SetPos(x, 0)

        x = x + Button:GetWide() + 5 * screenscale
        ButtonPanel:SetWide(x)

        NumOptions = NumOptions + 1
    end
    local w, h = Text:GetSize()
    w = math.max(w, ButtonPanel:GetWide())

    Window:SetSize(w * screenscale + 50 * screenscale, h * screenscale + 125 * screenscale)
    Window:Center()

    InnerPanel:StretchToParent(5 * screenscale, 0, 5 * screenscale, 75 * screenscale)
    Text:StretchToParent(5 * screenscale, 25 * screenscale, 5 * screenscale, 0)

    ButtonPanel:CenterHorizontal()
    ButtonPanel:AlignBottom(8)

    Window:MakePopup()
    Window:DoModal()

    return Window
end

function DEXDerma_StringRequest(strTitle, strText, strDefaultText, fnCancel, strButtonText, strButtonCancelText)
    local screenscale = BetterScreenScale()

    local Window = vgui.Create("DFrame")
    Window:SetTitle(" ")
    Window:SetDraggable(false)
    Window:ShowCloseButton(false)
    Window:SetBackgroundBlur(true)
    Window:SetDrawOnTop(true)

    local TitlePanel = vgui.Create("DLabel", Window)
    TitlePanel:SetText(strTitle)
    TitlePanel:SetFont(screenscale > 0.85 and "ZSBodyTextFont" or "DefaultFontAA")
    TitlePanel:SizeToContents()
    
    local InnerPanel = vgui.Create("DPanel", Window)
    InnerPanel:SetPaintBackground(false)

    local Text = vgui.Create("DLabel", InnerPanel)
    Text:SetFont("ZSHUDFontSmall")
    Text:SetText(strText)
    Text:SizeToContents()
    Text:SetContentAlignment(5)
    Text:SetTextColor(color_white)

    local TextPanel = vgui.Create("DPanel", InnerPanel)
    TextPanel:SetTall(40 * screenscale)

    local TextEntry = vgui.Create("DTextEntry", TextPanel)
    TextEntry:SetFont("ZSHUDFontSmall")
    TextEntry:SetText(strDefaultText)
    TextEntry:SetPaintBackground(false)
    TextEntry:Dock(FILL)
    TextEntry.OnEnter = function()
        Window:Close()
        fnCancel(TextEntry:GetValue())
    end

    local ButtonPanel = vgui.Create("DPanel", Window)
    ButtonPanel:SetTall(50 * screenscale)
    ButtonPanel:SetPaintBackground(false)

    local Button = vgui.Create("DButton", ButtonPanel)
    Button:SetFont("ZSHUDFontSmall")
    Button:SetText(translate.Get("dsr_ok"))
    Button:SizeToContents()
    Button:SetTall(40 * screenscale)
    Button:SetWide(Button:GetWide() + 50 * screenscale)
    Button:SetPos(5 * screenscale, 0)
    Button.DoClick = function()
        Window:Close()
        fnCancel(TextEntry:GetValue())
    end
    
    local ButtonCancel = vgui.Create("DButton", ButtonPanel)
    ButtonCancel:SetFont("ZSHUDFontSmall")
    ButtonCancel:SetText(translate.Get("dsr_cancel"))
    ButtonCancel:SizeToContents()
    ButtonCancel:SetTall(40 * screenscale)
    ButtonCancel:SetWide(Button:GetWide() + 50 * screenscale)
    ButtonCancel:SetPos(5 * screenscale, 0)
    ButtonCancel.DoClick = function()
        Window:Close()
        if (strButtonText) then
            strButtonText(TextEntry:GetValue())
        end
    end
    ButtonCancel:MoveRightOf(Button, 5 * screenscale)

    ButtonPanel:SetWide(Button:GetWide() + 5 * screenscale + ButtonCancel:GetWide() + 10 * screenscale)

    local w, h = Text:GetSize()
    w = math.max(w, 400)

    Window:SetSize(w * screenscale + 50 * screenscale, h * screenscale + 160 * screenscale)
    Window:Center()

    InnerPanel:StretchToParent(5 * screenscale, 0, 5 * screenscale, 75 * screenscale)
    Text:StretchToParent(5 * screenscale, 5 * screenscale, 5 * screenscale, 30 * screenscale)

    TextPanel:StretchToParent(5 * screenscale, nil, 5 * screenscale, nil)
    TextPanel:AlignBottom(5)

    TextEntry:RequestFocus()
    TextEntry:SelectAllText(true)

    ButtonPanel:CenterHorizontal()
    ButtonPanel:AlignBottom(8)

    Window:MakePopup()
    Window:DoModal()
    
    return Window
end
