OPTIONS_INTERFACE = 1
OPTIONS_PERFORMANCE = 2
OPTIONS_EFFECTS = 3
OPTIONS_GAMEPLAY = 4
OPTIONS_CROSSHAIR = 5
OPTIONS_SOUND = 6

local OptionsCategories = {
	[OPTIONS_INTERFACE] = translate.Get("options_category_interface"),
	[OPTIONS_PERFORMANCE] = translate.Get("options_category_performance"),
	[OPTIONS_EFFECTS] = translate.Get("options_category_effects"),
    [OPTIONS_GAMEPLAY] = translate.Get("options_category_game"),
    [OPTIONS_CROSSHAIR] = translate.Get("options_category_crosshair"),
	[OPTIONS_SOUND] = translate.Get("options_category_sound")
}

local function CheckBoxOption(text, convar, category, list, i)
    if i == category then
        local checkbox = vgui.Create("DEXCheckBoxLabel", pOptions)
        checkbox:SetText(text)
        checkbox:SetFont("ZSHUDFontSmallest")
        checkbox:SetTextColor(color_white)
        checkbox:SetConVar(convar)
        checkbox:SizeToContents()
        list:AddItem(checkbox)
    end
end

local function NumSliderOption(text, convar, decimal, min, max, category, list, i)
    if i == category then
        local numslider = vgui.Create("DNumSlider", pOptions)
        numslider:SetDecimals(decimal)
        numslider:SetMinMax(min, max)
        numslider:SetConVar(convar)
        numslider:SetText(text)
        numslider.Label:SetFont("ZSHUDFontSmallest")
        numslider.Label:SetTextColor(color_white)
        numslider:SizeToContents()
        list:AddItem(numslider)
    end
end

local function ColorPickerOption(text, u, category, list, i)
    if i == category then
        list:AddItem(EasyLabel(pOptions, text, "ZSHUDFontSmallest", color_white))
        colpicker = vgui.Create("DColorMixer", pOptions)
        colpicker:SetAlphaBar(u.ConvarA)
        colpicker:SetPalette(false)
        colpicker:SetConVarR(u.ConvarR)
        colpicker:SetConVarG(u.ConvarG)
        colpicker:SetConVarB(u.ConvarB)
        colpicker:SetConVarA(u.ConvarA)
        colpicker:SetTall(70 * BetterScreenScale())
        list:AddItem(colpicker)
    end
end

local function LabelOption(text, category, list, i)
    if i == category then
        local label = vgui.Create("DButton", pOptions)
        label:SetFont("ZSHUDFontSmall")
        label:SetText(text)
        label:SetTextColor(color_white)
        label:SetTall(draw.GetFontHeight("ZSHUDFontSmall") * BetterScreenScale())
        label:SetCursor("arrow")

        function label:Paint()
        end

        function label:UpdateColours()
        end

        list:AddItem(label)
    end
end

local function ComboBoxOption(text, convar, option, choices, category, list, i)
    if i == category then
        list:AddItem(EasyLabel(pOptions, text, "ZSHUDFontSmallest", color_white))
        dropdown = vgui.Create("DEXComboBox", pOptions)
        dropdown:SetMouseInputEnabled(true)
        for me, index in pairs(choices) do
            dropdown:AddChoice(index)
        end
        dropdown.OnSelect = function(me, index, value, data)
            RunConsoleCommand(convar, table.KeysFromValue(choices, value)[1])
        end
        dropdown:SetText(choices[GAMEMODE[option]] or choices[0] or "Unknown")
        dropdown:SetTall(28 * BetterScreenScale())
        dropdown:SetTextColor(color_white)
        list:AddItem(dropdown)
    end
end

local function BeatsComboBoxOption(text, convar, option, choices, category, list, i)
    if i == category then
        list:AddItem(EasyLabel(pOptions, text, "ZSHUDFontSmallest", color_white))
        dropdown = vgui.Create("DEXComboBox", pOptions)
        dropdown:SetMouseInputEnabled(true)
        for me in pairs(GAMEMODE.Beats) do
            if me ~= GAMEMODE[choices] then
                dropdown:AddChoice(me)
            end
        end
        dropdown:AddChoice("none")
        dropdown:AddChoice("default")
        dropdown.OnSelect = function(me, index, value, data)
            RunConsoleCommand(convar, value)
        end
        dropdown:SetText(GAMEMODE[option] == GAMEMODE[choices] and "default" or GAMEMODE[v])
        dropdown:SetTall(28 * BetterScreenScale())
        dropdown:SetTextColor(color_white)
        list:AddItem(dropdown)
    end
end

