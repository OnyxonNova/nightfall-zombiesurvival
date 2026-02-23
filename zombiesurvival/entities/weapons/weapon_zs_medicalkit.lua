AddCSLuaFile()

SWEP.PrintName = "Медицинская Аптечка"
SWEP.Description = "Нажмите ЛКМ, чтобы лечить других игроков получая за это поинты.\nНажмите ПКМ, чтобы полечить себя."

if CLIENT then
    SWEP.ViewModelBoneMods = {
        ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1.034), pos = Vector(-70, 0, 0), angle = Angle(0, 0, 0) },
    }
 
    SWEP.VMPos = Vector(0, 0, -2)
    SWEP.VMAng = Vector(4.225, -12.5, 13.37)
end

SWEP.Base = "weapon_zs_basemedicalkit"

SWEP.Heal = 15
SWEP.Primary.HealCoolDown = 10

SWEP.Primary.DefaultClip = 150

SWEP.Secondary.DelayMul = 20 / SWEP.Primary.HealCoolDown
SWEP.Secondary.HealMul = 10 / SWEP.Heal

SWEP.HealRange = 36

SWEP.HoldType = "slam"

SWEP.HudColor = COLOR_GREEN

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_HEALCOOLDOWN, -0.8)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALRANGE, 4, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 1.5)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Покровитель' Аптечка", "Вы не можете лечить себя, сниженная задержка лечения", function(wept)
	wept.NoSelfHealing = true
	wept.HudColor = COLOR_PINK
	wept.Primary.HealCoolDown = wept.Primary.HealCoolDown * 0.6
	wept.Heal = wept.Heal + 5

	wept.ShowViewModel = false
	wept.ShowWorldModel = false

	wept.VElements = {
	["models/Items/HealthKit.mdl"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "medkit", pos = Vector(-0.95, -3.481, -1.828), angle = Angle(-4.849, -91.205, 0), size = Vector(0.61, 0.61, 0.61), color = Color(255, 190, 230, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["medkit"] = { type = "Model", model = "", bone = "medkit_bone", rel = "", pos = Vector(0.107, -0.088, 0.014), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	wept.WElements = {
	["models/Items/HealthKit.mdl"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "medkit", pos = Vector(-0.914, -3.898, -1.787), angle = Angle(-4.849, -91.205, 0), size = Vector(0.577, 0.577, 0.577), color = Color(255, 190, 230, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["medkit"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.815, 3.905, -0.57), angle = Angle(-178.706, -79.256, 55.098), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end)
branch.Colors = {[0]=Color(255, 100, 255)}
branch.NewNames = {[0]="Покровитель"}

local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Инъектор' Кровавая Аптечка", "Лечит Кровавую броню заместо Здоровья, использует меньше Медикаментов", function(wept)
	wept.BloodHealing = true
	wept.HudColor = COLOR_SOFTRED

	wept.PrimaryHealingSound = "npc/ichthyosaur/snap.wav"
	wept.SecondaryHealingSound = "npc/ichthyosaur/snap.wav"

	wept.ShowViewModel = false
	wept.ShowWorldModel = false

	wept.Heal = wept.Heal * math.Round(2 - (1 / 3), 1)
	wept.Primary.HealCoolDown = wept.Primary.HealCoolDown * 0.825

	wept.Secondary.DelayMul = 10 / wept.Primary.HealCoolDown

	wept.ConsumptionMultiplier = wept.ConsumptionMultiplier * 0.825

	wept.VElements = {
	["models/props_combine/combine_dispenser.mdl"] = { type = "Model", model = "models/props_combine/combine_dispenser.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "medkit", pos = Vector(-1.242, 0.98, 0.386), angle = Angle(97.793, 87.166, -180), size = Vector(0.09, 0.09, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "medkit", pos = Vector(0.86, 2.657, 0.153), angle = Angle(-84.582, 95.285, 6.19), size = Vector(0.629, 0.629, 0.639), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/HealthKit.mdl"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "medkit", pos = Vector(-0.95, -3.481, -1.828), angle = Angle(-4.849, -91.205, 0), size = Vector(0.61, 0.61, 0.61), color = Color(182, 182, 182, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_pipes/pipeset02d_corner128d_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_corner128d_001a.mdl", bone = "medkit_bone", rel = "medkit", pos = Vector(-0.172, 1.588, 0.347), angle = Angle(0.887, 88.343, 86.441), size = Vector(0.014, 0.014, 0.014), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["medkit"] = { type = "Model", model = "", bone = "medkit_bone", rel = "", pos = Vector(0.107, -0.088, 0.014), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	wept.WElements = {
	["models/props_combine/combine_dispenser.mdl"] = { type = "Model", model = "models/props_combine/combine_dispenser.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "medkit", pos = Vector(-1.242, 0.98, 0.386), angle = Angle(97.793, 87.166, -180), size = Vector(0.09, 0.09, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "medkit", pos = Vector(0.773, 2.061, 0.115), angle = Angle(-85.142, 94.56, 6.19), size = Vector(0.628, 0.628, 0.628), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/HealthKit.mdl"] = { type = "Model", model = "models/Items/HealthKit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "medkit", pos = Vector(-0.914, -3.898, -1.787), angle = Angle(-4.849, -91.205, 0), size = Vector(0.577, 0.577, 0.577), color = Color(182, 182, 182, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_pipes/pipeset02d_corner128d_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_corner128d_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "medkit", pos = Vector(-0.172, 1.588, 0.347), angle = Angle(0.887, 88.343, 86.441), size = Vector(0.014, 0.014, 0.014), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["medkit"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.815, 3.905, -0.57), angle = Angle(-178.706, -79.256, 55.098), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end)
branch.Colors = {[0]=Color(255, 40, 40)}
branch.NewNames = {[0]="Инъектор"}