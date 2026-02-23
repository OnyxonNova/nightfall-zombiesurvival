AddCSLuaFile()

SWEP.Base = "weapon_zs_basemelee"

SWEP.PrintName = "Шприц с Адреналином"
SWEP.Description = "При использовании повышает на короткий промежуток времени скорость.\nТак же восстанавливает кровавую броню и даёт регенерацию здоровья"

SWEP.Slot = 4
SWEP.SlotPos = 0

if CLIENT then
	SWEP.VElements = {
		["models/hunter/tubes/circle2x2.mdl++1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "body", rel = "basebutton", pos = Vector(-0.47, 2.072, -0.288), angle = Angle(11.512, -11.731, 89.279), size = Vector(0.013, 0.013, 0.218), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "body", rel = "basebody", pos = Vector(-0.359, 1.667, -0.345), angle = Angle(8.314, -11.629, 90.573), size = Vector(0.017, 0.017, 0.3), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "v_weapon.Knife_Handle", rel = "basebody", pos = Vector(-0.456, 2.016, -0.329), angle = Angle(85.612, 166.705, 91.625), size = Vector(0.5, 0.5, 0.711), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "body", rel = "basebody", pos = Vector(0.847, -4.437, -0.353), angle = Angle(7.021, -9.087, 91.661), size = Vector(0.014, 0.014, 0.479), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basebody"] = { type = "Model", model = "", bone = "body", rel = "basesyringe1", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "body", rel = "basebody", pos = Vector(0.879, -4.976, -0.348), angle = Angle(7.92, -10.353, 89.958), size = Vector(0.009, 0.009, 0.188), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/mechanics/roboticslarge/xfoot.mdl"] = { type = "Model", model = "models/mechanics/roboticslarge/xfoot.mdl", bone = "v_weapon.Knife_Handle", rel = "basebody", pos = Vector(-0.729, 3.551, -0.341), angle = Angle(-100.118, -11.221, -90.876), size = Vector(0.013, 0.013, 0.013), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_wasteland/prison_lamp001a.mdl"] = { type = "Model", model = "models/props_wasteland/prison_lamp001a.mdl", bone = "v_weapon.Knife_Handle", rel = "basebody", pos = Vector(1.097, -6.027, -0.295), angle = Angle(-89.568, 50.481, -29.967), size = Vector(0.039, 0.039, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/mechanics/robotics/a1.mdl"] = { type = "Model", model = "models/mechanics/robotics/a1.mdl", bone = "v_weapon.Knife_Handle", rel = "basebody", pos = Vector(-0.475, 2.273, -0.324), angle = Angle(0.689, 78.573, 29.954), size = Vector(0.13, 0.029, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basesyringe1"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.709, 1.868, -1.517), angle = Angle(8.734, -64.344, 97.033), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basebutton"] = { type = "Model", model = "", bone = "button", rel = "basesyringe1", pos = Vector(0.052, -0.144, -0.075), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["models/hunter/tubes/circle2x2.mdl++1"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebutton", pos = Vector(-0.47, 2.072, -0.288), angle = Angle(11.512, -11.731, 89.279), size = Vector(0.013, 0.013, 0.218), color = Color(36, 36, 36, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(-0.359, 1.667, -0.345), angle = Angle(8.314, -11.629, 90.573), size = Vector(0.017, 0.017, 0.3), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/healthvial.mdl"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(-0.456, 2.016, -0.329), angle = Angle(85.612, 166.705, 91.625), size = Vector(0.5, 0.5, 0.711), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl+"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(0.847, -4.437, -0.353), angle = Angle(7.021, -9.087, 91.661), size = Vector(0.014, 0.014, 0.479), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basebody"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basesyringe1", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/tubes/circle2x2.mdl++"] = { type = "Model", model = "models/hunter/tubes/circle2x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(0.879, -4.976, -0.348), angle = Angle(7.92, -10.353, 89.958), size = Vector(0.009, 0.009, 0.188), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/mechanics/roboticslarge/xfoot.mdl"] = { type = "Model", model = "models/mechanics/roboticslarge/xfoot.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(-0.729, 3.551, -0.341), angle = Angle(-100.118, -11.221, -90.876), size = Vector(0.013, 0.013, 0.013), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_wasteland/prison_lamp001a.mdl"] = { type = "Model", model = "models/props_wasteland/prison_lamp001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(1.097, -6.027, -0.295), angle = Angle(-89.568, 50.481, -29.967), size = Vector(0.039, 0.039, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/mechanics/robotics/a1.mdl"] = { type = "Model", model = "models/mechanics/robotics/a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basebody", pos = Vector(-0.475, 2.273, -0.324), angle = Angle(0.689, 78.573, 29.954), size = Vector(0.13, 0.029, 0.029), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["basesyringe1"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.723, 1.378, -1.66), angle = Angle(-4.454, 120.292, 73.623), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basebutton"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basesyringe1", pos = Vector(0.052, -0.144, -0.075), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.ViewModelBoneMods = {
    	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.9769999980927, 0.27500000596046, -2.2139999866486) },
   		["ValveBiped.Bip01_R_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.798999786377, 25.440000534058, -25.051000595093) },
    	["ValveBiped.Bip01_R_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 44.977001190186, 0) },
    	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.1789999008179, -33.581001281738, 13.072999954224) },
    	["ValveBiped.Bip01_R_Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -28.618999481201, 0) },
    	["ValveBiped.Bip01_R_Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -51.848999023438, 0) },
    	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.2460000514984, -50.087001800537, -3.2449998855591) },
    	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -12.03600025177, 0) },
    	["ValveBiped.Bip01_R_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -62.381000518799, 0) },
    	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.548999786377, -55.595001220703, -9.0260000228882) },
		["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.00100004673, -1.9919999837875, -10.220000267029) },
    	["ValveBiped.Bip01_R_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -36.632999420166, 0) },
    	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(8.7220001220703, -42.65299987793, -43.266998291016) },
    	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.78200000524521, -4.2150001525879, 33.423999786377) },
    	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(15.265999794006, -16.333999633789, -6.9130001068115) }
	}

    SWEP.VMPos = Vector(-2, -4, 0)
    SWEP.VMAng = Vector(0, 0, -22)
