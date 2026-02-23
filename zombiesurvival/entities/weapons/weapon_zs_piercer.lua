AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Прошиватель' Револьвер"
SWEP.Description = "Пули данного оружия отскакивают от поверхности тем самым наносят дополнительный урон и также пробивают зомби."
SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	SWEP.ShowWorldModel = false
	SWEP.HUD3DBone = "Python"
	SWEP.HUD3DPos = Vector(0.85, -0.5, -2.5)
	SWEP.HUD3DScale = 0.0175

	SWEP.ViewModelBoneMods = {
    ["Bullet2"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["Bullet3"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["Bullet4"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["Bullet5"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["Bullet6"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["Python"] = { scale = Vector(1.1169999837875, 1.1169999837875, 1.1169999837875), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["models/hunter/plates/plate.mdl1+"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.191, 4.428, -2.037), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl1"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.151, 4.434, -0.172), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "Python", rel = "baseframe", pos = Vector(7.171, 4.449, -7.37), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdlneon++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.434, 3.927, 1.745), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(33, 255, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/shell2x2a.mdl"] = { type = "Model", model = "models/hunter/misc/shell2x2a.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.473, 5.953, -15.143), angle = Angle(0, 0, 180), size = Vector(0.024, 0.024, 0.024), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdlneon+"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.335, 4.059, -15.759), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(33, 255, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl+++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.414, 6.08, -0.528), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "Python", rel = "baseframe", pos = Vector(7.179, 4.919, -7.887), angle = Angle(-1.127, 2.578, 88.822), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "baseframe", pos = Vector(7.176, 5.114, -7.397), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.414, 6.08, -2.692), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdlneon"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.539, 4.052, -15.744), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(33, 255, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl+"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "Python", rel = "baseframe", pos = Vector(7.168, 4.445, -7.843), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl+"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "baseframe", pos = Vector(7.176, 5.114, -7.875), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl1++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.151, 4.434, -4.068), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl+++"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "baseframe", pos = Vector(7.176, 5.114, -8.756), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/triangles/trapezium.mdl1111111+"] = { type = "Model", model = "models/hunter/triangles/trapezium.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.42, 4.739, -5.127), angle = Angle(0, 90, 0), size = Vector(0.019, 0.009, 4.675), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.665, 4.453, -4.047), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/geometric/hex05x1.mdl"] = { type = "Model", model = "models/hunter/geometric/hex05x1.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.419, 5.315, -12.825), angle = Angle(0, 90, 0), size = Vector(0.019, 0.009, 4.897), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl+"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.665, 4.453, -1.89), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "Python", rel = "", pos = Vector(-6.441, -6.15, 13.829), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/triangles/trapezium3x3x1c.mdl"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.434, 4.223, 1.754), angle = Angle(90, -90, 0), size = Vector(0.009, 0.009, 0.014), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl+++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "Python", rel = "baseframe", pos = Vector(7.165, 4.453, -8.728), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.401, 5.092, 1.889), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x4.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x4.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.412, 5.08, -11.971), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.072), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/gravestone002a.mdl"] = { type = "Model", model = "models/props_c17/gravestone002a.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.421, 5.475, -5.193), angle = Angle(90, 0, -90), size = Vector(1.593, 0.039, 0.025), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "Python", rel = "baseframe", pos = Vector(7.165, 4.453, -8.32), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl+"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.414, 6.08, -6.33), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.414, 6.08, -9.931), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "Python", rel = "baseframe", pos = Vector(6.665, 4.453, 0.097), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl++"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "baseframe", pos = Vector(7.176, 5.114, -8.355), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["models/hunter/plates/plate.mdl1+"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.14, 4.438, -2.039), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl1"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.151, 4.434, -0.172), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.171, 4.449, -7.37), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdlneon++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.429, 3.97, 1.731), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(33, 255, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.665, 4.453, 0.097), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl+++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.414, 6.08, -0.528), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.179, 4.919, -7.887), angle = Angle(-1.127, 2.578, 88.822), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl+++"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.176, 5.114, -8.756), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl++"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.414, 6.08, -2.692), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/w_357.mdl"] = { type = "Model", model = "models/weapons/w_357.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.206, 7.126, -18.338), angle = Angle(95.156, 90.566, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl1++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.151, 4.434, -4.068), angle = Angle(0, 16.152, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl+"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.168, 4.445, -7.843), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.176, 5.114, -7.397), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/triangles/trapezium.mdl1111111+"] = { type = "Model", model = "models/hunter/triangles/trapezium.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.42, 4.739, -5.127), angle = Angle(0, 90, 0), size = Vector(0.019, 0.009, 4.675), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl++"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.665, 4.453, -4.047), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.513, -4.003, -8.733), angle = Angle(-2.623, -91.414, -88.927), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate.mdl+"] = { type = "Model", model = "models/hunter/plates/plate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.665, 4.453, -1.89), angle = Angle(0, -16.153, 0), size = Vector(0.048, 0.05, 0.456), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.165, 4.453, -8.32), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl+"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.176, 5.114, -7.875), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/Items/AR2_Grenade.mdl+++"] = { type = "Model", model = "models/Items/AR2_Grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.165, 4.453, -8.728), angle = Angle(0.634, 88.639, 0), size = Vector(0.119, 0.119, 0.119), color = Color(255, 223, 127, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.401, 5.092, 1.889), angle = Angle(0, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x4.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.412, 5.08, -11.971), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.072), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/gravestone002a.mdl"] = { type = "Model", model = "models/props_c17/gravestone002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.421, 5.475, -5.193), angle = Angle(90, 0, -90), size = Vector(1.593, 0.039, 0.025), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/geometric/hex05x1.mdl"] = { type = "Model", model = "models/hunter/geometric/hex05x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.419, 5.315, -12.825), angle = Angle(0, 90, 0), size = Vector(0.019, 0.009, 4.897), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl+"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.414, 6.08, -6.33), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack9.mdl"] = { type = "Model", model = "models/props_phx/gears/rack9.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.414, 6.08, -9.931), angle = Angle(0, 0, 90), size = Vector(0.254, 0.1, 0.1), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/triangles/trapezium3x3x1c.mdl"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(6.434, 4.223, 1.754), angle = Angle(90, -90, 0), size = Vector(0.009, 0.009, 0.012), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/rifleshell.mdl++"] = { type = "Model", model = "models/weapons/rifleshell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(7.176, 5.114, -8.355), angle = Angle(-1.619, 90.851, -1.933), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false
SWEP.RequiredClip = 2
SWEP.Primary.Sound = Sound("weapons/zs_piercer/piercer.ogg") 
SWEP.Primary.Delay = 0.7
SWEP.Primary.Damage = 176
SWEP.Primary.NumShots = 1

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Tier = 6
SWEP.MaxStock = 1

SWEP.ConeMax = 2.2
SWEP.ConeMin = 0.9

SWEP.BounceMulti = 1.5

SWEP.Pierces = 4

SWEP.IronSightsPos = Vector(-1.62, 0, 0.8)
SWEP.IronSightsAng = Vector(0, 0, 1)

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.EnableChargingAbility = true

SWEP.FullChargeText = "ПКМ: Двойной Выстрел!"
SWEP.ChargeText = "Попадания"

SWEP.ChargeColor = COLOR_YELLOW

SWEP.ChargeGain = 0.07

SWEP.ReloadSpeed = 1.05

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.5, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.25, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.07, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_BULLET_PIERCES, 1)
local function DoRicochet(attacker, hitpos, hitnormal, normal, damage)
	local RicoCallback = function(att, tr, dmginfo)
		local ent = tr.Entity
		local wep = att:GetActiveWeapon()
		if wep.Branch == 1 and ent:IsValidZombie() then
			wep:SetDTInt(9, wep:GetDTInt(9) + 2)
		end
	end

	attacker.RicochetBullet = true
	if attacker:IsValid() then
		attacker:FireBulletsLua(hitpos, 2 * hitnormal * hitnormal:Dot(normal * -1) + normal, 0, 1, damage, nil, nil, "tracer_rico", RicoCallback, nil, nil, nil, nil, attacker:GetActiveWeapon())
	end
	attacker.RicochetBullet = nil
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	local wep = attacker:GetActiveWeapon()
	if SERVER and tr.HitWorld and not tr.HitSky then
		local hitpos, hitnormal, normal, dmg = tr.HitPos, tr.HitNormal, tr.Normal, dmginfo:GetDamage() * attacker:GetActiveWeapon().BounceMulti
		timer.Simple(0, function() DoRicochet(attacker, hitpos, hitnormal, normal, dmg) end)
	end

	local damage = (dmginfo:GetDamage() * wep.ChargeGain)
	if ent:IsValidZombie() and wep.EnableChargingAbility then
		local intd = math.min(100 - damage, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))
		wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, intd + damage)
	end

	if SERVER then
		if wep.Branch == 1 and ent:IsValidZombie() then
			wep:SetDTInt(9, wep:GetDTInt(9) + 1)
		end
	end
