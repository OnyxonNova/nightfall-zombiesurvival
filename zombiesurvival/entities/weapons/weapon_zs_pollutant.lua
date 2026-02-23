AddCSLuaFile()

SWEP.PrintName = "'Поллютант' Химический Пистолет"
SWEP.Description = "Запускает в зомби слабенькие химические снаряды."

SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "ValveBiped.square"
	SWEP.HUD3DPos = Vector(1.35, 0.25, -2)
	SWEP.HUD3DScale = 0.015

	SWEP.VMPos = Vector(0, -5.5, 2)

	SWEP.VElements = {
		["models/props_pipes/valve003.mdl"] = { type = "Model", model = "models/props_pipes/valve003.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(-0.06, -0.48, -0.875), angle = Angle(-179.211, 1.623, 0.902), size = Vector(0.178, 0.178, 0.178), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(-0.082, -2.368, 0.679), angle = Angle(0.644, 4.089, 89.015), size = Vector(0.013, 0.019, 0.1), color = Color(218, 218, 218, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
		["models/Gibs/HGIBS_spine.mdl"] = { type = "Model", model = "models/Gibs/HGIBS_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.149, 0.82, 1.917), angle = Angle(0.398, 3.226, -83.673), size = Vector(0.136, 0.136, 0.1), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_trainstation/trashcan_indoor001b.mdl"] = { type = "Model", model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0, -0.487, 9.779), angle = Angle(-0.574, 7.75, -0.172), size = Vector(0.059, 0.059, 0.059), color = Color(225, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.003, -0.445, -0.494), angle = Angle(-0.387, 0, 0), size = Vector(0.019, 0.019, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/items/battery.mdl+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(-0.101, 0.134, 6.269), angle = Angle(180, 0.133, 90.01), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/windows/window_curve360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/windows/window_curve360x2.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(0.116, 1.621, 0.653), angle = Angle(-4.659, 3.7, -90.143), size = Vector(0.012, 0.018, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/misc/iron_beam1.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(-0.125, 1.606, -0.875), angle = Angle(20.851, 90.464, 7.776), size = Vector(0.086, 0.111, 0.165), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/props_animated_breakable/smokestack/brickwall002a", skin = 0, bodygroup = {} },
		["models/props/de_train/barrel.mdl"] = { type = "Model", model = "models/props/de_train/barrel.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(0.068, 1.682, 0.759), angle = Angle(91.373, -85.995, -1.389), size = Vector(0.059, 0.029, 0.09), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/props/de_train/barrel0004", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(0.1, 2.329, 0.698), angle = Angle(0.644, 3.549, 89.015), size = Vector(0.014, 0.02, 0.442), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube2x2x025c.mdl"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.096, -0.355, 2.088), angle = Angle(-15.752, 95.678, 92.158), size = Vector(0.039, 0.039, 0.029), color = Color(242, 242, 242, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(-0.014, -0.475, -0.865), angle = Angle(-0.071, 4.368, 0.074), size = Vector(0.035, 0.035, 0.238), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/weapons/v_crossbow/rebar_glow", skin = 0, bodygroup = {} },
		["models/Items/combine_rifle_ammo01.mdl"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(-0.076, -1.922, 0.62), angle = Angle(-1.639, -0.852, -90.811), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipe01_connector01.mdl"] = { type = "Model", model = "models/props_pipes/pipe01_connector01.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.008, -0.466, -0.806), angle = Angle(92.13, 0, 0), size = Vector(0.298, 0.298, 0.298), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props/CS_militia/milceil001", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.697, 1.424, -2.474), angle = Angle(2.558, -91.425, -90.217), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/windows/window_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/windows/window_curve360x2.mdl", bone = "ValveBiped.clip", rel = "baseclip", pos = Vector(-0.08, -2.362, 0.675), angle = Angle(-4.147, 3.417, 90.267), size = Vector(0.012, 0.018, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/items/battery.mdl"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(-0.036, 0.115, 6.84), angle = Angle(180, 0.133, 90.01), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props/de_train/barrel.mdl+"] = { type = "Model", model = "models/props/de_train/barrel.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.143, 1.182, 4.815), angle = Angle(91.373, -85.995, -1.389), size = Vector(0.079, 0.05, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.007, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_64_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.727, -1.073, 1.042), angle = Angle(-90.057, -37.463, 5.632), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.007, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.014, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipecluster32d_003a.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster32d_003a.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.569, 0.027, 3.526), angle = Angle(174.785, -79.945, -91.431), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.parent", rel = "baseframe", pos = Vector(0.003, -0.445, 9.302), angle = Angle(-0.387, 0, 0), size = Vector(0.019, 0.019, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseclip"] = { type = "Model", model = "", bone = "ValveBiped.clip", rel = "", pos = Vector(0.101, 1.475, 4.328), angle = Angle(-3.678, -5.145, -7.186), size = Vector(0.5, 0.5, 1.016), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["models/props_pipes/valve003.mdl"] = { type = "Model", model = "models/props_pipes/valve003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.06, -0.48, -0.875), angle = Angle(-179.211, 1.623, 0.902), size = Vector(0.178, 0.178, 0.178), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/Gibs/HGIBS_spine.mdl"] = { type = "Model", model = "models/Gibs/HGIBS_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basetrigger", pos = Vector(5.375, 2.226, -2.629), angle = Angle(0.398, 3.226, 2.141), size = Vector(0.136, 0.136, 0.1), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_trainstation/trashcan_indoor001b.mdl"] = { type = "Model", model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0, -0.487, 9.779), angle = Angle(-0.574, 7.75, -0.172), size = Vector(0.059, 0.059, 0.059), color = Color(225, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.003, -0.445, -0.494), angle = Angle(-0.387, 0, 0), size = Vector(0.019, 0.019, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_plate_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.003, -0.445, 9.302), angle = Angle(-0.387, 0, 0), size = Vector(0.019, 0.019, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/windows/window_curve360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/windows/window_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "models/props_phx/construct/windows/window_curve360x2.mdl", pos = Vector(-0.005, -0.011, 1.743), angle = Angle(-0.003, -1.652, -0.165), size = Vector(0.012, 0.018, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube2x2x025c.mdl"] = { type = "Model", model = "models/hunter/tubes/tube2x2x025c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.096, -0.355, 2.088), angle = Angle(-15.752, 95.678, 92.158), size = Vector(0.039, 0.039, 0.029), color = Color(242, 242, 242, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["models/props/de_train/barrel.mdl"] = { type = "Model", model = "models/props/de_train/barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(0.068, 1.682, 0.759), angle = Angle(91.373, -85.995, -1.389), size = Vector(0.059, 0.029, 0.09), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/props/de_train/barrel0004", skin = 0, bodygroup = {} },
		["models/props_pipes/pipeset02d_64_001a.mdl"] = { type = "Model", model = "models/props_pipes/pipeset02d_64_001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.727, -1.073, 1.042), angle = Angle(-90.057, -37.463, 5.632), size = Vector(0.039, 0.039, 0.039), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.014, -0.475, -0.865), angle = Angle(-0.071, 4.368, 0.074), size = Vector(0.035, 0.035, 0.238), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/weapons/v_crossbow/rebar_glow", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(0.1, 2.329, 0.698), angle = Angle(0.644, 3.549, 89.015), size = Vector(0.014, 0.02, 0.442), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/items/battery.mdl+"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.101, 0.134, 6.269), angle = Angle(180, 0.133, 90.01), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.014, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.123), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.638, 1.034, -2.238), angle = Angle(-177.989, 82.421, 85.758), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseclip"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.347, 2.035, 0.345), angle = Angle(9.262, 85.775, -82.243), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/items/battery.mdl"] = { type = "Model", model = "models/items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.036, 0.115, 6.84), angle = Angle(180, 0.133, 90.01), size = Vector(0.14, 0.14, 0.14), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props/de_train/barrel.mdl+"] = { type = "Model", model = "models/props/de_train/barrel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.093, 1.534, 4.732), angle = Angle(91.373, -85.995, -1.389), size = Vector(0.079, 0.05, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.007, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipe01_connector01.mdl"] = { type = "Model", model = "models/props_pipes/pipe01_connector01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.008, -0.466, -0.806), angle = Angle(92.13, 0, 0), size = Vector(0.298, 0.298, 0.298), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props/CS_militia/milceil001", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_wire_angle360x2.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.007, -0.449, -0.84), angle = Angle(0, 0, 0), size = Vector(0.018, 0.018, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/misc/iron_beam1.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.084, 1.664, -0.88), angle = Angle(20.851, 90.464, 7.776), size = Vector(0.086, 0.111, 0.165), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/props_animated_breakable/smokestack/brickwall002a", skin = 0, bodygroup = {} },
		["models/props_pipes/pipecluster32d_003a.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster32d_003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.569, 0.027, 3.526), angle = Angle(174.785, -79.945, -91.431), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_c17/metalladder001", skin = 0, bodygroup = {} },
		["basetrigger"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.75, 4.802, 0.985), angle = Angle(-3.839, 61.46, -0.681), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/windows/window_curve360x2.mdl"] = { type = "Model", model = "models/props_phx/construct/windows/window_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(-0.049, -0.861, 0.676), angle = Angle(-4.147, 3.417, 90.267), size = Vector(0.012, 0.018, 0.018), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelBoneMods = {
  	  ["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.49099999666214, 6.8010001182556, 0.91799998283386), angle = Angle(0, 0, 0) }
	}
end

SWEP.Base = "weapon_zs_baseproj"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.UseHands = true

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.ReloadSound = Sound("Weapon_Pistol.Reload")
SWEP.Primary.Damage = 31
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.43

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "chemical"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 2.25
SWEP.ConeMin = 1.75

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.FireAnimSpeed = 0.25

SWEP.BulletSize = 30

SWEP.ReloadSpeed = 0.55

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.05)

local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Ожог' Напалмовый Пистолет", "Запускает в зомби слабенькие химические снаряды которые имеют шанс их поджечь.", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.9

	local col = Color(230, 150, 100)
	if SERVER then
		wept.EntModify = function(self, ent)
			ent:SetDTInt(5, 1)
		end
	else
		wept.VElements["models/hunter/tubes/tube1x1x1.mdl"].color = col
		wept.WElements["models/hunter/tubes/tube1x1x1.mdl"].color = col
		wept.VElements["models/props/de_train/barrel.mdl"].color = col
		wept.WElements["models/props/de_train/barrel.mdl"].color = col
	end
end)
branch.Colors = {[0]=Color(255, 185, 50), [1]=Color(255, 160, 50), [2]=Color(215, 120, 50), [3]=Color(175, 100, 40)}
branch.NewNames = {[0]="Ожог", [1]="Горячий", [2]="Обжигающий", [3]="Поджигание"}

branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Глазурь' Крио Пистолет", "Запускает в зомби слабенькие химические снаряды которые имеют шанс их замедлить.", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.85

	wept.LegDamage = 10
	local col = Color(0, 126, 255)
	if SERVER then
		wept.EntModify = function(self, ent)
			ent:SetDTInt(5, 2)
		end
	else
		wept.VElements["models/hunter/tubes/tube1x1x1.mdl"].color = col
		wept.WElements["models/hunter/tubes/tube1x1x1.mdl"].color = col
		wept.VElements["models/props/de_train/barrel.mdl"].color = col
		wept.WElements["models/props/de_train/barrel.mdl"].color = col
	end
end)
branch.Colors = {[0]=Color(85, 170, 255), [1]=Color(50, 160, 255), [2]=Color(50, 130, 215), [3]=Color(40, 115, 175)}
branch.NewNames = {[0]="Глазурь", [1]="Холодный", [2]="Арктический", [3]="Ледниковый"}

function SWEP:EmitFireSound()
	self:EmitSound("^weapons/mortar/mortar_fire1.wav", 70, math.random(110, 120), 0.65)
	self:EmitSound("npc/barnacle/barnacle_gulp2.wav", 70, 70, 0.85, CHAN_AUTO + 20)
end

function SWEP:SecondaryAttack()
end

if not SERVER then return end

SWEP.Primary.Projectile = "projectile_bioriflepollutant"
SWEP.Primary.ProjVelocity = 1600

function SWEP:PhysModify(physobj)
end