GM.ZombieEscapeWeaponsPrimary = {
	"weapon_zs_zeakbar",
	"weapon_zs_zesweeper",
	"weapon_zs_zesmg",
	"weapon_zs_zeinferno",
	"weapon_zs_zestubber",
	"weapon_zs_zebulletstorm",
	"weapon_zs_zesilencer",
	"weapon_zs_zequicksilver",
	"weapon_zs_zeamigo",
	"weapon_zs_zem4"
}

GM.ZombieEscapeWeaponsSecondary = {
	"weapon_zs_zedeagle",
	"weapon_zs_zebattleaxe",
	"weapon_zs_zeeraser",
	"weapon_zs_zeglock",
	"weapon_zs_zetempest"
}

-- Change this if you plan to alter the cost of items or you severely change how Worth works.
-- Having separate cart files allows people to have separate loadouts for different servers.
GM.CartFile = "nzscarts.txt"
GM.SkillLoadoutsFile = "nzsskloadouts.txt"
GM.FavoriteFile = "nzsfavorites.txt"

ITEMCAT_GUNS = 1
ITEMCAT_AMMO = 2
ITEMCAT_MELEE = 3
ITEMCAT_TOOLS = 4
ITEMCAT_DEPLOYABLES = 5
ITEMCAT_TRINKETS = 6
ITEMCAT_OTHER = 7
ITEMCAT_BUILDING = 8

ITEMSUBCAT_TRINKETS_DEFENSIVE = 1
ITEMSUBCAT_TRINKETS_HEALTH = 2
ITEMSUBCAT_TRINKETS_SUPPORT = 3
ITEMSUBCAT_TRINKETS_MELEE = 4
ITEMSUBCAT_TRINKETS_OFFENSIVE = 5
ITEMSUBCAT_TRINKETS_PERFORMANCE = 6

GM.ItemCategories = {
	[ITEMCAT_GUNS] = translate.Get("itemcat_guns"),
	[ITEMCAT_AMMO] = translate.Get("itemcat_ammo"),
	[ITEMCAT_MELEE] = translate.Get("itemcat_melee"),
	[ITEMCAT_TOOLS] = translate.Get("itemcat_tools"),
	[ITEMCAT_DEPLOYABLES] = translate.Get("itemcat_deployables"),
	[ITEMCAT_TRINKETS] = translate.Get("itemcat_trinkets"),
	[ITEMCAT_OTHER] = translate.Get("itemcat_other"),
	[ITEMCAT_BUILDING] = translate.Get("itemcat_building")
}

GM.ItemSubCategories = {
    [ITEMSUBCAT_TRINKETS_DEFENSIVE] = translate.Get("itemsubcat_defensive"),
    [ITEMSUBCAT_TRINKETS_OFFENSIVE] = translate.Get("itemsubcat_offensive"),
    [ITEMSUBCAT_TRINKETS_MELEE] = translate.Get("itemsubcat_melee"),
    [ITEMSUBCAT_TRINKETS_PERFORMANCE] = translate.Get("itemsubcat_performance"),
    [ITEMSUBCAT_TRINKETS_HEALTH] = translate.Get("itemsubcat_health"),
    [ITEMSUBCAT_TRINKETS_SUPPORT] = translate.Get("itemsubcat_support")
}

GM.EssenceTrinkets = {"trinket_bleaksoul", "trinket_barbedarmor", "trinket_escapemanual"}

