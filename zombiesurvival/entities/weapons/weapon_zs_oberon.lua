AddCSLuaFile()

SWEP.PrintName = "'Оберон' Импульсный Дробовик"
SWEP.Description = "Оберон имеет хороший разброс и его пули замедляют цель."

if CLIENT then
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(2.12, -1, -8)
	SWEP.HUD3DScale = 0.025

	SWEP.ShowViewModel = true

	SWEP.VElements = {
		["base+++"] = { type = "Model", model = "models/Items/boxflares.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-1.283, -2.158, 1.508), angle = Angle(90, -90, -90), size = Vector(0.437, 0.226, 0.446), color = Color(0, 255, 255, 255), surpresslightning = true, material = "models/error/new light1", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_mortar01a.mdl", bone = "ValveBiped.Pump", rel = "", pos = Vector(-1.313, 1.697, -20.396), angle = Angle(0.476, 90, 0), size = Vector(0.172, 0.179, 0.256), color = Color(255, 147, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base++"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0.197, 3.431, 3.428), angle = Angle(-90, 0, -90.676), size = Vector(0.071, 0.019, 0.025), color = Color(255, 180, 123, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["base++"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.329, 1.085, -3.164), angle = Angle(175.024, 0.411, 0), size = Vector(0.037, 0.02, 0.017), color = Color(255, 180, 123, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base+++"] = { type = "Model", model = "models/Items/boxflares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.725, -0.431, -6.599), angle = Angle(6.518, 180, -90), size = Vector(0.277, 0.277, 0.469), color = Color(0, 255, 255, 255), surpresslightning = true, material = "models/error/new light1", skin = 0, bodygroup = {} },
		["base+"] = { type = "Model", model = "models/props_combine/combine_mortar01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.356, 0.796, -2.659), angle = Angle(-94.139, 1.621, 0), size = Vector(0.129, 0.136, 0.108), color = Color(255, 147, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

sound.Add(
{
	name = "Weapon_Oberon.Single",
	channel = CHAN_WEAPON,
	volume = 1.0,
	soundlevel = 100,
	pitch = {85, 92},
	sound = "weapons/gauss/fire1.wav"
})

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_Oberon.Single")
SWEP.Primary.Damage = 14
SWEP.Primary.NumShots = 7
SWEP.Primary.Delay = 0.8

SWEP.FireAnimSpeed = 0.55

SWEP.Primary.ClipSize = 18
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pulse"
SWEP.Primary.DefaultClip = 30
SWEP.RequiredClip = 3
SWEP.ConeMax = 6
SWEP.ConeMin = 2.5

SWEP.ReloadDelay = 0.4

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.TracerName = "AR2Tracer"

SWEP.PumpSound = Sound("Weapon_Shotgun.Special1")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

SWEP.LegDamage = 9
SWEP.Tier = 3

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_LEG_DAMAGE, 1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValidLivingZombie() then
		ent:AddLegDamageExt(dmginfo:GetInflictor().LegDamage, attacker, attacker:GetActiveWeapon(), SLOWTYPE_PULSE)
	end

	if IsFirstTimePredicted() then
		util.CreatePulseImpactEffect(tr.HitPos, tr.HitNormal)
	end
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/stunstick/alyx_stunner2.wav", 72, 115, 0.65, CHAN_AUTO)
	self:EmitSound("weapons/gauss/fire1.wav", 72, 108, 0.65)
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
	if self.ReloadSound then
		self:EmitSound(self.ReloadSound)
	end

	self:GetOwner():RemoveAmmo(1, self.Primary.Ammo, false)
	self:SetClip1(self:Clip1() + 3)

	self:SetDTBool(2, false)
	-- We always wanna call the reload function one more time. Forces a pump to take place.
	self:SetDTFloat(3, CurTime() + delay)

	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))
end

