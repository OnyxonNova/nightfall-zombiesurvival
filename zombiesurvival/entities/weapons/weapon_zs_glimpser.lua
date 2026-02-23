AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Проблеск' Винтовка"
SWEP.Description = "Стреляет пробивающими пулями, при достаточном нанесении урона по головам зомби ускоряет временно стрельбу и перезарядки."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 58

	SWEP.HUD3DBone = "v_weapon.m4_Parent"
	SWEP.HUD3DPos = Vector(-1.3, -4.2, -1.2)
	SWEP.HUD3DAng = Angle(0, -5, 0)
	SWEP.HUD3DScale = 0.015
	SWEP.ShowViewModel = false	
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["models/props_c17/oildrum001.mdl1"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.64, -0.015, -3.781), angle = Angle(26.768, 12.892, -5.874), size = Vector(0.009, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.051, 0.028, 12.192), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(0.064, -0.132, 0.888), angle = Angle(0, 0, 88.248), size = Vector(0.1, 0.202, 0.048), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/blocks/cube025x025x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.08, 1.44, 1.398), angle = Angle(-0.357, 0.423, -1.959), size = Vector(0.064, 0.141, 0.142), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.093, -1.272, 8.881), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.098, 0.086, -3.901), angle = Angle(0, 0, -2.425), size = Vector(0.035, 0.035, 0.064), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.098, -0.238, 2.552), angle = Angle(0, 0, -3), size = Vector(0.045, 0.056, 0.268), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_combine/combine_mine01.mdl"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.113, -0.908, 14.651), angle = Angle(0.34, -4.856, -1.382), size = Vector(0.029, 0.029, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.076, -0.801, -0.213), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.079, 0.037), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl1"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.718, -1.387, 13.434), angle = Angle(-1.941, 46.49, 88.064), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl1+"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.723, -1.27, 11.402), angle = Angle(-1.941, 46.49, 88.064), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl+++"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.529, -1.275, 11.312), angle = Angle(2.398, -46.882, 87.872), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseclip"] = { type = "Model", model = "", bone = "v_weapon.m4_Clip", rel = "", pos = Vector(-0.463, 2.841, 0.634), angle = Angle(1.847, -3.711, 5.622), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/maxofs2d/lamp_flashlight.mdl+"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.065, -1.884, -2.337), angle = Angle(-87.261, -86.973, 0.75), size = Vector(0.3, 0.15, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.686, -0.575, 8.567), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xeon133/slider/slider_12x12x12.mdl"] = { type = "Model", model = "models/xeon133/slider/slider_12x12x12.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.098, -0.119, -0.159), angle = Angle(0, 0, -1.693), size = Vector(0.05, 0.05, 0.127), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/maxofs2d/lamp_flashlight.mdl"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.058, -2.119, 0.931), angle = Angle(93.56, -86.973, 0.75), size = Vector(0.305, 0.15, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/construct/concrete_pipe01.mdl"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.057, -2.135, 1.189), angle = Angle(0.711, 1.292, -1.989), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2+++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.713, -0.796, 12.418), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.686, -0.579, 8.569), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/construct/concrete_pipe01.mdl+"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.008, -1.851, -3.276), angle = Angle(0.711, 1.292, -1.989), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl++"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.515, -1.39, 13.399), angle = Angle(2.398, -46.882, 87.872), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl1+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.654, -0.015, -3.83), angle = Angle(26.768, 12.892, -5.874), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basebolt"] = { type = "Model", model = "", bone = "v_weapon.m4_Parent", rel = "baseframe", pos = Vector(-0.04, -0.461, -3.539), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.049, 0.328, 5.342), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/gravestone003a.mdl"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.142, 0.211, -9.438), angle = Angle(91.081, -90.54, 1.236), size = Vector(1.35, 0.025, 0.019), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl1++"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.198, 0.361, -11.994), angle = Angle(-0.575, 2.766, -2.201), size = Vector(0.029, 0.029, 0.209), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basedust"] = { type = "Model", model = "", bone = "v_weapon.m4_Eject", rel = "", pos = Vector(-0.461, 1.358, -0.025), angle = Angle(164.57, -2.018, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_building_details/Storefront_Template001a_Bars.mdl"] = { type = "Model", model = "models/props_building_details/Storefront_Template001a_Bars.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basedust", pos = Vector(0.141, -1.422, -1.127), angle = Angle(18.538, -2.306, 178.574), size = Vector(0.009, 0.014, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/mechanics/articulating/arm_base_b.mdl"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.273, -1.144, 1.383), angle = Angle(0, 0, 87.311), size = Vector(0.021, 0.019, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(0.061, -0.027, -0.524), angle = Angle(0, -89.249, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_trainstation/Ceiling_Arch001a.mdl"] = { type = "Model", model = "models/props_trainstation/Ceiling_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.266, 1.705, -10.629), angle = Angle(0, 0, 180), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/triangles/2x2x2.mdl"] = { type = "Model", model = "models/hunter/triangles/2x2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.349, -0.029, -0.889), angle = Angle(0, -90, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam2.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.079, -1.463, 1.536), angle = Angle(180, 90, 0), size = Vector(0.009, 0.056, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_trainstation/Ceiling_Arch001a.mdl+"] = { type = "Model", model = "models/props_trainstation/Ceiling_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.457, 1.726, -10.65), angle = Angle(0, 0, 180), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.097, -1.453, 12.543), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.093, -1.244, 8.609), angle = Angle(87.157, 90, 0), size = Vector(0.254, 0.14, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.026, -1.836, -0.566), angle = Angle(-93.572, 90, 0), size = Vector(0.195, 0.048, 0.048), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.044, 0.128, 9.449), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/blocks/cube05x2x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube05x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.077, 0.409, -0.355), angle = Angle(177, 90, 90), size = Vector(0.108, 0.07, 0.061), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/w_pist_usp.mdl"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.137, 5.893, -2.615), angle = Angle(90, -90, 0), size = Vector(0.85, 0.801, 0.899), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(0.023, -3.143, -0.913), angle = Angle(0, 0, 86), size = Vector(0.085, 0.018, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing1.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.168, 1.23, -12.193), angle = Angle(0, 0, -1.956), size = Vector(0.012, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "v_weapon.m4_Parent", rel = "", pos = Vector(-0.047, -4.409, -2.31), angle = Angle(-176.777, -3.345, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.535, -0.491, 8.559), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.531, -0.244, 4.466), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(218, 218, 218, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.547, -0.696, 12.236), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/mechanics/articulating/arm_base_b.mdl+"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.277, -0.907, -3.112), angle = Angle(0, 0, 87.311), size = Vector(0.021, 0.019, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.076, -1.058, 4.788), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_pipes/pipecluster08d_extender64.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.128, -0.996, 17.103), angle = Angle(0, 0.725, -2.064), size = Vector(0.05, 0.05, 0.151), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xeon133/slider/slider_12x12x12.mdl+"] = { type = "Model", model = "models/xeon133/slider/slider_12x12x12.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.263, -0.106, -0.171), angle = Angle(-1.397, 90.032, 90), size = Vector(0.05, 0.119, 0.014), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl+"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.335, -0.014, -3.672), angle = Angle(2.813, -91.266, 21.743), size = Vector(0.009, 0.009, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam2.mdl+"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.08, -1.173, -2.961), angle = Angle(180, 90, 0), size = Vector(0.009, 0.056, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.666, -0.375, 4.489), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(182, 182, 182, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["models/props_c17/oildrum001.mdl1"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.64, -0.015, -3.781), angle = Angle(26.768, 12.892, -5.874), size = Vector(0.009, 0.009, 0.009), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.051, 0.028, 12.192), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/maxofs2d/lamp_flashlight.mdl+"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.065, -1.884, -2.337), angle = Angle(-87.261, -86.973, 0.75), size = Vector(0.3, 0.15, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/blocks/cube025x025x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube025x025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.08, 1.44, 1.398), angle = Angle(-0.357, 0.423, -1.959), size = Vector(0.064, 0.141, 0.142), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.666, -0.375, 4.489), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(182, 182, 182, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.098, 0.086, -3.901), angle = Angle(0, 0, -2.425), size = Vector(0.035, 0.035, 0.064), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.098, -0.238, 2.552), angle = Angle(0, 0, -3), size = Vector(0.045, 0.056, 0.268), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_combine/combine_mine01.mdl"] = { type = "Model", model = "models/props_combine/combine_mine01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.113, -0.908, 14.651), angle = Angle(0.34, -4.856, -1.382), size = Vector(0.029, 0.029, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.076, -0.801, -0.213), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.079, 0.037), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl1"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.718, -1.387, 13.434), angle = Angle(-1.941, 46.49, 88.064), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl+++"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.529, -1.275, 11.312), angle = Angle(2.398, -46.882, 87.872), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl1+"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.723, -1.27, 11.402), angle = Angle(-1.941, 46.49, 88.064), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.093, -1.244, 8.609), angle = Angle(87.157, 90, 0), size = Vector(0.254, 0.14, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseclip"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-0.013, 4.541, 2.16), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.547, -0.696, 12.236), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(0.064, -0.132, 0.888), angle = Angle(0, 0, 88.248), size = Vector(0.1, 0.202, 0.048), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xeon133/slider/slider_12x12x12.mdl"] = { type = "Model", model = "models/xeon133/slider/slider_12x12x12.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.098, -0.119, -0.159), angle = Angle(0, 0, -1.693), size = Vector(0.05, 0.05, 0.127), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/xeon133/slider/slider_12x12x12.mdl+"] = { type = "Model", model = "models/xeon133/slider/slider_12x12x12.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.263, -0.106, -0.171), angle = Angle(-1.397, 90.032, 90), size = Vector(0.05, 0.119, 0.014), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl++"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.515, -1.39, 13.399), angle = Angle(2.398, -46.882, 87.872), size = Vector(0.009, 0.009, 0.019), color = Color(0, 0, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2+++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.713, -0.796, 12.418), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.686, -0.579, 8.569), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/construct/concrete_pipe01.mdl+"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.008, -1.851, -3.276), angle = Angle(0.711, 1.292, -1.989), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basegun"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.552, 1.373, -2.75), angle = Angle(180, 89.394, 87.916), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl1+"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.654, -0.015, -3.83), angle = Angle(26.768, 12.892, -5.874), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebolt", pos = Vector(0.061, -0.027, -0.524), angle = Angle(0, -89.249, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.049, 0.328, 5.342), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/gravestone003a.mdl"] = { type = "Model", model = "models/props_c17/gravestone003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.142, 0.211, -9.438), angle = Angle(91.081, -90.54, 1.236), size = Vector(1.35, 0.025, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_c17/oildrum001.mdl1++"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.198, 0.361, -11.994), angle = Angle(-0.422, 2.766, -2.201), size = Vector(0.029, 0.029, 0.209), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/construct/concrete_pipe01.mdl"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.057, -2.135, 1.189), angle = Angle(0.711, 1.292, -1.989), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/mechanics/articulating/arm_base_b.mdl"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.273, -1.144, 1.383), angle = Angle(0, 0, 87.311), size = Vector(0.021, 0.019, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/triangles/2x2x2.mdl"] = { type = "Model", model = "models/hunter/triangles/2x2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.349, -0.029, -0.889), angle = Angle(0, -90, 0), size = Vector(0.009, 0.009, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing1.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.201, 2.487, -12.16), angle = Angle(0, 0, -1.956), size = Vector(0.012, 0.019, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_trainstation/Ceiling_Arch001a.mdl"] = { type = "Model", model = "models/props_trainstation/Ceiling_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.266, 1.705, -10.629), angle = Angle(0, 0, 180), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.531, -0.244, 4.466), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(218, 218, 218, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.097, -1.453, 12.543), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_trainstation/Ceiling_Arch001a.mdl+"] = { type = "Model", model = "models/props_trainstation/Ceiling_Arch001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.457, 1.726, -10.65), angle = Angle(0, 0, 180), size = Vector(0.019, 0.019, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++3+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.044, 0.128, 9.449), angle = Angle(0, 0, 87.238), size = Vector(0.129, 0.05, 0.039), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basedustprotector"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(-0.04, 0.246, -0.234), angle = Angle(-18.472, -5.862, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/blocks/cube05x2x025.mdl"] = { type = "Model", model = "models/hunter/blocks/cube05x2x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.077, 0.409, -0.355), angle = Angle(177, 90, 90), size = Vector(0.108, 0.07, 0.061), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_wasteland/light_spotlight01_lamp.mdl"] = { type = "Model", model = "models/props_wasteland/light_spotlight01_lamp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.026, -1.836, -0.566), angle = Angle(-93.572, 90, 0), size = Vector(0.195, 0.048, 0.048), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+++2++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.686, -0.575, 8.567), angle = Angle(3, -90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/weapons/w_pist_usp.mdl"] = { type = "Model", model = "models/weapons/w_pist_usp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.137, 5.893, -2.615), angle = Angle(90, -90, 0), size = Vector(0.85, 0.801, 0.899), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_lab/blastdoor001a.mdl"] = { type = "Model", model = "models/props_lab/blastdoor001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseclip", pos = Vector(0.023, -3.143, -0.913), angle = Angle(0, 0, 86), size = Vector(0.085, 0.018, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam2.mdl"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.079, -1.463, 1.536), angle = Angle(180, 90, 0), size = Vector(0.009, 0.056, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseframe"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0.115, -0.265, -0.113), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++++1+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.535, -0.491, 8.559), angle = Angle(-3, 90, 90), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basebolt"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basegun", pos = Vector(0.065, -0.759, -3.543), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_building_details/Storefront_Template001a_Bars.mdl"] = { type = "Model", model = "models/props_building_details/Storefront_Template001a_Bars.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basedustprotector", pos = Vector(0.507, -0.7, 0.082), angle = Angle(18.172, 7.026, 175.791), size = Vector(0.009, 0.014, 0.014), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/mechanics/articulating/arm_base_b.mdl+"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.277, -0.907, -3.112), angle = Angle(0, 0, 87.311), size = Vector(0.021, 0.019, 0.009), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl+"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.076, -1.058, 4.788), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_pipes/pipecluster08d_extender64.mdl"] = { type = "Model", model = "models/props_pipes/pipecluster08d_extender64.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.128, -0.996, 17.103), angle = Angle(0, 0.725, -2.064), size = Vector(0.05, 0.05, 0.151), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/gears/rack18.mdl++"] = { type = "Model", model = "models/props_phx/gears/rack18.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.093, -1.272, 8.881), angle = Angle(0, 0, -92.881), size = Vector(0.129, 0.05, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/misc/roundthing2.mdl+"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(0.335, -0.014, -3.672), angle = Angle(2.813, -91.266, 21.743), size = Vector(0.009, 0.009, 0.019), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam2.mdl+"] = { type = "Model", model = "models/props_phx/misc/iron_beam2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.08, -1.173, -2.961), angle = Angle(180, 90, 0), size = Vector(0.009, 0.056, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/maxofs2d/lamp_flashlight.mdl"] = { type = "Model", model = "models/maxofs2d/lamp_flashlight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseframe", pos = Vector(-0.058, -2.119, 0.931), angle = Angle(93.56, -86.973, 0.75), size = Vector(0.305, 0.15, 0.15), color = Color(72, 72, 72, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.3, -0.2), angle = Angle(0, 0, 0) }
}

