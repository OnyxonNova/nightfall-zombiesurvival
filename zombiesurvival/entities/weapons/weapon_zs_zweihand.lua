AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Цвайхендер"
SWEP.Description = "Сильный рубящий меч, легко пронзающий толпы зомби."

if CLIENT then
	SWEP.ViewModelFOV = 65
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["models/props_vehicles/tire001c_car.mdl+"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.595, 1.781, -1.834), angle = Angle(101.651, -122.048, 98.462), size = Vector(0.056, 0.039, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.13, -0.215, -1.627), angle = Angle(0, -10, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/lampshade001a.mdl"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.572, 0.609, 8.027), angle = Angle(-6.707, 20.249, -5.69), size = Vector(0.045, 0.045, 0.045), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/props_phx/wheels/monster_truck.mdl+"] = { type = "Model", model = "models/props_phx/wheels/monster_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.127, 1.983, -3.404), angle = Angle(85.091, -2.533, 180), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/gibs/manhack_gib06.mdl+"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.209, 3.315, -13.554), angle = Angle(119.546, -174.956, 77.625), size = Vector(0.3, 0.4, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate05x2.mdl"] = { type = "Model", model = "models/hunter/plates/plate05x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0.968, 3.926, -20.132), angle = Angle(-5.205, -2.981, -96.951), size = Vector(0.05, 0.349, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_c17/canister01a.mdl"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.375, 1.764), angle = Angle(172.074, 21.024, 4.527), size = Vector(0.07, 0.07, 0.216), color = Color(127, 95, 0, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs01", skin = 0, bodygroup = {} },
	["models/props_phx/wheels/monster_truck.mdl"] = { type = "Model", model = "models/props_phx/wheels/monster_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.945, 1.876, -3.307), angle = Angle(85.091, -2.533, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_junk/harpoon002a.mdl+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0.892, 1.797, -3.125), angle = Angle(174.552, -3.757, 0), size = Vector(0.1, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/gibs/manhack_gib06.mdl"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.251, 2.923, -13.202), angle = Angle(78.502, 150.723, -63.571), size = Vector(0.3, 0.4, 0.973), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+1+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-1.435, 6.064, -38.72), angle = Angle(-174.504, 176.692, 85.421), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+12+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-1.45, 6.06, -38.73), angle = Angle(-174.504, 176.692, 81.97), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001c_car.mdl"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.687, 1.667, -0.81), angle = Angle(98.546, -115.112, 104.151), size = Vector(0.056, 0.029, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/props_junk/harpoon002a.mdl"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(4.653, 2.102, -3.503), angle = Angle(-5.277, -4.894, 0), size = Vector(0.1, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl1+"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.515, 2.049, -4.316), angle = Angle(-3.131, -2.958, -7.34), size = Vector(0.037, 0.114, 0.18), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001c", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.255, 6.122, -38.831), angle = Angle(174.192, -1.981, 98.008), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl+"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.48, 2.086, -4.59), angle = Angle(-3.131, -2.958, -7.34), size = Vector(0.029, 0.05, 0.063), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.276, 6.102, -38.813), angle = Angle(174.192, -2.55, 94.266), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["models/props_vehicles/tire001c_car.mdl+"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.595, 1.781, -1.834), angle = Angle(101.651, -122.048, 98.462), size = Vector(0.056, 0.039, 0.039), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.388, -0.174, -0.015), angle = Angle(13.991, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_c17/lampshade001a.mdl"] = { type = "Model", model = "models/props_c17/lampshade001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.572, 0.609, 8.027), angle = Angle(-6.707, 20.249, -5.69), size = Vector(0.045, 0.045, 0.045), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/props_phx/wheels/monster_truck.mdl+"] = { type = "Model", model = "models/props_phx/wheels/monster_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.127, 1.983, -3.404), angle = Angle(85.091, -2.533, 180), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/gibs/manhack_gib06.mdl+"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(3.209, 3.315, -13.554), angle = Angle(119.546, -174.956, 77.625), size = Vector(0.3, 0.4, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate05x2.mdl"] = { type = "Model", model = "models/hunter/plates/plate05x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0.968, 3.926, -20.132), angle = Angle(-5.205, -2.981, -96.951), size = Vector(0.05, 0.349, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_c17/canister01a.mdl"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.951, 1.375, 1.764), angle = Angle(172.074, 21.024, 4.527), size = Vector(0.07, 0.07, 0.216), color = Color(127, 95, 0, 255), surpresslightning = false, material = "models/gibs/woodgibs/woodgibs01", skin = 0, bodygroup = {} },
	["models/props_phx/wheels/monster_truck.mdl"] = { type = "Model", model = "models/props_phx/wheels/monster_truck.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(1.945, 1.876, -3.307), angle = Angle(85.091, -2.533, 0), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_junk/harpoon002a.mdl+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0.892, 1.797, -3.125), angle = Angle(174.552, -3.757, 0), size = Vector(0.1, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/gibs/manhack_gib06.mdl"] = { type = "Model", model = "models/gibs/manhack_gib06.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.251, 2.923, -13.202), angle = Angle(78.502, 150.723, -63.571), size = Vector(0.3, 0.4, 0.973), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+1+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-1.435, 6.064, -38.72), angle = Angle(-174.504, 176.692, 85.421), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+12+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-1.45, 6.06, -38.73), angle = Angle(-174.504, 176.692, 81.97), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_vehicles/tire001c_car.mdl"] = { type = "Model", model = "models/props_vehicles/tire001c_car.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.687, 1.667, -0.81), angle = Angle(98.546, -115.112, 104.151), size = Vector(0.056, 0.029, 0.029), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/props_junk/harpoon002a.mdl"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(4.653, 2.102, -3.503), angle = Angle(-5.277, -4.894, 0), size = Vector(0.1, 0.189, 0.189), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl1+"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.515, 2.049, -4.316), angle = Angle(-3.131, -2.958, -7.34), size = Vector(0.037, 0.114, 0.18), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_vents/borealis_vent001c", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.255, 6.122, -38.831), angle = Angle(174.192, -1.981, 98.008), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} },
	["models/props_phx/misc/iron_beam1.mdl+"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(2.48, 2.086, -4.59), angle = Angle(-3.131, -2.958, -7.34), size = Vector(0.029, 0.05, 0.063), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/props_pipes/destroyedpipes01a", skin = 0, bodygroup = {} },
	["models/hunter/triangles/025x025.mdl+"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(-0.276, 6.102, -38.813), angle = Angle(174.192, -2.55, 94.266), size = Vector(0.05, 0.189, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_debris/metalwall001a", skin = 0, bodygroup = {} }
}

end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 129
SWEP.MeleeRange = 77
SWEP.MeleeSize = 2.4
SWEP.MeleeKnockBack = 150

SWEP.Primary.Delay = 1.3
SWEP.SwingTime = 0.97

SWEP.Tier = 5
SWEP.MaxStock = 2

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.SwingRotation = Angle(30, -20, 10)
SWEP.SwingOffset = Vector(0, -20, 0)
SWEP.SwingHoldType = "melee2"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.125)

function SWEP:PlayRevupSound()
    self:EmitSound("nox/sword_miss.ogg", 75, math.random(15, 35), 0.75)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(65, 85))
