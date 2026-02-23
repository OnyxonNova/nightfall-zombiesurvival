AddCSLuaFile()

SWEP.PrintName = "'Разгар' Дробовик"
SWEP.Description = "Боевый и точный дробовик, который за несколько выстрелов может с лёгкостью убьёт зомби!"

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "v_weapon.galil"
	SWEP.HUD3DPos = Vector(1.5, -1, 6)
	SWEP.HUD3DScale = 0.025

SWEP.VElements = {
	["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.491, 0.977, -14.115), angle = Angle(-0.724, 1.661, -89.854), size = Vector(0.1, 0.1, 0.254), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl+++"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.657, -1.221, -0.981), angle = Angle(2.749, 91.17, -89.405), size = Vector(0.086, 0.086, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x05.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.415, -0.635, -6.869), angle = Angle(2.03, -83.807, 89.947), size = Vector(0.241, 0.626, 0.697), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.412, -0.588, 9.192), angle = Angle(-0.306, 1.128, -0.332), size = Vector(0.112, 0.187, 0.229), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.396, -1.486, 19.065), angle = Angle(-0.894, 0, 0), size = Vector(0.029, 0.029, 0.16), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_interiors/pot02a.mdl"] = { type = "Model", model = "models/props_interiors/pot02a.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.336, -5.034, 19.263), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.675, -1.759, -2.495), angle = Angle(0.233, -92.432, -0.278), size = Vector(0.046, 0.046, 0.314), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x075.mdl+"] = { type = "Model", model = "models/hunter/plates/plate025x075.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.188, 7.876, 0.27), angle = Angle(180, -2.547, 75.998), size = Vector(0.082, 0.219, 0.361), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001b_truck.mdl+"] = { type = "Model", model = "models/props_vehicles/tire001b_truck.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.477, -5.598, -1.223), angle = Angle(-95.212, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "v_weapon.bolt", rel = "basebolt", pos = Vector(-0.996, 0.64, 0.768), angle = Angle(-0.182, 89.343, -89.245), size = Vector(0.061, 0.061, 0.061), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basebolt"] = { type = "Model", model = "", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.058, -0.109, 0.537), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate05.mdl1"] = { type = "Model", model = "models/hunter/plates/plate05.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.726, -4.691, -0.982), angle = Angle(-91.548, 7.242, 5.54), size = Vector(0.192, 0.057, 0.166), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x5.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x5.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.443, 1.789, -14.013), angle = Angle(-0.104, 2.451, -6.935), size = Vector(0.046, 0.097, 0.071), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/w_pist_fiveseven.mdl"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.132, 7.879, -1.343), angle = Angle(85.78, -92.24, 3.484), size = Vector(1.174, 0.93, 1.406), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xqm/afterburner1.mdl"] = { type = "Model", model = "models/xqm/afterburner1.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.301, -1.464, 27.284), angle = Angle(0.089, -0.297, -0.069), size = Vector(0.07, 0.07, 0.122), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x075.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x075.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.366, 4.885, 3.619), angle = Angle(180, -0.399, 3.953), size = Vector(0.134, 0.236, 0.135), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl+++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.505, -1.685, -13.808), angle = Angle(0.499, -82.602, 0.533), size = Vector(0.046, 0.046, 0.291), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(1.649, -0.774, 16.636), angle = Angle(91.401, 180, 0), size = Vector(0.207, 0.054, 0.054), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.603, 0.246, 6.277), angle = Angle(-1.009, -0.383, -90.053), size = Vector(0.4, 2.23, 0.85), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x5.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x5.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.396, -0.317, 0.029), angle = Angle(0, 0, 0), size = Vector(0.046, 0.097, 0.046), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "v_weapon.magazine", rel = "baseclip", pos = Vector(-0.536, 7.467, 0.74), angle = Angle(-1.198, -2.31, -96.342), size = Vector(0.165, 0.05, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl+"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.165, -0.803, 19.216), angle = Angle(2.477, 89.698, -89.245), size = Vector(0.086, 0.086, 0.064), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "v_weapon.galil", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/tri2x1.mdl"] = { type = "Model", model = "models/hunter/plates/tri2x1.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-1.086, 0.432, -0.819), angle = Angle(91.028, -178.834, -1.015), size = Vector(0.273, 0.122, 0.504), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.505, -1.65, -13.815), angle = Angle(1.238, 167.953, 0.098), size = Vector(0.046, 0.046, 0.291), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl+"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.447, -1.678, -7.897), angle = Angle(-0.232, -0.862, -90.259), size = Vector(0.19, 0.998, 0.37), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseclip"] = { type = "Model", model = "", bone = "v_weapon.magazine", rel = "", pos = Vector(-0.046, 0.446, 0.226), angle = Angle(2.348, 0.537, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_combine/breenclock.mdl"] = { type = "Model", model = "models/props_combine/breenclock.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(1.447, -1.05, 16.596), angle = Angle(-90.609, 5.993, 0), size = Vector(0.843, 0.068, 0.074), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_junk/TrashDumpster01a.mdl"] = { type = "Model", model = "models/props_junk/TrashDumpster01a.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-1.04, -1.127, 4.76), angle = Angle(180, 83.643, -90.947), size = Vector(0.039, 0.059, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.258, -1.637, -2.51), angle = Angle(0.041, 172.641, 0.699), size = Vector(0.046, 0.046, 0.314), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+++"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.182, -2.478, 15.604), angle = Angle(-0.843, 0, 0), size = Vector(0.029, 0.029, 0.082), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl++"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(0.074, -1.221, -0.977), angle = Angle(1.085, 91.401, -89.959), size = Vector(0.086, 0.086, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001b_truck.mdl"] = { type = "Model", model = "models/props_vehicles/tire001b_truck.mdl", bone = "v_weapon.galil", rel = "baseframe", pos = Vector(-0.473, -5.335, -1.274), angle = Angle(-95.212, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.491, 0.977, -14.115), angle = Angle(-0.724, 1.661, -89.854), size = Vector(0.1, 0.1, 0.254), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl+++"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.657, -1.221, -0.981), angle = Angle(2.749, 91.17, -89.405), size = Vector(0.086, 0.086, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x05.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.415, -0.635, -6.869), angle = Angle(2.03, -83.807, 89.947), size = Vector(0.241, 0.626, 0.697), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.412, -0.588, 9.192), angle = Angle(-0.306, 1.128, -0.332), size = Vector(0.112, 0.187, 0.229), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.339, -1.474, 19.111), angle = Angle(-0.894, 0, 0), size = Vector(0.029, 0.029, 0.16), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_interiors/pot02a.mdl"] = { type = "Model", model = "models/props_interiors/pot02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.336, -5.034, 19.263), angle = Angle(0, 0, 0), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.675, -1.759, -2.495), angle = Angle(0.233, -92.432, -0.278), size = Vector(0.046, 0.046, 0.314), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x075.mdl+"] = { type = "Model", model = "models/hunter/plates/plate025x075.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.188, 7.876, 0.27), angle = Angle(180, -2.547, 75.998), size = Vector(0.082, 0.219, 0.361), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001b_truck.mdl+"] = { type = "Model", model = "models/props_vehicles/tire001b_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.477, -5.598, -1.223), angle = Angle(-95.212, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(-0.996, 0.64, 0.768), angle = Angle(-0.182, 89.343, -89.245), size = Vector(0.061, 0.061, 0.061), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basebolt"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0.785, -1.67, 6.565), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["basegun"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.992, 1.363, -3.096), angle = Angle(-180, 90.431, 82.837), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate05.mdl1"] = { type = "Model", model = "models/hunter/plates/plate05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.726, -4.691, -0.982), angle = Angle(-91.548, 7.242, 5.54), size = Vector(0.192, 0.057, 0.166), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x5.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x5.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.443, 1.789, -14.013), angle = Angle(-0.104, 2.451, -6.935), size = Vector(0.046, 0.097, 0.071), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/w_pist_fiveseven.mdl"] = { type = "Model", model = "models/weapons/w_pist_fiveseven.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.132, 7.879, -1.343), angle = Angle(85.78, -92.24, 3.484), size = Vector(1.174, 0.93, 1.406), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xqm/afterburner1.mdl"] = { type = "Model", model = "models/xqm/afterburner1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.278, -1.499, 27.207), angle = Angle(0.089, -0.297, -0.069), size = Vector(0.07, 0.07, 0.122), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x075.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x075.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.366, 4.885, 3.619), angle = Angle(180, -0.399, 3.953), size = Vector(0.134, 0.236, 0.135), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl+++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.505, -1.685, -13.808), angle = Angle(0.499, -82.602, 0.533), size = Vector(0.046, 0.046, 0.291), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.649, -0.774, 16.636), angle = Angle(91.401, 180, 0), size = Vector(0.207, 0.054, 0.054), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.258, -1.637, -2.51), angle = Angle(0.041, 172.641, 0.699), size = Vector(0.046, 0.046, 0.314), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x5.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x5.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.396, -0.317, 0.029), angle = Angle(0, 0, 0), size = Vector(0.046, 0.097, 0.046), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(-0.536, 7.467, 0.74), angle = Angle(-1.198, -2.31, -96.342), size = Vector(0.165, 0.05, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl+"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.165, -0.803, 19.216), angle = Angle(2.477, 89.698, -89.245), size = Vector(0.086, 0.086, 0.064), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/tri2x1.mdl"] = { type = "Model", model = "models/hunter/plates/tri2x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-1.086, 0.432, -0.819), angle = Angle(91.028, -178.834, -1.015), size = Vector(0.273, 0.122, 0.504), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/tubes/tube1x1x1d.mdl++++"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.505, -1.65, -13.815), angle = Angle(1.238, 167.953, 0.098), size = Vector(0.046, 0.046, 0.291), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl+"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.447, -1.678, -7.897), angle = Angle(-0.232, -0.862, -90.259), size = Vector(0.19, 0.998, 0.37), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/phxtended/tri1x1.mdl++"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.074, -1.221, -0.977), angle = Angle(1.085, 91.401, -89.959), size = Vector(0.086, 0.086, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.603, 0.246, 6.277), angle = Angle(-1.009, -0.383, -90.053), size = Vector(0.4, 2.23, 0.85), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_junk/TrashDumpster01a.mdl"] = { type = "Model", model = "models/props_junk/TrashDumpster01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-1.04, -1.127, 4.76), angle = Angle(180, 83.643, -90.947), size = Vector(0.039, 0.059, 0.039), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_combine/breenclock.mdl"] = { type = "Model", model = "models/props_combine/breenclock.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.447, -1.05, 16.596), angle = Angle(-90.609, 5.993, 0), size = Vector(0.843, 0.068, 0.074), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseclip"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-0.042, 1.735, 5.268), angle = Angle(2.348, 0.537, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+++"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.182, -2.478, 15.604), angle = Angle(-0.843, 0, 0), size = Vector(0.029, 0.029, 0.082), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001b_truck.mdl"] = { type = "Model", model = "models/props_vehicles/tire001b_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.473, -5.335, -1.274), angle = Angle(-95.212, 0, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.UseHands = true

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadDelay = 0.9
SWEP.ReloadSpeed = 1.15

SWEP.Primary.Sound = "weapons/aa12/xm1014-1.mp3"
SWEP.Primary.Damage = 16
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.25

SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 16
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.ConeMax = 8
SWEP.ConeMin = 3.95

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.2, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.2, 1)
branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Умиротворитель' Дробовик", "Увеличенный урон, но меньше обойма и скорострельность", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 1.15
	wept.Primary.ClipSize = 5
	wept.Primary.Delay = wept.Primary.Delay * 1.2
end)
branch.NewNames = {[0]="Умиротворитель"}

function SWEP:SecondaryAttack()
end