end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.UseHands = true

SWEP.ReloadSpeed = 1
SWEP.Primary.Sound = Sound("weapons/zs_glimpser/glimpser.ogg") 
SWEP.Primary.Damage = 50
SWEP.Primary.NumShots = 3
SWEP.Primary.Delay = 0.4

SWEP.Primary.ClipSize = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 2
SWEP.ConeMin = 0.5

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 6
SWEP.MaxStock = 1

SWEP.HeadshotMulti = 1.5

SWEP.Pierces = 2

SWEP.EnableChargingAbility = true

SWEP.FullChargeText = "ЛКМ: Быстрый Выстрел!"
SWEP.ChargeText = "Хедшоты"

SWEP.ChargeColor = COLOR_GRAY

SWEP.ChargeGain = 0.1

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.2, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.15, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_BULLET_PIERCES, 1)
--[[
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Затмение' Винтовка", "Here be dragons", function(wept)
end)
]]

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
	local tr = owner:CompensatedPenetratingMeleeTrace(4092, 0.01, start, dir)
	local ent

	local dmgf = function(i) return dmg * (1 - 0.1 * i) end

	owner:LagCompensation(true)
	for i, trace in ipairs(tr) do
		if not trace.Hit then continue end
		if i > self.Pierces - 1 then break end

		ent = trace.Entity

		if ent and ent:IsValid() then
			owner:FireBulletsLua(trace.HitPos, dir, 0, numbul, dmgf(i-1), nil, self.Primary.KnockbackScale, "", self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)
		end
	end
	owner:FireBulletsLua(start, dir, cone, numbul, 0, nil, self.Primary.KnockbackScale, self.TracerName, self.BulletCallback, self.Primary.HullSize, nil, self.Primary.MaxDistance, nil, self)
	owner:LagCompensation(false)
