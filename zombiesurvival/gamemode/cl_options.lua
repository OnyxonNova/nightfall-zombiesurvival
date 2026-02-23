GM.BeatSetHumanDefault = "defaulthuman"
GM.BeatSetZombieDefault = "defaultzombiev2"

GM.ItemCategoryIcons = {
	[ITEMCAT_GUNS] = "icon16/gun.png",
	[ITEMCAT_AMMO] = "icon16/box.png",
	[ITEMCAT_MELEE] = "icon16/cog.png",
	[ITEMCAT_TOOLS] = "icon16/wrench.png",
	[ITEMCAT_DEPLOYABLES] = "icon16/package.png",
	[ITEMCAT_OTHER] = "icon16/world.png",
	[ITEMCAT_TRINKETS] = "icon16/ruby.png",
	[ITEMCAT_BUILDING] = "icon16/house.png"
}

GM.RemortColors = {
	[9] = COLOR_TAN,
	[8] = COLOR_BROWN,
	[7] = COLOR_RPINK,
	[6] = COLOR_RPURPLE,
	[5] = COLOR_CYAN,
	[4] = COLOR_GREEN,
	[3] = COLOR_YELLOW,
	[2] = COLOR_RORANGE,
	[1] = COLOR_RED
}

GM.SpeedToText = {
	[SPEED_NORMAL] = translate.Get("st_sp_normal"),
	[SPEED_SLOWEST] = translate.Get("st_sp_slowest"),
	[SPEED_SLOWER] = translate.Get("st_sp_slower"),
	[SPEED_SLOW] = translate.Get("st_sp_slow"),
	[SPEED_FAST] = translate.Get("st_sp_fast"),
	[SPEED_FASTER] = translate.Get("st_sp_faster"),
	[SPEED_FASTEST] = translate.Get("st_sp_fastest"),
	[-1] = translate.Get("st_sp_ulslow"),
}

GM.AmmoToPurchaseNames = {
	["pistol"] = "pistolammo",
	["buckshot"] = "shotgunammo",
	["smg1"] = "smgammo",
	["ar2"] = "assaultrifleammo",
	["357"] = "rifleammo",
	["pulse"] = "pulseammo",
	["XBowBolt"] = "crossbowammo",
	["impactmine"] = "impactmine",
	["chemical"] = "chemical"
}

GM.WeaponStatBarVals = {
	{"Heal", translate.Get("st_heal"), 10, 30, false},
    {"HealRange", translate.Get("st_healr"), 18, 70, false},
	{"HealCoolDown", translate.Get("st_healc"), 5, 15	, false, "Primary"},

	{"HealStrength", translate.Get("st_heals"), 1, 16, false},

	{"MeleeDamage", translate.Get("st_mdam"), 2, 140, false},
	{"MeleeRange", translate.Get("st_range"), 30, 100, false},
	{"MeleeSize", translate.Get("st_msize"), 0.2, 3, false},
	{"MeleeKnockBack", translate.Get("st_mknock"), 75, 250, false},

	{"Damage", translate.Get("st_dam"), 1, 105, false, "Primary"},
	{"Delay", translate.Get("st_mdelay"), 0.05, 2, true, "Primary"},

	{"Pierces", translate.Get("st_pierces"), -2, 9, false},
	{"HeadshotMulti", translate.Get("st_hdam"), 1, 2.5, false},
	{"LegDamage", translate.Get("st_ldam"), 0, 15, false},

	{"ProjVelocity",  translate.Get("st_projspeed"), 1200, 1600, false, "Primary"},
	{"ClipSize", translate.Get("st_clipsize"), 1, 35, false, "Primary"},

	{"ConeMin", translate.Get("st_conemin"), 0, 5, true},
	{"ConeMax", translate.Get("st_conemax"), 1.5, 7, true},

	{"DamageDrone", translate.Get("st_ddam"), 0, 40, false, "Primary"},
	{"HitCooldown", translate.Get("st_mhitc"), 0, 40, false},
	{"CarryMass", translate.Get("st_maxweight"), 0, 40, false},

	{"TurretDelay", translate.Get("st_mdelay"), 0.5, 2, true},
	{"TurretSpread", translate.Get("st_turretspread"), 2, 7, true},

	{"MagnetStrength", translate.Get("st_mstrength"), 0.5, 2, false},

	{"WalkSpeed", translate.Get("st_move"), 200, 250, false}
}

GM.LifeStatsLifeTime = 5

GM.RewardIcons = {}
GM.RewardIcons["weapon_zs_barricadekit"] = "models/props_debris/wood_board05a.mdl"