GM.Items = {}
function GM:AddItem(signature, category, price, swep, name, desc, model, callback)
	local tab = {Signature = signature, Name = name or "?", Description = desc, Category = category, Price = price or 0, SWEP = swep, Callback = callback, Model = model}

	tab.Worth = tab.Price -- compat

	self.Items[#self.Items + 1] = tab
	self.Items[signature] = tab

	return tab
end

function GM:AddStartingItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem(signature, category, price, swep, name, desc, model, callback)
	item.WorthShop = true

	return item
end

function GM:AddPointShopItem(signature, category, price, swep, name, desc, model, callback)
	local item = self:AddItem("ps_"..signature, category, price, swep, name, desc, model, callback)
	item.PointShop = true

	return item
end

function GM:AddPropMakerItem(signature, category, price, model, name, desc, health, stock)
	local item = self:AddItem( "pm_" .. signature, category, price, nil, name, desc, model)
	item.PropMakerShop = true
	item.Health = health
	item.MaxStock = stock

	return item
end

-- How much ammo is considered one 'clip' of ammo? For use with setting up weapon defaults. Works directly with zs_survivalclips
GM.AmmoCache = {}
GM.AmmoCache["ar2"]							= 32		-- Assault rifles.
GM.AmmoCache["alyxgun"]						= 24		-- Not used.
GM.AmmoCache["pistol"]						= 18		-- Pistols.
GM.AmmoCache["smg1"]						= 36		-- SMG's and some rifles.
GM.AmmoCache["357"]							= 9			-- Rifles, especially of the sniper variety.
GM.AmmoCache["xbowbolt"]					= 8			-- Crossbows
GM.AmmoCache["buckshot"]					= 12		-- Shotguns
GM.AmmoCache["ar2altfire"]					= 1			-- Not used.
GM.AmmoCache["slam"]						= 1			-- Force Field Emitters.
GM.AmmoCache["rpg_round"]					= 1			-- Not used. Rockets?
GM.AmmoCache["smg1_grenade"]				= 1			-- Not used.
GM.AmmoCache["sniperround"]					= 1			-- Barricade Kit
GM.AmmoCache["sniperpenetratedround"]		= 1			-- Remote Det pack.
GM.AmmoCache["grenade"]						= 1			-- Grenades.
GM.AmmoCache["thumper"]						= 1			-- Gun turret.
GM.AmmoCache["gravity"]						= 1			-- Unused.
GM.AmmoCache["battery"]						= 30		-- Used with the Medical Kit.
GM.AmmoCache["gaussenergy"]					= 2			-- Nails used with the Carpenter's Hammer.
GM.AmmoCache["combinecannon"]				= 1			-- Not used.
GM.AmmoCache["airboatgun"]					= 1			-- Arsenal crates.
GM.AmmoCache["striderminigun"]				= 1			-- Message beacons.
GM.AmmoCache["helicoptergun"]				= 1			-- Resupply boxes.
GM.AmmoCache["propmaker"]					= 1
GM.AmmoCache["manhack"]						= 1
GM.AmmoCache["repairfield"]					= 1
GM.AmmoCache["zapper"]						= 1
GM.AmmoCache["pulse"]						= 30
GM.AmmoCache["impactmine"]					= 10
GM.AmmoCache["chemical"]					= 20
GM.AmmoCache["flashbomb"]					= 1
GM.AmmoCache["turret_buckshot"]				= 1
GM.AmmoCache["turret_assault"]				= 1
GM.AmmoCache["scrap"]						= 3

GM.AmmoResupply = table.ToAssoc({"ar2", "pistol", "smg1", "357", "buckshot", "battery", "pulse", "impactmine", "chemical", "gaussenergy", "scrap"})

---------------------
-- Начальный закуп --
---------------------

-- Оружие
GM:AddStartingItem("p228",				ITEMCAT_GUNS,			25,				"weapon_zs_p228")
GM:AddStartingItem("usp",				ITEMCAT_GUNS,			25,				"weapon_zs_usp")
GM:AddStartingItem("owens",				ITEMCAT_GUNS,			25,				"weapon_zs_owens")
GM:AddStartingItem("blstr",				ITEMCAT_GUNS,			25,				"weapon_zs_blaster")
GM:AddStartingItem("tossr",				ITEMCAT_GUNS,			25,				"weapon_zs_tosser")
GM:AddStartingItem("scout",				ITEMCAT_GUNS,			25,				"weapon_zs_scout")
GM:AddStartingItem("famas",				ITEMCAT_GUNS,			25,				"weapon_zs_famas")
GM:AddStartingItem("z9000",				ITEMCAT_GUNS,			25,				"weapon_zs_z9000")
GM:AddStartingItem("pollutant",			ITEMCAT_GUNS,			25,				"weapon_zs_pollutant")
GM:AddStartingItem("minelayer",			ITEMCAT_GUNS,			25,				"weapon_zs_minelayer")

--Патроны
GM:AddStartingItem("1pcp",				ITEMCAT_AMMO,			10,				nil,			"Пистолет (70x)",			nil,		"ammo_pistol",			function(pl) pl:GiveAmmo(70, "pistol", true) end)
GM:AddStartingItem("1sgcp",				ITEMCAT_AMMO,			10,				nil,			"Картечь (50x)",			nil,		"ammo_shotgun",			function(pl) pl:GiveAmmo(50, "buckshot", true) end)
GM:AddStartingItem("1smgcp",			ITEMCAT_AMMO,			10,				nil,			"Автомат (180x)",			nil,		"ammo_smg",				function(pl) pl:GiveAmmo(180, "smg1", true) end)
GM:AddStartingItem("1arcp",				ITEMCAT_AMMO,			10,				nil,			"Штурмовые (160x)",			nil,		"ammo_assault",			function(pl) pl:GiveAmmo(160, "ar2", true) end)
GM:AddStartingItem("1rcp",				ITEMCAT_AMMO,			10,				nil,			"Винтовка (40x)",			nil,		"ammo_rifle",			function(pl) pl:GiveAmmo(40, "357", true) end)
GM:AddStartingItem("1pls",				ITEMCAT_AMMO,			10,				nil,			"Импульсные (150x)",		nil,		"ammo_pulse",			function(pl) pl:GiveAmmo(150, "pulse", true) end)
GM:AddStartingItem("1mines",			ITEMCAT_AMMO,			10,				nil,			"Взрывчатка (30x)",			nil,		"ammo_explosive",		function(pl) pl:GiveAmmo(30, "impactmine", true) end)
GM:AddStartingItem("1chem",				ITEMCAT_AMMO,			10,				nil,			"Химикаты (100x)",			nil,		"ammo_chemical",		function(pl) pl:GiveAmmo(100, "chemical", true) end)
GM:AddStartingItem("1nails",			ITEMCAT_AMMO,			10,				nil,			"Гвозди (20x)",				nil, 		"ammo_nail", 			function(pl) pl:GiveAmmo(20, "GaussEnergy", true) end)
GM:AddStartingItem("1mkit",				ITEMCAT_AMMO,			10,				nil,			"Медикаменты (150x)",		nil,		"ammo_medpower",		function(pl) pl:GiveAmmo(150, "Battery", true) end)
-- Ближний бой
GM:AddStartingItem("knife",				ITEMCAT_MELEE,			25,				"weapon_zs_knife")
GM:AddStartingItem("brassknuckles",		ITEMCAT_MELEE,			25,				"weapon_zs_brassknuckles")
GM:AddStartingItem("zpaxe",				ITEMCAT_MELEE,			25,				"weapon_zs_axe")
GM:AddStartingItem("crwbar",			ITEMCAT_MELEE,			25,				"weapon_zs_crowbar")
GM:AddStartingItem("stnbtn",			ITEMCAT_MELEE,			25,				"weapon_zs_stunbaton")
GM:AddStartingItem("zpplnk",			ITEMCAT_MELEE,			25,				"weapon_zs_plank")
GM:AddStartingItem("pipe",				ITEMCAT_MELEE,			25,				"weapon_zs_pipe")
GM:AddStartingItem("hook",				ITEMCAT_MELEE,			25,				"weapon_zs_hook")
GM:AddStartingItem("zpfryp",			ITEMCAT_MELEE,			25,				"weapon_zs_fryingpan")
--Инструменты
GM:AddStartingItem("hammer",				ITEMCAT_TOOLS,			20,				"weapon_zs_hammer")
GM:AddStartingItem("wrench",				ITEMCAT_TOOLS,			10,				"weapon_zs_wrench")
GM:AddStartingItem("magnet",				ITEMCAT_TOOLS,			10,				"weapon_zs_magnet")
GM:AddStartingItem("nightvision",			ITEMCAT_TOOLS,			10,				"weapon_zs_nightvision")
GM:AddStartingItem("аптечка",				ITEMCAT_TOOLS,			25,				"weapon_zs_medicalkit")
GM:AddStartingItem("медицинский пистолет",	ITEMCAT_TOOLS,			25,				"weapon_zs_medicgun")
GM:AddStartingItem("антидотный выстрел",	ITEMCAT_TOOLS,			25,				"weapon_zs_antidoteshot")

local item

--Оборудования
GM:AddStartingItem("арсенальный ящик",			ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddStartingItem("ящик снабжения",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_resupplybox").Countables = "prop_resupplybox"
GM:AddStartingItem("верстак",			ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_remantler").Countables = "prop_remantler"

item = GM:AddStartingItem("ремонтное поле",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_repairfield",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_repairfield"
item = GM:AddStartingItem("молния",			ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_zapper",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_zapper"
item = GM:AddStartingItem("ffemitter",			ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_ffemitter",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(50, "pulse") end)
item.Countables = "prop_ffemitter"

item = GM:AddStartingItem("infturret",			ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_gunturret",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") pl:GiveAmmo(125, "smg1") end)
item.Countables = "prop_gunturret"

item = GM:AddStartingItem("турель с дробовиком",		ITEMCAT_DEPLOYABLES,			25,				"weapon_zs_gunturret_buckshot",	nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") pl:GiveAmmo(30, "buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.SkillRequirement = SKILL_U_BLASTTURRET

item = GM:AddStartingItem("дрон",				ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_drone",				nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone") pl:GiveAmmo(1, "drone") pl:GiveAmmo(60, "smg1") end)
item.Countables = "prop_drone"

item = GM:AddStartingItem("пульсовой дрон",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_drone_pulse",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_pulse") pl:GiveAmmo(1, "pulse_cutter") pl:GiveAmmo(60, "pulse") end)
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE

item = GM:AddStartingItem("дрон грузщик",			ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_drone_hauler",		nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_hauler") pl:GiveAmmo(1, "drone_hauler") end)
item.Countables = "prop_drone_hauler"

item = GM:AddStartingItem("менхак",			ITEMCAT_DEPLOYABLES,			15,				"weapon_zs_manhack")
item.Countables = "prop_manhack"

item = GM:AddStartingItem("мина",		ITEMCAT_DEPLOYABLES,			20,				"weapon_zs_rollermine",			nil,							nil,									nil,											function(pl) pl:GiveEmptyWeapon("weapon_zs_rollermine") pl:GiveAmmo(1, "rollermine") end)
item.Countables = "prop_rollermine"

GM:AddStartingItem("msgbeacon",			ITEMCAT_DEPLOYABLES,			5,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
GM:AddStartingItem("barricadekit",		ITEMCAT_DEPLOYABLES,			35,				"weapon_zs_barricadekit")
GM:AddStartingItem("camera",			ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddStartingItem("tv",				ITEMCAT_DEPLOYABLES,			10,				"weapon_zs_tv").Countables = "prop_tv"

-- Улучшения
GM:AddStartingItem("healthpack", 		ITEMCAT_TRINKETS, 		15, 			"trinket_healthpack").SubCategory = 			ITEMSUBCAT_TRINKETS_HEALTH
GM:AddStartingItem("bloodbank", 		ITEMCAT_TRINKETS, 		15, 			"trinket_bloodbank").SubCategory = 				ITEMSUBCAT_TRINKETS_HEALTH
GM:AddStartingItem("biocleanser", 		ITEMCAT_TRINKETS, 		15, 			"trinket_biocleanser").SubCategory = 			ITEMSUBCAT_TRINKETS_HEALTH
GM:AddStartingItem("cutlery", 			ITEMCAT_TRINKETS, 		15, 			"trinket_cutlery").SubCategory = 				ITEMSUBCAT_TRINKETS_HEALTH

GM:AddStartingItem("bodyarmor", 		ITEMCAT_TRINKETS, 		15, 			"trinket_bodyarmor").SubCategory = 				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("bandage", 			ITEMCAT_TRINKETS, 		15, 			"trinket_bandage").SubCategory = 				ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddStartingItem("antitoxinpack", 	ITEMCAT_TRINKETS, 		15, 			"trinket_antitoxinpack").SubCategory = 			ITEMSUBCAT_TRINKETS_DEFENSIVE

GM:AddStartingItem("swing", 			ITEMCAT_TRINKETS, 		15, 			"trinket_strengthenedswing").SubCategory = 		ITEMSUBCAT_TRINKETS_MELEE
GM:AddStartingItem("longgrip", 			ITEMCAT_TRINKETS, 		15, 			"trinket_longgrip").SubCategory = 				ITEMSUBCAT_TRINKETS_MELEE

GM:AddStartingItem("oxygentank", 		ITEMCAT_TRINKETS, 		15, 			"trinket_oxygentank").SubCategory = 			ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("nightvision", 		ITEMCAT_TRINKETS, 		15, 			"trinket_nightvision").SubCategory = 			ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddStartingItem("exoskeleton", 		ITEMCAT_TRINKETS, 		15, 			"trinket_exoskeleton").SubCategory = 			ITEMSUBCAT_TRINKETS_PERFORMANCE
	
GM:AddStartingItem("blueprints", 		ITEMCAT_TRINKETS, 		15, 			"trinket_blueprints").SubCategory = 			ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddStartingItem("processor", 		ITEMCAT_TRINKETS, 		15, 			"trinket_processor").SubCategory = 				ITEMSUBCAT_TRINKETS_SUPPORT

GM:AddStartingItem("arsenalpack", 		ITEMCAT_TRINKETS, 		30, 			"trinket_arsenalpack").SubCategory = 			ITEMSUBCAT_TRINKETS_SUPPORT

GM:AddStartingItem("holster", 			ITEMCAT_TRINKETS, 		15, 			"trinket_holster").SubCategory = 				ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("sightingvisor", 	ITEMCAT_TRINKETS, 		15, 			"trinket_sightingvisor").SubCategory = 			ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddStartingItem("impulseinfuser", 	ITEMCAT_TRINKETS, 		15, 			"trinket_impulseinfuser").SubCategory = 		ITEMSUBCAT_TRINKETS_OFFENSIVE

-- Прочее
GM:AddStartingItem("flashbomb",			ITEMCAT_OTHER,			5,				"weapon_zs_flashbomb")
GM:AddStartingItem("grenade",			ITEMCAT_OTHER,			10,				"weapon_zs_grenade")
GM:AddStartingItem("molotov",			ITEMCAT_OTHER,			10,				"weapon_zs_molotov")
GM:AddStartingItem("betty",				ITEMCAT_OTHER,			10,				"weapon_zs_proxymine")
GM:AddStartingItem("adrenaline",		ITEMCAT_OTHER,			15,				"weapon_zs_adrenalineshot")
GM:AddStartingItem("detpck",			ITEMCAT_OTHER,			15,				"weapon_zs_detpack").Countables = "prop_detpack"
GM:AddStartingItem("corgasgrenade",		ITEMCAT_OTHER,			15,				"weapon_zs_corgasgrenade")
GM:AddStartingItem("crygasgrenade",		ITEMCAT_OTHER,			15,				"weapon_zs_crygasgrenade")
GM:AddStartingItem("bloodshot",			ITEMCAT_OTHER,			15,				"weapon_zs_bloodshotbomb")
GM:AddStartingItem("medcloud",			ITEMCAT_OTHER,			15,				"weapon_zs_mediccloudbomb")
GM:AddStartingItem("nanitecloud",		ITEMCAT_OTHER,			15,				"weapon_zs_nanitecloudbomb")

------------
-- Поинты --
------------

-- Tier 1
GM:AddPointShopItem("p228",				ITEMCAT_GUNS,			15,				"weapon_zs_p228")
GM:AddPointShopItem("usp",				ITEMCAT_GUNS,			15,				"weapon_zs_usp")
GM:AddPointShopItem("owens",			ITEMCAT_GUNS,			15,				"weapon_zs_owens")
GM:AddPointShopItem("blstr",			ITEMCAT_GUNS,			15,				"weapon_zs_blaster")
GM:AddPointShopItem("tossr",			ITEMCAT_GUNS,			15,				"weapon_zs_tosser")
GM:AddPointShopItem("famas",			ITEMCAT_GUNS,			15,				"weapon_zs_famas")
GM:AddPointShopItem("scout",			ITEMCAT_GUNS,			15,				"weapon_zs_scout")
GM:AddPointShopItem("z9000",			ITEMCAT_GUNS,			15,				"weapon_zs_z9000")
GM:AddPointShopItem("pollutant",		ITEMCAT_GUNS,			15,				"weapon_zs_pollutant")
GM:AddPointShopItem("minelayer",		ITEMCAT_GUNS,			15,				"weapon_zs_minelayer")
-- Tier 2
GM:AddPointShopItem("glock18",			ITEMCAT_GUNS,			30,				"weapon_zs_glock18")
GM:AddPointShopItem("magnum",			ITEMCAT_GUNS,			30,				"weapon_zs_magnum")
GM:AddPointShopItem("fiveseven",		ITEMCAT_GUNS,			30,				"weapon_zs_fiveseven")
GM:AddPointShopItem("sawedoff",			ITEMCAT_GUNS,			30,				"weapon_zs_sawedoff")
GM:AddPointShopItem("uzi",				ITEMCAT_GUNS,			30,				"weapon_zs_uzi")
GM:AddPointShopItem("sg552",			ITEMCAT_GUNS,			30,				"weapon_zs_sg552")
GM:AddPointShopItem("annabelle",		ITEMCAT_GUNS,			30,				"weapon_zs_annabelle")
GM:AddPointShopItem("hurricane",		ITEMCAT_GUNS,			30,				"weapon_zs_hurricane")
GM:AddPointShopItem("enkindler",		ITEMCAT_GUNS,			30,				"weapon_zs_enkindler")
-- Tier 3
GM:AddPointShopItem("deagle",			ITEMCAT_GUNS,			65,				"weapon_zs_deagle")
GM:AddPointShopItem("tempest",			ITEMCAT_GUNS,			65,				"weapon_zs_tempest")
GM:AddPointShopItem("ender",			ITEMCAT_GUNS,			65,				"weapon_zs_ender")
GM:AddPointShopItem("galestorm",		ITEMCAT_GUNS,			65,				"weapon_zs_galestorm")
GM:AddPointShopItem("mp5",				ITEMCAT_GUNS,			65,				"weapon_zs_mp5")
GM:AddPointShopItem("tmp",				ITEMCAT_GUNS,			65,				"weapon_zs_tmp")
GM:AddPointShopItem("ak47",				ITEMCAT_GUNS,			65,				"weapon_zs_ak47")
GM:AddPointShopItem("stabber",			ITEMCAT_GUNS,			65,				"weapon_zs_stabber")
GM:AddPointShopItem("awp",				ITEMCAT_GUNS,			65,				"weapon_zs_awp")
GM:AddPointShopItem("onyx",				ITEMCAT_GUNS,			65,				"weapon_zs_onyx")
GM:AddPointShopItem("tithonus",			ITEMCAT_GUNS,			65,				"weapon_zs_tithonus")
GM:AddPointShopItem("oberon",			ITEMCAT_GUNS,			65,				"weapon_zs_oberon")
GM:AddPointShopItem("pollutor",			ITEMCAT_GUNS,			65,				"weapon_zs_pollutor")
GM:AddPointShopItem("hyena",			ITEMCAT_GUNS,			65,				"weapon_zs_hyena")
GM:AddPointShopItem("savior",			ITEMCAT_GUNS,			65,				"weapon_zs_savior")
-- Tier 4
GM:AddPointShopItem("longarm",			ITEMCAT_GUNS,			115,			"weapon_zs_longarm")
GM:AddPointShopItem("seditionist",		ITEMCAT_GUNS,			115,			"weapon_zs_seditionist")
GM:AddPointShopItem("m3",				ITEMCAT_GUNS,			115,			"weapon_zs_m3")
GM:AddPointShopItem("jackhammer",		ITEMCAT_GUNS,			115,			"weapon_zs_jackhammer")
GM:AddPointShopItem("p90",				ITEMCAT_GUNS,			115,			"weapon_zs_p90")
GM:AddPointShopItem("ump45",			ITEMCAT_GUNS,			115,			"weapon_zs_ump45")
GM:AddPointShopItem("proliferator",		ITEMCAT_GUNS,			115,			"weapon_zs_proliferator")
GM:AddPointShopItem("stalker",			ITEMCAT_GUNS,			115,			"weapon_zs_stalker")
GM:AddPointShopItem("aug",				ITEMCAT_GUNS,			115,			"weapon_zs_aug")
GM:AddPointShopItem("g3sg1",			ITEMCAT_GUNS,			115,			"weapon_zs_g3sg1")
GM:AddPointShopItem("slugrifle",		ITEMCAT_GUNS,			115,			"weapon_zs_slugrifle")
GM:AddPointShopItem("innervator",		ITEMCAT_GUNS,			115,			"weapon_zs_innervator")
GM:AddPointShopItem("quasar",			ITEMCAT_GUNS,			115,			"weapon_zs_quasar")
GM:AddPointShopItem("gluon",			ITEMCAT_GUNS,			115,			"weapon_zs_gluon")
GM:AddPointShopItem("artemis",			ITEMCAT_GUNS,			115,			"weapon_zs_artemis")
GM:AddPointShopItem("eminence",			ITEMCAT_GUNS,			115,			"weapon_zs_eminence")
GM:AddPointShopItem("barrage",			ITEMCAT_GUNS,			115,			"weapon_zs_barrage")
-- Tier 5
GM:AddPointShopItem("novacolt",			ITEMCAT_GUNS,			175,			"weapon_zs_novacolt")
GM:AddPointShopItem("deathdlrs",		ITEMCAT_GUNS,			175,			"weapon_zs_deathdealers")
GM:AddPointShopItem("drumgun",			ITEMCAT_GUNS,			175,			"weapon_zs_drumgun")
GM:AddPointShopItem("boomstick",		ITEMCAT_GUNS,			175,			"weapon_zs_boomstick")
GM:AddPointShopItem("minigun",			ITEMCAT_GUNS,			175,			"weapon_zs_minigun")
GM:AddPointShopItem("m249",				ITEMCAT_GUNS,			175,			"weapon_zs_m249")
GM:AddPointShopItem("scar",				ITEMCAT_GUNS,			175,			"weapon_zs_scar")
GM:AddPointShopItem("renegade",			ITEMCAT_GUNS,			175,			"weapon_zs_renegade")
GM:AddPointShopItem("colossus",			ITEMCAT_GUNS,			175,			"weapon_zs_colossus")
GM:AddPointShopItem("asmd",				ITEMCAT_GUNS,			175,			"weapon_zs_asmd")
GM:AddPointShopItem("hephaestus",		ITEMCAT_GUNS,			175,			"weapon_zs_hephaestus")
GM:AddPointShopItem("pulserifle",		ITEMCAT_GUNS,			175,			"weapon_zs_pulserifle")
GM:AddPointShopItem("broadside",		ITEMCAT_GUNS,			175,			"weapon_zs_broadside")
-- Tier 6
GM:AddPointShopItem("piercer",			ITEMCAT_GUNS,			265,			"weapon_zs_piercer")
GM:AddPointShopItem("creator",			ITEMCAT_GUNS,			265,			"weapon_zs_creator")
GM:AddPointShopItem("razor",			ITEMCAT_GUNS,			265,			"weapon_zs_razor")
GM:AddPointShopItem("glimpser",			ITEMCAT_GUNS,			265,			"weapon_zs_glimpser")

GM:AddPointShopItem("pistolammo",		ITEMCAT_AMMO,			8,				nil,		"Пистолет (18x)",			nil,	"ammo_pistol",						function(pl) pl:GiveAmmo(18, "pistol", true) end)
GM:AddPointShopItem("shotgunammo",		ITEMCAT_AMMO,			8,				nil,		"Картечь (12x)",			nil,	"ammo_shotgun",						function(pl) pl:GiveAmmo(12, "buckshot", true) end)
GM:AddPointShopItem("smgammo",			ITEMCAT_AMMO,			8,				nil,		"Автомат (36x)",			nil,	"ammo_smg",							function(pl) pl:GiveAmmo(36, "smg1", true) end)
GM:AddPointShopItem("assaultrifleammo",	ITEMCAT_AMMO,			8,				nil,		"Штурмовые (32x)",			nil,	"ammo_assault",						function(pl) pl:GiveAmmo(32, "ar2", true) end)
GM:AddPointShopItem("rifleammo",		ITEMCAT_AMMO,			8,				nil,		"Винтовка (9x)",			nil,	"ammo_rifle",						function(pl) pl:GiveAmmo(9, "357", true) end)
GM:AddPointShopItem("pulseammo",		ITEMCAT_AMMO,			8,				nil,		"Импульсные (30x)",			nil,	"ammo_pulse",						function(pl) pl:GiveAmmo(30, "pulse", true) end)
GM:AddPointShopItem("impactmine",		ITEMCAT_AMMO,			8,				nil,		"Взрывчатка (10x)",			nil,	"ammo_explosive",					function(pl) pl:GiveAmmo(10, "impactmine", true) end)
GM:AddPointShopItem("chemical",			ITEMCAT_AMMO,			8,				nil,		"Химикаты (20x)",			nil,	"ammo_chemical",					function(pl) pl:GiveAmmo(20, "chemical", true) end)
GM:AddPointShopItem("25mkit",			ITEMCAT_AMMO,			4,				nil,		"Медикаменты (25x)",		nil,	"ammo_medpower",					function(pl) pl:GiveAmmo(25, "Battery", true) end)
GM:AddPointShopItem("nail",				ITEMCAT_AMMO,			4,				nil,		"Гвоздь (2x)",				nil,	"ammo_nail",						function(pl) pl:GiveAmmo(2, "GaussEnergy", true) end)
GM:AddPointShopItem("scrapammo",		ITEMCAT_AMMO,			16,				nil,		"Металл (8x)",				nil,	"ammo_scrap",						function(pl) pl:GiveAmmo(8, "scrap", true) end).CantMakeFromScrap = true
-- Tier 1
GM:AddPointShopItem("knife",			ITEMCAT_MELEE,			15,				"weapon_zs_knife")
GM:AddPointShopItem("brassknuckles",	ITEMCAT_MELEE,			15,				"weapon_zs_brassknuckles")
GM:AddPointShopItem("zpplnk",			ITEMCAT_MELEE,			15,				"weapon_zs_plank")
GM:AddPointShopItem("axe",				ITEMCAT_MELEE,			15,				"weapon_zs_axe")
GM:AddPointShopItem("crowbar",			ITEMCAT_MELEE,			15,				"weapon_zs_crowbar")
GM:AddPointShopItem("pipe",				ITEMCAT_MELEE,			15,				"weapon_zs_pipe")
GM:AddPointShopItem("stunbaton",		ITEMCAT_MELEE,			15,				"weapon_zs_stunbaton")
GM:AddPointShopItem("hook",				ITEMCAT_MELEE,			15,				"weapon_zs_hook")
GM:AddPointShopItem("zpfryp",			ITEMCAT_MELEE,			15,				"weapon_zs_fryingpan")
-- Tier 2
GM:AddPointShopItem("shovel",			ITEMCAT_MELEE,			30,				"weapon_zs_shovel")
GM:AddPointShopItem("sledgehammer",		ITEMCAT_MELEE,			30,				"weapon_zs_sledgehammer")
GM:AddPointShopItem("baseballbat",		ITEMCAT_MELEE,			30,				"weapon_zs_ballbat")
GM:AddPointShopItem("harpoon",			ITEMCAT_MELEE,			30,				"weapon_zs_harpoon")
GM:AddPointShopItem("butcherknf",		ITEMCAT_MELEE,			30,				"weapon_zs_butcherknife")
GM:AddPointShopItem("bust",				ITEMCAT_MELEE,			30,				"weapon_zs_bust")
-- Tier 3
GM:AddPointShopItem("longsword",		ITEMCAT_MELEE,			65,				"weapon_zs_longsword")
GM:AddPointShopItem("executioner",		ITEMCAT_MELEE,			65,				"weapon_zs_executioner")
GM:AddPointShopItem("giantspoon",		ITEMCAT_MELEE,			65,				"weapon_zs_giantspoon")
GM:AddPointShopItem("megamasher",		ITEMCAT_MELEE,			65,				"weapon_zs_megamasher")
GM:AddPointShopItem("rebarmace",		ITEMCAT_MELEE,			65,				"weapon_zs_rebarmace")
-- Tier 4
GM:AddPointShopItem("graveshvl",		ITEMCAT_MELEE,			115,			"weapon_zs_graveshovel")
GM:AddPointShopItem("kongol",			ITEMCAT_MELEE,			115,			"weapon_zs_kongolaxe")
GM:AddPointShopItem("katana",			ITEMCAT_MELEE,			115,			"weapon_zs_katana")
GM:AddPointShopItem("scythe",			ITEMCAT_MELEE,			115,			"weapon_zs_scythe")
GM:AddPointShopItem("powerfists",		ITEMCAT_MELEE,			115,			"weapon_zs_powerfists")
-- Tier 5
GM:AddPointShopItem("frotchet",			ITEMCAT_MELEE,			175,			"weapon_zs_frotchet")
GM:AddPointShopItem("impulsehammer",	ITEMCAT_MELEE,			175,			"weapon_zs_impulsehammer")
GM:AddPointShopItem("zweihander",		ITEMCAT_MELEE,			175,			"weapon_zs_zweihand")
-- Tier 6
GM:AddPointShopItem("ganymede",			ITEMCAT_MELEE,			270,			"weapon_zs_ganymede")

-- Оборудование
GM:AddPointShopItem("hammer",			ITEMCAT_TOOLS,			25,				"weapon_zs_hammer",			nil,	nil,	nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_hammer") pl:GiveAmmo(5, "GaussEnergy") end)
GM:AddPointShopItem("electrohammer",	ITEMCAT_TOOLS,			60,				"weapon_zs_electrohammer",	nil,	nil,	nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_electrohammer") pl:GiveAmmo(5, "GaussEnergy") end)
GM:AddPointShopItem("wrench",			ITEMCAT_TOOLS,			15,				"weapon_zs_wrench")
GM:AddPointShopItem("magnet",			ITEMCAT_TOOLS,			15,				"weapon_zs_magnet")
GM:AddPointShopItem("nightvision",		ITEMCAT_TOOLS,			15,				"weapon_zs_nightvision")
GM:AddPointShopItem("antidote",			ITEMCAT_TOOLS,			30,				"weapon_zs_antidoteshot")
GM:AddPointShopItem("medkit",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicalkit")
GM:AddPointShopItem("healthkit",		ITEMCAT_TOOLS,			60,				"weapon_zs_healthkit")
GM:AddPointShopItem("medgun",			ITEMCAT_TOOLS,			30,				"weapon_zs_medicgun")
GM:AddPointShopItem("medrifle",			ITEMCAT_TOOLS,			55,				"weapon_zs_medicrifle")
GM:AddPointShopItem("saviormed",		ITEMCAT_TOOLS,			65,				"weapon_zs_savior")
GM:AddPointShopItem("healray",			ITEMCAT_TOOLS,			125,			"weapon_zs_healingray")

GM:AddPointShopItem("arsenalcrate",		ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_arsenalcrate").Countables = "prop_arsenalcrate"
GM:AddPointShopItem("resupplybox",		ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_resupplybox").Countables = "prop_resupplybox"
GM:AddPointShopItem("remantler",		ITEMCAT_DEPLOYABLES,	30,				"weapon_zs_remantler").Countables = "prop_remantler"
GM:AddPointShopItem("propmaker",		ITEMCAT_DEPLOYABLES,	50,				"weapon_zs_propmaker").Countables = "prop_propmaker"

GM:AddPointShopItem("repairfield",		ITEMCAT_DEPLOYABLES,	55,				"weapon_zs_repairfield",nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_repairfield") pl:GiveAmmo(1, "repairfield") pl:GiveAmmo(30, "pulse") end).Countables = "prop_repairfield"
GM:AddPointShopItem("ffemitter",		ITEMCAT_DEPLOYABLES,	40,				"weapon_zs_ffemitter",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_ffemitter") pl:GiveAmmo(1, "slam") pl:GiveAmmo(30, "pulse") end).Countables = "prop_ffemitter"

GM:AddPointShopItem("infturret",		ITEMCAT_DEPLOYABLES,	50,				"weapon_zs_gunturret",			nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret") pl:GiveAmmo(1, "thumper") end).Countables = "prop_gunturret"
item = GM:AddPointShopItem("blastturret",		ITEMCAT_DEPLOYABLES,	50,		"weapon_zs_gunturret_buckshot",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_buckshot") pl:GiveAmmo(1, "turret_buckshot") end)
item.Countables = "prop_gunturret_buckshot"
item.SkillRequirement = SKILL_U_BLASTTURRET

item = GM:AddPointShopItem("assaultturret",		ITEMCAT_DEPLOYABLES,		125,"weapon_zs_gunturret_assault",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_assault") pl:GiveAmmo(1, "turret_assault") end)
item.Countables = "prop_gunturret_assault"

item = GM:AddPointShopItem("rocketturret",		ITEMCAT_DEPLOYABLES,	125,	"weapon_zs_gunturret_rocket",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_gunturret_rocket") pl:GiveAmmo(1, "turret_rocket") end)
item.Countables = "prop_gunturret_rocket"
item.SkillRequirement = SKILL_U_ROCKETTURRET

item = GM:AddPointShopItem("drone",				ITEMCAT_DEPLOYABLES,		40,	"weapon_zs_drone",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_drone") pl:GiveAmmo(1, "drone") end)
item.Countables = "prop_drone"

item = GM:AddPointShopItem("pulsedrone",		ITEMCAT_DEPLOYABLES,	40,		"weapon_zs_drone_pulse",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_pulse") pl:GiveAmmo(1, "pulse_cutter") end)
item.Countables = "prop_drone_pulse"
item.SkillRequirement = SKILL_U_DRONE

item = GM:AddPointShopItem("hauldrone",			ITEMCAT_DEPLOYABLES,		15,	"weapon_zs_drone_hauler",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_drone_hauler") pl:GiveAmmo(1, "drone_hauler") end)
item.Countables = "prop_drone_hauler"

item = GM:AddPointShopItem("rollermine",		ITEMCAT_DEPLOYABLES,	35,		"weapon_zs_rollermine",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_rollermine") pl:GiveAmmo(1, "rollermine") end)
item.Countables = "prop_rollermine"

GM:AddPointShopItem("zapper",			ITEMCAT_DEPLOYABLES,	50,				"weapon_zs_zapper",		nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper") pl:GiveAmmo(1, "zapper") pl:GiveAmmo(30, "pulse") end).Countables = "prop_zapper"
item = GM:AddPointShopItem("zapper_arc",		ITEMCAT_DEPLOYABLES,	100,	"weapon_zs_zapper_arc",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_zapper_arc") pl:GiveAmmo(1, "zapper_arc") pl:GiveAmmo(30, "pulse") end)
item.Countables = "prop_zapper_arc"
item.SkillRequirement = SKILL_U_ZAPPER_ARC

item = GM:AddPointShopItem("manhack",			ITEMCAT_DEPLOYABLES,	30,		"weapon_zs_manhack",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_manhack") pl:GiveAmmo(1, "manhack") end)
item.Countables = "prop_manhack"

item = GM:AddPointShopItem("манхак с пилой",	ITEMCAT_DEPLOYABLES,	55,		"weapon_zs_manhack_saw",	nil,nil,nil,	function(pl) pl:GiveEmptyWeapon("weapon_zs_manhack_saw") pl:GiveAmmo(1, "manhack_saw") end)
item.Countables = "prop_manhack_saw"
item.SkillRequirement = SKILL_U_MANHACK_SAW

GM:AddPointShopItem("msgbeacon",		ITEMCAT_DEPLOYABLES,	10,				"weapon_zs_messagebeacon").Countables = "prop_messagebeacon"
GM:AddPointShopItem("barricadekit",		ITEMCAT_DEPLOYABLES,	85,				"weapon_zs_barricadekit")

GM:AddPointShopItem("camera",			ITEMCAT_DEPLOYABLES,	15,				"weapon_zs_camera").Countables = "prop_camera"
GM:AddPointShopItem("tv",				ITEMCAT_DEPLOYABLES,	25,				"weapon_zs_tv").Countables = "prop_tv"

-- Улучшения
GM:AddPointShopItem("healthpack", 		ITEMCAT_TRINKETS, 		10, "trinket_healthpack").SubCategory = 										ITEMSUBCAT_TRINKETS_HEALTH
GM:AddPointShopItem("bloodbank", 		ITEMCAT_TRINKETS, 		10, "trinket_bloodbank").SubCategory = 											ITEMSUBCAT_TRINKETS_HEALTH
GM:AddPointShopItem("regenimplant", 	ITEMCAT_TRINKETS, 		10, "trinket_regenimplant").SubCategory =										ITEMSUBCAT_TRINKETS_HEALTH
GM:AddPointShopItem("biocleanser", 		ITEMCAT_TRINKETS, 		10, "trinket_biocleanser").SubCategory = 										ITEMSUBCAT_TRINKETS_HEALTH
GM:AddPointShopItem("cutlery", 			ITEMCAT_TRINKETS, 		10, "trinket_cutlery").SubCategory = 											ITEMSUBCAT_TRINKETS_HEALTH

GM:AddPointShopItem("bodyarmor", 		ITEMCAT_TRINKETS, 		10, "trinket_bodyarmor").SubCategory = 											ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("eodvest", 			ITEMCAT_TRINKETS, 		10, "trinket_eodvest").SubCategory = 											ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("bandage", 			ITEMCAT_TRINKETS, 		10, "trinket_bandage").SubCategory = 											ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("antitoxinpack", 	ITEMCAT_TRINKETS, 		10, "trinket_antitoxinpack").SubCategory = 										ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("reactiveflasher", 	ITEMCAT_TRINKETS, 		10, "trinket_reactiveflasher").SubCategory = 									ITEMSUBCAT_TRINKETS_DEFENSIVE
GM:AddPointShopItem("forcedamp", 		ITEMCAT_TRINKETS, 		15, "trinket_forcedamp").SubCategory = 											ITEMSUBCAT_TRINKETS_DEFENSIVE

GM:AddPointShopItem("swing", 			ITEMCAT_TRINKETS, 		10, "trinket_strengthenedswing").SubCategory = 									ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("adrenalinerush", 	ITEMCAT_TRINKETS, 		10, "trinket_adrenalinerush").SubCategory = 									ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("longgrip", 		ITEMCAT_TRINKETS, 		10, "trinket_longgrip").SubCategory = 											ITEMSUBCAT_TRINKETS_MELEE
GM:AddPointShopItem("powergauntlet", 	ITEMCAT_TRINKETS, 		10, "trinket_powergauntlet").SubCategory = 										ITEMSUBCAT_TRINKETS_MELEE

GM:AddPointShopItem("oxygentank", 		ITEMCAT_TRINKETS, 		10, "trinket_oxygentank").SubCategory = 										ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("nightvision", 		ITEMCAT_TRINKETS, 		10, "trinket_nightvision").SubCategory = 										ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("agilitymagnifier", ITEMCAT_TRINKETS, 		10, "trinket_agilitymagnifier").SubCategory = 									ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("featherfallboots", ITEMCAT_TRINKETS, 		10, "trinket_featherfallboots").SubCategory = 									ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("analgesic", 		ITEMCAT_TRINKETS, 		10, "trinket_analgesic").SubCategory = 											ITEMSUBCAT_TRINKETS_PERFORMANCE
GM:AddPointShopItem("exoskeleton", 		ITEMCAT_TRINKETS, 		10, "trinket_exoskeleton").SubCategory = 										ITEMSUBCAT_TRINKETS_PERFORMANCE

GM:AddPointShopItem("blueprints", 		ITEMCAT_TRINKETS, 		10, "trinket_blueprints").SubCategory = 										ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("acqmanifest", 		ITEMCAT_TRINKETS, 		10, "trinket_acqmanifest").SubCategory = 										ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("matrixchip", 		ITEMCAT_TRINKETS, 		10, "trinket_matrixchip").SubCategory = 										ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("controlplat", 		ITEMCAT_TRINKETS, 		10, "trinket_controlplat").SubCategory = 										ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("processor", 		ITEMCAT_TRINKETS, 		10, "trinket_processor").SubCategory = 											ITEMSUBCAT_TRINKETS_SUPPORT
GM:AddPointShopItem("arsenalpack", 		ITEMCAT_TRINKETS, 		30, "trinket_arsenalpack").SubCategory = 										ITEMSUBCAT_TRINKETS_SUPPORT

GM:AddPointShopItem("holster", 			ITEMCAT_TRINKETS, 		10, "trinket_holster").SubCategory = 											ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("cartridgebelt", 	ITEMCAT_TRINKETS, 		10, "trinket_cartridgebelt").SubCategory = 										ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("sightingvisor", 	ITEMCAT_TRINKETS, 		10, "trinket_sightingvisor").SubCategory = 										ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("aimcomp", 			ITEMCAT_TRINKETS, 		10, "trinket_aimcomp").SubCategory = 											ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("impulseinfuser", 	ITEMCAT_TRINKETS, 		10, "trinket_impulseinfuser").SubCategory = 									ITEMSUBCAT_TRINKETS_OFFENSIVE
GM:AddPointShopItem("weights", 			ITEMCAT_TRINKETS, 		15, "trinket_weights").SubCategory = 											ITEMSUBCAT_TRINKETS_OFFENSIVE

-- Прочее
GM:AddPointShopItem("flashbomb",		ITEMCAT_OTHER,			25,				"weapon_zs_flashbomb")
GM:AddPointShopItem("molotov",			ITEMCAT_OTHER,			30,				"weapon_zs_molotov")
GM:AddPointShopItem("grenade",			ITEMCAT_OTHER,			35,				"weapon_zs_grenade")
GM:AddPointShopItem("betty",			ITEMCAT_OTHER,			35,				"weapon_zs_proxymine")
GM:AddPointShopItem("adrenaline",		ITEMCAT_OTHER,			35,				"weapon_zs_adrenalineshot")
GM:AddPointShopItem("detpck",			ITEMCAT_OTHER,			40,				"weapon_zs_detpack")
GM:AddPointShopItem("sigfragment",		ITEMCAT_OTHER,			30,				"weapon_zs_sigilfragment")
GM:AddPointShopItem("corruptedfragment",ITEMCAT_OTHER,			55,				"weapon_zs_corruptedfragment").SkillRequirement = SKILL_U_CORRUPTEDFRAGMENT
GM:AddPointShopItem("corgasgrenade",	ITEMCAT_OTHER,			35,				"weapon_zs_corgasgrenade")
GM:AddPointShopItem("crygasgrenade",	ITEMCAT_OTHER,			35,				"weapon_zs_crygasgrenade")
GM:AddPointShopItem("bloodshot",		ITEMCAT_OTHER,			35,				"weapon_zs_bloodshotbomb")
GM:AddPointShopItem("medcloud",			ITEMCAT_OTHER,			35,				"weapon_zs_mediccloudbomb")
GM:AddPointShopItem("nanitecloud",		ITEMCAT_OTHER,			40,				"weapon_zs_nanitecloudbomb")

GM:AddPropMakerItem( "furniturecouch01",		ITEMCAT_BUILDING, 35,	"models/props_c17/FurnitureCouch001a.mdl",					"Красный диван", nil, 1567, 2)
GM:AddPropMakerItem( "furnitureshelf",			ITEMCAT_BUILDING, 35,	"models/props_interiors/Furniture_shelf01a.mdl",			"Шкаф полка", nil, 1567, 2)
GM:AddPropMakerItem( "pushcart",				ITEMCAT_BUILDING, 32,	"models/props_junk/PushCart01a.mdl",						"Красная тележка", nil, 1366, 3)
GM:AddPropMakerItem( "washingmachine",			ITEMCAT_BUILDING, 30,	"models/props_c17/FurnitureWashingmachine001a.mdl",			"Стиральная машина", nil, 1567, 4)
GM:AddPropMakerItem( "kitchenshelf01",			ITEMCAT_BUILDING, 29,	"models/props_wasteland/kitchen_shelf001a.mdl",				"Кухонный стеллаж", nil, 1131, 3)
GM:AddPropMakerItem( "furniturebed",			ITEMCAT_BUILDING, 27,	"models/props_c17/FurnitureBed001a.mdl",					"Кушетка", nil, 1410, 4)
GM:AddPropMakerItem( "radiator",				ITEMCAT_BUILDING, 26,	"models/props_c17/FurnitureRadiator001a.mdl",				"Радиатор", nil, 1337, 4)
GM:AddPropMakerItem( "ravenholmsign",			ITEMCAT_BUILDING, 26,	"models/props_junk/ravenholmsign.mdl",						"Вывеска Рейвенхолма", nil, 934, 5)
GM:AddPropMakerItem( "door01",					ITEMCAT_BUILDING, 24,	"models/props_c17/door01_left.mdl",							"Деревянная дверь", nil, 713, 6)
GM:AddPropMakerItem( "woodcrate02",				ITEMCAT_BUILDING, 22,	"models/props_junk/wood_crate002a.mdl",						"Большая коробка", nil, 972, 7)
GM:AddPropMakerItem( "furnituretable02",		ITEMCAT_BUILDING, 21,	"models/props_c17/FurnitureTable002a.mdl",					"Стол", nil, 887, 8)
GM:AddPropMakerItem( "woodpallet",				ITEMCAT_BUILDING, 20,	"models/props_junk/wood_pallet001a.mdl",					"Деревянный паллет", nil, 800, 8)
GM:AddPropMakerItem( "kitchenshelf02",			ITEMCAT_BUILDING, 20,	"models/props_wasteland/kitchen_shelf002a.mdl",				"Стеллаж для подноса", nil, 837, 8)
GM:AddPropMakerItem( "laundrycart",				ITEMCAT_BUILDING, 20,	"models/props_wasteland/laundry_cart002.mdl",				"Тележка", nil, 835, 8)
GM:AddPropMakerItem( "bench01",					ITEMCAT_BUILDING, 19,	"models/props_c17/bench01a.mdl",							"Скамейка", nil, 749, 8)
GM:AddPropMakerItem( "bicycle",					ITEMCAT_BUILDING, 14,	"models/props_junk/bicycle01a.mdl",							"Велосипед", nil, 755, 8)

-- These are the honorable mentions that come at the end of the round.

local function genericcallback(pl, magnitude) return pl:Name(), magnitude end
GM.HonorableMentions = {}
GM.HonorableMentions[HM_MOSTZOMBIESKILLED] = {Name = "Большинство убитых зомби", String = "около %s, с %d убитые зомби.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTDAMAGETOUNDEAD] = {Name = "Наибольший урон по живым", String = "переходит к %s, с общей of %d урон, нанесенный нежити.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHEADSHOTS] = {Name = "Больше убийств в голову", String = "переходит к %s, в общей сложности %s выстрел в голову убивает.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_PACIFIST] = {Name = "Пацифист", String = "олучает %s за то, что не убил ни одного зомби и все еще жив!", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_MOSTHELPFUL] = {Name = "Самый полезный", String = "отправляется %s за помощь в уничтожении%d зомби.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_LASTHUMAN] = {Name = "Последний человек", String = "достается %s за то, что он был последним живым человеком.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_OUTLANDER] = {Name = "Чужестранец", String = "получает %s за то, что был убит %d в нескольких футах от порождения зомби.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_GOODDOCTOR] = {Name = "Хороший доктор", String = "переходит к %s за исцеление своей команды на %d очков здоровья.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_HANDYMAN] = {Name = "Умелый человек", String = "переходит к %s для получения %d очков помощи при баррикадировании.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_SCARECROW] = {Name = "Пугало", String = "достается %s за убийство %d бедных ворон.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_MOSTBRAINSEATEN] = {Name = "Большинство съеденных мозгов", String = "по %s, с %d съеденными мозгами.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_MOSTDAMAGETOHUMANS] = {Name = "Большенство урона по людям", String = "переходит в %s, при этом общий урон, наносимый живым игрокам, составляет %d.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_LASTBITE] = {Name = "Последний укус", String = "переходит в %s для завершения раунда.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_USEFULTOOPPOSITE] = {Name = "Наиболее полезен для противоположной команды", String = "достается %s за то, что он отказался от огромного количества убийств %d!", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_STUPID] = {Name = "Идиот!!!!", String = "это то, что %s означает быть убитым %d в нескольких футах от порождения зомби.", Callback = genericcallback, Color = COLOR_RED}
GM.HonorableMentions[HM_SALESMAN] = {Name = "Продавец", String = "это то, что означает %s за то, что предметы, взятые из их ящика с арсеналом, стоят %d очков.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_WAREHOUSE] = {Name = "Склад", String = "хорошо описывает %s, поскольку их ящики для пополнения запасов использовались %d раз.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_DEFENCEDMG] = {Name = "Защитник", String = "получает %s за защиту людей от урона %d с усилением защиты.", Callback = genericcallback, Color = COLOR_WHITE}
GM.HonorableMentions[HM_STRENGTHDMG] = {Name = "Алхимик", String = "это то, что %s предназначено для усиления игроков дополнительным уроном %d.", Callback = genericcallback, Color = COLOR_CYAN}
GM.HonorableMentions[HM_BARRICADEDESTROYER] = {Name = "Разрушитель баррикад", String = "переходит к %s за нанесение %d урона баррикадам.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTDESTROYER] = {Name = "Уничтожитель гнёзд", String = "переходит к %s за уничтожение гнёзд %d.", Callback = genericcallback, Color = COLOR_LIMEGREEN}
GM.HonorableMentions[HM_NESTMASTER] = {Name = "Мастер гнёзд", String = "достается %s за то, что %d зомби появилось в его гнезде.", Callback = genericcallback, Color = COLOR_LIMEGREEN}

GM.RestrictedModels = {
	"models/player/zombie_classic.mdl",
	"models/player/zombie_classic_hbfix.mdl",
	"models/player/zombine.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/corpse1.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl",
	"models/player/zelpa/stalker.mdl",
	"models/player/fatty/fatty.mdl",
	"models/player/zombie_lacerator2.mdl",
	"models/player/soldier_stripped.mdl",
	"models/mailer/characters/fiddlesticks.mdl",
	"models/shadow.mdl",
	"models/vinrax/player/billy_herrington.mdl",
	"models/player/mrbeast/mrbeast.mdl",
	"models/paynamia/bms/gordon_survivor_player.mdl",
	"models/mrtan/crazy_dave/crazy_dave.mdl"
}

GM.RandomPlayerModels = {}
for name, mdl in pairs(player_manager.AllValidModels()) do
	if not table.HasValue(GM.RestrictedModels, string.lower(mdl)) then
		table.insert(GM.RandomPlayerModels, name)
	end
end

GM.DeployableInfo = {}
function GM:AddDeployableInfo(class, name, wepclass)
	local tab = {Class = class, Name = name or "?", WepClass = wepclass}

	self.DeployableInfo[#self.DeployableInfo + 1] = tab
	self.DeployableInfo[class] = tab

	return tab
end
GM:AddDeployableInfo("prop_arsenalcrate", 		"Арсенальный Ящик", 			"weapon_zs_arsenalcrate")
GM:AddDeployableInfo("prop_resupplybox", 		"Ящик Аммуниции", 				"weapon_zs_resupplybox")
GM:AddDeployableInfo("prop_remantler", 			"Верстак", 						"weapon_zs_remantler")
GM:AddDeployableInfo("prop_propmaker", 			"Создатель Пропов", 			"weapon_zs_propmaker")
GM:AddDeployableInfo("prop_messagebeacon", 		"Маяк Сообщения", 				"weapon_zs_messagebeacon")
GM:AddDeployableInfo("prop_camera", 			"Камера",	 					"weapon_zs_camera")
GM:AddDeployableInfo("prop_gunturret", 			"Турель",			 			"weapon_zs_gunturret")
GM:AddDeployableInfo("prop_gunturret_assault", 	"Штурмовая Турель",	 			"weapon_zs_gunturret_assault")
GM:AddDeployableInfo("prop_gunturret_buckshot",	"Взрывная Турель",	 			"weapon_zs_gunturret_buckshot")
GM:AddDeployableInfo("prop_gunturret_rocket",	"Ракетная Турель",	 			"weapon_zs_gunturret_rocket")
GM:AddDeployableInfo("prop_repairfield",		"Ремонтное Поле",				"weapon_zs_repairfield")
GM:AddDeployableInfo("prop_zapper",				"'Жало' Шоковая станция",		"weapon_zs_zapper")
GM:AddDeployableInfo("prop_zapper_arc",			"'Динамо' Шоковая станция",		"weapon_zs_zapper_arc")
GM:AddDeployableInfo("prop_ffemitter",			"Силовое Поле",					"weapon_zs_ffemitter")
GM:AddDeployableInfo("prop_manhack",			"Манхак",						"weapon_zs_manhack")
GM:AddDeployableInfo("prop_manhack_saw",		"Манхак с пилой",				"weapon_zs_manhack_saw")
GM:AddDeployableInfo("prop_drone",				"Дрон",							"weapon_zs_drone")
GM:AddDeployableInfo("prop_drone_pulse",		"Импульсный дрон",				"weapon_zs_drone_pulse")
GM:AddDeployableInfo("prop_drone_hauler",		"Дрон-Сборщик",					"weapon_zs_drone_hauler")
GM:AddDeployableInfo("prop_rollermine",			"Шаровая Мина",					"weapon_zs_rollermine")
GM:AddDeployableInfo("prop_tv",                 "Телевизор",              		"weapon_zs_tv")

GM.MaxSigils = 2

GM.ThreeSigilsRequirement = 20

GM.TwoSigilsRequirement = 10

GM.DefaultRedeem = 0

GM.TimeLimit = 60 * 30

GM.RoundLimit = 2

-- Initial length for wave 1.
GM.WaveOneLength = 220

-- Add this many seconds for each additional wave.
GM.TimeAddedPerWave = 15

-- New players are put on the zombie team if the current wave is this or higher. Do not put it lower than 1 or you'll break the game.
GM.NoNewHumansWave = 2

-- Humans can not commit suicide if the current wave is this or lower.
GM.NoSuicideWave = 1

-- How long 'wave 0' should last in seconds. This is the time you should give for new players to join and get ready.
GM.WaveZeroLength = 160

-- Time humans have between waves to do stuff without NEW zombies spawning. Any dead zombies will be in spectator (crow) view and any living ones will still be living.
GM.WaveIntermissionLength = 100

-- Time in seconds between end round and next map.
GM.EndGameTime = 45

-- How many clips of ammo guns from the Worth menu start with. Some guns such as shotguns and sniper rifles have multipliers on this.
GM.SurvivalClips = 4 --2

-- How long do humans have to wait before being able to get more ammo from a resupply box?
GM.ResupplyBoxCooldown = 60

-- Put your unoriginal, 5MB Rob Zombie and Metallica music here.
GM.LastHumanSound = Sound("zombiesurvival/lasthuman_uzs.ogg")

-- Sound played when humans all die.
GM.AllLoseSound = Sound("zombiesurvival/music_lose_1.ogg")

-- Sound played when humans survive.
GM.HumanWinSound = Sound("zombiesurvival/music_win_1.ogg")

-- Sound played to a person when they die as a human.
GM.DeathSound = Sound("zombiesurvival/human_death_stinger.ogg")

--[[
(Requires LockItemTiers) Adjusts how early or late in waves an item will unlock.
For example, if you set it to 1, a tier 2 item will unlock on wave 1, instead of
a tier 2 item unlocking on wave 2.
Do not set negative values.
]]
GM.LockItemsTierPlus = 2

-- Lock item purchases to waves. Tier 2 items can only be purchased on wave 2, tier 3 on wave 3, etc (unless you have LockItemsTierPlus).
-- Always false if objective map, zombie escape, classic mode, or wave number is changed by the map.
GM.LockItemTiers = true

--[[
Test Mode
Makes points, scrap, and ammo infinite
You can shop/upgrade weapons anywhere and buy as many MaxStock items as you want
Item tier locking is disabled
Disables experience gain to prevent levels from increasing
Enable only in local play for testing
]]
GM.TestingMode = false

-- Max amount of damage left to tick on these. Any more pending damage is ignored.
GM.MaxPoisonDamage = 50
GM.MaxBleedDamage = 50
GM.MaxVampirism = 50
GM.MaxRegeneration = 50

-- Give humans this many points when the wave ends.
GM.EndWavePointsBonus = 5

-- Also give humans this many points when the wave ends, multiplied by (wave - 1)
GM.EndWavePointsBonusPerWave = 1