end

function SWEP:PlayHitSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75, math.random(65, 70))
end

function SWEP:GetTracesNumPlayers(traces)
	local numplayers = 0

	local ent
	for _, trace in pairs(traces) do
		ent = trace.Entity
		if ent and ent:IsValidPlayer() then
			numplayers = numplayers + 1
		end
	end

	return numplayers
end

function SWEP:GetDamage(numplayers, basedamage)
	basedamage = basedamage or self.MeleeDamage

	if numplayers then
		return basedamage * math.Clamp(1.25 - numplayers * 0.25, 0.5, 1)
	end

	return basedamage
end

function SWEP:MeleeSwing()
	local owner = self:GetOwner()

	owner:DoAttackEvent()
	self:SendWeaponAnim(self.MissAnim)
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	local hit = false
	local tr = owner:CompensatedPenetratingMeleeTrace(self.MeleeRange * (owner.MeleeRangeMul or 1), self.MeleeSize)
	local damage = self:GetDamage(self:GetTracesNumPlayers(tr))
	local ent

	local damagemultiplier = owner:Team() == TEAM_HUMAN and owner.MeleeDamageMultiplier or 1

	for _, trace in ipairs(tr) do
		if not trace.Hit then continue end

		ent = trace.Entity

		hit = true

		local hitflesh = trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH or trace.MatType == MAT_ANTLION or trace.MatType == MAT_ALIENFLESH

		if hitflesh then
			util.Decal(self.BloodDecal, trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)

			if SERVER then
				self:ServerHitFleshEffects(ent, trace, damagemultiplier)
			end

		end

		if ent and ent:IsValid() then
			if SERVER then
				self:ServerMeleeHitEntity(trace, ent, damagemultiplier)
			end

			self:MeleeHitEntity(trace, ent, damagemultiplier, damage)
		end
	end

	if hit then
		self:PlayHitSound()
	else
		self:PlaySwingSound()

		if owner.MeleePowerAttackMul and owner.MeleePowerAttackMul > 1 then
			self:SetPowerCombo(0)
		end
	end
