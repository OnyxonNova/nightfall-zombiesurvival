AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_basemelee")

SWEP.PrintName = "'Ганимед' Великий Меч"
SWEP.Description = "Очень тяжелый меч.\nНанеся достаточно урона временно увеличит дальность атаки на 30%"

if CLIENT then
	SWEP.ViewModelFOV = 68
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	
	SWEP.VElements = {
		["baseblade"] = { type = "Model", model = "", bone = "main_control", rel = "basemelee", pos = Vector(0.19300000369549, 0.26300001144409, 0.52600002288818), angle = Angle(5.1160001754761, -0.20499999821186, 3.614000082016), size = Vector(0.5, 0.5, 0.5), color = Color(255, 126, 126, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basehandle"] = { type = "Model", model = "", bone = "main_control", rel = "basemelee", pos = Vector(0, 0, 0), angle = Angle(3.1900000572205, 1.4589999914169, 2.2019999027252), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.6579999923706, 0.91200000047684, 1.6469999551773), angle = Angle(-6.6199998855591, -190.37899780273, 88.470001220703), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "main_control", rel = "basehandle", pos = Vector(0.32699999213219, 9.8620004653931, -0.12999999523163), angle = Angle(93.127998352051, 0, 90), size = Vector(0.034000001847744, 0.10000000149012, 0.029999999329448), color = Color(182, 182, 182, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/plates/plate025x05.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "main_control", rel = "baseblade", pos = Vector(0.51599997282028, 31.822999954224, 0.18600000441074), angle = Angle(1.8020000457764, 0.37200000882149, -1.5770000219345), size = Vector(0.34200000762939, 1.6619999408722, 0.29300001263618), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(2.5269999504089, 31.781000137329, 0.23600000143051), angle = Angle(-177.12199401855, 0.31799998879433, 91.599998474121), size = Vector(0.16599999368191, 0.037000000476837, 13.177000045776), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl+"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(-1.3819999694824, 31.795000076294, 0.12099999934435), angle = Angle(0.80000001192093, 0.023000000044703, 88.400001525879), size = Vector(0.16599999368191, 0.037000000476837, 13.177000045776), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl1"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(-0.23100000619888, 55.90599822998, 0.70099997520447), angle = Angle(-0.62800002098083, 16.704999923706, 89.22200012207), size = Vector(0.14399999380112, 0.029999999329448, 3.4089999198914), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl2+"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(0.99000000953674, 55.99100112915, 0.73600000143051), angle = Angle(-1.8270000219345, 159.63900756836, 89.105003356934), size = Vector(0.15099999308586, 0.029999999329448, 3.5999999046326), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/05x05mirrored.mdl"] = { type = "Model", model = "models/hunter/triangles/05x05mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(0.3910000026226, 55.265998840332, 0.67599999904633), angle = Angle(-0.018999999389052, 87.167999267578, -2.7809998989105), size = Vector(0.33000001311302, 0.090000003576279, 0.18000000715256), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/05x05mirrored.mdl+"] = { type = "Model", model = "models/hunter/triangles/05x05mirrored.mdl", bone = "main_control", rel = "baseblade", pos = Vector(0.18999999761581, 63.571998596191, 0.72899997234344), angle = Angle(-0.35199999809265, 90.09700012207, -1.0709999799728), size = Vector(0.2419999986887, 0.050000000745058, 0.27300000190735), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_docks/dock01_cleat01a.mdl"] = { type = "Model", model = "models/props_docks/dock01_cleat01a.mdl", bone = "main_control", rel = "basehandle", pos = Vector(0.34200000762939, 10.883999824524, -0.15999999642372), angle = Angle(3.191999912262, -0.7620000243187, 89.96900177002), size = Vector(0.57400000095367, 0.19200000166893, 0.1410000026226), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_junk/watermelon01.mdl"] = { type = "Model", model = "models/props_junk/watermelon01.mdl", bone = "main_control", rel = "basehandle", pos = Vector(0.22100000083447, -8.7659997940063, -0.18500000238419), angle = Angle(-8.3090000152588, 1.7680000066757, -13.675000190735), size = Vector(0.22300000488758, 0.22300000488758, 0.22300000488758), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/props/cs_assault/pylon", skin = 0, bodygroup = {} },
		["models/xqm/airplanewheel1.mdl"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "main_control", rel = "basehandle", pos = Vector(0.14699999988079, 0.16099999845028, -0.14000000059605), angle = Angle(0.1710000038147, 89.52799987793, 0), size = Vector(2.5539999008179, 0.10999999940395, 0.10999999940395), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/XQM//WoodTexture_1", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["baseblade"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0.2039999961853, 0.17299999296665, 0.69199997186661), angle = Angle(5.2829999923706, -0.49099999666214, 4.6849999427795), size = Vector(0.5, 0.5, 0.5), color = Color(255, 126, 126, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basehandle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "basemelee", pos = Vector(0, 0, 0), angle = Angle(3.1900000572205, 1.4589999914169, 2.2019999027252), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["basemelee"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.2149999141693, 1.4539999961853, -0.40700000524521), angle = Angle(-1.4409999847412, 16.388000488281, 85.88200378418), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/misc/roundthing2.mdl"] = { type = "Model", model = "models/hunter/misc/roundthing2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0.32699999213219, 9.8620004653931, -0.12999999523163), angle = Angle(93.127998352051, 0, 90), size = Vector(0.034000001847744, 0.10000000149012, 0.029999999329448), color = Color(182, 182, 182, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/plates/plate025x05.mdl"] = { type = "Model", model = "models/hunter/plates/plate025x05.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.51599997282028, 31.822999954224, 0.18600000441074), angle = Angle(1.8020000457764, 0.37200000882149, -1.5770000219345), size = Vector(0.34200000762939, 1.6619999408722, 0.29300001263618), color = Color(36, 36, 36, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(2.5269999504089, 31.781000137329, 0.23600000143051), angle = Angle(-177.12199401855, 0.31799998879433, 91.599998474121), size = Vector(0.16599999368191, 0.037000000476837, 13.177000045776), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl+"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(-1.3819999694824, 31.795000076294, 0.12099999934435), angle = Angle(0.80000001192093, 0.023000000044703, 88.400001525879), size = Vector(0.16599999368191, 0.037000000476837, 13.177000045776), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl1"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(-0.23100000619888, 55.90599822998, 0.70099997520447), angle = Angle(-0.62800002098083, 16.704999923706, 89.22200012207), size = Vector(0.14399999380112, 0.029999999329448, 3.4089999198914), color = Color(109, 109, 109, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["models/hunter/triangles/025x025mirrored.mdl2+"] = { type = "Model", model = "models/hunter/triangles/025x025mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.99000000953674, 55.99100112915, 0.73600000143051), angle = Angle(-1.8270000219345, 159.63900756836, 89.105003356934), size = Vector(0.15099999308586, 0.029999999329448, 3.5999999046326), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/05x05mirrored.mdl"] = { type = "Model", model = "models/hunter/triangles/05x05mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.3910000026226, 55.265998840332, 0.67599999904633), angle = Angle(-0.018999999389052, 87.167999267578, -2.7809998989105), size = Vector(0.33000001311302, 0.090000003576279, 0.18000000715256), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/hunter/triangles/05x05mirrored.mdl+"] = { type = "Model", model = "models/hunter/triangles/05x05mirrored.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "baseblade", pos = Vector(0.16099999845028, 61.903999328613, 0.67699998617172), angle = Angle(-0.35199999809265, 90.09700012207, -1.0709999799728), size = Vector(0.089000001549721, 0.0489999987185, 0.27399998903275), color = Color(109, 109, 109, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/props_docks/dock01_cleat01a.mdl"] = { type = "Model", model = "models/props_docks/dock01_cleat01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0.34200000762939, 10.883999824524, -0.15999999642372), angle = Angle(3.191999912262, -0.7620000243187, 89.96900177002), size = Vector(0.57400000095367, 0.19200000166893, 0.1410000026226), color = Color(72, 72, 72, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} },
		["models/xqm/airplanewheel1.mdl"] = { type = "Model", model = "models/xqm/airplanewheel1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "basehandle", pos = Vector(0.14699999988079, 0.16099999845028, -0.14000000059605), angle = Angle(0.1710000038147, 89.52799987793, 0), size = Vector(2.5539999008179, 0.10999999940395, 0.10999999940395), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/XQM//WoodTexture_1", skin = 0, bodygroup = {} }
	}

	SWEP.ViewModelBoneMods = {
		["ValveBiped.Bip01_Spine4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -1.4), angle = Angle(0, 0, 0) },
		["main_control"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -1.4), angle = Angle(0, 0, 0) }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 182
SWEP.MeleeRange = 87
SWEP.MeleeSize = 3.5
SWEP.MeleeKnockBack = 270

SWEP.Primary.Delay = 1.75

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingTime = 1.15
SWEP.SwingHoldType = "melee"

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)

SWEP.HitDecal = "Manhackcut"

SWEP.Tier = 6
SWEP.MaxStock = 1

SWEP.AllowQualityWeapons = true

SWEP.EnableChargingAbility = true
SWEP.FullChargeText = "ЛКМ: Дальний Удар!"

SWEP.ChargeGain = 0.05
SWEP.ChargeColor = Color(154, 205, 50)

SWEP.AbilityActive = false

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.17)

function SWEP:PlayRevupSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(15, 25), 1)

    local sound = CreateSound(self, "physics/concrete/rock_scrape_rough_loop1.wav")

    sound:PlayEx(75, math.random(45, 55))

    timer.Simple(0.15, function()
        if sound then
            sound:Stop()
        end
    end)
