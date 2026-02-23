GM.WeaponQualityModifiers = {}
GM.WeaponQualities = {
	{translate.Get("rh_sturdy"), 1.10, translate.Get("rh_tuned")},
	{translate.Get("rh_honed"), 1.20, translate.Get("rh_modified")},
	{translate.Get("rh_perfected"), 1.35, translate.Get("rh_reformed")}
}
GM.WeaponQualityColors = {
	[0] = {Color(255,255,255), Color(253,188,127)},
	[1] = {Color(235, 235, 115), Color(172, 219, 105)},
	[2] = {Color(50, 90, 175), Color(35, 110, 145)},
	[3] = {Color(160, 95, 235), Color(252, 100, 100)}
}

WEAPON_MODIFIER_MIN_SPREAD = 1
WEAPON_MODIFIER_MAX_SPREAD = 2
WEAPON_MODIFIER_FIRE_DELAY = 3 -- Rounds up based on tick rate.
WEAPON_MODIFIER_RELOAD_SPEED = 4
WEAPON_MODIFIER_CLIP_SIZE = 5
WEAPON_MODIFIER_MELEE_RANGE = 6
WEAPON_MODIFIER_MELEE_SIZE = 7
WEAPON_MODIFIER_MELEE_IMPACT_DELAY = 8
WEAPON_MODIFIER_PROJECTILE_VELOCITY = 9
WEAPON_MODIFIER_SHORT_TEAM_HEAT = 10
WEAPON_MODIFIER_SHOT_COUNT = 11
WEAPON_MODIFIER_BULLET_PIERCES = 12
WEAPON_MODIFIER_MAXIMUM_MINES = 13
WEAPON_MODIFIER_MAX_DISTANCE = 14
WEAPON_MODIFIER_AURA_RADIUS = 15
WEAPON_MODIFIER_RECOIL = 16
WEAPON_MODIFIER_DAMAGE = 17
WEAPON_MODIFIER_HEALRANGE = 18
WEAPON_MODIFIER_HEALCOOLDOWN = 19
WEAPON_MODIFIER_BUFF_DURATION = 20
WEAPON_MODIFIER_LEG_DAMAGE = 21
WEAPON_MODIFIER_REPAIR = 22
WEAPON_MODIFIER_TURRET_SPREAD = 23
WEAPON_MODIFIER_HEALING = 24
WEAPON_MODIFIER_HEADSHOT_MULTI = 25
WEAPON_MODIFIER_MELEE_KNOCK = 26
WEAPON_MODIFIER_TURRET_DELAY = 27
WEAPON_MODIFIER_HIT_COOLDOWN = 28
WEAPON_MODIFIER_CARRY_MASS = 29
WEAPON_MODIFIER_DAMAGE_DRONE = 30
WEAPON_MODIFIER_MAGNET_STRENGTH = 31
WEAPON_MODIFIER_SECONDARY_CLIP_SIZE = 32

local index = 1
function GM:AddWeaponQualityModifier(id, name, displayraw, vartable)
	local datatab = {Name = name, DisplayRaw = displayraw, VarTable = vartable}
	self.WeaponQualityModifiers[id] = datatab

	index = index + 1

	return datatab
end

function GM:SetPrimaryWeaponModifier(swep, modifier, amount)
	swep.PrimaryRemantleModifier = {Modifier = modifier, Amount = amount}
end

function GM:AttachWeaponModifier(swep, modifier, amount, qualitystart)
	if not swep.AltRemantleModifiers then swep.AltRemantleModifiers = {} end

	local datatab = {Amount = amount, QualityStart = qualitystart or 2}
	swep.AltRemantleModifiers[modifier] = datatab
end

function GM:AddNewRemantleBranch(swep, no, printname, desc, branchfunc)
	if not swep.Branches then swep.Branches = {} end

	local datatab = {PrintName = printname, Desc = desc, BranchFunc = branchfunc}
	swep.Branches[no] = datatab

	return datatab
end

GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MIN_SPREAD, 				"Мин. Разброс", 			false, 	{ConeMin = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_SPREAD,					"Макс. Разброс", 			false, 	{ConeMax = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_FIRE_DELAY,					"Задержка атаки", 			false, 	{Delay = true})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_RELOAD_SPEED,				"Скорость перезарядки",		false, 	{ReloadSpeed = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_CLIP_SIZE,					"Объем магазина", 			true, 	{ClipSize = true}).ReqClip = true
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_RANGE,				"Дальность атаки", 			false, 	{MeleeRange = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_SIZE,					"Размер оружия", 			false, 	{MeleeSize = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_IMPACT_DELAY,			"Задержка удара", 		    false, 	{SwingTime = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_PROJECTILE_VELOCITY,		"Скорость пули", 		    false, 	{ProjVelocity = true})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_SHORT_TEAM_HEAT,			"Короткая командная жара", 	false, 	{HeatBuildShort = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_SHOT_COUNT,					"Счетчик выстрелов", 		true, 	{NumShots = true})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BULLET_PIERCES,				"Проникающая способность",	true, 	{Pierces = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAXIMUM_MINES,				"Максимум мин", 			true, 	{MaxMines = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAX_DISTANCE,				"Максимальная дистанция", 	false, 	{MaxDistance = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_AURA_RADIUS,				"Радиус обнаружения ауры", 	false, 	{AuraRange = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_RECOIL,						"Отдача", 					false, 	{Recoil = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_DAMAGE,						"Урон", 					false, 	{Damage = true, MeleeDamage = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_DAMAGE_DRONE,				"Урон", 					false, 	{DamageDrone = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALRANGE,					"Диапазон исцеления", 		false, 	{HealRange = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALCOOLDOWN,				"Исцеление, восстановление",false, 	{HealCoolDown = true})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_BUFF_DURATION,				"Длительность усиления", 	false, 	{BuffDuration = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_LEG_DAMAGE,					"Повреждение ног", 		    false, 	{LegDamage = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_REPAIR,						"Ремонтная сила", 			false, 	{Repair = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_TURRET_SPREAD,				"Разброс пуль у турели", 	false, 	{TurretSpread = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_TURRET_DELAY,				"Задержка Выстрела", 		false, 	{TurretDelay = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEALING,					"Сумма к исцелению", 		false, 	{Heal = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HEADSHOT_MULTI,				"Бонус урона в голову", 	false, 	{HeadshotMulti = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MELEE_KNOCK,				"Отброс назад", 			false, 	{MeleeKnockBack = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_HIT_COOLDOWN,				"Задержка Удара", 			false, 	{HitCooldown = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_CARRY_MASS,					"Максимальная Масса", 		false, 	{CarryMass = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_MAGNET_STRENGTH,			"Сила магнита", 			false, 	{MagnetStrength = false})
GM:AddWeaponQualityModifier(WEAPON_MODIFIER_SECONDARY_CLIP_SIZE,		"Вторичный Объем магазина", true, 	{ClipSize = false}).IsSecondary = true

local function ApplyWeaponModifier(modinfo, wept, datatab, remantledescs, i)
	local displayed = false
	local mtbl, basestat, newstat, qfactor

	for var, isprimary in pairs(modinfo.VarTable) do
		mtbl = isprimary and wept.Primary or wept
		if modinfo.IsSecondary then
			mtbl = wept.Secondary
		end
		if mtbl[var] then
			qfactor = math.max(0, i - (datatab.QualityStart - 1))
			basestat = mtbl[var]
			newstat = basestat + datatab.Amount * qfactor

			mtbl[var] = newstat

			if not displayed and qfactor > 0 then
				local ispos = datatab.Amount > 0 and "+" or ""
				local statincdesc = not modinfo.DisplayRaw and (((math.Round(newstat/basestat, 2)-1) * 100).. "% ")
					or ((datatab.Amount * qfactor / (modinfo.ReqClip and wept.RequiredClip or 1)).. " ")

				table.insert(remantledescs, ispos .. statincdesc .. modinfo.Name)
				displayed = true
			end
		end
	end
end

local function CreateQualityKillicon(oldc, newc, i, b, cols)
	local kitbl = killicon.Get(oldc)
	if kitbl then
		local kifunc = #kitbl == 2 and killicon.Add or killicon.AddFont
		local nkitbl = table.Copy(kitbl)
		local wepget = weapons.Get(oldc)
		nkitbl[#kitbl] = cols and cols[i] or GAMEMODE.WeaponQualityColors[i][b and 2 or 1]
		kifunc(newc, unpack(nkitbl))
	end
end

function GM:CreateWeaponOfQuality(i, orig, quality, classname, branch)
	local remantledescs = {}
	local wept = weapons.Get(classname)
	if ((branch and branch.No ~= 0) or quality) and wept.AllowQualityWeapons then
		orig.RemantleDescs[branch and branch.No or 0][i] = {}
		remantledescs = orig.RemantleDescs[branch and branch.No or 0][i]
	end
	-- Doing it with a full copy prevents crash issues on scoped weapons.
	-- TODO: Refactor me to not use the full weapon class once all self.BaseClass calls have been removed
	
	wept.BaseQuality = classname
	wept.QualityTier = i
	wept.Branch = branch and branch.No


	if quality then
		if wept.PrintName then
			local qualtier = wept.QualityTier
			local text = branch and branch.PrintName or wept.PrintName
			wept.PrintName = text .. (qualtier > 0 and " +" .. qualtier or "")
		end

		if wept.PrimaryRemantleModifier then
			local primod = wept.PrimaryRemantleModifier

			ApplyWeaponModifier(self.WeaponQualityModifiers[primod.Modifier], wept, {Amount = primod.Amount, QualityStart = 1}, remantledescs, i)
		else
			if wept.Primary and wept.Primary.Damage then
				wept.Primary.Damage = wept.Primary.Damage * quality[2]
			end
			if wept.MeleeDamage then
				wept.MeleeDamage = wept.MeleeDamage * quality[2]
			end

			table.insert(remantledescs, "+" .. ((quality[2]-1) * 100) .. "% " .. "Урона")
		end
		if wept.AltRemantleModifiers then
			for modifier, datatab in pairs(wept.AltRemantleModifiers) do
				if modifier == "BaseClass" then continue end -- ???

				ApplyWeaponModifier(self.WeaponQualityModifiers[modifier], wept, datatab, remantledescs, i)
			end
		end
	elseif wept.PrintName then
		wept.PrintName = (branch and branch.PrintName or wept.PrintName)
	end

	if branch and branch.BranchFunc then
		if (branch.No ~= 0) and wept.AllowQualityWeapons then table.insert(remantledescs, 1, branch.Desc) end
		branch.BranchFunc(wept)
	end

	local newclass = self:GetWeaponClassOfQuality(classname, i, branch and branch.No)
	if CLIENT then
		CreateQualityKillicon(branch and branch.Killicon or classname, newclass, i, branch and branch.No, branch and branch.Colors)
	end

	local regscriptent = function(class, cbk, prefix)
		local newent = self:GetWeaponClassOfQuality(class, i)
		local afent = scripted_ents.Get((prefix or "") .. class)
		if cbk then cbk(afent, newent) end

		afent.ClassName = nil
		scripted_ents.Register(afent, (prefix or "") .. newent)
		return newent
	end

	if wept.DeployClass then
		wept.DeployClass = regscriptent(wept.DeployClass, function(ent, newcl)
			if CLIENT then
				CreateQualityKillicon(wept.DeployClass, newcl, i)
			end

			if self.DeployableInfo[wept.DeployClass] then
				if quality then
					self:AddDeployableInfo(newcl, quality[1].." "..self.DeployableInfo[wept.DeployClass].Name, "")
				else
					self:AddDeployableInfo(newcl, self.DeployableInfo[wept.DeployClass].Name, "")
				end
			end
		end)

		if wept.AmmoIfHas then
			local newammo = self:GetWeaponClassOfQuality(wept.Primary.Ammo, i)

			game.AddAmmoType({name = newammo})
			wept.Primary.Ammo = newammo
		end

		if wept.Channel then
			table.insert(self.ChannelsToClass[wept.Channel], wept.DeployClass)
		end
	end

	if wept.GhostStatus then wept.GhostStatus = regscriptent(wept.GhostStatus, function(ent)
		local ghostent = self:GetWeaponClassOfQuality(ent.GhostEntity, i)
		ent.GhostEntity = ghostent
		ent.GhostWeapon = newclass
	end, "status_") end

	wept.ClassName = nil
	weapons.Register(wept, newclass)

	--This is a place we can override stuff properly, atleast for Primary.Automatic
	local tbl = weapons.GetStored(newclass)
	if tbl then
		tbl.Primary.Automatic = wept.Primary.Automatic
	end
end

function GM:CreateWeaponQualities()
	local allweapons = weapons.GetList()
	local classname

	for _, t in ipairs(allweapons) do
		classname = t.ClassName

		if string.sub(classname, 1, 14) == "weapon_zs_base" then
			continue
		end

		local wept = weapons.Get(classname)

		if wept and wept.AllowQualityWeapons then
			local orig = weapons.GetStored(classname)
			orig.RemantleDescs = {}
			orig.RemantleDescs[0] = {}

			if orig.Branches then
				for no, _ in pairs(orig.Branches) do
					orig.RemantleDescs[no] = {}
				end
			end

			for i = 0, #self.WeaponQualities do
				local quality = self.WeaponQualities[i]

				if i > 0 then
					self:CreateWeaponOfQuality(i, orig, quality, classname)
				end

				if orig.Branches then
					for no, tbl in pairs(orig.Branches) do
						local ntbl = table.Copy(tbl)
						ntbl.No = no

						self:CreateWeaponOfQuality(i, orig, i == 0 and {"qual_standart", 1, "qual_modified"} or quality, classname, ntbl)
					end
				end
			end
		end
	end
end

function GM:GetWeaponClassOfQuality(classname, quality, branch)
	return classname.."_"..string.char(113 + (branch or 0))..quality
end

function GM:GetDismantleScrap(wtbl, invitem)
	local itier = wtbl.Tier
	local quatier = wtbl.QualityTier ~= 0 and wtbl.QualityTier or invitem and wtbl.QualityTier
	local invitemdata = invitem and self.ZSInventoryItemData[self:GetBaseItemName(invitem)]

	local dismantlediv = invitem and 2.5 or 1
	local baseval = invitem and GAMEMODE.ScrapValsTrinkets[itier or 1] or GAMEMODE.ScrapVals[itier or 1]

	local qu = (quatier or 0) + 1
	local basicvalue = baseval * GAMEMODE.DismantleMultipliers[qu] - ((quatier or itier) and 0 or 1)

	local basevalue = baseval * self.DismantleMultipliers[1]
	local scrapmultiplier = (basevalue / dismantlediv) * (invitem and invitemdata.ScrapMultiplier or 1) - (basevalue / dismantlediv)

	return math.floor(basicvalue / (wtbl.DismantleDiv or dismantlediv) * (invitem and invitemdata.ScrapMultiplier or 1) - (scrapmultiplier))
end

function GM:GetUpgradeScrap(wtbl, qualitychoice)
	local itier = wtbl.Tier

	return math.ceil(self.ScrapVals[itier or 1] * qualitychoice)
end

function GM:GetUpgradeScrapTrinket(wtbl, qualitychoice, multiplier)
	local itier = wtbl.Tier

	return math.ceil((self.ScrapVals[itier or 1] * (qualitychoice + 1)) * 0.25) * (multiplier or 1)
end

function GM:PointsToScrap(points)
	return points / (70 / 32)
end

function GM:ScrapToPoints(scrap)
	return scrap * (70 / 32)
end