GM.CrosshairColor = Color(CreateClientConVar("zs_crosshair_colr", "255", true, false):GetInt(), CreateClientConVar("zs_crosshair_colg", "255", true, false):GetInt(), CreateClientConVar("zs_crosshair_colb", "255", true, false):GetInt(), CreateClientConVar("zs_crosshair_cola", "220", true, false):GetInt())
GM.CrosshairColor2 = Color(CreateClientConVar("zs_crosshair_colr2", "220", true, false):GetInt(), CreateClientConVar("zs_crosshair_colg2", "0", true, false):GetInt(), CreateClientConVar("zs_crosshair_colb2", "0", true, false):GetInt(), CreateClientConVar("zs_crosshair_cola2", "220", true, false):GetInt())
cvars.AddChangeCallback("zs_crosshair_colr", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.r = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_colg", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.g = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_colb", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.b = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_cola", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor.a = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_colr2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.r = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_colg2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.g = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_colb2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.b = tonumber(newvalue) or 255 end)
cvars.AddChangeCallback("zs_crosshair_cola2", function(cvar, oldvalue, newvalue) GAMEMODE.CrosshairColor2.a = tonumber(newvalue) or 255 end)

GM.FilmMode = CreateClientConVar("zs_filmmode", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_filmmode", function(cvar, oldvalue, newvalue)
	GAMEMODE.FilmMode = tonumber(newvalue) == 1

	gamemode.Call("EvaluateFilmMode")
end)

CreateClientConVar("zs_noredeem", "0", true, true)
CreateClientConVar("zs_nobosspick", "0", true, true)
CreateClientConVar("zs_nousetodeposit", "0", true, true)
CreateClientConVar("zs_nopickupprops", "0", true, true)
CreateClientConVar("zs_enablemetalpointbuy", "0", true, true)

GM.DisableScopes = CreateClientConVar("zs_disablescopes", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_disablescopes", function(cvar, oldvalue, newvalue)
	GAMEMODE.DisableScopes = tonumber(newvalue) == 1
end)

GM.IronsightZoomScale = math.Clamp(CreateClientConVar("zs_ironsightzoom", 1, true, false):GetFloat(), 0, 1)
cvars.AddChangeCallback("zs_ironsightzoom", function(cvar, oldvalue, newvalue)
	GAMEMODE.IronsightZoomScale = math.Clamp(tonumber(newvalue) or 1, 0, 1)
end)

GM.ThirdPersonKnockdown = CreateClientConVar("zs_thirdpersonknockdown", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_thirdpersonknockdown", function(cvar, oldvalue, newvalue)
	GAMEMODE.ThirdPersonKnockdown = tonumber(newvalue) == 1
end)

GM.SuicideOnChangeClass = CreateClientConVar("zs_suicideonchange", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_suicideonchange", function(cvar, oldvalue, newvalue)
	GAMEMODE.SuicideOnChangeClass = tonumber(newvalue) == 1
end)

GM.BeatsEnabled = CreateClientConVar("zs_beats", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_beats", function(cvar, oldvalue, newvalue)
	GAMEMODE.BeatsEnabled = tonumber(newvalue) == 1
end)

GM.DamageNumberThroughWalls = CreateClientConVar("zs_damagefloaterswalls", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_damagefloaterswalls", function(cvar, oldvalue, newvalue)
	GAMEMODE.DamageNumberThroughWalls = tonumber(newvalue) == 1
end)

GM.BeatsVolume = math.Clamp(CreateClientConVar("zs_beatsvolume", 80, true, false):GetInt(), 0, 100) / 100
cvars.AddChangeCallback("zs_beatsvolume", function(cvar, oldvalue, newvalue)
	GAMEMODE.BeatsVolume = math.Clamp(tonumber(newvalue) or 0, 0, 100) / 100
end)

GM.CrosshairLines = math.Clamp(CreateClientConVar("zs_crosshairlines", 4, true, false):GetInt(), 2, 8)
cvars.AddChangeCallback("zs_crosshairlines", function(cvar, oldvalue, newvalue)
	GAMEMODE.CrosshairLines = math.Clamp(tonumber(newvalue) or 4, 2, 8)
end)

GM.CrosshairOffset = math.Clamp(CreateClientConVar("zs_crosshairoffset", 0, true, false):GetInt(), 0, 90)
cvars.AddChangeCallback("zs_crosshairoffset", function(cvar, oldvalue, newvalue)
	GAMEMODE.CrosshairOffset = math.Clamp(tonumber(newvalue) or 0, 0, 90)
end)

GM.CrosshairThickness = math.Clamp(CreateClientConVar("zs_crosshairthickness", 1, true, false):GetFloat(), 0.5, 2)
cvars.AddChangeCallback("zs_crosshairthickness", function(cvar, oldvalue, newvalue)
	GAMEMODE.CrosshairThickness = math.Clamp(tonumber(newvalue) or 1, 0.5, 2)
end)

GM.PropRotationSensitivity = math.Clamp(CreateClientConVar("zs_proprotationsens", 1, true, false):GetFloat(), 0.1, 4)
cvars.AddChangeCallback("zs_proprotationsens", function(cvar, oldvalue, newvalue)
	GAMEMODE.PropRotationSensitivity = math.Clamp(tonumber(newvalue) or 1, 0.1, 4)
end)

GM.PropRotationSnap = math.Clamp(CreateClientConVar("zs_proprotationsnap", 0, true, false):GetInt(), 0, 45)
cvars.AddChangeCallback("zs_proprotationsnap", function(cvar, oldvalue, newvalue)
	GAMEMODE.PropRotationSnap = math.Clamp(tonumber(newvalue) or 0, 0, 45)
end)

GM.DamageNumberScale = math.Clamp(CreateClientConVar("zs_dmgnumberscale", 1, true, false):GetFloat(), 0.5, 2)
cvars.AddChangeCallback("zs_dmgnumberscale", function(cvar, oldvalue, newvalue)
	GAMEMODE.DamageNumberScale = math.Clamp(tonumber(newvalue) or 1, 0.5, 2)
end)

GM.DamageNumberSpeed = math.Clamp(CreateClientConVar("zs_dmgnumberspeed", 1, true, false):GetFloat(), 0, 1)
cvars.AddChangeCallback("zs_dmgnumberspeed", function(cvar, oldvalue, newvalue)
	GAMEMODE.DamageNumberSpeed = math.Clamp(tonumber(newvalue) or 1, 0, 1)
end)

GM.DamageNumberLifetime = math.Clamp(CreateClientConVar("zs_dmgnumberlife", 1, true, false):GetFloat(), 0.2, 1.5)
cvars.AddChangeCallback("zs_dmgnumberlife", function(cvar, oldvalue, newvalue)
	GAMEMODE.DamageNumberLifetime = math.Clamp(tonumber(newvalue) or 1, 0.2, 1.5)
end)

GM.InterfaceSize = math.Clamp(CreateClientConVar("zs_interfacesize", 1, true, false):GetFloat(), 0.7, 1.3)
cvars.AddChangeCallback("zs_interfacesize", function(cvar, oldvalue, newvalue)
	if not GAMEMODE.EmptyCachedFontHeights then return end

	GAMEMODE.InterfaceSize = math.Clamp(math.Round(tonumber(newvalue), 1) or 1, 0.7, 1.3)

	GAMEMODE:CreateScalingFonts()
    GAMEMODE:EmptyCachedFontHeights()

    local screenscale = BetterScreenScale()

    GAMEMODE.GameStatePanel:InvalidateLayout()
    GAMEMODE.GameStatePanel:SetSize(screenscale * 825, screenscale * 80)
   	GAMEMODE.TopNotificationHUD:InvalidateLayout()
    GAMEMODE.CenterNotificationHUD:InvalidateLayout()
    GAMEMODE.HealthHUD:InvalidateLayout()
    GAMEMODE.StatusHUD:InvalidateLayout()
    GAMEMODE.XPHUD:InvalidateLayout()

	if GAMEMODE.RemantlerViewer and GAMEMODE.RemantlerViewer:IsValid() then
        GAMEMODE.RemantlerViewer:Remove()
        GAMEMODE.RemantlerViewer = nil
    end

    if GAMEMODE.InventoryMenu and GAMEMODE.InventoryMenu:IsValid() then
        GAMEMODE.InventoryMenu:Remove()
        GAMEMODE.InventoryMenu = nil
        if GAMEMODE.m_InvViewer and GAMEMODE.m_InvViewer:IsValid() then
            GAMEMODE.m_InvViewer:Remove()
            GAMEMODE.m_InvViewer = nil
        end
        if GAMEMODE.AmmoViewer and GAMEMODE.AmmoViewer:IsValid() then
            GAMEMODE.AmmoViewer:Remove()
            GAMEMODE.AmmoViewer = nil
        end
    end
	
	GAMEMODE.ArsenalInterface = nil

	databasepanel = nil
	ModelSelectionPanel = nil

    GAMEMODE:ScoreboardRebuild()
end)

GM.AlwaysShowNails = CreateClientConVar("zs_alwaysshownails", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_alwaysshownails", function(cvar, oldvalue, newvalue)
	GAMEMODE.AlwaysShowNails = tonumber(newvalue) == 1
end)

GM.AlwaysQuickBuy = CreateClientConVar("zs_alwaysquickbuy", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_alwaysquickbuy", function(cvar, oldvalue, newvalue)
	GAMEMODE.AlwaysQuickBuy = tonumber(newvalue) == 1
end)

GM.NoIronsights = CreateClientConVar("zs_noironsights", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_noironsights", function(cvar, oldvalue, newvalue)
	GAMEMODE.NoIronsights = tonumber(newvalue) == 1
end)

GM.NoCrosshairRotate = CreateClientConVar("zs_nocrosshairrotate", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_nocrosshairrotate", function(cvar, oldvalue, newvalue)
	GAMEMODE.NoCrosshairRotate = tonumber(newvalue) == 1
end)

GM.HideShadowInterface = CreateClientConVar("zs_hideshadowinterface", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_hideshadowinterface", function(cvar, oldvalue, newvalue)
	GAMEMODE.HideShadowInterface = tonumber(newvalue) == 1
end)

GM.TransparencyRadiusMax = 2048
GM.TransparencyRadius = 0

GM.TransparencyRadius1p = math.Clamp(CreateClientConVar("zs_transparencyradius", 140, true, false):GetInt(), 0, GM.TransparencyRadiusMax) ^ 2
cvars.AddChangeCallback("zs_transparencyradius", function(cvar, oldvalue, newvalue)
	GAMEMODE.TransparencyRadius1p = math.Clamp(tonumber(newvalue) or 0, 0, GAMEMODE.TransparencyRadiusMax) ^ 2
end)

GM.TransparencyRadius3p = math.Clamp(CreateClientConVar("zs_transparencyradius3p", 140, true, false):GetInt(), 0, GM.TransparencyRadiusMax) ^ 2
cvars.AddChangeCallback("zs_transparencyradius3p", function(cvar, oldvalue, newvalue)
	GAMEMODE.TransparencyRadius3p = math.Clamp(tonumber(newvalue) or 0, 0, GAMEMODE.TransparencyRadiusMax) ^ 2
end)

GM.MovementViewRoll = CreateClientConVar("zs_movementviewroll", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_movementviewroll", function(cvar, oldvalue, newvalue)
	GAMEMODE.MovementViewRoll = tonumber(newvalue) == 1
end)

GM.MessageBeaconShow = CreateClientConVar("zs_messagebeaconshow", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_messagebeaconshow", function(cvar, oldvalue, newvalue)
	GAMEMODE.MessageBeaconShow = tonumber(newvalue) == 1
end)

GM.WeaponHUDMode = CreateClientConVar("zs_weaponhudmode", "0", true, false):GetInt()
cvars.AddChangeCallback("zs_weaponhudmode", function(cvar, oldvalue, newvalue)
	GAMEMODE.WeaponHUDMode = tonumber(newvalue) or 0
end)

GM.DrawPainFlash = CreateClientConVar("zs_drawpainflash", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_drawpainflash", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawPainFlash = tonumber(newvalue) == 1
end)

GM.DisplayXPHUD = CreateClientConVar("zs_drawxp", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_drawxp", function(cvar, oldvalue, newvalue)
	GAMEMODE.DisplayXPHUD = tonumber(newvalue) == 1
	gamemode.Call("EvaluateFilmMode")
end)

GM.FontEffects = CreateClientConVar("zs_fonteffects", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_fonteffects", function(cvar, oldvalue, newvalue)
	GAMEMODE.FontEffects = tonumber(newvalue) == 1
end)

GM.AlwaysDrawFriend = CreateClientConVar("zs_showfriends", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_showfriends", function(cvar, oldvalue, newvalue)
	GAMEMODE.AlwaysDrawFriend = tonumber(newvalue) == 1
end)

GM.GetLootsDisplay = math.Clamp(CreateClientConVar("zs_get_loots_display", 0, true, false):GetInt(), 0, 1)
cvars.AddChangeCallback("zs_get_loots_display", function(cvar, oldvalue, newvalue)
	GAMEMODE.GetLootsDisplay = math.Clamp(tonumber(newvalue) or 1, 0, 1)
end)

GM.GetHandsDisplay = math.Clamp(CreateClientConVar("zs_get_hands_display", 0, true, false):GetInt(), 0, 2)
cvars.AddChangeCallback("zs_get_hands_display", function(cvar, oldvalue, newvalue)
	GAMEMODE.GetHandsDisplay = math.Clamp(tonumber(newvalue) or 1, 0, 2)
end)

GM.EnableLootDrawBox = CreateClientConVar("zs_enablelootdrawbox", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_enablelootdrawbox", function(cvar, oldvalue, newvalue)
	GAMEMODE.EnableLootDrawBox = tonumber(newvalue) == 1
end)

GM.HitSounds = CreateClientConVar("zs_hitsoundenable", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_hitsoundenable", function(cvar, oldvalue, newvalue)
	GAMEMODE.HitSounds = tonumber(newvalue) == 1
end)

CreateConVar( "cl_playercolor", "0.24 0.34 0.41", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "The value is a Vector - so between 0-1 - not between 0-255" )
CreateConVar( "cl_weaponcolor", "0.30 1.80 2.10", { FCVAR_ARCHIVE, FCVAR_USERINFO }, "The value is a Vector - so between 0-1 - not between 0-255" )

CreateConVar("cl_playerskin", "0", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD}, "The skin to use, if the model has any")

