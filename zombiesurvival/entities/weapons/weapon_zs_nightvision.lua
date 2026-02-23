AddCSLuaFile()

SWEP.Base = "weapon_zs_basemelee"
SWEP.Slot = 5

SWEP.PrintName = "Прибор Ночного Видения"
SWEP.Description = "Позволяет видеть в темноте и снижает интенсивность нечеткого зрения."

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.UseHands = true

if CLIENT then
	SWEP.VElements = {
		["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, -2.597), angle = Angle(5.843, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.5, -2), angle = Angle(5, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_FAST

SWEP.IsMelee = false

SWEP.HoldType = "slam"
SWEP.SwingHoldType = "slam"

SWEP.NoDismantle = true
SWEP.NoDeploySpeedChange = true
SWEP.AutoSwitchFrom	= false

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + 1)

	local owner = self:GetOwner()

	if CLIENT and IsFirstTimePredicted() then
		surface.PlaySound(GAMEMODE.m_NightVision and "items/nvg_off.wav" or "items/nvg_on.wav")
		GAMEMODE.m_NightVision = not GAMEMODE.m_NightVision
		owner:DoAttackEvent()
	end
end

function SWEP:OnRemove()
	if CLIENT and self:GetOwner() == MySelf then
		if GAMEMODE.m_NightVision then
			self:EmitSound("items/nvg_off.wav")
			GAMEMODE.m_NightVision = false
		end
		self:Anim_OnRemove()
	end
end