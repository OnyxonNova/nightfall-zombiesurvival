AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "'Творец' Импульсный Дробовик"
SWEP.Description = "При достаточном нанесении урона может выстрелить на ПКМ сильными пробивающими пулями"

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VMPos = Vector(-1, -3, 1.25)

	SWEP.HUD3DBone = "v_weapon.M3_PARENT"
	SWEP.HUD3DPos = Vector(-1.75, -4.4, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.441, 0.472, -13.566), angle = Angle(2.484, -7.439, -92.05), size = Vector(0.039, 0.1, 0.111), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/items/combine_rifle_ammo01.mdl+"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.011, 0.477, -11.919), angle = Angle(180, 9.534, -177.599), size = Vector(0.079, 0.079, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_256_001a.mdl+"] = { type = "Model", model = "models/props_pipes/pipeset02d_256_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.939, -0.463, -7.462), angle = Angle(3.492, -74.935, 0.569), size = Vector(0.019, 0.05, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "phoenix_storms/white_brushes", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.07, -0.091, 17.003), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basepump", pos = Vector(0.004, -0.848, -7.323), angle = Angle(0.657, -3.01, 3.506), size = Vector(0.059, 0.07, 0.156), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.017, -0.062, 19.211), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["basepump"] = { type = "Model", model = "", bone = "v_weapon.M3_PUMP", rel = "", pos = Vector(-0.117, 0.035, 0.407), angle = Angle(0.372, 4.693, -3.59), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/tprotato1.mdl"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.934, -0.56, -3.756), angle = Angle(-0.08, 0, 0), size = Vector(0.009, 0.009, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseshell"] = { type = "Model", model = "", bone = "v_weapon.M3_SHELL", rel = "", pos = Vector(0.54, -0.264, -0.872), angle = Angle(-4.197, 110.329, 102.838), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/Items/battery.mdl"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.337, -0.525, -2.731), angle = Angle(0.301, 82.302, -0.917), size = Vector(0.4, 0.25, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.024, -0.077, 16.569), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/hunter/misc/platehole1x1a.mdl"] = { type = "Model", model = "models/hunter/misc/platehole1x1a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.8, -0.599, 3.871), angle = Angle(90.684, 8.937, -3.666), size = Vector(0.05, 0.016, 0.071), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.03, -0.08, 17.472), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_elite_single.mdl"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.257, 4.443, -3.201), angle = Angle(90.94, -84.981, -12.79), size = Vector(0.796, 0.66, 0.79), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basebolt"] = { type = "Model", model = "", bone = "v_weapon.M3_CHAMBER", rel = "", pos = Vector(-0.714, -3.685, 3.78), angle = Angle(-5.448, -11.035, -87.612), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.001, -0.086, 18.634), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.289, -0.069, 1.733), angle = Angle(0.92, -8.03, -89.096), size = Vector(0.016, 0.016, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.363, 0.51, 3.388), angle = Angle(1.327, -5.595, 2.295), size = Vector(0.025, 0.025, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props/de_nuke/electricalbox02.mdl"] = { type = "Model", model = "models/props/de_nuke/electricalbox02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.159, 0.157, -0.285), angle = Angle(-0.033, 10.359, -90.427), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.024, -0.077, 15.989), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/hunter/plates/plate025x025.mdl+1"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(1.041, -6.17, -3.353), angle = Angle(86.646, -9.657, 3.298), size = Vector(0.064, 0.2, 0.016), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/plates/plate025x025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.889, -0.359, 0.66), angle = Angle(91.139, 0.808, 4.164), size = Vector(0.342, 0.112, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/weapons/shotgun_shell.mdl"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseshell", pos = Vector(0.624, 0.046, -0.311), angle = Angle(2.194, -90.769, -5.113), size = Vector(0.349, 0.349, 0.349), color = Color(143, 115, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_lock01.mdl"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.054, -0.287, -10.285), angle = Angle(-0.801, 94.787, 179.207), size = Vector(0.1, 0.05, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.305, -0.525, 3.111), angle = Angle(0.087, -31.472, 2.058), size = Vector(0.023, 0.023, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.474, 0.428, -9.308), angle = Angle(-1.443, 180, -84.171), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/trains/wheel_medium.mdl"] = { type = "Model", model = "models/props_phx/trains/wheel_medium.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.009, 1.08, 18.695), angle = Angle(-0.835, -133.473, -2.011), size = Vector(0.024, 0.024, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "v_weapon.M3_PARENT", rel = "", pos = Vector(-0.138, -3.945, -2.651), angle = Angle(180, -8.539, -2.264), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/items/combine_rifle_ammo01.mdl"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseshell", pos = Vector(0.654, 1.184, -0.065), angle = Angle(2.796, -0.002, -89.95), size = Vector(0.079, 0.079, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.019, -0.083, 19.781), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.432, -0.083, -9), angle = Angle(-0.267, 179.947, 95.37), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x3d.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.076, 0.108, 0.071), angle = Angle(5.018, 48.337, 3.089), size = Vector(0.029, 0.039, 0.025), color = Color(59, 59, 59, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.015, -0.026, 21.125), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.02, -0.094, 18), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/tprotato1.mdl+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.053, -0.758, -3.977), angle = Angle(-0.788, 166.938, -2.704), size = Vector(0.009, 0.009, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_256_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_256_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.177, -0.847, 11.895), angle = Angle(1.228, -5.783, 1.968), size = Vector(0.029, 0.05, 0.07), color = Color(72, 72, 72, 255), surpresslightning = false, material = "phoenix_storms/white_brushes", skin = 0, bodygroup = {} },
		["models/props_combine/breenpod.mdl"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.12, 0.218, 22.333), angle = Angle(-171.277, 84.746, 1.906), size = Vector(0.029, 0.05, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1f+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.451, -0.475, -7.204), angle = Angle(0.92, -8.03, -89.096), size = Vector(0.01, 0.021, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.441, 0.472, -13.566), angle = Angle(2.484, -7.439, -92.05), size = Vector(0.039, 0.1, 0.111), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/items/combine_rifle_ammo01.mdl+"] = { type = "Model", model = "models/items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.011, 0.477, -11.919), angle = Angle(180, 9.534, -177.599), size = Vector(0.079, 0.079, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_256_001a.mdl+"] = { type = "Model", model = "models/props_pipes/pipeset02d_256_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.939, -0.463, -7.462), angle = Angle(3.492, -74.935, 0.569), size = Vector(0.019, 0.05, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "phoenix_storms/white_brushes", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.07, -0.091, 17.003), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basepump", pos = Vector(-0.325, 2.114, -0.593), angle = Angle(-4.153, -1.607, -87.439), size = Vector(0.059, 0.07, 0.156), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_fence01a", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.017, -0.062, 19.211), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["basepump"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0.321, 1.2, 11.045), angle = Angle(3.905, 13.982, 88.693), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/tprotato1.mdl"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.934, -0.56, -3.756), angle = Angle(-0.08, 0, 0), size = Vector(0.009, 0.009, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/Items/battery.mdl"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.407, -0.449, -2.74), angle = Angle(0.301, 82.302, -0.917), size = Vector(0.4, 0.25, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.024, -0.077, 16.569), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/hunter/misc/platehole1x1a.mdl"] = { type = "Model", model = "models/hunter/misc/platehole1x1a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.8, -0.599, 3.871), angle = Angle(90.684, 8.937, -3.666), size = Vector(0.05, 0.016, 0.071), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.02, -0.094, 18), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_elite_single.mdl"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.257, 4.443, -3.201), angle = Angle(90.94, -84.981, -12.79), size = Vector(0.796, 0.66, 0.79), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basegun"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.087, 0.595, -2.908), angle = Angle(-175.249, 92.142, 76.188), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.001, -0.086, 18.634), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.289, -0.069, 1.733), angle = Angle(0.92, -8.03, -89.096), size = Vector(0.016, 0.016, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.363, 0.51, 3.388), angle = Angle(1.327, -5.595, 2.295), size = Vector(0.025, 0.025, 0.323), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props/de_nuke/electricalbox02.mdl"] = { type = "Model", model = "models/props/de_nuke/electricalbox02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.159, 0.157, -0.285), angle = Angle(-0.033, 10.359, -90.427), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl+++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.024, -0.077, 15.989), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/hunter/plates/plate025x025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.889, -0.359, 0.66), angle = Angle(91.139, 0.808, 4.164), size = Vector(0.342, 0.112, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/trains/wheel_medium.mdl"] = { type = "Model", model = "models/props_phx/trains/wheel_medium.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.009, 1.08, 18.695), angle = Angle(-0.835, -133.473, -2.011), size = Vector(0.024, 0.024, 0.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.305, -0.525, 3.111), angle = Angle(0.087, -31.472, 2.058), size = Vector(0.025, 0.025, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/metal_combinebridge001", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1++"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.474, 0.428, -9.308), angle = Angle(-1.443, 180, -84.171), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-0.151, 0.075, 0.479), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1f+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.451, -0.475, -7.204), angle = Angle(0.92, -8.03, -89.096), size = Vector(0.01, 0.021, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/combine_lock01.mdl"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.054, -0.287, -10.285), angle = Angle(-0.801, 94.787, 179.207), size = Vector(0.1, 0.05, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x3d.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x3d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.076, 0.108, 0.071), angle = Angle(5.018, 48.337, 3.089), size = Vector(0.029, 0.039, 0.025), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.019, -0.083, 19.781), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.015, -0.026, 21.125), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.141), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/combine_mine01.mdl++++"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.03, -0.08, 17.472), angle = Angle(0, -5, 0), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_combine/tprotato1.mdl+"] = { type = "Model", model = "models/props_combine/tprotato1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.053, -0.758, -3.977), angle = Angle(-0.788, 166.938, -2.704), size = Vector(0.009, 0.009, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_256_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_256_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.177, -0.847, 11.895), angle = Angle(1.228, -5.783, 1.968), size = Vector(0.029, 0.05, 0.07), color = Color(72, 72, 72, 255), surpresslightning = false, material = "phoenix_storms/white_brushes", skin = 0, bodygroup = {} },
		["models/props_combine/combine_train02a.mdl+1+"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.432, -0.083, -9), angle = Angle(-0.267, 179.947, 95.37), size = Vector(0.009, 0.014, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_combine/breenpod.mdl"] = { type = "Model", model = "models/props_combine/breenpod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.12, 0.218, 22.333), angle = Angle(-171.277, 84.746, 1.906), size = Vector(0.029, 0.05, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.UseHands = true

SWEP.ReloadDelay = 0.45

SWEP.Primary.Sound = Sound("Weapon_M3.Single")
SWEP.Primary.Damage = 24
SWEP.Primary.NumShots = 9
SWEP.Primary.Delay = 0.8

SWEP.Primary.ClipSize = 21
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 4.5
SWEP.ConeMin = 3

SWEP.FireAnimSpeed = 0.9
SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 6
SWEP.MaxStock = 1

SWEP.DeploySound = ")weapons/m3/m3_pump.wav"

SWEP.EnableChargingAbility = true

SWEP.FullChargeText = "ПКМ: Импульсный Выстрел!"
SWEP.ChargeText = "Попадания"

SWEP.ChargeColor = Color(85, 170, 255)

SWEP.ChargeGain = 0.1

SWEP.TracerName = "AR2Tracer"

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.RequiredClip = 3

SWEP.LegDamage = 9

function SWEP.BulletCallback(attacker, tr, dmginfo)
	dmginfo:SetDamageType(DMG_DISSOLVE)
	local ent = tr.Entity
	local wep = attacker:GetActiveWeapon()
	if ent:IsValidLivingZombie() then
		ent:AddLegDamageExt(dmginfo:GetInflictor().LegDamage, attacker, attacker:GetActiveWeapon(), SLOWTYPE_PULSE)
		local damage = (dmginfo:GetDamage() * wep.ChargeGain)
		local intd = math.min(100 - damage, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))
		wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, intd + damage)
	end

	if IsFirstTimePredicted() then
		util.CreatePulseImpactEffect(tr.HitPos, tr.HitNormal)
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	local intd = wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON)

	if self:CanPrimaryAttack() and intd >= 100 then

		local rnda = 8 * -1 
		local rndb = 8 * math.random(-1, 1) 

		self.Owner:ViewPunch(Angle(rnda, rndb, rnda ))

		local damage = self.Primary.Damage * 1.6

		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		self:EmitSound("weapons/shotgun/shotgun_dbl_fire.wav", 100, math.random(70, 80), 0.95, CHAN_AUTO+20)
		self:EmitSound("weapons/stunstick/alyx_stunner2.wav", 72, 115, 0.65, CHAN_AUTO+21)
		self:EmitSound("weapons/gauss/fire1.wav", 72, 108, 0.65, 0.85, CHAN_AUTO+22)
		self:EmitSound("Weapon_M3.Single")

		self:ShootBulletsPiercing(damage, self.Primary.NumShots, self:GetCone() * 0.75)
		self:TakeAmmo()
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, 0)
	end
end

function SWEP:DoReload()
	if not self:CanReload() or self:GetOwner():KeyDown(IN_ATTACK) or not self:GetDTBool(2) and not self:GetOwner():KeyDown(IN_RELOAD) then
		self:StopReloading()
		return
	end

	local delay = self:GetReloadDelay()
	if self.ReloadActivity then
		self:SendWeaponAnim(self.ReloadActivity)
		self:ProcessReloadAnim()
	end

	self:EmitSound("items/battery_pickup.wav", 70, math.random(112, 120), 0.8, CHAN_WEAPON + 22)

	self:GetOwner():RemoveAmmo(3, self.Primary.Ammo, false)
	self:SetClip1(self:Clip1() + 3)

	self:SetDTBool(2, false)

	self:SetDTFloat(3, CurTime() + delay)

	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/stunstick/alyx_stunner2.wav", 75, 115, 0.65, CHAN_AUTO+20)
	self:EmitSound("Weapon_M3.Single")
end