end

function SWEP:ShootBullets(dmg, numbul, cone)
	local owner = self:GetOwner()
	self:SendWeaponAnimation()
	owner:DoAttackEvent()

	local dir = owner:GetAimVector()
	local dirang = dir:Angle()
	local start = owner:GetShootPos()

	dirang:RotateAroundAxis(dirang:Forward(), util.SharedRandom("bulletrotate1", 0, 360))
	dirang:RotateAroundAxis(dirang:Up(), util.SharedRandom("bulletangle1", -cone, cone))

	dir = dirang:Forward()
	local tr = owner:CompensatedPenetratingMeleeTrace(2048, 0.01, start, dir)
	local ent

	owner:LagCompensation(true)
	owner:FireBulletsLua(start, dir, cone, numbul, dmg, nil, self.Primary.KnockbackScale, self.TracerName, self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)
	for i, trace in ipairs(tr) do
		if i == 1 or not trace.Hit then continue end
		if i > self.Pierces then break end

		ent = trace.Entity

		if ent and ent:IsValid() then
			owner:FireBulletsLua(trace.HitPos, dir, 0, numbul, dmg/i, nil, self.Primary.KnockbackScale, "", self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)
		end
	end
	owner:LagCompensation(false)
	
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	local intd = wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON)

	if self:CanPrimaryAttack() and intd >= 100 then
		local rnda = 6 * -1 
		local rndb = 6 * math.random(-1, 1) 

		self.Owner:ViewPunch(Angle(rnda, rndb, rnda ))

		local damage = self.Primary.Damage * 1.5

		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		self:EmitSound("weapons/zs_longarm/longarm_fire.ogg", 120, 60, 0.9, CHAN_AUTO +20)
		self:EmitSound("weapons/zs_piercer/piercer.ogg", 100, 80, 0.9, CHAN_AUTO +21)

		self:ShootBulletsPiercing(damage, self.Primary.NumShots * 2, self:GetCone() * 0.5)
		self:TakeAmmo()
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, 0)
	elseif self:GetNextSecondaryFire() <= CurTime() and not self:GetOwner():IsHolding() and self:GetReloadFinish() == 0 then
		self:SetIronsights(true)
	end
end