end

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 45, math.random(50, 65))
end

function SWEP:PlayHitSound()
    self:EmitSound("weapons/melee/golf club/golf_hit-0" .. math.random(4) .. ".ogg", math.random(61, 70))
    self:EmitSound("ambient/machines/slicer" .. math.random(4) .. ".wav", 75, math.random(60, 68), nil, CHAN_AUTO)
end

function SWEP:PlayHitFleshSound()
	    self:EmitSound(
        ")physics/body/body_medium_break" .. math.random(2, 4) .. ".wav",
        85,
        math.Rand(86, 90),
        0.60,
        CHAN_WEAPON + 40
    )
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

	local wep = owner:GetActiveWeapon()

	local hit = false
	local tr = owner:CompensatedPenetratingMeleeTrace(self.MeleeRange * (owner.MeleeRangeMul or 1) * (wep.AbilityActive and 1.3 or 1), self.MeleeSize)
	local damage = self:GetDamage(self:GetTracesNumPlayers(tr))

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

			local intd = wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON)
			if wep.AbilityActive then
				local damagetotal = (damage * wep.ChargeGain * 0.65)
				local intd = math.min(100 - damagetotal, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))
				wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, intd - damagetotal)
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

		local wep = owner:GetActiveWeapon()
		if hitent:IsValidZombie() and wep.EnableChargingAbility and not wep.AbilityActive then
			local damage = (dmginfo:GetDamage() * wep.ChargeGain)
			local intd = math.min(100 - damage, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))
			wep:SetDTInt(DT_PLAYER_INT_ABILITYWEAPON, intd + damage)
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

function SWEP:Think()
	self.BaseClass.Think(self)

	local owner = self:GetOwner()
	local wep = owner:GetActiveWeapon()

	local intd = math.min(100, wep:GetDTInt(DT_PLAYER_INT_ABILITYWEAPON))

	if intd >= 100 then
		wep.AbilityActive = true
	elseif intd <= 0 then
		wep.AbilityActive = false
	end
end