AddCSLuaFile()

SWEP.PrintName = "'Благодеятель' Мед. Винтовка"
SWEP.Description = "Гибрид штурмовой и мед. винтовки, умеет стрелять лечащими дротиками на ПКМ так и обычными пулями на ЛКМ"

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55

	SWEP.VMPos = Vector(1, -1, 1.5)

	SWEP.HUD3DBone = "v_weapon.aug_Parent"
	SWEP.HUD3DPos = Vector(-1.1, -3.5, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015

	SWEP.VElements = {
		["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(-1.867, -3.633, 10.871), angle = Angle(6.238, 81.82, 77.425), size = Vector(0.159, 0.2, 0.05), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tubebend1x1x90.mdl+"] = { type = "Model", model = "models/hunter/tubes/tubebend1x1x90.mdl", bone = "v_weapon.aug_Bolt", rel = "baseframe", pos = Vector(2.951, -6.336, -8.78), angle = Angle(7.287, 79.696, 69.268), size = Vector(0.016, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(3.565, -4.759, -10.881), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl+++"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(-0.117, -6.59, 4.927), angle = Angle(-168.269, -8.801, -93.769), size = Vector(0.014, 0.019, 0.019), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_angle360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(-0.072, -7.867, 5.504), angle = Angle(11.085, -6.052, 2.447), size = Vector(0.014, 0.014, 0.014), color = Color(25, 255, 0, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.282, -4.789, -9.964), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(3.391, -4.75, -10.216), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.609, -4.911, -11.094), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseclip"] = { type = "Model", model = "", bone = "v_weapon.aug_Clip", rel = "", pos = Vector(-0.817, -0.167, 0.064), angle = Angle(-6.098, 7.787, -1.841), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basebolt"] = { type = "Model", model = "", bone = "v_weapon.aug_Bolt", rel = "", pos = Vector(-2.184, -0.766, 0.166), angle = Angle(6.556, -5.782, 0), size = Vector(0.5, 0.5, 0.326), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl++"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.141, -6.746, -5.475), angle = Angle(11.928, -9.011, -84.838), size = Vector(0.014, 0.01, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'++"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.333, -3.484, 1.33), angle = Angle(11.734, -8.863, -79.516), size = Vector(0.029, 0.209, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/airboatgun.mdl"] = { type = "Model", model = "models/airboatgun.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.622, -3.047, -9.924), angle = Angle(-100.798, -154.112, -56.862), size = Vector(0.142, 0.142, 0.142), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_c17/gravestone001a.mdl"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.702, -5.466, -2.398), angle = Angle(12.078, -8.395, 3.786), size = Vector(0.039, 0.039, 0.1), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.833, -4.526, -0.211), angle = Angle(11.913, -8.863, -85.592), size = Vector(0.029, 0.239, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tubebend1x1x90.mdl"] = { type = "Model", model = "models/hunter/tubes/tubebend1x1x90.mdl", bone = "v_weapon.aug_Bolt", rel = "baseframe", pos = Vector(2.407, -6.452, -8.664), angle = Angle(7.323, 61.949, -173.734), size = Vector(0.014, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_angle360.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.447, -8.282, -5.691), angle = Angle(10.645, -6.205, 2.789), size = Vector(0.009, 0.009, 0.009), color = Color(25, 255, 0, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_p228.mdl"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(-0.571, 0.873, 1.11), angle = Angle(-76.911, 18.059, -63.132), size = Vector(0.8, 0.689, 0.679), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/maxofs2d/lamp_flashlight.mdl"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.202, -7.896, 4.169), angle = Angle(101.271, 5.729, 0.773), size = Vector(0.158, 0.15, 0.15), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.674, -2.429, -11.164), angle = Angle(11.041, 81.365, -11.098), size = Vector(0.321, 0.321, 0.321), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube1x5x025.mdl+"] = { type = "Model", model = "models/hunter/blocks/cube1x5x025.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.847, -7.849, 1.351), angle = Angle(12.159, -8.815, -85.955), size = Vector(0.029, 0.025, 0.125), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(3.286, -4.573, -9.506), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/phxtended/bar1x.mdl+"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "v_weapon.aug_Clip", rel = "baseframe", pos = Vector(0.259, 0.18, -3.251), angle = Angle(12.086, -8.688, 93.602), size = Vector(0.143, 0.105, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.424, -4.828, -10.549), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_c17/gravestone003a.mdl"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(1.195, -8.249, 0.148), angle = Angle(102.547, 6.692, -104.029), size = Vector(2, 0.039, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1d.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.395, -6.317, -8.631), angle = Angle(-4.553, -99.206, 11.774), size = Vector(0.019, 0.009, 0.421), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(1.833, -8.134, -3.984), angle = Angle(-77.306, 9.34, -6.658), size = Vector(0.2, 0.059, 0.059), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(3.042, -6.615, -9.865), angle = Angle(11.928, -9.011, -84.838), size = Vector(0.017, 0.029, 0.009), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1d.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(-1.297, -5.364, 10.987), angle = Angle(-4.349, -98.69, -167.971), size = Vector(0.019, 0.009, 0.421), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "v_weapon.aug_Clip", rel = "baseclip", pos = Vector(1.205, -2.526, 0.523), angle = Angle(2.308, -10.721, 100.164), size = Vector(0.085, 0.034, 0.057), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/trapezium3x3x1c.mdl"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(1.894, -8.044, -3.32), angle = Angle(102.694, 7.151, -105.722), size = Vector(0.039, 0.029, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "v_weapon.aug_Parent", rel = "", pos = Vector(0.206, 0.209, -0.376), angle = Angle(-15.082, 5.842, -0.718), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_c17/gravestone001a.mdl+"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.964, -6.29, -2.738), angle = Angle(32.484, -15.115, 7.565), size = Vector(0.1, 0.019, 0.009), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'+"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.643, -5.586, 1.235), angle = Angle(11.913, -8.863, -85.592), size = Vector(0.019, 0.209, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_c17/TrapPropeller_Lever.mdl"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "v_weapon.aug_Bolt", rel = "basebolt", pos = Vector(-0.047, -0.258, -3.829), angle = Angle(3.062, 100.736, 7.881), size = Vector(0.272, 0.136, 0.277), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(3.154, -4.454, -9.02), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.118, -4.772, -9.282), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipecluster08d_extender64.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(2.789, -5.795, -9.172), angle = Angle(12.602, -9.287, 3.697), size = Vector(0.1, 0.1, 0.3), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/phxtended/bar1x.mdl"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "v_weapon.aug_Clip", rel = "baseframe", pos = Vector(0.231, 0.409, -3.464), angle = Angle(10.369, -9.143, -7.297), size = Vector(0.143, 0.089, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_p228.mdl+"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.911, 1.769, -6.368), angle = Angle(-76.911, 18.059, -63.132), size = Vector(0.679, 0.679, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl+"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(0.439, -6.436, 2.217), angle = Angle(-167.881, -9.738, -86.033), size = Vector(0.014, 0.017, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube1x5x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube1x5x025.mdl", bone = "v_weapon.aug_Parent", rel = "baseframe", pos = Vector(1.116, -6.891, -0.616), angle = Angle(12.159, -9.171, -86.133), size = Vector(0.029, 0.039, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["models/props_vehicles/carparts_wheel01a.mdl"] = { type = "Model", model = "models/props_vehicles/carparts_wheel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-1.867, -3.633, 10.871), angle = Angle(6.238, 81.82, 77.425), size = Vector(0.159, 0.2, 0.05), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tubebend1x1x90.mdl+"] = { type = "Model", model = "models/hunter/tubes/tubebend1x1x90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.951, -6.336, -8.78), angle = Angle(7.287, 79.696, 69.268), size = Vector(0.016, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(3.565, -4.759, -10.881), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl+++"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.117, -6.59, 4.927), angle = Angle(-168.269, -8.801, -93.769), size = Vector(0.014, 0.019, 0.019), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tubebend1x1x90.mdl"] = { type = "Model", model = "models/hunter/tubes/tubebend1x1x90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.407, -6.452, -8.664), angle = Angle(7.323, 61.949, -173.734), size = Vector(0.014, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.282, -4.789, -9.964), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(3.391, -4.75, -10.216), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.609, -4.911, -11.094), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_angle360.mdl+"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.447, -8.282, -5.691), angle = Angle(10.645, -6.205, 2.789), size = Vector(0.009, 0.009, 0.009), color = Color(25, 255, 0, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["basebolt"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0.816, -4.394, -2.655), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(3.042, -6.615, -9.865), angle = Angle(11.928, -9.011, -84.838), size = Vector(0.017, 0.029, 0.009), color = Color(0, 127, 31, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["basegun"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.513, 0.694, -0.9), angle = Angle(-169.405, -99.478, 93.426), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'++"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.333, -3.484, 1.33), angle = Angle(11.734, -8.863, -79.516), size = Vector(0.029, 0.209, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/airboatgun.mdl"] = { type = "Model", model = "models/airboatgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.622, -3.047, -9.924), angle = Angle(-100.798, -154.112, -56.862), size = Vector(0.142, 0.142, 0.142), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/trapezium3x3x1c.mdl"] = { type = "Model", model = "models/hunter/triangles/trapezium3x3x1c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.894, -8.044, -3.32), angle = Angle(102.694, 7.151, -105.722), size = Vector(0.039, 0.029, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(3.286, -4.573, -9.506), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_c17/gravestone003a.mdl"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.195, -8.249, 0.148), angle = Angle(102.547, 6.692, -104.029), size = Vector(2, 0.039, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_p228.mdl"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.571, 0.873, 1.11), angle = Angle(-76.911, 18.059, -63.132), size = Vector(0.8, 0.689, 0.679), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/maxofs2d/lamp_flashlight.mdl"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.202, -7.896, 4.169), angle = Angle(101.271, 5.729, 0.773), size = Vector(0.15, 0.15, 0.15), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_phx/construct/metal_angle360.mdl"] = { type = "Model", model = "models/props_phx/construct/metal_angle360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.026, -7.875, 5.419), angle = Angle(11.085, -6.052, 2.447), size = Vector(0.014, 0.014, 0.014), color = Color(25, 255, 0, 255), surpresslightning = false, material = "models/props_combine/combine_interface_disp", skin = 0, bodygroup = {} },
		["models/phxtended/bar1x.mdl"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.231, 0.409, -3.464), angle = Angle(10.369, -9.143, -7.297), size = Vector(0.143, 0.089, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube1x5x025.mdl+"] = { type = "Model", model = "models/hunter/blocks/cube1x5x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.847, -7.849, 1.351), angle = Angle(12.159, -8.815, -85.955), size = Vector(0.029, 0.025, 0.125), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/phxtended/bar1x.mdl+"] = { type = "Model", model = "models/phxtended/bar1x.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.259, 0.18, -3.251), angle = Angle(12.086, -8.688, 93.602), size = Vector(0.143, 0.105, 0.09), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.424, -4.828, -10.549), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube1x5x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube1x5x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.116, -6.891, -0.616), angle = Angle(12.159, -9.171, -86.133), size = Vector(0.029, 0.039, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1d.mdl"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.395, -6.317, -8.631), angle = Angle(-4.553, -99.206, 11.774), size = Vector(0.019, 0.009, 0.421), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.833, -8.134, -3.984), angle = Angle(-77.306, 9.34, -6.658), size = Vector(0.2, 0.059, 0.059), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl+++++++"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(3.154, -4.454, -9.02), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/tube1x1x1d.mdl+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x1d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-1.297, -5.364, 10.987), angle = Angle(-4.349, -98.69, -167.971), size = Vector(0.019, 0.009, 0.421), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(-0.009, -1.973, 0.838), angle = Angle(8.3, -7.541, 103.738), size = Vector(0.085, 0.034, 0.057), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl++"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.141, -6.746, -5.475), angle = Angle(11.928, -9.011, -84.838), size = Vector(0.014, 0.01, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-0.022, 0.133, -0.197), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.833, -4.526, -0.211), angle = Angle(11.913, -8.863, -85.592), size = Vector(0.029, 0.239, 0.059), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/blocks/cube075x2x1.mdl'+"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.643, -5.586, 1.235), angle = Angle(11.913, -8.863, -85.592), size = Vector(0.019, 0.209, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_c17/TrapPropeller_Lever.mdl"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(0.065, -0.81, -3.198), angle = Angle(3.062, 89.086, -7.262), size = Vector(0.451, 0.085, 0.4), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.674, -2.429, -11.164), angle = Angle(11.041, 81.365, -11.098), size = Vector(0.321, 0.321, 0.321), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_lab/labpart.mdl"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.118, -4.772, -9.282), angle = Angle(-7.712, 174.518, -4.012), size = Vector(0.082, 0.159, 0.082), color = Color(4, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/props_pipes/pipecluster08d_extender64.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(2.789, -5.795, -9.172), angle = Angle(13.248, -9.287, 3.697), size = Vector(0.1, 0.1, 0.3), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["baseclip"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-1.247, -1.134, 6.256), angle = Angle(4.495, -2.006, 2.693), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/weapons/w_pist_p228.mdl+"] = { type = "Model", model = "models/weapons/w_pist_p228.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(1.519, 1.001, -7.737), angle = Angle(-76.911, 18.059, -63.132), size = Vector(0.679, 0.679, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/2x1x1.mdl+"] = { type = "Model", model = "models/hunter/triangles/2x1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.439, -6.436, 2.217), angle = Angle(-167.881, -9.738, -86.033), size = Vector(0.014, 0.017, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_c17/gravestone001a.mdl"] = { type = "Model", model = "models/props_c17/gravestone001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.702, -5.466, -2.398), angle = Angle(12.078, -8.395, 3.786), size = Vector(0.039, 0.039, 0.1), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemedicalweapon"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.Primary.Sound = Sound("") 
SWEP.Primary.Damage = 22.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.112

SWEP.Primary.ClipSize = 32
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Secondary.ClipSize = 30
SWEP.Secondary.DefaultClip = 30
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "Battery"
SWEP.Secondary.Automatic = true
SWEP.Secondary.RequiredClip = 3
SWEP.Secondary.Delay = 0.43

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ConeMax = 4	
SWEP.ConeMin = 1

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 3

SWEP.Heal = 15

SWEP.Primary.Projectile = "projectile_healdartsavior"
SWEP.Primary.ProjVelocity = 2200

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 3)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_SECONDARY_CLIP_SIZE, 5)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEALING, 1.2)