GM.BeatSetHuman = CreateClientConVar("zs_beatset_human", "default", true, false):GetString()
cvars.AddChangeCallback("zs_beatset_human", function(cvar, oldvalue, newvalue)
	newvalue = tostring(newvalue)
	if newvalue == "default" then
		GAMEMODE.BeatSetHuman = GAMEMODE.BeatSetHumanDefault
	else
		GAMEMODE.BeatSetHuman = newvalue
	end
end)
if GM.BeatSetHuman == "default" then
	GM.BeatSetHuman = GM.BeatSetHumanDefault
end

GM.BeatSetZombie = CreateClientConVar("zs_beatset_zombie", "default", true, false):GetString()
cvars.AddChangeCallback("zs_beatset_zombie", function(cvar, oldvalue, newvalue)
	newvalue = tostring(newvalue)
	if newvalue == "default" then
		GAMEMODE.BeatSetZombie = GAMEMODE.BeatSetZombieDefault
	else
		GAMEMODE.BeatSetZombie = newvalue
	end
end)
if GM.BeatSetZombie == "default" then
	GM.BeatSetZombie = GM.BeatSetZombieDefault
end

GM.DrawTotalDamage = CreateClientConVar("zs_drawtotaldamage", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_drawtotaldamage", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawTotalDamage = tonumber(newvalue) == 1
end)

