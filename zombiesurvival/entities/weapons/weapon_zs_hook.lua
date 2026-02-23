AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Мясной Крюк"
SWEP.Description = "Проникает в зомби, нанося урон кровотечением в течение нескольких секунд."

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -5), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.181, 4, -9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.DamageType = DMG_SLASH

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_junk/meathook001a.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 80
SWEP.MeleeRange = 60
SWEP.MeleeSize = 1.15

SWEP.HitGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SWEP.MissGesture = SWEP.HitGesture

SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "grenade"

SWEP.Primary.Delay = 1

SWEP.WalkSpeed = SPEED_FAST

SWEP.AllowQualityWeapons = true
SWEP.Weaken = false

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1)
local branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "Мясной Захват", "Зомби получают больше урона от любого источника", function(wept)
	wept.Weaken = true
	wept.MeleeDamage = wept.MeleeDamage * 0.65
end)
branch.NewNames = {[0]="Мясной Захват"}

AccessorFuncDT(SWEP, "SwingCount", "Int", 9)

function SWEP:Deploy()
    BaseClass.Deploy(self)
    if CLIENT then
        self:PlayRevupSound()
    end
    return true
end

function SWEP:PlayRevupSound()
    self:EmitSound("physics/metal/weapon_impact_soft1.wav", 75, math.random(100, 100), 1)
    self:EmitSound("npc/roller/blade_in.wav", 75, math.random(100, 115), 0.75, CHAN_AUTO)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(95, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.random(120, 130))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_sheet_impact_bullet"..math.random(2)..".wav")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if SERVER and hitent:IsValid() and hitent:IsPlayer() and hitent:Health() > self.MeleeDamage and not hitent.SpawnProtection then
		local ang = self:GetOwner():EyeAngles()
		ang:RotateAroundAxis(ang:Forward(), 180)

		local ent = ents.Create("prop_meathook")
		if ent:IsValid() then
			ent:SetPos(tr.HitPos)
			ent.BaseWeapon = self:GetClass()
			ent.Weaken = true
			ent:Spawn()
			ent.BleedPerTick = 13
			ent.TicksRemaining = 5
			ent:SetOwner(self:GetOwner())
			ent:SetParent(hitent)
			ent:SetAngles(ang)
		end

		timer.Simple(0, function() self:GetOwner():StripWeapon(self:GetClass()) end)
	end
end

