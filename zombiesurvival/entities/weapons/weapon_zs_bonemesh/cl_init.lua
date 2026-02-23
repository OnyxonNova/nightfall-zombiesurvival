INC_CLIENT()

SWEP.PrintName = "Костолом"
SWEP.ViewModelFOV = 75
SWEP.DrawCrosshair = true

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

SWEP.ViewModelFlip = false
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
	
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, -0, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger11"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger12"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, 0, -0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 10) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(9.029, -52.984, -12.752) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, -55.211, 0) },
    ["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(0, 0, 0), pos = Vector(0, 0, 0), angle = Angle(0, -55.211, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(5, -2.5, -6), angle = Angle(3.035, -8.169, -6.045) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(20.917, -14.115, -34.5) }
}
	
SWEP.WElements = {
	["mettal"] = { type = "Model", model = "models/props_c17/metalladder002b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-1, -2, 1), angle = Angle(-16, 50, 80), size = Vector(0.6, 0.6, 0.6), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["cone"] = { type = "Model", model = "models/props_junk/TrafficCone001a.mdl", bone = "ValveBiped.Bip01_Neck", rel = "", pos = Vector(-16.514, 3.124, 34), angle = Angle(-67.575, -90.163, 24.312), size = Vector(0.563, 0.563, 0.563), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["hookleft"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(12.744, -0.601, -0.758), angle = Angle(-157.594, 90.811, -98.482), size = Vector(1.3, 1.3, 1.3), color = Color(255, 35, 35, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["body1"] = { type = "Model", model = "models/Humans/Charple03.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-44, 0, 23.875), angle = Angle(67.311, 0.119, 180), size = Vector(0.899, 0.899, 0.899), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	
SWEP.VElements = {
	["hookleft"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0, 1, -4), angle = Angle(160, 80, -55), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local matSheet = Material("Models/flesh")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