end

function SWEP:MeleeHitEntity(tr, hitent, damagemultiplier, damage)
	if not IsFirstTimePredicted() then return end

	local owner = self:GetOwner()

	damage = damage * damagemultiplier

	local dmginfo = DamageInfo()
	dmginfo:SetDamagePosition(tr.HitPos)
	dmginfo:SetAttacker(owner)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamageType(self.DamageType)
	dmginfo:SetDamage(damage)
	dmginfo:SetDamageForce(math.min(self.MeleeDamage, 50) * 50 * owner:GetAimVector())

	local vel
	if hitent:IsPlayer() then

		if owner.MeleePowerAttackMul and owner.MeleePowerAttackMul > 1 then
			self:SetPowerCombo(self:GetPowerCombo() + 1)

			damage = damage + damage * (owner.MeleePowerAttackMul - 1) * (self:GetPowerCombo()/4)
			dmginfo:SetDamage(damage)

			if self:GetPowerCombo() >= 4 then
				self:SetPowerCombo(0)
				if SERVER then
					local pitch = math.Clamp(math.random(90, 110) + 15 * (1 - damage/45), 50 , 200)
					owner:EmitSound("npc/strider/strider_skewer1.wav", 75, pitch)
				end
			end
		end

		hitent:MeleeViewPunch(damage)
		if hitent:IsHeadcrab() then
			damage = damage * 2
			dmginfo:SetDamage(damage)
		end

		if SERVER then
			hitent:SetLastHitGroup(tr.HitGroup)
			if tr.HitGroup == HITGROUP_HEAD then
				hitent:SetWasHitInHead()
			end

			if hitent:WouldDieFrom(damage, tr.HitPos) then
				dmginfo:SetDamageForce(math.min(self.MeleeDamage, 50) * 400 * owner:GetAimVector())
			end
		end

		vel = hitent:GetVelocity()
	else
		if owner.MeleePowerAttackMul and owner.MeleePowerAttackMul > 1 then
			self:SetPowerCombo(0)
		end
	end

	--if not hitent.LastHeld or CurTime() >= hitent.LastHeld + 0.1 then -- Don't allow people to shoot props out of their hands
		if self.PointsMultiplier then
			POINTSMULTIPLIER = self.PointsMultiplier
		end

		hitent:DispatchTraceAttack(dmginfo, tr, owner:GetAimVector())

		if self.PointsMultiplier then
			POINTSMULTIPLIER = nil
		end

		-- Invalidate the engine knockback vs. players
		if vel then
			hitent:SetLocalVelocity(vel)
		end
	--end

	-- Perform our own knockback vs. players
	if hitent:IsPlayer() then
		local knockback = self.MeleeKnockBack * (owner.MeleeKnockbackMultiplier or 1)
		if knockback > 0 then
			hitent:ThrowFromPositionSetZ(tr.StartPos, knockback, nil, true)
		end
	end

	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetStart(tr.StartPos)
	effectdata:SetNormal(tr.HitNormal)
	util.Effect("RagdollImpact", effectdata)
	if not tr.HitSky then
		effectdata:SetSurfaceProp(tr.SurfaceProps)
		effectdata:SetDamageType(self.DamageType)
		effectdata:SetHitBox(tr.HitBox)
		effectdata:SetEntity(hitent)
		util.Effect("Impact", effectdata)
	end
end