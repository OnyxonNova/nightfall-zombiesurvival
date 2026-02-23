SWEP.PrintName = "'Аегис' Строй-Установщик"
SWEP.Description = "Готовое к работе универсальное устройство для развертывания плат.\nОно автоматически разворачивает доску, а затем надежно приклепляет ее практически к любой поверхности.\nНажмите ЛКМ, чтобы поставить доску.\nНажмите ПКМ или E, чтобы повернуть доску."
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.Delay = 1.65
SWEP.Primary.DefaultClip = 6

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Ammo = "dummy"
SWEP.Secondary.Automatic = false

SWEP.UseHands = true

SWEP.MaxStock = 5

SWEP.HoldType = "rpg"

if CLIENT then
	SWEP.ViewModelFOV = 60
end

SWEP.WalkSpeed = SPEED_SLOWEST

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	GAMEMODE:DoChangeDeploySpeed(self)
end

function SWEP:Deploy()
    GAMEMODE:DoChangeDeploySpeed(self)

    gamemode.Call("WeaponDeployed", self:GetOwner(), self)
	
    return true
end

function SWEP:CanPrimaryAttack()
	local owner = self:GetOwner()

	if owner:IsHolding() or owner:GetBarricadeGhosting() then return false end

	if self:GetPrimaryAmmoCount() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return false
	end

	return true
end


function SWEP:PrimaryAttack()
	if SERVER then
		if not self:CanPrimaryAttack() then return end

		local owner = self:GetOwner()
		if not gamemode.Call("CanPlaceNail", owner) then return false end

		local status = owner.status_ghost_barricadekit
		if not (status and status:IsValid()) then return end
		status:RecalculateValidity()
		if not status:GetValidPlacement() then return end

		local pos, ang = status:RecalculateValidity()
		if not pos or not ang then return end

		self:SetNextPrimaryAttack(CurTime() + self.Primary.Delay)

		local ent = ents.Create("prop_aegisboard")
		if ent:IsValid() then
			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:Spawn()

			ent:EmitSound("npc/dog/dog_servo12.wav")

			ent:SetObjectOwner(owner)

			local stored = owner:PopPackedItem(ent:GetClass())
			if stored then
				ent:SetObjectHealth(stored[1])
			end

			self:TakePrimaryAmmo(1)
		end
	end

	local owner = self:GetOwner()

	owner:DoAttackEvent()

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

util.PrecacheModel("models/props_debris/wood_board05a.mdl")
util.PrecacheSound("npc/dog/dog_servo12.wav")

local ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]      	= ACT_HL2MP_IDLE_DUEL,
	[ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER,
	[ "camera" ]		= ACT_HL2MP_IDLE_CAMERA
}

function SWEP:SetWeaponHoldType( t )

	t = string.lower( t )
	local index = ActIndex[ t ]

	if ( index == nil ) then
		Msg( "SWEP:SetWeaponHoldType - ActIndex[ \""..t.."\" ] isn't set! (defaulting to normal) (from "..self:GetClass()..")\n" )
		t = "normal"
		index = ActIndex[ t ]
	end

	self.ActivityTranslate = {}
	self.ActivityTranslate [ ACT_MP_STAND_IDLE ] 				= index
	self.ActivityTranslate [ ACT_MP_WALK ] 						= index+1
	self.ActivityTranslate [ ACT_MP_RUN ] 						= index+2
	self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] 				= index+3
	self.ActivityTranslate [ ACT_MP_CROUCHWALK ] 				= index+4
	self.ActivityTranslate [ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	= index+5
	self.ActivityTranslate [ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = index+5
	self.ActivityTranslate [ ACT_MP_RELOAD_STAND ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_RELOAD_CROUCH ]		 		= index+6
	self.ActivityTranslate [ ACT_MP_JUMP ] 						= index+7
	self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM_IDLE ] 				= index+8
	self.ActivityTranslate [ ACT_MP_SWIM ] 						= index+9

	-- "normal" jump animation doesn't exist
	if t == "normal" then
		self.ActivityTranslate [ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end

	-- these two aren't defined in ACTs for whatever reason
	if t == "knife" or t == "melee2" then
		self.ActivityTranslate [ ACT_MP_CROUCH_IDLE ] = nil
	end
end

SWEP:SetWeaponHoldType("pistol")

function SWEP:TranslateActivity(act)
	return self.ActivityTranslate and self.ActivityTranslate[act] or -1
end