function SWEP:EmitFireSound()
	self:EmitSound("weapons/sg552/sg552-1.wav", 72, 100, 0.6, CHAN_AUTO + 20)
	self:EmitSound("weapons/zs_scar/scar_fire1.ogg", 70, 100, 0.45)
end

function SWEP:EmitFireSoundSecond()
	self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 70, math.random(137, 143), 0.85)
	self:EmitSound("weapons/ar2/fire1.wav", 70, math.random(105, 115), 0.85, CHAN_WEAPON + 20)
	self:EmitSound("items/smallmedkit1.wav", 70, math.random(165, 170), 0.65, CHAN_WEAPON + 21)
end

if not CLIENT then return end

local colBG = Color(16, 16, 16, 90)

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 144
	local clip = self:Clip2()
	local spare = self:GetOwner():GetAmmoCount(self:GetSecondaryAmmoType())
	local maxclip = self.Secondary.ClipSize

	local dclip, dspare, dmaxclip = self:GetDisplayAmmo(clip, spare, maxclip)

	draw.RoundedBox(16, x, y, wid, hei, colBG)

	local displayspare = dmaxclip > 0 and self.Secondary.DefaultClip ~= 99999
	if displayspare then
		draw.SimpleTextBlurry(dspare, dspare >= 1000 and "ZSHUDFontSmall" or "ZSHUDFont", x + wid * 0.75, y + hei * 0.5, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	draw.SimpleTextBlurry(dclip, dclip >= 100 and "ZSHUDFont" or "ZSHUDFontBig", x + wid * (displayspare and 0.25 or 0.5), y + hei * 0.5, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	self.BaseClass.Draw2DHUD(self)
end

function SWEP:Draw3DHUD(vm, pos, ang)
	local wid, hei = 180, 200
	local x, y = wid * -0.6, hei * -1.6
	local clip = self:Clip2()
	local spare = self:GetOwner():GetAmmoCount(self:GetSecondaryAmmoType())
	local maxclip = self.Secondary.ClipSize

	local dclip, dspare, dmaxclip = self:GetDisplayAmmo(clip, spare, maxclip)

	cam.Start3D2D(pos, ang, self.HUD3DScale / 2)
		draw.RoundedBoxEx(32, x, y, wid, hei, colBG, true, false, true, false)

		local displayspare = dmaxclip > 0 and self.Secondary.DefaultClip ~= 99999
		if displayspare then
			draw.SimpleTextBlurry(dspare, dspare >= 1000 and "ZS3D2DFontSmall" or "ZS3D2DFont", x + wid * 0.5, y + hei * 0.75, COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		draw.SimpleTextBlurry(dclip, dclip >= 100 and "ZS3D2DFont" or "ZS3D2DFontBig", x + wid * 0.5, y + hei * (displayspare and 0.3 or 0.5), COLOR_GREEN, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()

	self.BaseClass.Draw3DHUD(self,vm, pos, ang)
end