end

function SWEP:GetFireDelay()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	return self.Primary.Delay / (owner:GetStatus("frost") and 0.7 or 1) * (wep.AbilityActive and 0.75 or 1)
end

function SWEP:GetReloadSpeedMultiplier()
	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()
	local primstring = self:GetPrimaryAmmoTypeString()
	local reloadspecmulti = primstring and "ReloadSpeedMultiplier" .. string.upper(primstring) or nil

	local extramulti = 1
	if owner:IsSkillActive(SKILL_SUPASM) and (self.Tier or 1) <= 2 and not self.PrimaryRemantleModifier and self.QualityTier then
		extramulti = GAMEMODE.WeaponQualities[self.QualityTier][2]
	end

	return self:GetOwner():GetTotalAdditiveModifier("ReloadSpeedMultiplier", reloadspecmulti) * (owner:GetStatus("frost") and 0.7 or 1) * extramulti / (wep.AbilityActive and 0.85 or 1)
end

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	local wep = attacker:GetActiveWeapon()
	if tr.HitGroup == HITGROUP_HEAD and not wep.AbilityActive then
		if ent:IsValidZombie() and wep.EnableChargingAbility then
			local damage = (dmginfo:GetDamage() * wep.ChargeGain)
			local intd = math.min(100 - damage, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))
			if not wep.AbilityActive then
				wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, intd + damage)
			end
		end
	end
end

local nexttime = 0
function SWEP:Think()
	self.BaseClass.Think(self)

	local time = CurTime()

	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()

	local intd = math.min(100, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))

	if wep.AbilityActive and time >= nexttime then
		nexttime = time + 0.2
		wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, math.max(0, intd - 0.175))
	end

	if intd >= 100 then
		wep.AbilityActive = true
	elseif intd <= 0 then
		wep.AbilityActive = false
	end
end

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

	function SWEP:GetViewModelPosition(pos, ang)
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return BaseClass.GetViewModelPosition(self, pos, ang)
	end

	function SWEP:DrawHUDBackground()
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			self:DrawRegularScope()
		end
	end
end