GM.ViewBobToggle = CreateClientConVar("zs_viewbobhands", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_viewbobhands", function(cvar, oldvalue, newvalue)
	GAMEMODE.ViewBobToggle = tonumber(newvalue) == 1
end)

GM.DrawBloodParticles = CreateClientConVar("zs_drawbloodparticles", "1", true, false):GetBool()
cvars.AddChangeCallback("zs_drawbloodparticles", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawBloodParticles = tonumber(newvalue) == 1
end)

GM.DrawShotBloodParticles = CreateClientConVar("zs_drawshotbloodparticles", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_drawshotbloodparticles", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawShotBloodParticles = tonumber(newvalue) == 1
end)

GM.DrawHeadShotBloodParticles = CreateClientConVar("zs_drawheadshotbloodparticles", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_drawheadshotbloodparticles", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawHeadShotBloodParticles = tonumber(newvalue) == 1
end)

GM.DrawPlayerGibs = CreateClientConVar("zs_drawplayergibs", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_drawplayergibs", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawPlayerGibs = tonumber(newvalue) == 1
end)

GM.DrawSCKWeapons = CreateClientConVar("zs_drawsckweaponspls", "0", true, false):GetBool()
cvars.AddChangeCallback("zs_drawsckweaponspls", function(cvar, oldvalue, newvalue)
	GAMEMODE.DrawSCKWeapons = tonumber(newvalue) == 1
end)

GM.WeaponPosX = math.Clamp(CreateClientConVar("zs_weaponposx", 0, true, false):GetFloat(), -10, 10)
cvars.AddChangeCallback("zs_weaponposx", function(b, c, d)
    GAMEMODE.WeaponPosX = math.Clamp(tonumber(d) or 0, -10, 10)
end)

GM.WeaponPosY = math.Clamp(CreateClientConVar("zs_weaponposy", 0, true, false):GetFloat(), -10, 10)
cvars.AddChangeCallback("zs_weaponposy", function(b, c, d)
    GAMEMODE.WeaponPosY = math.Clamp(tonumber(d) or 0, -10, 10)
end)

GM.WeaponPosZ = math.Clamp(CreateClientConVar("zs_weaponposz", 0, true, false):GetFloat(), -10, 10)
cvars.AddChangeCallback("zs_weaponposz", function(b, c, d)
    GAMEMODE.WeaponPosZ = math.Clamp(tonumber(d) or 0, -10, 10)
end)