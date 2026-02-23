AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "Катана"
SWEP.Description = "Отлично разрубает несколько зомби одним взмахом."

if CLIENT then
	SWEP.ViewModelFOV = 65
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

SWEP.VElements = {
	["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(9.161, -6.934, -39.521), angle = Angle(101.039, 75.599, -176.189), size = Vector(0.239, 0.15, 0.123), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basehandle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.393, -0.171, 0.326), angle = Angle(-6.158, 0, -13.009), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/xqm/airplanewheel1.mdl+"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(2.309, 1.878, 0.477), angle = Angle(-71.556, 47.504, -22.431), size = Vector(1.769, 0.109, 0.07), color = Color(91, 69, 69, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+12+"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.822, -6.035, -35.663), angle = Angle(2.621, 11.692, 104.512), size = Vector(0.029, 0.209, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/Gibs/HGIBS_spine.mdl"] = { type = "Model", model = "models/Gibs/HGIBS_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(6.742, -2.958, -21.74), angle = Angle(-13.867, -102.7, 4.123), size = Vector(0.2, 0.56, 3), color = Color(182, 182, 182, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_wasteland/wheel01.mdl"] = { type = "Model", model = "models/props_wasteland/wheel01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.707, 0.342, -6.134), angle = Angle(-6.178, 157.026, -106.225), size = Vector(0.07, 0.07, 0.07), color = Color(255, 191, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+1+"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.89, -6.225, -35.7), angle = Angle(-11.266, -45.371, 100.76), size = Vector(0.029, 0.209, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/apc_tire001.mdl"] = { type = "Model", model = "models/props_vehicles/apc_tire001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.842, 0.275, -6.507), angle = Angle(-74.181, 51.703, -22.393), size = Vector(0.194, 0.029, 0.009), color = Color(255, 191, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basenidle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.483, -0.091, -1.137), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/xqm/airplanewheel1.mdl"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.694, 0.451, -5.375), angle = Angle(-70.732, 47.763, -27.754), size = Vector(0.172, 0.123, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.022, -6.094, -34.881), angle = Angle(-3.343, -10.316, 104.786), size = Vector(0.129, 0.33, 0.112), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+2"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(7.326, -6.417, -35.869), angle = Angle(-1.259, -9.955, 103.382), size = Vector(0.009, 0.642, 0.112), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseblade"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["models/hunter/triangles/025x025.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(9.161, -6.934, -39.521), angle = Angle(101.039, 75.599, -176.189), size = Vector(0.239, 0.15, 0.123), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.407, 0.294, 0.016), angle = Angle(-14.363, 15.888, -24.504), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/xqm/airplanewheel1.mdl+"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(2.309, 1.878, 0.477), angle = Angle(-71.556, 47.504, -22.431), size = Vector(1.769, 0.109, 0.07), color = Color(91, 69, 69, 255), surpresslightning = false, material = "phoenix_storms/Fender_wood", skin = 0, bodygroup = {} },
	["models/Gibs/HGIBS_spine.mdl"] = { type = "Model", model = "models/Gibs/HGIBS_spine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(6.742, -2.958, -21.74), angle = Angle(-13.867, -102.7, 4.123), size = Vector(0.2, 0.56, 3), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+12+"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.822, -6.035, -35.663), angle = Angle(2.621, 11.692, 104.512), size = Vector(0.029, 0.209, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basehandle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/props_wasteland/wheel01.mdl"] = { type = "Model", model = "models/props_wasteland/wheel01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.875, 0.342, -6.257), angle = Angle(14.645, 17.15, -80.961), size = Vector(0.07, 0.07, 0.07), color = Color(255, 191, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+1+"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.89, -6.225, -35.7), angle = Angle(-11.266, -45.371, 100.76), size = Vector(0.029, 0.209, 0.009), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/props_vehicles/apc_tire001.mdl"] = { type = "Model", model = "models/props_vehicles/apc_tire001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.842, 0.275, -6.507), angle = Angle(-74.181, 51.703, -22.393), size = Vector(0.194, 0.029, 0.009), color = Color(255, 191, 0, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["basenidle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.483, -0.091, -1.137), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/xqm/airplanewheel1.mdl"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(3.694, 0.451, -5.375), angle = Angle(-70.732, 47.763, -27.754), size = Vector(0.172, 0.123, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(8.022, -6.094, -34.881), angle = Angle(-3.343, -10.316, 104.786), size = Vector(0.129, 0.33, 0.112), color = Color(145, 145, 145, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["models/hunter/plates/plate025x025.mdl+2"] = { type = "Model", model = "models/hunter/plates/plate025x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basenidle", pos = Vector(7.326, -6.417, -35.869), angle = Angle(-1.259, -9.955, 103.382), size = Vector(0.009, 0.642, 0.112), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
	["baseblade"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 101
SWEP.MeleeRange = 75
SWEP.MeleeSize = 2.5
SWEP.MeleeKnockBack = 125

SWEP.MaxStock = 3

SWEP.Primary.Delay = 1
SWEP.SwingTime = 0.8

SWEP.Tier = 4

SWEP.WalkSpeed = SPEED_FAST

SWEP.SwingRotation = Angle(30, -20, 10)
SWEP.SwingOffset = Vector(0, -20, 0)
SWEP.SwingHoldType = "melee2"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1)
branch = GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Ловкость Самурая' Катана", "Низкая задержка удара, меньше урон", function(wept)
	wept.Primary.Delay = wept.Primary.Delay * 0.8
	wept.SwingTime = wept.SwingTime * 0.9
	wept.MeleeDamage = wept.MeleeDamage * 0.7125
end)
branch.NewNames = {[0]="Ловкость Самурая"}

function SWEP:PlaySwingSound()
	self:EmitSound("nox/sword_miss.ogg", 75, math.random(65, 85))
end

function SWEP:PlayHitSound()
	self:EmitSound("nox/sword_miss.ogg", 100, math.random(40, 65))
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 75, 100, 1, CHAN_AUTO)
end

function SWEP:PlayRevupSound()
    self:EmitSound("nox/sword_miss.ogg", 75, math.random(50, 90), 0.75)
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