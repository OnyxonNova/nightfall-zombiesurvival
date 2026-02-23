AddCSLuaFile()

SWEP.Base = "weapon_zs_basemelee"
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Магнит"
SWEP.Slot = 5

SWEP.Description = "Притягивает к себе предметы при взятии в руку."

SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.UseHands = true

if CLIENT then
	SWEP.VElements = {
		["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.299, 2.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
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

SWEP.IsMagnet = true

SWEP.WalkSpeed = SPEED_FAST

SWEP.IsMelee = false

SWEP.HoldType = "slam"

SWEP.NoDeploySpeedChange = true
SWEP.AllowQualityWeapons = true

SWEP.MagnetStrength = 1

SWEP.Radius = 400 * SWEP.MagnetStrength
SWEP.Force = 50 * SWEP.MagnetStrength
SWEP.ForceDelay = 0.25 / SWEP.MagnetStrength

GAMEMODE:SetPrimaryWeaponModifier(SWEP, WEAPON_MODIFIER_MAGNET_STRENGTH, 1 / 3)

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if not SERVER then return end

SWEP.TrinketStatus = "status_magnet"

function SWEP:Initialize()
	BaseClass.Initialize(self)

	timer.Simple(0, function()
		if IsValid(self) then
			if self.TrinketStatus ~= "" then
				self:CreateTrinketStatus()
			end
		end
	end)
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if self.TrinketStatus ~= "" then
		self:CreateTrinketStatus()
	end

	return true
end

function SWEP:CreateTrinketStatus()
	local owner = self:GetOwner()
	if not owner:IsValid() then return end

	local status = self.TrinketStatus
	for _, ent in pairs(ents.FindByClass(status)) do
		if ent:GetOwner() == owner then return end
	end

	local ent = ents.Create(status)
	if ent:IsValid() then
		ent:SetPos(owner:EyePos())
		ent:SetParent(owner)
		ent:SetOwner(owner)
		ent:Spawn()
	end
end