end

SWEP.ViewModel = "models/weapons/v_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_eq_smokegrenade.mdl"
SWEP.UseHands = true

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.HoldType = "slam"
SWEP.SwingHoldType = "slam"

SWEP.SwingTime = 1

SWEP.SwingRotation = Angle(-30, 20, 25)
SWEP.SwingOffset = Vector(-24, -25, -30)

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.MaxStock = 8

AccessorFuncDT(SWEP, "ShotEndTime", "Float", 0)
AccessorFuncDT(SWEP, "ShotStartTime", "Float", 1)

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	if self:GetShotEndTime() == 0 then
		self:SetShotStartTime(CurTime())
		self:SetShotEndTime(CurTime() + self.SwingTime)
		owner:DoAttackEvent()
	end
end

function SWEP:Think()
	if self:GetShotEndTime() > 0 then
		local owner = self:GetOwner()
		local time = CurTime()

		if time >= self:GetShotEndTime() then
			self:SetShotEndTime(0)
			self:UseAdrenaline()
			return
		end

		local owner = self:GetOwner()
		if not owner:IsValid() then return end
	end
end

function SWEP:UseAdrenaline()
	local owner = self:GetOwner()

	local boost = owner:GiveStatus("adrenaline", 10)
	if boost and boost:IsValid() then
		boost:SetSpeed(40)
	end

	owner:EmitSound("items/suitchargeok1.wav", nil, math.random(121, 124), 0.75, CHAN_STATIC)
	owner:EmitSound("items/smallmedkit1.wav", nil, math.random(53, 55), nil, CHAN_STATIC + 1)

	if not SERVER then return end

	owner:SetBloodArmor(math.min(owner:GetMaxBloodArmor(), owner:GetBloodArmor() + 25))

	local sta = owner:GiveStatus("regeneration")
	sta:AddRegeneration(20)

	owner:StripWeapon(self:GetClass())
end

function SWEP:Holster()
	self:SetShotStartTime(0)
	self:SetShotEndTime(0)

	return true
end