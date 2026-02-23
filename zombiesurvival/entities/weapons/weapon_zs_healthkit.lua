AddCSLuaFile()

SWEP.PrintName = "'Проект Исцеления' Аптечка"
SWEP.Description = "Усовершенствованная и более эффективная версия обычной Аптечки."

if CLIENT then
	SWEP.ViewModelFOV = 57
	SWEP.ViewModelFlip = false

	SWEP.ShowWorldModel = false
	SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(-0.825, -0.341, 0.045), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.491, 0.619, -0.149), angle = Angle(0, 0, 0) },
	["medkit_bone"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
	SWEP.VElements = {
	["healthkit"] = { type = "Model", model = "models/props_combine/health_charger001.mdl", bone = "medkit_bone", rel = "", pos = Vector(-0.522, 0.616, -2.063), angle = Angle(80.168, -101.436, 5.625), size = Vector(0.414, 0.414, 0.414), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	SWEP.WElements = {
	["healthkit"] = { type = "Model", model = "models/props_combine/health_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.295, 5.198, 0), angle = Angle(0, -176.224, 174.85), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end

SWEP.Base = "weapon_zs_basemedicalkit"

SWEP.ViewModel = "models/weapons/c_medkit.mdl"
SWEP.WorldModel = "models/props_combine/health_charger001.mdl"
SWEP.UseHands = true

SWEP.Heal = 35
SWEP.Primary.HealCoolDown = 7.5

SWEP.Primary.DefaultClip = 150

SWEP.Secondary.DelayMul = 40 / SWEP.Primary.HealCoolDown
SWEP.Secondary.HealMul = 12.5 / SWEP.Heal

SWEP.HealRange = 50

SWEP.HoldType = "slam"

SWEP.Tier = 2

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_HEALCOOLDOWN, -0.8)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALRANGE, 4, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 1.5)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Восполнитель' Аптечка", "Лечение даёт регенерацию, её количество будет зависеть от суммы вылеченного здоровья, использует больше медикаментов, лечение здоровья слабее и увеличенная задержка лечения", function(wept)
	wept.HudColor = COLOR_PINK
	wept.RegenHealing = true

	wept.Heal = wept.Heal * 0.7
	wept.ConsumptionMultiplier = wept.ConsumptionMultiplier * 1.25
	wept.Primary.HealCoolDown = wept.Primary.HealCoolDown * 1.35

	wept.VElements = {
	["healthkit"] = { type = "Model", model = "models/props_combine/health_charger001.mdl", bone = "medkit_bone", rel = "", pos = Vector(-0.522, 0.616, -2.063), angle = Angle(80.168, -101.436, 5.625), size = Vector(0.414, 0.414, 0.414), color = Color(255, 190, 230, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	wept.WElements = {
	["healthkit"] = { type = "Model", model = "models/props_combine/health_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.295, 5.198, 0), angle = Angle(0, -176.224, 174.85), size = Vector(0.5, 0.5, 0.5), color = Color(255, 190, 230, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end)
branch.Colors = {[0]=Color(255, 100, 255)}
branch.NewNames = {[0]="Восполнитель"}