function GM:AddOptions(list, i)
    LabelOption(translate.Get("options_human"), OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_alwaysquickbuy"), "zs_alwaysquickbuy", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_enablemetalpointbuy"), "zs_enablemetalpointbuy", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_thirdpersonknockdown"), "zs_thirdpersonknockdown", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_nousetodeposit"), "zs_nousetodeposit", OPTIONS_GAMEPLAY, list, i)
    
    LabelOption(translate.Get("options_zombie"), OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_nobosspick"), "zs_nobosspick", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_suicideonchange"), "zs_suicideonchange", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_noredeem"), "zs_noredeem", OPTIONS_GAMEPLAY, list, i)

    LabelOption(translate.Get("options_props"), OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_alwaysshownails"), "zs_alwaysshownails", OPTIONS_GAMEPLAY, list, i)
    CheckBoxOption(translate.Get("options_nopickupprops"), "zs_nopickupprops", OPTIONS_GAMEPLAY, list, i)
    NumSliderOption(translate.Get("options_proprotationsens"), "zs_proprotationsens", 2, 0.1, 4, OPTIONS_GAMEPLAY, list, i)
    ComboBoxOption(translate.Get("options_proprotationsnap"), "zs_proprotationsnap", "PropRotationSnap", {[0] = translate.Get("options_proprotationsnap_0"), [15] = translate.Get("options_proprotationsnap_15"), [30] = translate.Get("options_proprotationsnap_30"), [45] = translate.Get("options_proprotationsnap_45")}, OPTIONS_GAMEPLAY, list, i)

    LabelOption(OptionsCategories[OPTIONS_INTERFACE], OPTIONS_INTERFACE, list, i)
    NumSliderOption(translate.Get("options_interfacesize"), "zs_interfacesize", 1, 0.7, 1.3, OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_hideshadowinterface"), "zs_hideshadowinterface", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_fonteffects"), "zs_fonteffects", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_drawxp"), "zs_drawxp", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_drawtotaldamage"), "zs_drawtotaldamage", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_messagebeaconshow"), "zs_messagebeaconshow", OPTIONS_INTERFACE, list, i)

    LabelOption(translate.Get("options_screen"), OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_drawpainflash"), "zs_drawpainflash", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_postprocessing"), "zs_postprocessing", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_colormod"), "zs_colormod", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_filmmode"), "zs_filmmode", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_filmgrain"), "zs_filmgrain", OPTIONS_INTERFACE, list, i)
    NumSliderOption(translate.Get("options_filmgrainopacity"), "zs_filmgrainopacity", 0, 0, 255, OPTIONS_INTERFACE, list, i)

    LabelOption(translate.Get("options_weapons"), OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_movementviewroll"), "zs_movementviewroll", OPTIONS_INTERFACE, list, i)
    CheckBoxOption(translate.Get("options_viewbobhands"), "zs_viewbobhands", OPTIONS_INTERFACE, list, i)
    ComboBoxOption(translate.Get("options_gethandsdisplay"), "zs_get_hands_display", "GetHandsDisplay", {[0] = translate.Get("options_gethandsdisplay_0"), [1] = translate.Get("options_gethandsdisplay_1"), [2] = translate.Get("options_gethandsdisplay_2")}, OPTIONS_INTERFACE, list, i)
    ComboBoxOption(translate.Get("options_weaponhudmode"), "zs_weaponhudmode", "WeaponHUDMode", {[0] = translate.Get("options_weaponhudmode_0"), [1] = translate.Get("options_weaponhudmode_1"), [2] = translate.Get("options_weaponhudmode_2")}, OPTIONS_INTERFACE, list, i)
    NumSliderOption(translate.Get("options_weaponposx"), "zs_weaponposx", 2, -10, 10, OPTIONS_INTERFACE, list, i)
    NumSliderOption(translate.Get("options_weaponposy"), "zs_weaponposy", 2, -10, 10, OPTIONS_INTERFACE, list, i)
    NumSliderOption(translate.Get("options_weaponposz"), "zs_weaponposz", 2, -10, 10, OPTIONS_INTERFACE, list, i)
    
    LabelOption(translate.Get("options_bloodandgibs"), OPTIONS_EFFECTS, list, i)
    CheckBoxOption(translate.Get("options_drawbloodparticles"), "zs_drawbloodparticles", OPTIONS_EFFECTS, list, i)
    CheckBoxOption(translate.Get("options_drawheadshotbloodparticles"), "zs_drawheadshotbloodparticles", OPTIONS_EFFECTS, list, i)
    CheckBoxOption(translate.Get("options_drawshotbloodparticles"), "zs_drawshotbloodparticles", OPTIONS_EFFECTS, list, i)
    ComboBoxOption(translate.Get("options_drawplayergibs"), "zs_drawplayergibs", "DrawPlayerGibs", {[0] = translate.Get("options_drawplayergibs_0"), [1] = translate.Get("options_drawplayergibs_1")}, OPTIONS_EFFECTS, list, i)

    LabelOption(translate.Get("options_damagefloaters"), OPTIONS_EFFECTS, list, i)
    CheckBoxOption(translate.Get("options_damagefloaterswalls"), "zs_damagefloaterswalls", OPTIONS_EFFECTS, list, i)
    NumSliderOption(translate.Get("options_dmgnumberscale"), "zs_dmgnumberscale", 1, 0.5, 2, OPTIONS_EFFECTS, list, i)
    NumSliderOption(translate.Get("options_dmgnumberspeed"), "zs_dmgnumberspeed", 1, 0, 1, OPTIONS_EFFECTS, list, i)
    NumSliderOption(translate.Get("options_dmgnumberlife"), "zs_dmgnumberlife", 1, 0.2, 1.5, OPTIONS_EFFECTS, list, i)

    LabelOption(translate.Get("options_healthaura"), OPTIONS_EFFECTS, list, i)
    CheckBoxOption(translate.Get("options_auras"), "zs_auras", OPTIONS_EFFECTS, list, i)
    ColorPickerOption(translate.Get("options_auracolorfull"), {ConvarR = "zs_auracolor_full_r", ConvarG = "zs_auracolor_full_g", ConvarB = "zs_auracolor_full_b"}, OPTIONS_EFFECTS, list, i)
    ColorPickerOption(translate.Get("options_auracolorempty"), {ConvarR = "zs_auracolor_empty_r", ConvarG = "zs_auracolor_empty_g", ConvarB = "zs_auracolor_empty_b"}, OPTIONS_EFFECTS, list, i)

    LabelOption(translate.Get("options_droppeditems"), OPTIONS_PERFORMANCE, list, i)
    CheckBoxOption(translate.Get("options_enablelootdrawbox"), "zs_enablelootdrawbox", OPTIONS_PERFORMANCE, list, i)
    ComboBoxOption(translate.Get("options_getlootsdisplay"), "zs_get_loots_display", "GetLootsDisplay", {[0] = translate.Get("options_getlootsdisplay_0"), [1] = translate.Get("options_getlootsdisplay_1")}, OPTIONS_PERFORMANCE, list, i)

    LabelOption(translate.Get("options_transparency"), OPTIONS_PERFORMANCE, list, i)
    CheckBoxOption(translate.Get("options_showfriends"), "zs_showfriends", OPTIONS_PERFORMANCE, list, i)
    NumSliderOption(translate.Get("options_transparencyradius"), "zs_transparencyradius", 0, 0, self.TransparencyRadiusMax, OPTIONS_PERFORMANCE, list, i)
    NumSliderOption(translate.Get("options_transparencyradius3p"), "zs_transparencyradius3p", 0, 0, self.TransparencyRadiusMax, OPTIONS_PERFORMANCE, list, i)

    LabelOption("SWEP Construction Kit", OPTIONS_PERFORMANCE, list, i)
    CheckBoxOption(translate.Get("options_drawsckweaponspls"), "zs_drawsckweaponspls", OPTIONS_PERFORMANCE, list, i)

    LabelOption(OptionsCategories[OPTIONS_CROSSHAIR], OPTIONS_CROSSHAIR, list, i)
    CheckBoxOption(translate.Get("options_disablescopes"), "zs_disablescopes", OPTIONS_CROSSHAIR, list, i)
    CheckBoxOption(translate.Get("options_noironsights"), "zs_noironsights", OPTIONS_CROSSHAIR, list, i)
    CheckBoxOption(translate.Get("options_nocrosshairrotate"), "zs_nocrosshairrotate", OPTIONS_CROSSHAIR, list, i)
    NumSliderOption(translate.Get("options_ironsightzoom"), "zs_ironsightzoom", 2, 0, 1, OPTIONS_CROSSHAIR, list, i)
    NumSliderOption(translate.Get("options_crosshairlines"), "zs_crosshairlines", 0, 2, 8, OPTIONS_CROSSHAIR, list, i)
    NumSliderOption(translate.Get("options_crosshairoffset"), "zs_crosshairoffset", 0, 0, 90, OPTIONS_CROSSHAIR, list, i)
    NumSliderOption(translate.Get("options_crosshairthickness"), "zs_crosshairthickness", 1, 0, 5, OPTIONS_CROSSHAIR, list, i)
    ColorPickerOption(translate.Get("options_crosshaircol"), {ConvarR = "zs_crosshair_colr", ConvarG = "zs_crosshair_colg", ConvarB = "zs_crosshair_colb", ConvarA = "zs_crosshair_cola"}, OPTIONS_CROSSHAIR, list, i)
    ColorPickerOption(translate.Get("options_crosshaircol2"), {ConvarR = "zs_crosshair_colr2", ConvarG = "zs_crosshair_colg2", ConvarB = "zs_crosshair_colb2", ConvarA = "zs_crosshair_cola2"}, OPTIONS_CROSSHAIR, list, i)

    LabelOption(OptionsCategories[OPTIONS_SOUND], OPTIONS_SOUND, list, i)
    BeatsComboBoxOption(translate.Get("options_beatsethuman"), "zs_beatset_human", "BeatSetHuman", "BeatSetHumanDefault", OPTIONS_SOUND, list, i)
    BeatsComboBoxOption(translate.Get("options_beatsetzombie"), "zs_beatset_zombie", "BeatSetZombie", "BeatSetZombieDefault", OPTIONS_SOUND, list, i)
    NumSliderOption(translate.Get("options_beatsvolume"), "zs_beatsvolume", 0, 0, 100, OPTIONS_SOUND, list, i)
    CheckBoxOption(translate.Get("options_beats"), "zs_beats", OPTIONS_SOUND, list, i)
    CheckBoxOption(translate.Get("options_playmusic"), "zs_playmusic", OPTIONS_SOUND, list, i)
    CheckBoxOption(translate.Get("options_hitsoundenable"), "zs_hitsoundenable", OPTIONS_SOUND, list, i)
end

function GM:MakeOptions()
	PlayMenuOpenSound()

	if pOptions then
		pOptions:SetAlpha(0)
		pOptions:AlphaTo(255, 0.15, 0)
		pOptions:SetVisible(true)
		pOptions:MakePopup()
		return
	end

	local screenscale = BetterScreenScale()

	local wid, hei = 800 * screenscale, 700 * screenscale
	local y = 8 * screenscale

	local frame = vgui.Create("DFrame")
	frame:SetSize(wid, hei)
	frame:Center()
	frame:SetTitle(" ")
	frame:SetDeleteOnClose(false)
	pOptions = frame

	local title = EasyLabel(frame, translate.Get("f1_settings"), "ZSScoreBoardTitle", color_white)
    title:SetPos(wid * 0.5 - title:GetWide() * 0.5, y)

	y = y + title:GetTall() + 8 * screenscale

	local tabpane = vgui.Create("DPanel", frame)
	tabpane.Paint = function() end
	tabpane.Grids = {}
	tabpane.Buttons = {}
	tabpane:SetSize(w, h - y)
    tabpane:SetPos(0, y)
    tabpane:SetPaintBackground(false)

	local itemframe = vgui.Create("DScrollPanel", tabpane)
    itemframe:SetSize(frame:GetWide(), hei - y - 80 * screenscale)
    itemframe:SetPos(0, 80 * screenscale)
	local function mkgrid()
        local list = vgui.Create("DPanelList", itemframe)
        list:SetSize(itemframe:GetWide(), itemframe:GetTall())
        list:SetPos(0, 0)
        list:SetPadding(8)
        list:SetSpacing(4)
        list:EnableVerticalScrollbar(true)
        return list
    end

	for i = 1, #OptionsCategories do
		local categorybutton = EasyButton(tabpane, OptionsCategories[i], 2, 8)
		categorybutton:SetFont("ZSHUDFontTiny")
        categorybutton:SetAlpha(i == 1 and 255 or 125)
        categorybutton:SetColor(i == 1 and SELECT_COLOR or COLOR_WHITE)
		categorybutton:SetContentAlignment(5)
		categorybutton:SetSize(155 * screenscale, 32 * screenscale)
		categorybutton:AlignLeft((categorybutton:GetWide()) + (((i-1) % 3) + 1 - 1) * 170 * screenscale)
		categorybutton:AlignTop(i <= 3 and 0 or 0 + 45 * screenscale)
		categorybutton.DoClick = function(me)
			for k, v in pairs(tabpane.Grids) do
                v:SetVisible(k == i)
                tabpane.Buttons[k]:SetColor(k == i and SELECT_COLOR or COLOR_WHITE)
                tabpane.Buttons[k]:SetAlpha(k == i and 255 or 100)
            end
			itemframe:GetVBar():SetScroll(0)
		end

		tabpane.Grids[i] = mkgrid()
        tabpane.Grids[i]:SetVisible(i == 1)
        tabpane.Buttons[i] = categorybutton

		self:AddOptions(tabpane.Grids[i], i)
	end

    frame:SetAlpha(0)
	frame:AlphaTo(255, 0.15, 0)
	frame:MakePopup()
end