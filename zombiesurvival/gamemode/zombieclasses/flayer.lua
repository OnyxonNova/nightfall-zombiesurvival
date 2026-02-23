CLASS.Base = "lacerator"

CLASS.Name = "Flayer"
CLASS.TranslationName = "class_flayer"
CLASS.Description = "description_flayer"
CLASS.Help = "controls_flayer"

CLASS.Model = Model("models/player/zombie_classic_hbfix.mdl")
CLASS.OverrideModel = Model("models/Zombie/Poison.mdl")
CLASS.Wave = 5 / 6
CLASS.ClassType = 3
CLASS.Health = 280
CLASS.HealthPerWave = 15
CLASS.Speed = 275
CLASS.SWEP = "weapon_zs_flayer"

CLASS.GearFoleyVolumeHeavy = 0.6
CLASS.GearFoleyVolume = 0.225

CLASS.GearFoley = {
	"physics/flesh/flesh_squishy_impact_hard1.wav",
	"physics/flesh/flesh_squishy_impact_hard2.wav",
	"physics/flesh/flesh_squishy_impact_hard3.wav",
	"physics/flesh/flesh_squishy_impact_hard4.wav"
}

local matSkin = Material("models/flesh")
function CLASS:PrePlayerDrawOverrideModel(pl)
	render.ModelMaterialOverride(matSkin)
	render.SetColorModulation(0.57, 0.35, 0.37)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render.ModelMaterialOverride(nil)
	render.SetColorModulation(1, 1, 1)
end

if SERVER then return end

CLASS.Icon = "zombiesurvival/killicons/lacerator"
CLASS.IconColor = Color(255, 0, 0)