GM.Skills = {}
GM.SkillModifiers = {}
GM.SkillFunctions = {}
GM.SkillModifierFunctions = {}

function GM:AddSkill(id, name, description, x, y, connections, tree)
	local skill = {Connections = table.ToAssoc(connections or {})}

	if CLIENT then
		skill.x = x
		skill.y = y

		-- TODO: Dynamic skill descriptions based on modifiers on the skill.

		skill.Description = description
	end

	if #name == 0 then
		name = "Skill "..id
		skill.Disabled = true
	end

	skill.Name = name
	skill.Tree = tree

	self.Skills[id] = skill

	return skill
end

local qualitytier
function GM:AddTrinket(swepaffix, weles, upgradable, status)
	local skill = {Connections = {}}

	local name = "t_" .. swepaffix
	local description = "d_" .. swepaffix

	skill.Name = name
	skill.Trinket = swepaffix
	skill.Status = status
	skill.Upgradable = upgradable
    skill.QualityTier = qualitytier

	local datatab = {PrintName = name, DroppedEles = weles, Tier = 2, Description = description, Icon = "trinket_" .. self:GetBaseItemName(swepaffix), Upgradable = upgradable, QualityTier = qualitytier or 0}

	self.ZSInventoryItemData["trinket_" .. swepaffix] = datatab
	self.Skills[#self.Skills + 1] = skill

	local skills = #self.Skills

	if not qualitytier and skill.Upgradable then
		for i = 1, 3 do
			qualitytier = i
			self:AddTrinket(swepaffix .. "_q" .. i, weles, upgradable)
		end
		qualitytier = nil
	end

	return skills, self.ZSInventoryItemData["trinket_" .. swepaffix]
end

-- I'll leave this here, but I don't think it's needed.
function GM:GetTrinketSkillID(trinketname)
	for skillid, skill in pairs(GM.Skills) do
		if skill.Trinket and skill.Trinket == trinketname then
			return skillid
		end
	end
end

function GM:AddSkillModifier(skillid, modifier, amount)
	if self.Skills[skillid].Trinket and self.Skills[skillid].Upgradable then
        for i = 1, 3 do
            self.SkillModifiers[skillid + i] = self.SkillModifiers[skillid + i] or {}
            self.SkillModifiers[skillid + i][modifier] = (self.SkillModifiers[skillid + i][modifier] or 0) + amount
        end
    end

    self.SkillModifiers[skillid] = self.SkillModifiers[skillid] or {}
    self.SkillModifiers[skillid][modifier] = (self.SkillModifiers[skillid][modifier] or 0) + amount
end

function GM:AddSkillModifierQuality(skillid, tier, modifier, amount)
    skillid = skillid + tier
	
    self.SkillModifiers[skillid] = self.SkillModifiers[skillid] or {}
    self.SkillModifiers[skillid][modifier] = (self.SkillModifiers[skillid][modifier] or 0) + amount
end

function GM:AddSkillFunction(skillid, func)
	self.SkillFunctions[skillid] = self.SkillFunctions[skillid] or {}
	table.insert(self.SkillFunctions[skillid], func)
end

function GM:SetSkillModifierFunction(modid, func)
	self.SkillModifierFunctions[modid] = func
end

function GM:MkGenericMod(modifiername)
	return function(pl, amount) pl[modifiername] = math.Clamp(amount + 1.0, 0.0, 1000.0) end
end

function GM:MkGenericModBoolean(modifiername)
	return function(pl, amount) pl[modifiername] = amount == 1 and true or false end
end

-- These are used for position on the screen
TREE_HEALTHTREE = 1
TREE_SPEEDTREE = 2
TREE_SUPPORTTREE = 3
TREE_BUILDINGTREE = 4
TREE_MELEETREE = 5
TREE_GUNTREE = 6
TREE_BLOODARMORTREE = 7
TREE_TECHNICIANTREE = 8

SKILL_NONE = 0

SKILL_SPEED1 = 1
SKILL_SPEED2 = 2
SKILL_SPEED3 = 3
SKILL_SPEED4 = 4
SKILL_SPEED5 = 5
SKILL_STOIC1 = 6
SKILL_STOIC2 = 7
SKILL_STOIC3 = 8
SKILL_STOIC4 = 9
SKILL_STOIC5 = 10
SKILL_SURGEON1 = 11
SKILL_SURGEON2 = 12
SKILL_SURGEON3 = 13
SKILL_HANDY1 = 14
SKILL_HANDY2 = 15
SKILL_HANDY3 = 16
SKILL_MOTIONI = 17
SKILL_BACKPEDDLER = 18
SKILL_PHASER = 19
SKILL_LOADEDHULL = 20
SKILL_REINFORCEDHULL = 21
SKILL_REINFORCEDBLADES = 22
SKILL_AVIATOR = 23
SKILL_U_BLASTTURRET = 24
SKILL_TWINVOLLEY = 26
SKILL_TURRETOVERLOAD = 27
SKILL_LIGHTCONSTRUCT = 34
SKILL_QUICKDRAW = 39
SKILL_QUICKRELOAD = 41
SKILL_VITALITY2 = 45
SKILL_REACHEM = 46
SKILL_BARRICADEEXPERT = 77
SKILL_BATTLER1 = 48
SKILL_BATTLER2 = 49
SKILL_BATTLER3 = 50
SKILL_BATTLER4 = 51
SKILL_HEAVYSTRIKES = 53
SKILL_COMBOKNUCKLE = 62
SKILL_SCAVENGER = 67
SKILL_U_ZAPPER_ARC = 68
SKILL_ULTRANIMBLE = 70
SKILL_U_MEDICCLOUD = 72
SKILL_SMARTTARGETING = 73
SKILL_REGENERATOR = 80
SKILL_SAFEFALL = 83
SKILL_VITALITY3 = 84
SKILL_TANKER = 86
SKILL_U_CORRUPTEDFRAGMENT = 87
SKILL_WORTHINESS3 = 78
SKILL_WORTHINESS4 = 88
SKILL_WORTHINESS1 = 42
SKILL_WORTHINESS2 = 43
SKILL_U_DRONE = 28
SKILL_LIGHTHAMMER = 29
SKILL_TURRETLOCK = 25
SKILL_HAMMERDISCIPLINE = 30
SKILL_FIELDAMP = 31
SKILL_TRIGGER_DISCIPLINE1 = 37
SKILL_LASTSTAND = 54
SKILL_NAILSAMMUNITION = 55
SKILL_D_CLUMSY = 58
SKILL_CHEAPKNUCKLE = 59
SKILL_CRITICALKNUCKLE = 60
SKILL_VITALITY1 = 66
SKILL_TAUT = 69
SKILL_PREPAREDNESS = 82
SKILL_FORAGER = 89
SKILL_LANKY = 90
SKILL_BLASTPROOF = 92
SKILL_MASTERCHEF = 93
SKILL_SUGARRUSH = 94
SKILL_U_STRENGTHSHOT = 95
SKILL_LIGHTWEIGHT = 97
SKILL_AGILEI = 98
SKILL_SOFTDET = 100
SKILL_U_ROCKETTURRET = 104
SKILL_RECLAIMSOL = 105
SKILL_ORPHICFOCUS = 106
SKILL_IRONBLOOD = 107
SKILL_HAEMOSTASIS = 109
SKILL_AGILEII = 111
SKILL_AGILEIII = 112
SKILL_BIOLOGYI = 113
SKILL_BIOLOGYII = 114
SKILL_BIOLOGYIII = 115
SKILL_FOCUSI = 116
SKILL_SURESTEP = 119
SKILL_INTREPID = 120
SKILL_SCOURER = 123
SKILL_LANKYII = 124
SKILL_DISPERSION = 126
SKILL_MOTIONII = 127
SKILL_MOTIONIII = 128
SKILL_BRASH = 130
SKILL_INSTRUMENTS = 135
SKILL_HANDY4 = 136
SKILL_HANDY5 = 137
SKILL_TECHNICIAN = 138
SKILL_BIOLOGYIV = 139
SKILL_SURGEONIV = 140
SKILL_PHASERII = 142
SKILL_EXTENDEDMAG = 143
SKILL_LEGFOCUS = 144
SKILL_ROBUST = 145
SKILL_TRUEWOOISM = 147
SKILL_UNBOUND = 148
SKILL_SANGUINE1 = 149
SKILL_SANGUINE2 = 150
SKILL_SANGUINE3 = 151
SKILL_SANGUINE4 = 152
SKILL_SANGUINE5 = 153
SKILL_BLOODGAINER1 = 154
SKILL_BLOODGAINER2 = 155
SKILL_BLOODGAINER3 = 156
SKILL_BLOODGAINER4 = 157
SKILL_BLOODGAINER5 = 158
SKILL_BLOODSTART = 159
SKILL_SUPASM = 160
SKILL_HAMMERDOOR = 161
SKILL_COMPOSURE = 162
SKILL_MASTER1 = 163
SKILL_MASTER2 = 164
SKILL_MASTER3 = 165
SKILL_MASTER4 = 166
SKILL_MASTER5 = 167
SKILL_HAMMERDISCIPLINE2 = 168
SKILL_TRIGGER_DISCIPLINE2 = 169
SKILL_FOCUSII = 170
SKILL_PHASENAILS = 173
SKILL_STRONGMUSCLE = 174
SKILL_COMPACTNAILS = 175
SKILL_CIRCULATION = 176
SKILL_VAMPIRISM = 177
SKILL_ANTIGEN = 179
SKILL_IMPATIENCE = 180
SKILL_U_MANHACK_SAW = 181
SKILL_TELEPORTER = 182
SKILL_REFINERAIM = 183
SKILL_PROJGUIDE = 184
SKILL_PROJWEI = 185

SKILLMOD_HEALTH = 1
SKILLMOD_SPEED = 2
SKILLMOD_WORTH = 3
SKILLMOD_BLOODARMOR = 4
SKILLMOD_FALLDAMAGE_RECOVERY_MUL = 5
SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL = 6
SKILLMOD_FOODRECOVERY_MUL = 7
SKILLMOD_FOODEATTIME_MUL = 8
SKILLMOD_JUMPPOWER_MUL = 9
SKILLMOD_RELOADSPEED_MUL = 11
SKILLMOD_DEPLOYSPEED_MUL = 12
SKILLMOD_UNARMED_DAMAGE_MUL = 13
SKILLMOD_UNARMED_SWING_DELAY_MUL = 14
SKILLMOD_MELEE_DAMAGE_MUL = 15
SKILLMOD_HAMMER_SWING_DELAY_MUL = 16
SKILLMOD_CONTROLLABLE_SPEED_MUL = 17
SKILLMOD_CONTROLLABLE_HANDLING_MUL = 18
SKILLMOD_CONTROLLABLE_HEALTH_MUL = 19
SKILLMOD_MANHACK_DAMAGE_MUL = 20
SKILLMOD_BARRICADE_PHASE_SPEED_MUL = 21
SKILLMOD_MEDKIT_COOLDOWN_MUL = 22
SKILLMOD_MEDKIT_EFFECTIVENESS_MUL = 23
SKILLMOD_REPAIRRATE_MUL = 24
SKILLMOD_TURRET_HEALTH_MUL = 25
SKILLMOD_TURRET_SCANSPEED_MUL = 26
SKILLMOD_TURRET_SCANANGLE_MUL = 27
SKILLMOD_FALLDAMAGE_THRESHOLD_MUL = 28
SKILLMOD_MELEE_KNOCKBACK_MUL = 29
SKILLMOD_SELF_DAMAGE_MUL = 30
SKILLMOD_AIMSPREAD_MUL = 31
SKILLMOD_POINTS = 32
SKILLMOD_POINT_MULTIPLIER = 33
SKILLMOD_FALLDAMAGE_DAMAGE_MUL = 34
SKILLMOD_MANHACK_HEALTH_MUL = 35
SKILLMOD_DEPLOYABLE_HEALTH_MUL = 36
SKILLMOD_DEPLOYABLE_PACKTIME_MUL = 37
SKILLMOD_DRONE_SPEED_MUL = 38
SKILLMOD_DRONE_CARRYMASS_MUL = 39
SKILLMOD_MEDGUN_FIRE_DELAY_MUL = 40
SKILLMOD_RESUPPLY_DELAY_MUL = 41
SKILLMOD_FIELD_RANGE_MUL = 42
SKILLMOD_FIELD_DELAY_MUL = 43
SKILLMOD_DRONE_GUN_RANGE_MUL = 44
SKILLMOD_HEALING_RECEIVED = 45
SKILLMOD_RELOADSPEED_PISTOL_MUL = 46
SKILLMOD_RELOADSPEED_SMG_MUL = 47
SKILLMOD_RELOADSPEED_ASSAULT_MUL = 48
SKILLMOD_RELOADSPEED_SHELL_MUL = 49
SKILLMOD_RELOADSPEED_RIFLE_MUL = 50
SKILLMOD_RELOADSPEED_PULSE_MUL = 52
SKILLMOD_RELOADSPEED_EXP_MUL = 53
SKILLMOD_MELEE_ATTACKER_DMG_REFLECT = 54
SKILLMOD_PULSE_WEAPON_SLOW_MUL = 55
SKILLMOD_MELEE_DAMAGE_TAKEN_MUL = 56
SKILLMOD_POISON_DAMAGE_TAKEN_MUL = 57
SKILLMOD_BLEED_DAMAGE_TAKEN_MUL = 58
SKILLMOD_MELEE_SWING_DELAY_MUL = 59
SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL = 60
SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL = 61
SKILLMOD_MELEE_POWERATTACK_MUL = 62
SKILLMOD_KNOCKDOWN_RECOVERY_MUL = 63
SKILLMOD_MELEE_RANGE_MUL = 64
SKILLMOD_SLOW_EFF_TAKEN_MUL = 65
SKILLMOD_EXP_DAMAGE_TAKEN_MUL = 66
SKILLMOD_FIRE_DAMAGE_TAKEN_MUL = 67
SKILLMOD_PROP_CARRY_CAPACITY_MUL = 68
SKILLMOD_PROP_THROW_STRENGTH_MUL = 69
SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL = 70
SKILLMOD_VISION_ALTER_DURATION_MUL = 71
SKILLMOD_DIMVISION_EFF_MUL = 72
SKILLMOD_PROP_CARRY_SLOW_MUL = 73
SKILLMOD_BLEED_SPEED_MUL = 74
SKILLMOD_MELEE_LEG_DAMAGE_ADD = 75
SKILLMOD_SIGIL_TELEPORT_MUL = 76
SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT = 77
SKILLMOD_POISON_SPEED_MUL = 78
SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL = 79
SKILLMOD_EXP_DAMAGE_RADIUS = 80
SKILLMOD_MEDGUN_RELOAD_SPEED_MUL = 81
SKILLMOD_WEAPON_WEIGHT_SLOW_MUL = 82
SKILLMOD_FRIGHT_DURATION_MUL = 83
SKILLMOD_IRONSIGHT_EFF_MUL = 84
SKILLMOD_BLOODARMOR_DMG_REDUCTION = 85
SKILLMOD_BLOODARMOR_MUL = 86
SKILLMOD_LOW_HEALTH_SLOW_MUL = 88
SKILLMOD_PROJ_SPEED = 89
SKILLMOD_SCRAP_START = 90
SKILLMOD_ENDWAVE_POINTS = 91
SKILLMOD_ARSENAL_DISCOUNT = 92
SKILLMOD_CLOUD_RADIUS = 93
SKILLMOD_CLOUD_TIME = 94
SKILLMOD_PROJECTILE_DAMAGE_MUL = 95
SKILLMOD_EXP_DAMAGE_MUL = 96
SKILLMOD_TURRET_RANGE_MUL = 97
SKILLMOD_AIM_SHAKE_MUL = 98
SKILLMOD_MEDDART_EFFECTIVENESS_MUL = 99
SKILLMOD_FIREWEAPON_DAMAGE_MUL = 100
SKILLMOD_NAILRANGE_MUL = 101
SKILLMOD_VAMPIRISMSPEED_MUL = 102
SKILLMOD_NAILPLACE_MUL = 103
SKILLMOD_BLEAKSOUL = 104
SKILLMOD_REGENIMPLANT = 105
SKILLMOD_BIOCLEANSER = 106
SKILLMOD_REACTIVEFLASHER = 107
SKILLMOD_TARGETLOCUS = 108
SKILLMOD_IMPULSEINFUSER = 109

local GOOD = "^"..COLORID_GREEN
local BAD = "^"..COLORID_RED
-- Blood Armor Tree
GM:AddSkill(SKILL_VAMPIRISM, "Вампиризм", GOOD.."Часть урона в ближнем бою по зомби конвертируется в статусный эффект Вампиризм\nДанный статусный эффект восполняет кровавую броню\nКровавая броня поглощает 50% урона",
																0,			-4,					{SKILL_NONE, SKILL_BLOODSTART, SKILL_SANGUINE1, SKILL_BLOODGAINER1}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODSTART, "Густокровный", GOOD.."Даётся ваше максимальное значение кровавой брони при спавне",
																0,			-2.05,					{SKILL_CIRCULATION}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_CIRCULATION, "Циркуляция", GOOD.."Создаёт 20 кровавой брони если ваше здоровье ниже 50%\n"..BAD.."-5 максимальной кровавой брони\nПерезаряжается каждую минуту",
																0,			-0.5,					{SKILL_SANGUINE3, SKILL_BLOODGAINER3, SKILL_ANTIGEN}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_SANGUINE1, "Оптимальность I", GOOD.."+2 максимальной кровавой брони\n"..BAD.."-2 максимального здоровья",
																-2,			-3,					{SKILL_SANGUINE2}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_SANGUINE2, "Оптимальность II", GOOD.."+4 максимальной кровавой брони\n"..BAD.."-4 максимального здоровья",
																-2,			-1.25,					{SKILL_SANGUINE3}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_SANGUINE3, "Оптимальность III", GOOD.."+6 максимальной кровавой брони\n"..BAD.."-6 максимального здоровья",
																-2,			0.5,					{SKILL_SANGUINE4, SKILL_HAEMOSTASIS}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_SANGUINE4, "Оптимальность IV", GOOD.."+8 максимальной кровавой брони\n"..BAD.."-8 максимального здоровья",
																-3,			2.25,					{SKILL_SANGUINE5}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_SANGUINE5, "Оптимальность V", GOOD.."+10 максимальной кровавой брони\n"..BAD.."-10 максимального здоровья",
																-3,			4,					{}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_IRONBLOOD, "Стальная кровь", GOOD.."+25% к поглощении кровавой брони\n"..BAD.."-50% максимальной кровавой брони\n"..BAD.."-25% к скорости Вампиризма",
																0,        	3.5,					{}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODGAINER1, "Кровожадный I", GOOD.."+2% к скорости Вампиризма",
																2,			-3,					{SKILL_BLOODGAINER2}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODGAINER2, "Кровожадный II", GOOD.."+4% к скорости Вампиризма",
																2,			-1.25,					{SKILL_BLOODGAINER3}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODGAINER3, "Кровожадный III", GOOD.."+6% к скорости Вампиризма",
																2,			0.5,					{SKILL_BLOODGAINER4, SKILL_IMPATIENCE}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODGAINER4, "Кровожадный IV", GOOD.."+8% к скорости Вампиризма",
																3,			2.25,					{SKILL_BLOODGAINER5}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_BLOODGAINER5, "Кровожадный V", GOOD.."+10% к скорости Вампиризма",
																3,			4,					{}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_HAEMOSTASIS, "Гемостаз", GOOD.."-50% времени статусным эффектам от зомби, пока у вас есть хотя бы 2 кровавой брони\n"..BAD.."Вы потеряете 2 кровавой брони при использовании\n"..BAD.."-10% к поглощении кровавой брони\n",
																-1,			2.25,					{SKILL_IRONBLOOD}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_ANTIGEN, "Антиген", GOOD.."+5% к поглощении кровавой брони\n"..BAD.."-3 максимального здоровья",
																0,        	1.05,                    {SKILL_HAEMOSTASIS, SKILL_IMPATIENCE}, TREE_BLOODARMORTREE)
GM:AddSkill(SKILL_IMPATIENCE, "Паника", GOOD.."Увеличивает скорость Вампиризма в 1.5 раза если ваше здоровье ниже 50%\n"..BAD.."-30% к скорости Вампиризма в остальное время",
																1,          2.25,                    {SKILL_IRONBLOOD}, TREE_BLOODARMORTREE)
-- Health Tree
GM:AddSkill(SKILL_STOIC1, "Стойкий I", GOOD.."+1 максимального здоровья\n"..BAD.."-0.75 скорости передвижения",
																0,			-3.5,					{SKILL_NONE, SKILL_STOIC2, SKILL_PREPAREDNESS, SKILL_VITALITY1}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC2, "Стойкий II", GOOD.."+2 максимального здоровья\n"..BAD.."-1.5 скорости передвижения",
																0,			-2,					{SKILL_STOIC3}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC3, "Стойкий III", GOOD.."+4 максимального здоровья\n"..BAD.."-3 скорости передвижения",
																0,			-0.5,					{SKILL_STOIC4}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC4, "Стойкий IV", GOOD.."+6 максимального здоровья\n"..BAD.."-4.5 скорости передвижения",
																0,			1,					{SKILL_STOIC5}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_STOIC5, "Стойкий V", GOOD.."+7 максимального здоровья\n"..BAD.."-5.25 скорости передвижения",
																0,			2.5,					{SKILL_TANKER}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_PREPAREDNESS, "Подготовленность", GOOD.."Вашим стартовым предметом может быть случайная еда",
																-2.25,			-2,					{SKILL_SUGARRUSH}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_REGENERATOR, "Регенератор", GOOD.."Восстанавливает 1 здоровье каждые 6 секунд, когда уровень здоровья ниже 60%\n"..BAD.."-6 максимального здоровья",
																-2,			2.5,					{SKILL_STOIC4}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY1, "Живость I", GOOD.."+1 максимального здоровья",
																2.25,			-2,					{SKILL_VITALITY2}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY2, "Живость II", GOOD.."+1 максимального здоровья",
																3.25,			-0.5,					{SKILL_VITALITY3}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_VITALITY3, "Живость III", GOOD.."+1 максимального здоровья",
																3.75,			1,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_TANKER, "Танк", GOOD.."+20 максимального здоровья\n"..BAD.."-15 скорости передвижения",
																0,			4,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_FORAGER, "Сытый", GOOD.."25% шанс забрать еду из ящика амуниции\n"..BAD.."+10% задержка пополнения запасов",
																-3.75,			1,					{}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_SUGARRUSH, "Сахарная Лихорадка", GOOD.."Вы получаете статусный эффект 'Регенерация' при употреблении еды\n".."Количество получаемого статусного эффекта будет зависить от еды\n"..BAD.."Вы больше не будете получать лечение здоровье от еды",
																-3.25,			-0.5,					{SKILL_FORAGER}, TREE_HEALTHTREE)
GM:AddSkill(SKILL_COMPOSURE, "Самообладание", GOOD.."Восстанавливает 35 здоровья в конце каждой волны\n".."Избыток перейдёт в статусный эффект 'Регенерация'\n"..BAD.."-5 максимального здоровья",
																2,			2.5,					{SKILL_STOIC4}, TREE_HEALTHTREE)
-- Speed Tree
GM:AddSkill(SKILL_SPEED1, "Скорость I", GOOD.."+0.75 скорости передвижения\n"..BAD.."-1 максимального здоровья",
																2,			-3.5,					{SKILL_NONE, SKILL_SPEED2}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED2, "Скорость II", GOOD.."+1.5 скорости передвижения\n"..BAD.."-2 максимального здоровья",
																4,			-3.5,					{SKILL_SPEED3}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED3, "Скорость III", GOOD.."+3 скорости передвижения\n"..BAD.."-4 максимального здоровья",
																4,			-1.5,					{SKILL_SPEED4, SKILL_MOTIONI}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED4, "Скорость IV", GOOD.."+4.5 скорости передвижения\n"..BAD.."-6 максимального здоровья",
																4,			0.5,					{SKILL_SPEED5, SKILL_UNBOUND}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SPEED5, "Скорость V", GOOD.."+5.25 скорости передвижения\n"..BAD.."-7 максимального здоровья",
																4,			2.5,					{SKILL_ULTRANIMBLE}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEI, "Гибкость I", GOOD.."+2% к прыжку\n"..BAD.."-1 скорости передвижения",
																-4,			-3.5,					{SKILL_NONE, SKILL_AGILEII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEII, "Гибкость II", GOOD.."+3% к прыжку\n"..BAD.."-1.5 скорости передвижения",
																-4,			-1.5,					{SKILL_AGILEIII, SKILL_U_CORRUPTEDFRAGMENT}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_AGILEIII, "Гибкость III", GOOD.."+5% к прыжку\n"..BAD.."-2.5 скорости передвижения",
																-4,			0.5,					{SKILL_SURESTEP, SKILL_SAFEFALL}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SAFEFALL, "Безопасное Падение", GOOD.."-40% получаемого урона от падения\n"..GOOD.."+50% более быстрое восстановление после нокдауна при падении\n"..BAD.."+40% замедления от приземления или урона от падения",
																-5,			2.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONI, "Движение I", GOOD.."+0.75 скорости передвижения",
																2,			-1.5,					{SKILL_MOTIONII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONII, "Движение II", GOOD.."+0.75 скорости передвижения",
																1,			-0.5,					{SKILL_MOTIONIII, SKILL_PHASER, SKILL_UNBOUND}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_MOTIONIII, "Движение III", GOOD.."+0.75 скорости передвижения",
																0,			-1.5,					{SKILL_TELEPORTER}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_TELEPORTER, "Настойчивость", GOOD.."Удары зомби по вам не сбрасывают прогресс телепортации к маяку\n"..BAD.."+55% времени телепортации маяков",
																-1,			-0.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_BACKPEDDLER, "Задний Ход", GOOD.."Вы двигаетесь с одинаковой скоростью во всех направлениях\n"..BAD.."-5 скорости передвижения\n"..BAD.."Вы получаете урон ногой при любом ударе в ближнем бою",
																3,			3,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_PHASER, "Фазирование I", GOOD.."-5% времени телепортации маяков\n"..GOOD.."+5% скорости передвижения по фазе баррикад",
																0,			0.5,					{SKILL_PHASERII}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_PHASERII, "Фазирование II", GOOD.."+75% скорости передвижения по фазе баррикад\n"..BAD.."+100% времени телепортации маяков",
																0,			2.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_U_CORRUPTEDFRAGMENT, "Чертеж: Кусок Маяка Зомби", GOOD.."Разблокирует покупку Кусочек Маяка Зомби\nТелепортируется на заражённые маяки вместо обычных",
																-2,			0.5,					{SKILL_WORTHINESS3, SKILL_PHASER}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_ULTRANIMBLE, "Ультра Ловкость", GOOD.."+15 скорости передвижения\n"..BAD.."-20 максимального здоровья",
																4,			4.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_WORTHINESS3, "Аккуратность III", GOOD.."+5 поинтов в начальном складе\n"..BAD.."-3 поинтов в начале",
																-2,			2.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_SURESTEP, "Уверенный Шаг", GOOD.."-30% эффективность замедлений\n"..BAD.."-4 скорости передвижения",
																-3,			3.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_INTREPID, "Бесстрашный", GOOD.."-35% низкая интенсивность замедления здоровья\n"..BAD.."-4 скорости передвижения",
																1,			3.5,					{}, TREE_SPEEDTREE)
GM:AddSkill(SKILL_UNBOUND, "Несвязанный", GOOD.."-60% уменьшение задержки при смене оружия, влияющей на скорость передвижения\n"..BAD.."-4 скорости передвижения",
																2,		0.5,					{SKILL_INTREPID, SKILL_BACKPEDDLER}, TREE_SPEEDTREE)
-- Medic Tree
GM:AddSkill(SKILL_SURGEON1, "Хирург I", GOOD.."-8% времени восстановления аптечки",
																-1.5,			-3,					{SKILL_NONE, SKILL_SURGEON2}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEON2, "Хирург II", GOOD.."-9% времени восстановления аптечки",
																-2,			-1,					{SKILL_SURGEON3}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEON3, "Хирург III", GOOD.."-10% времени восстановления аптечки",
																-2,			1,					{SKILL_SURGEONIV}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SURGEONIV, "Хирург IV", GOOD.."-11% времени восстановления аптечки",
																-1.5,			3,				{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_SMARTTARGETING, "Умное Прицеливание", GOOD.."Дротики из медицинского оружия захватывают цель щелчком ПКМ\n"..BAD.."+60% задержка срабатывания медицинского оружия\n"..BAD.."-30% эффективность лечения медицинскими дротиками",
																0,			1,					{SKILL_WORTHINESS4}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYI, "Биолог I", GOOD.."+8% эффективности лечебного инструмента",
																1.5, 			-3,				{SKILL_NONE, SKILL_BIOLOGYII}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYII, "Биолог II", GOOD.."+9% эффективности лечебного инструмента",
																2,			-1,					{SKILL_BIOLOGYIII}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYIII, "Биолог III", GOOD.."+10% эффективности лечебного инструмента",
																2,			1,					{SKILL_BIOLOGYIV}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_BIOLOGYIV, "Биолог IV", GOOD.."+11% эффективности лечебного инструмента",
																1.5,			3,			{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_RECLAIMSOL, "Восстановление", GOOD.."60% потраченных впустую дротиков возвращаются вам\n"..BAD.."+125% задержка срабатывания медицинского оружия\n"..BAD.."-20% скорости перезарядки медицинского оружия\n"..BAD.."Дротики не дают бонус к скорости при лечении игроков",
																0,			-1,					{SKILL_SMARTTARGETING}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_WORTHINESS4, "Аккуратность IV", GOOD.."+5 поинтов в начальном складе\n"..BAD.."-3 поинтов в начале",
																0,			3,					{}, TREE_SUPPORTTREE)
GM:AddSkill(SKILL_DISPERSION, "Дисперсия", GOOD.."+15% радиус облачной бомбы\n"..GOOD.."+10% времени действия облачной бомбы",
																0,			-3,					{SKILL_NONE, SKILL_RECLAIMSOL}, TREE_SUPPORTTREE)

-- Barricade Tree
GM:AddSkill(SKILL_HANDY1, "Механик I", GOOD.."+4% к ремонту",
																1.65,			-5,					{SKILL_NONE, SKILL_HANDY2}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY2, "Механик II", GOOD.."+5% к ремонту",
																1.5,			-3,					{SKILL_HANDY3, SKILL_HAMMERDOOR}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY3, "Механик III", GOOD.."+6% к ремонту",
																2,				-1,					{SKILL_HANDY4, SKILL_HAMMERDOOR}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY4, "Механик IV", GOOD.."+7% к ремонту",
																2.5,			1,					{SKILL_HANDY5}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HANDY5, "Механик V", GOOD.."+8% к ремонту",
																2.5,			3,					{SKILL_HAMMERDISCIPLINE2, SKILL_NAILSAMMUNITION}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_BARRICADEEXPERT, "Подкрепление", GOOD.."Предметы, пораженные молотком за последние 2 секунды, получают на 8% меньше урона\n"..GOOD.."Набирайте очки за защищенные предметы\n"..BAD.."+30% задержка взмаха Молотка",
																-0.75,			5.5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_TAUT, "Крепкий хват", GOOD.."Удары не заставляют вас ронять предметы\n"..BAD.."+40% замедления при переноске предметов",
																-0.85,			-0.5,					{SKILL_COMPACTNAILS, SKILL_HAMMERDOOR}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_NAILSAMMUNITION, "Обеспеченность", GOOD.."25% шанс забрать 3 гвоздя из ящика амуниции\n"..BAD.."+15% задержка пополнения запасов",
																2,				5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HAMMERDOOR, 	"Дверолом", GOOD.."Наносит дополнительные 400 урона молотком по дверям\n"..BAD.."-5% урона оружия ближнего боя",
																0.85,			-0.5,					{SKILL_STRONGMUSCLE, SKILL_TAUT}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_LIGHTHAMMER, "Умелый Плотник", GOOD.."+10 скорости передвижения с предметами которые умеют чинить\n"..BAD.."-5% урона оружия ближнего боя",
																-2,				5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_MASTER1, "Мастер I", GOOD.."+4% к дальности чинящих инструментов",
																-1.65,			-5,					{SKILL_NONE, SKILL_MASTER2}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_MASTER2, "Мастер II", GOOD.."+5% к дальности чинящих инструментов",
																-1.5,			-3,					{SKILL_MASTER3, SKILL_TAUT}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_MASTER3, "Мастер III", GOOD.."+6% к дальности чинящих инструментов",
																-2,			-1,					{SKILL_MASTER4, SKILL_TAUT}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_MASTER4, "Мастер IV", GOOD.."+7% к дальности чинящих инструментов",
																-2.5,			1,					{SKILL_MASTER5, SKILL_COMPACTNAILS}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_MASTER5, "Мастер V", GOOD.."+8% к дальности чинящих инструментов",
																-2.5,			3,					{SKILL_HAMMERDISCIPLINE, SKILL_LIGHTHAMMER}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HAMMERDISCIPLINE, "Плотник I", GOOD.."-10% задержка взмаха Молотка",
																-1,			3.5,					{SKILL_BARRICADEEXPERT}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_HAMMERDISCIPLINE2, "Плотник II", GOOD.."-10% задержка взмаха Молотка",
																1,			3.5,					{SKILL_PHASENAILS, SKILL_STRONGMUSCLE}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_PHASENAILS, "Призрачный молоток", GOOD.."Позволяет ставить гвозди в фазировании\n"..BAD.."-25% скорости передвижения по фазе баррикад",
																0.75,			5.5,					{}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_COMPACTNAILS, "Компактность", GOOD.."Можно ставить гвозди очень близко друг к другу\n"..BAD.."-25% к дальности чинящих инструментов",
																-0.75,			1.5,					{SKILL_HAMMERDISCIPLINE, SKILL_STRONGMUSCLE}, TREE_BUILDINGTREE)
GM:AddSkill(SKILL_STRONGMUSCLE, "Мистер мускул", GOOD.."Позволяет таскать тяжёлые пропы\n"..GOOD.."-75% замедления при переноске предметов\n"..BAD.."-25% скорости перезарядки оружия\n"..BAD.."+30% задержка удара в ближнем бою",
																0.75,			1.5,					{SKILL_HANDY4}, TREE_BUILDINGTREE)
-- Technician tree
GM:AddSkill(SKILL_INSTRUMENTS, "Чип Турели", GOOD.."+10% дальность стрельбы турелей",
																2.5,		-2.5,					{SKILL_NONE, SKILL_LOADEDHULL, SKILL_TURRETOVERLOAD}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_TURRETOVERLOAD, "Разгон Ядра", GOOD.." +100% скорости сканирования турелей\n"..BAD.."-30% стрельбы турелей",
																3.5,		-0.5,					{SKILL_TURRETLOCK}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_TURRETLOCK, "Блок Турели", "-90% угол обзора турели\n"..BAD.."-90% угол прицеливания турели",
																2.5,		1.5,					{SKILL_U_BLASTTURRET}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_TWINVOLLEY, "Двойные Снаряды", GOOD.."Выпускают вдвое больше пуль в режиме ручной турели\n"..BAD.."+100% расход патронов турели в ручном режиме турели\n"..BAD.."+50% задержка стрельбы из турели в ручном режиме",
																2.5,		2.5,					{SKILL_U_BLASTTURRET}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_U_BLASTTURRET, "Чертеж: Турель-Дробовик", GOOD.."Разблокирует покупку Турель-Дробовик\nСтреляет картечью вместо Автоматных патронов\nУрон выше крупным планом\nНевозможно сканировать цели на большом расстоянии",
																0,			2.5,					{SKILL_U_MANHACK_SAW}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_U_ROCKETTURRET, "Чертеж: Ракетная Турель", GOOD.."Разблокирует покупку Ракетной Турели\nСтреляет взрывчаткой вместо Автоматных патронов.\nНаносит урон в радиусе\nВозможность развертывания на высоком уровне",
																2.5,		3.5,					{SKILL_U_BLASTTURRET}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_LOADEDHULL, "Груженый Корпус", GOOD.."Управляемые предметы взрываются при уничтожении, нанося взрывной урон\n"..BAD.."-10% контролируемого здоровья",
																1.5,		-0.5,					{SKILL_REINFORCEDHULL, SKILL_U_MANHACK_SAW, SKILL_TURRETLOCK}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_AVIATOR, "Авиатор", GOOD.."+40% контролируемая скорость и управляемость\n"..BAD.."-15% контролируемого здоровья",
																-3.5,		-0.5,					{SKILL_REINFORCEDBLADES, SKILL_LIGHTCONSTRUCT}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_REINFORCEDBLADES, "Усиленные Лезвия", GOOD.."+25% урона от Манхака\n"..BAD.."-10% здоровья от Манхака",
																-1.5,		-2.5,					{SKILL_NONE, SKILL_U_DRONE}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_LIGHTCONSTRUCT, "Легкая Конструкция", GOOD.."-25% времени развертывания установок\n"..BAD.."-25% здоровья установки",
																-2.5,		0.5,					{SKILL_U_ZAPPER_ARC}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_U_DRONE, "Чертеж: Импульсный Дрон", GOOD.."Разблокирует вариант импульсного Дрона\nЗапускает импульсные патроны ближнего действия вместо пуль",
																-1.5,		-0.5,					{SKILL_U_ZAPPER_ARC, SKILL_U_MANHACK_SAW, SKILL_REINFORCEDHULL}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_U_MANHACK_SAW, "Чертеж: Манхак с пилой", GOOD.."Разблокирует вариант Манхака с пилой\nУрон и живучесть больше чем у обычного манхака, но немного сложнее контролировать",
																0,			1,					{}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_REINFORCEDHULL, "Тяжёлый Корпус", GOOD.."+25% контролируемого здоровья\n"..BAD.."-20% контролируемая управляемость\n"..BAD.."-20% контролируемая скорость",
																0,			-2,				{}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_U_ZAPPER_ARC, "Чертеж: Динамо", GOOD.."Разблокирует покупку Динамо\nУбивает приближающихся зомби и хедкрабов\nСредний уровень развертывания и длительное время восстановления\nТребуется постоянное поддержание импульсных патронов",
																-1.5,		1.5,					{}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_FIELDAMP, "Усилитель", GOOD.."-10% задержка Шоковых Станций и Ремонтных Полей\n"..BAD.."-30% дальности Шоковых Станций и Ремонтных Полей",
																-2.5,		3.5,					{SKILL_U_ZAPPER_ARC}, TREE_TECHNICIANTREE)
GM:AddSkill(SKILL_TECHNICIAN, "Новая техника", GOOD.." +5% дальности Шоковых Станций и Ремонтных Полей\n"..GOOD.."-5% задержка Шоковых Станций и Ремонтных Полей",
																-0.5,		3.5,					{SKILL_U_ZAPPER_ARC}, TREE_TECHNICIANTREE)
-- Gunnery Tree
GM:AddSkill(SKILL_TRIGGER_DISCIPLINE1, "Прицельный Огонь I", GOOD.."+5% скорости перезарядки оружия\n"..GOOD.."+5% скорости смены оружия",
																0,			-3.5,					{SKILL_NONE, SKILL_TRIGGER_DISCIPLINE2, SKILL_QUICKRELOAD, SKILL_QUICKDRAW}, TREE_GUNTREE)
GM:AddSkill(SKILL_TRIGGER_DISCIPLINE2, "Прицельный Огонь II", GOOD.."+5% скорости перезарядки оружия\n"..GOOD.."+10% скорости смены оружия",
																0,			-2,					{SKILL_FOCUSI}, TREE_GUNTREE)
GM:AddSkill(SKILL_FOCUSI, "Фокусировка I", GOOD.."+2% к точности\n"..BAD.."-5% скорости перезарядки оружия",
																0,			-0.5,					{SKILL_FOCUSII, SKILL_REFINERAIM, SKILL_ORPHICFOCUS}, TREE_GUNTREE)
GM:AddSkill(SKILL_FOCUSII, "Фокусировка II", GOOD.."+5% к точности\n"..BAD.."-10% скорости перезарядки оружия",
																0,			1,					{SKILL_SCAVENGER}, TREE_GUNTREE)
GM:AddSkill(SKILL_SCAVENGER, "Стервятник", GOOD.."Вы можете видеть оружие, патроны и инструменты через стены\n"..GOOD.."Видно кол-во патрон в выпавших патронах",
																0,			2.5,					{SKILL_WORTHINESS1}, TREE_GUNTREE)
GM:AddSkill(SKILL_WORTHINESS1, "Аккуратность I", GOOD.."+5 поинтов в начальном складе\n"..BAD.."-3 поинтов в начале",
																0,			4,					{}, TREE_GUNTREE)							
GM:AddSkill(SKILL_QUICKDRAW, "Быстрый смена", GOOD.."+65% скорости смены оружия\n"..BAD.."-20% скорости перезарядки оружия",
																2,			-2,				{SKILL_BLASTPROOF}, TREE_GUNTREE)
GM:AddSkill(SKILL_QUICKRELOAD, "Быстрая Перезарядка", GOOD.."+10% скорости перезарядки оружия\n"..BAD.."-25% скорости смены оружия",
																-2,			-2,					{SKILL_SCOURER}, TREE_GUNTREE)
GM:AddSkill(SKILL_PROJWEI, "Вес Снаряда", GOOD.."+5% урона снарядами\n"..BAD.."-50% скорости снаряда",
																3,			-0.5,					{SKILL_QUICKDRAW, SKILL_REACHEM}, TREE_GUNTREE)
GM:AddSkill(SKILL_PROJGUIDE, "Наведение Снаряда", GOOD.."+25% скорости снаряда\n"..BAD.."-5% урона снарядами",
																-3,			-0.5,					{SKILL_QUICKRELOAD, SKILL_SOFTDET}, TREE_GUNTREE)
GM:AddSkill(SKILL_REACHEM, "Реактивные Химикаты", GOOD.."+10% радиуса взрывного урона\n"..BAD.."+30% получаемого взрывного урона",
																3.5,		1,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_SOFTDET, "Мягкая Детонация", GOOD.."-40% получаемого взрывного урона\n"..BAD.."-10% радиус взрывного урона",
																-3.5,		1,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_REFINERAIM, "Дешёвый Фокус", GOOD.."+25% к точности прицела оружия 3-го яруса и ниже\n"..BAD.."-25% к точности прицела оружия 4-го яруса и выше",
																2,			1,					{SKILL_SUPASM, SKILL_BLASTPROOF}, TREE_GUNTREE)
GM:AddSkill(SKILL_ORPHICFOCUS, "Орфифокус", GOOD.."90% разброс при прицеливании\n"..BAD.."110% магазина в любое другое время\n"..BAD.."-10% скорости перезарядки",
																-2,			1,					{SKILL_EXTENDEDMAG, SKILL_SCOURER}, TREE_GUNTREE)
GM:AddSkill(SKILL_SUPASM, "Пересборка Оружия", GOOD.."С каждой прокачкой оружия 2 Яруса и ниже увеличивает скорость её перезарядки\n"..BAD.."-25% к точности прицела\n"..BAD.."-10% скорости смены оружия",
																3,			2.5,					{SKILL_LEGFOCUS}, TREE_GUNTREE)
GM:AddSkill(SKILL_EXTENDEDMAG, "Расширенный Магазин", GOOD.."Увеличивает размер магазина оружия с размером магазина 8 и более на +15%\n"..BAD.."-45% скорости смены оружи\n"..BAD.."-20% бонус к точности при прицеливании",
																-3,			2.5,					{SKILL_TRUEWOOISM}, TREE_GUNTREE)
GM:AddSkill(SKILL_TRUEWOOISM, "Точный", GOOD.."Нет штрафа за точность при движении или в прыжке\n"..BAD.."Нет бонуса к точности в приседе или в прицеливании",
																-3.5,		4,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_LEGFOCUS, "Экспансивная пуля", GOOD.."Нету штрафа в виде уменьшенного урона за попадание в ноги зомби\n"..BAD.."-75% множителя урона по голове зомби",
																3.5,		4,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_BLASTPROOF, "Безопасник", GOOD.."-80% урона против себя\n"..BAD.."-5% скорости перезарядки оружия\n"..BAD.."-10% скорости смены оружия\n"..BAD.."-9 максимального здоровья",
																1.5,		-0.5,					{}, TREE_GUNTREE)
GM:AddSkill(SKILL_SCOURER, "Конвертатор", GOOD.."Получайте поинты в конце волны как металл\n"..BAD.."Вы больше не будете получать поинты в конце волны",
																-1.5,		-0.5,					{}, TREE_GUNTREE)
-- Melee Tree
GM:AddSkill(SKILL_WORTHINESS2, "Аккуратность II", GOOD.."+5 поинтов в начальном складе\n"..BAD.."-3 поинтов в начале",
																-2,		2.75,				{}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER1, "Боец I", GOOD.."+1% дальности оружия ближнего боя",
																-2,			-3.25,					{SKILL_NONE, SKILL_BATTLER2, SKILL_CRITICALKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER2, "Боец II", GOOD.."+2% дальности оружия ближнего боя",
																-0.5,		-1.75,				{SKILL_BATTLER3}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER3, "Боец III", GOOD.."+3% дальности оружия ближнего боя",
																1,			-0.25,					{SKILL_BATTLER4, SKILL_MASTERCHEF}, TREE_MELEETREE)
GM:AddSkill(SKILL_BATTLER4, "Боец IV", GOOD.."+4% дальности оружия ближнего боя",
																2.5,		1.25,				{SKILL_BRASH, SKILL_HEAVYSTRIKES}, TREE_MELEETREE)
GM:AddSkill(SKILL_LASTSTAND, "Последний Бой", GOOD.."При достижении 35% здоровья ваш урон в ближнем бою увеличивается в 2 раза на 1 минуту\n"..BAD.."0.8х урон от оружия ближнего боя в любое другое время\nПерезаряжается каждые 80 секунд после того как время увеличения урона закончилось",
																2.5,			2.75,					{SKILL_HEAVYSTRIKES}, TREE_MELEETREE)
GM:AddSkill(SKILL_CHEAPKNUCKLE, "Дешевая Тактика", GOOD.."Замедление цели при ударе из оружия ближнего боя сзади\n"..BAD.."-10% дальности оружия ближнего боя",
																-2,			-0.25,					{SKILL_COMBOKNUCKLE, SKILL_MASTERCHEF}, TREE_MELEETREE)
GM:AddSkill(SKILL_CRITICALKNUCKLE, "Критический Толчок", GOOD.."Отбрасывание при нанесении безоружного удара\n"..BAD.."-20% урона от рукопашного удара\n"..BAD.."+25% времени до следующего безоружного удара",
																-2,			-1.75,					{SKILL_CHEAPKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_COMBOKNUCKLE, "Комбо-Удары", GOOD.."Следующий безоружный удар в 1.2 раза быстрее, если вы попали во что-то\n"..BAD.."Следующий безоружный удар в 1.5 раза медленнее, если вы не попали во что-то",
																-2,			1.25,					{SKILL_WORTHINESS2, SKILL_CHEAPKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_HEAVYSTRIKES, "Тяжёлый Удар", GOOD.."+75% отбрасыванию в ближнем бою\n"..GOOD.."+40% урона в ближнем бою\n"..BAD.."5% нанесенного урона в ближнем бою отражается обратно к вам",
																4,		2.75,				{SKILL_LASTSTAND}, TREE_MELEETREE)
GM:AddSkill(SKILL_LANKY, "Воин II", GOOD.."+7.5% урона оружия ближнего боя\n"..BAD.."-25% отбрасыванию в ближнем бою",
																1,			2.75,					{SKILL_LANKYII, SKILL_LASTSTAND}, TREE_MELEETREE)
GM:AddSkill(SKILL_LANKYII, "Воин I", GOOD.."+7.5% урона оружия ближнего боя\n"..BAD.."-25% отбрасыванию в ближнем бою",
																-0.5,			2.75,					{SKILL_COMBOKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_MASTERCHEF, "Мастер Шеф", GOOD.."Зомби, пораженные кулинарным оружием в последнюю секунду, имеют шанс уронить продукты после смерти\n"..BAD.."-10% урона в ближнем бою",
																-0.5,		-0.25,				{}, TREE_MELEETREE)
GM:AddSkill(SKILL_LIGHTWEIGHT, "Легковес", GOOD.."+7 скорости передвижения с оружием ближнего боя\n"..BAD.."-10% урона оружия ближнего боя",
																-0.5,			1.25,					{SKILL_COMBOKNUCKLE}, TREE_MELEETREE)
GM:AddSkill(SKILL_BRASH, "Дерзкий", GOOD.."-16% задержка удара в ближнем бою\n"..BAD.."-10 скорости передвижения при убийстве в ближнем бою на 10 секунд",
																1,			1.25,					{SKILL_LIGHTWEIGHT}, TREE_MELEETREE)

GM:SetSkillModifierFunction(SKILLMOD_SPEED, function(pl, amount)
	pl.SkillSpeedAdd = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, function(pl, amount)
	pl.MedicHealMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDKIT_COOLDOWN_MUL, function(pl, amount)
	pl.MedicCooldownMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_WORTH, function(pl, amount)
	pl.ExtraStartingWorth = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, function(pl, amount)
	pl.FallDamageThresholdMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, function(pl, amount)
	pl.FallDamageSlowDownMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FOODEATTIME_MUL, function(pl, amount)
	pl.FoodEatTimeMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_JUMPPOWER_MUL, function(pl, amount)
	pl.JumpPowerMul = math.Clamp(amount + 1.0, 0.0, 10.0)

	if SERVER then
		pl:ResetJumpPower()
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_DEPLOYSPEED_MUL, function(pl, amount)
	pl.DeploySpeedMultiplier = math.Clamp(amount + 1.0, 0.05, 100.0)

	for _, wep in pairs(pl:GetWeapons()) do
		GAMEMODE:DoChangeDeploySpeed(wep)
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR, function(pl, amount)
	local oldarmor = pl:GetBloodArmor()
	local oldcap = pl:GetMaxBloodArmor() or 20
	local new = 20 + math.Clamp(amount, -20, 1000)

	if SERVER then
		pl:SetMaxBloodArmor(new)
		if oldarmor > oldcap then
			local overcap = oldarmor - oldcap
			pl:SetBloodArmor(pl:GetMaxBloodArmor() + overcap)
		else
			pl:SetBloodArmor(math.ceil(pl:GetBloodArmor() / oldcap * new))
		end
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR_MUL, function(pl, amount)
	local mul = math.Clamp(amount + 1.0, 0.0, 1000.0)

	pl.MaxBloodArmorMul = mul

	local oldarmor = pl:GetBloodArmor()
	local oldcap = pl:GetMaxBloodArmor() or 20
	local new = math.ceil(pl:GetMaxBloodArmor() * mul)

	if SERVER then
		pl:SetMaxBloodArmor(new)
		if oldarmor > oldcap then
			local overcap = oldarmor - oldcap
			pl:SetBloodArmor(pl:GetMaxBloodArmor() + overcap)
		else
			pl:SetBloodArmor(pl:GetBloodArmor() / oldcap * new)
		end
	end
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplier = math.Clamp(amount + 1.0, 0.05, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_MUL, function(pl, amount)
	pl.MeleeDamageMultiplier = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FIREWEAPON_DAMAGE_MUL, function(pl, amount)
	pl.FireweaponDamageMultiplier = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SELF_DAMAGE_MUL, function(pl, amount)
	pl.SelfDamageMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_KNOCKBACK_MUL, function(pl, amount)
	pl.MeleeKnockbackMultiplier = math.Clamp(amount + 1.0, 0.0, 10000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_UNARMED_DAMAGE_MUL, function(pl, amount)
	pl.UnarmedDamageMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_UNARMED_SWING_DELAY_MUL, function(pl, amount)
	pl.UnarmedDelayMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BARRICADE_PHASE_SPEED_MUL, function(pl, amount)
	pl.BarricadePhaseSpeedMul = math.Clamp(amount + 1.0, 0.05, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_HAMMER_SWING_DELAY_MUL, function(pl, amount)
	pl.HammerSwingDelayMul = math.Clamp(amount + 1.0, 0.01, 1.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_REPAIRRATE_MUL, function(pl, amount)
	pl.RepairRateMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_AIMSPREAD_MUL, function(pl, amount)
	pl.AimSpreadMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDGUN_FIRE_DELAY_MUL, function(pl, amount)
	pl.MedgunFireDelayMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MEDGUN_RELOAD_SPEED_MUL, function(pl, amount)
	pl.MedgunReloadSpeedMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_DRONE_GUN_RANGE_MUL, function(pl, amount)
	pl.DroneGunRangeMul = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_HEALING_RECEIVED, function(pl, amount)
	pl.HealingReceived = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_PISTOL_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierPISTOL = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_SMG_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierSMG1 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_ASSAULT_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierAR2 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_SHELL_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierBUCKSHOT = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_RIFLE_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplier357 = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_PULSE_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierPULSE = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_RELOADSPEED_EXP_MUL, function(pl, amount)
	pl.ReloadSpeedMultiplierIMPACTMINE = math.Clamp(amount + 1.0, 0.0, 100.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, function(pl, amount)
	pl.BarbedArmor = math.Clamp(amount, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PULSE_WEAPON_SLOW_MUL, function(pl, amount)
	pl.PulseWeaponSlowMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.MeleeDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_POISON_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.PoisonDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.BleedDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_SWING_DELAY_MUL, function(pl, amount)
	pl.MeleeSwingDelayMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_DAMAGE_TO_BLOODARMOR_MUL, function(pl, amount)
	pl.MeleeDamageToBloodArmorMul = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, function(pl, amount)
	pl.MeleeMovementSpeedOnKill = math.Clamp(amount, -15, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_POWERATTACK_MUL, function(pl, amount)
	pl.MeleePowerAttackMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_KNOCKDOWN_RECOVERY_MUL, function(pl, amount)
	pl.KnockdownRecoveryMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_RANGE_MUL, function(pl, amount)
	pl.MeleeRangeMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SLOW_EFF_TAKEN_MUL, function(pl, amount)
	pl.SlowEffTakenMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.ExplosiveDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.FireDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROP_CARRY_CAPACITY_MUL, function(pl, amount)
	pl.PropCarryCapacityMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROP_THROW_STRENGTH_MUL, function(pl, amount)
	pl.ObjectThrowStrengthMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, function(pl, amount)
	pl.PhysicsDamageTakenMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_VISION_ALTER_DURATION_MUL, function(pl, amount)
	pl.VisionAlterDurationMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_DIMVISION_EFF_MUL, function(pl, amount)
	pl.DimVisionEffMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROP_CARRY_SLOW_MUL, function(pl, amount)
	pl.PropCarrySlowMul = math.Clamp(amount + 1.0, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_BLEED_SPEED_MUL, function(pl, amount)
	pl.BleedSpeedMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_LEG_DAMAGE_ADD, function(pl, amount)
	pl.MeleeLegDamageAdd = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_SIGIL_TELEPORT_MUL, function(pl, amount)
	pl.SigilTeleportTimeMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, function(pl, amount)
	pl.BarbedArmorPercent = math.Clamp(amount, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_POISON_SPEED_MUL, function(pl, amount)
	pl.PoisonSpeedMul = math.Clamp(amount + 1.0, 0.1, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_PROJECTILE_DAMAGE_TAKEN_MUL, GM:MkGenericMod("ProjDamageTakenMul"))
GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_RADIUS, GM:MkGenericMod("ExpDamageRadiusMul"))
GM:SetSkillModifierFunction(SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, GM:MkGenericMod("WeaponWeightSlowMul"))
GM:SetSkillModifierFunction(SKILLMOD_FRIGHT_DURATION_MUL, GM:MkGenericMod("FrightDurationMul"))
GM:SetSkillModifierFunction(SKILLMOD_IRONSIGHT_EFF_MUL, GM:MkGenericMod("IronsightEffMul"))
GM:SetSkillModifierFunction(SKILLMOD_MEDDART_EFFECTIVENESS_MUL, GM:MkGenericMod("MedDartEffMul"))

GM:SetSkillModifierFunction(SKILLMOD_BLOODARMOR_DMG_REDUCTION, function(pl, amount)
	pl.BloodArmorDamageReductionAdd = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_LOW_HEALTH_SLOW_MUL, GM:MkGenericMod("LowHealthSlowMul"))
GM:SetSkillModifierFunction(SKILLMOD_PROJ_SPEED, GM:MkGenericMod("ProjectileSpeedMul"))

GM:SetSkillModifierFunction(SKILLMOD_ENDWAVE_POINTS, function(pl,amount)
	pl.EndWavePointsExtra = math.Clamp(amount, 0.0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_ARSENAL_DISCOUNT, GM:MkGenericMod("ArsenalDiscount"))
GM:SetSkillModifierFunction(SKILLMOD_CLOUD_RADIUS, GM:MkGenericMod("CloudRadius"))
GM:SetSkillModifierFunction(SKILLMOD_CLOUD_TIME, GM:MkGenericMod("CloudTime"))
GM:SetSkillModifierFunction(SKILLMOD_EXP_DAMAGE_MUL, GM:MkGenericMod("ExplosiveDamageMul"))
GM:SetSkillModifierFunction(SKILLMOD_PROJECTILE_DAMAGE_MUL, GM:MkGenericMod("ProjectileDamageMul"))
GM:SetSkillModifierFunction(SKILLMOD_TURRET_RANGE_MUL, GM:MkGenericMod("TurretRangeMul"))
GM:SetSkillModifierFunction(SKILLMOD_AIM_SHAKE_MUL, GM:MkGenericMod("AimShakeMul"))

GM:SetSkillModifierFunction(SKILLMOD_NAILRANGE_MUL, function(pl, amount)
	pl.NailRangeMul = math.Clamp(amount + 1.0, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_VAMPIRISMSPEED_MUL, function(pl, amount)
	pl.VampirismSpeedMul = math.Clamp(amount + 1, 0, 1000.0)
end)

GM:SetSkillModifierFunction(SKILLMOD_NAILPLACE_MUL, function(pl, amount)
	pl.CompactNailMul = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_REGENIMPLANT, function(pl, amount)
	pl.RegenImplantTimer = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_BIOCLEANSER, function(pl, amount)
	pl.BioCleanserTimer = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_REACTIVEFLASHER, function(pl, amount)
	pl.ReactiveFlasherTimer = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_BLEAKSOUL, function(pl, amount)
	pl.BleakSoulTimer = amount
end)

GM:SetSkillModifierFunction(SKILLMOD_TARGETLOCUS, GM:MkGenericModBoolean("TargetLocus"))

GM:SetSkillModifierFunction(SKILLMOD_IMPULSEINFUSER, GM:MkGenericModBoolean("PulseImpedance"))

GM:AddSkillModifier(SKILL_SPEED1, SKILLMOD_SPEED, 0.75)
GM:AddSkillModifier(SKILL_SPEED1, SKILLMOD_HEALTH, -1)

GM:AddSkillModifier(SKILL_SPEED2, SKILLMOD_SPEED, 1.5)
GM:AddSkillModifier(SKILL_SPEED2, SKILLMOD_HEALTH, -2)

GM:AddSkillModifier(SKILL_SPEED3, SKILLMOD_SPEED, 3)
GM:AddSkillModifier(SKILL_SPEED3, SKILLMOD_HEALTH, -4)

GM:AddSkillModifier(SKILL_SPEED4, SKILLMOD_SPEED, 4.5)
GM:AddSkillModifier(SKILL_SPEED4, SKILLMOD_HEALTH, -6)

GM:AddSkillModifier(SKILL_SPEED5, SKILLMOD_SPEED, 5.25)
GM:AddSkillModifier(SKILL_SPEED5, SKILLMOD_HEALTH, -7)

GM:AddSkillModifier(SKILL_STOIC1, SKILLMOD_HEALTH, 1)
GM:AddSkillModifier(SKILL_STOIC1, SKILLMOD_SPEED, -0.75)

GM:AddSkillModifier(SKILL_STOIC2, SKILLMOD_HEALTH, 2)
GM:AddSkillModifier(SKILL_STOIC2, SKILLMOD_SPEED, -1.5)

GM:AddSkillModifier(SKILL_STOIC3, SKILLMOD_HEALTH, 4)
GM:AddSkillModifier(SKILL_STOIC3, SKILLMOD_SPEED, -3)

GM:AddSkillModifier(SKILL_STOIC4, SKILLMOD_HEALTH, 6)
GM:AddSkillModifier(SKILL_STOIC4, SKILLMOD_SPEED, -4.5)

GM:AddSkillModifier(SKILL_STOIC5, SKILLMOD_HEALTH, 7)
GM:AddSkillModifier(SKILL_STOIC5, SKILLMOD_SPEED, -5.25)

GM:AddSkillModifier(SKILL_VITALITY1, SKILLMOD_HEALTH, 1)
GM:AddSkillModifier(SKILL_VITALITY2, SKILLMOD_HEALTH, 1)
GM:AddSkillModifier(SKILL_VITALITY3, SKILLMOD_HEALTH, 1)

GM:AddSkillModifier(SKILL_COMPOSURE, SKILLMOD_HEALTH, -5)

GM:AddSkillModifier(SKILL_MOTIONI, SKILLMOD_SPEED, 0.75)
GM:AddSkillModifier(SKILL_MOTIONII, SKILLMOD_SPEED, 0.75)
GM:AddSkillModifier(SKILL_MOTIONIII, SKILLMOD_SPEED, 0.75)

GM:AddSkillModifier(SKILL_FOCUSI, SKILLMOD_AIMSPREAD_MUL, -0.02)
GM:AddSkillModifier(SKILL_FOCUSI, SKILLMOD_RELOADSPEED_MUL, -0.05)

GM:AddSkillModifier(SKILL_FOCUSII, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifier(SKILL_FOCUSII, SKILLMOD_RELOADSPEED_MUL, -0.1)

GM:AddSkillModifier(SKILL_SUPASM, SKILLMOD_DEPLOYSPEED_MUL, -0.1)
GM:AddSkillModifier(SKILL_SUPASM, SKILLMOD_AIMSPREAD_MUL, 0.25)

GM:AddSkillModifier(SKILL_ORPHICFOCUS, SKILLMOD_RELOADSPEED_MUL, -0.1)

GM:AddSkillModifier(SKILL_EXTENDEDMAG, SKILLMOD_IRONSIGHT_EFF_MUL, -0.2)
GM:AddSkillModifier(SKILL_EXTENDEDMAG, SKILLMOD_DEPLOYSPEED_MUL, -0.45)

GM:AddSkillModifier(SKILL_TANKER, SKILLMOD_HEALTH, 20)
GM:AddSkillModifier(SKILL_TANKER, SKILLMOD_SPEED, -15)

GM:AddSkillModifier(SKILL_ULTRANIMBLE, SKILLMOD_HEALTH, -20)
GM:AddSkillModifier(SKILL_ULTRANIMBLE, SKILLMOD_SPEED, 15)

GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_SELF_DAMAGE_MUL, -0.80)
GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_RELOADSPEED_MUL, -0.05)
GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_DEPLOYSPEED_MUL, -0.10)
GM:AddSkillModifier(SKILL_BLASTPROOF, SKILLMOD_HEALTH, -9)

GM:AddSkillModifier(SKILL_SURGEON1, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.08)
GM:AddSkillModifier(SKILL_SURGEON2, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.09)
GM:AddSkillModifier(SKILL_SURGEON3, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.10)
GM:AddSkillModifier(SKILL_SURGEONIV, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.11)

GM:AddSkillModifier(SKILL_BIOLOGYI, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.08)
GM:AddSkillModifier(SKILL_BIOLOGYII, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.09)
GM:AddSkillModifier(SKILL_BIOLOGYIII, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.1)
GM:AddSkillModifier(SKILL_BIOLOGYIV, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.11)

GM:AddSkillModifier(SKILL_HANDY1, SKILLMOD_REPAIRRATE_MUL, 0.04)
GM:AddSkillModifier(SKILL_HANDY2, SKILLMOD_REPAIRRATE_MUL, 0.05)
GM:AddSkillModifier(SKILL_HANDY3, SKILLMOD_REPAIRRATE_MUL, 0.06)
GM:AddSkillModifier(SKILL_HANDY4, SKILLMOD_REPAIRRATE_MUL, 0.07)
GM:AddSkillModifier(SKILL_HANDY5, SKILLMOD_REPAIRRATE_MUL, 0.08)

GM:AddSkillModifier(SKILL_MASTER1, SKILLMOD_NAILRANGE_MUL, 0.04)
GM:AddSkillModifier(SKILL_MASTER2, SKILLMOD_NAILRANGE_MUL, 0.05)
GM:AddSkillModifier(SKILL_MASTER3, SKILLMOD_NAILRANGE_MUL, 0.06)
GM:AddSkillModifier(SKILL_MASTER4, SKILLMOD_NAILRANGE_MUL, 0.07)
GM:AddSkillModifier(SKILL_MASTER5, SKILLMOD_NAILRANGE_MUL, 0.08)

GM:AddSkillModifier(SKILL_LIGHTHAMMER, SKILLMOD_REPAIRRATE_MUL, -0.05)

GM:AddSkillModifier(SKILL_COMPACTNAILS, SKILLMOD_NAILPLACE_MUL, 75)
GM:AddSkillModifier(SKILL_COMPACTNAILS, SKILLMOD_NAILRANGE_MUL, -0.25)

GM:AddSkillModifier(SKILL_PHASENAILS, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, -0.25)

GM:AddSkillModifier(SKILL_BATTLER1, SKILLMOD_MELEE_RANGE_MUL, 0.01)
GM:AddSkillModifier(SKILL_BATTLER2, SKILLMOD_MELEE_RANGE_MUL, 0.02)
GM:AddSkillModifier(SKILL_BATTLER3, SKILLMOD_MELEE_RANGE_MUL, 0.03)
GM:AddSkillModifier(SKILL_BATTLER4, SKILLMOD_MELEE_RANGE_MUL, 0.04)

GM:AddSkillModifier(SKILL_LANKY, SKILLMOD_MELEE_DAMAGE_MUL, 0.075)
GM:AddSkillModifier(SKILL_LANKY, SKILLMOD_MELEE_KNOCKBACK_MUL, -0.25)

GM:AddSkillModifier(SKILL_LANKYII, SKILLMOD_MELEE_KNOCKBACK_MUL, -0.25)
GM:AddSkillModifier(SKILL_LANKYII, SKILLMOD_MELEE_DAMAGE_MUL, 0.075)

GM:AddSkillModifier(SKILL_HAMMERDOOR, SKILLMOD_MELEE_DAMAGE_MUL, -0.05)

GM:AddSkillModifier(SKILL_QUICKDRAW, SKILLMOD_DEPLOYSPEED_MUL, 0.65)
GM:AddSkillModifier(SKILL_QUICKDRAW, SKILLMOD_RELOADSPEED_MUL, -0.2)

GM:AddSkillModifier(SKILL_QUICKRELOAD, SKILLMOD_RELOADSPEED_MUL, 0.10)
GM:AddSkillModifier(SKILL_QUICKRELOAD, SKILLMOD_DEPLOYSPEED_MUL, -0.25)

GM:AddSkillModifier(SKILL_PROJWEI, SKILLMOD_PROJ_SPEED, -0.5)
GM:AddSkillModifier(SKILL_PROJWEI, SKILLMOD_PROJECTILE_DAMAGE_MUL, 0.05)

GM:AddSkillModifier(SKILL_PROJGUIDE, SKILLMOD_PROJ_SPEED, 0.25)
GM:AddSkillModifier(SKILL_PROJGUIDE, SKILLMOD_PROJECTILE_DAMAGE_MUL, -0.05)

GM:AddSkillModifier(SKILL_REACHEM, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, 0.3)
GM:AddSkillModifier(SKILL_REACHEM, SKILLMOD_EXP_DAMAGE_RADIUS, 0.1)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE1, SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE1, SKILLMOD_DEPLOYSPEED_MUL, 0.05)

GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE2, SKILLMOD_RELOADSPEED_MUL, 0.1)
GM:AddSkillModifier(SKILL_TRIGGER_DISCIPLINE2, SKILLMOD_DEPLOYSPEED_MUL, 0.1)

GM:AddSkillModifier(SKILL_PHASER, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.05)
GM:AddSkillModifier(SKILL_PHASER, SKILLMOD_SIGIL_TELEPORT_MUL, -0.05)

GM:AddSkillModifier(SKILL_PHASERII, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.75)
GM:AddSkillModifier(SKILL_PHASERII, SKILLMOD_SIGIL_TELEPORT_MUL, 1)

GM:AddSkillModifier(SKILL_TELEPORTER, SKILLMOD_SIGIL_TELEPORT_MUL, 0.55)

GM:AddSkillModifier(SKILL_HAMMERDISCIPLINE, SKILLMOD_HAMMER_SWING_DELAY_MUL, -0.1)
GM:AddSkillModifier(SKILL_HAMMERDISCIPLINE2, SKILLMOD_HAMMER_SWING_DELAY_MUL, -0.1)
GM:AddSkillModifier(SKILL_BARRICADEEXPERT, SKILLMOD_HAMMER_SWING_DELAY_MUL, 0.3)

GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.4)
GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_RECOVERY_MUL, -0.5)
GM:AddSkillModifier(SKILL_SAFEFALL, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, 0.4)

GM:AddSkillModifier(SKILL_BACKPEDDLER, SKILLMOD_SPEED, -5)
GM:AddSkillFunction(SKILL_BACKPEDDLER, function(pl, active)
	pl.NoBWSpeedPenalty = active
end)

GM:AddSkillFunction(SKILL_TAUT, function(pl, active)
	pl.BuffTaut = active
end)

GM:AddSkillModifier(SKILL_REGENERATOR, SKILLMOD_HEALTH, -6)

GM:AddSkillFunction(SKILL_ORPHICFOCUS, function(pl, active)
	pl.Orphic = active
end)

GM:AddSkillModifier(SKILL_WORTHINESS1, SKILLMOD_WORTH, 5)
GM:AddSkillModifier(SKILL_WORTHINESS2, SKILLMOD_WORTH, 5)
GM:AddSkillModifier(SKILL_WORTHINESS3, SKILLMOD_WORTH, 5)
GM:AddSkillModifier(SKILL_WORTHINESS4, SKILLMOD_WORTH, 5)

GM:AddSkillModifier(SKILL_CRITICALKNUCKLE, SKILLMOD_UNARMED_DAMAGE_MUL, -0.2)
GM:AddSkillModifier(SKILL_CRITICALKNUCKLE, SKILLMOD_UNARMED_SWING_DELAY_MUL, 0.25)

GM:AddSkillModifier(SKILL_SMARTTARGETING, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, 0.6)
GM:AddSkillModifier(SKILL_SMARTTARGETING, SKILLMOD_MEDDART_EFFECTIVENESS_MUL, -0.3)

GM:AddSkillModifier(SKILL_RECLAIMSOL, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, 1.25)
GM:AddSkillModifier(SKILL_RECLAIMSOL, SKILLMOD_MEDGUN_RELOAD_SPEED_MUL, -0.2)

GM:AddSkillModifier(SKILL_MASTERCHEF, SKILLMOD_MELEE_DAMAGE_MUL, -0.1)

GM:AddSkillModifier(SKILL_LIGHTWEIGHT, SKILLMOD_MELEE_DAMAGE_MUL, -0.1)

GM:AddSkillModifier(SKILL_LIGHTHAMMER, SKILLMOD_MELEE_DAMAGE_MUL, -0.05)

GM:AddSkillModifier(SKILL_AGILEI, SKILLMOD_JUMPPOWER_MUL, 0.02)
GM:AddSkillModifier(SKILL_AGILEI, SKILLMOD_SPEED, -1)

GM:AddSkillModifier(SKILL_AGILEII, SKILLMOD_JUMPPOWER_MUL, 0.03)
GM:AddSkillModifier(SKILL_AGILEII, SKILLMOD_SPEED, -1.5)

GM:AddSkillModifier(SKILL_AGILEIII, SKILLMOD_JUMPPOWER_MUL, 0.05)
GM:AddSkillModifier(SKILL_AGILEIII, SKILLMOD_SPEED, -2.5)

GM:AddSkillModifier(SKILL_SOFTDET, SKILLMOD_EXP_DAMAGE_RADIUS, -0.10)
GM:AddSkillModifier(SKILL_SOFTDET, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.4)

GM:AddSkillModifier(SKILL_SURESTEP, SKILLMOD_SPEED, -4)
GM:AddSkillModifier(SKILL_SURESTEP, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.35)

GM:AddSkillModifier(SKILL_INTREPID, SKILLMOD_SPEED, -4)
GM:AddSkillModifier(SKILL_INTREPID, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.4)

GM:AddSkillModifier(SKILL_UNBOUND, SKILLMOD_SPEED, -4)

GM:AddSkillModifier(SKILL_CHEAPKNUCKLE, SKILLMOD_MELEE_RANGE_MUL, -0.1)

GM:AddSkillModifier(SKILL_HEAVYSTRIKES, SKILLMOD_MELEE_DAMAGE_MUL, 0.4)
GM:AddSkillModifier(SKILL_HEAVYSTRIKES, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.75)

GM:AddSkillFunction(SKILL_SCOURER, function(pl, active)
	pl.Scourer = active
end)

GM:AddSkillModifier(SKILL_DISPERSION, SKILLMOD_CLOUD_RADIUS, 0.15)
GM:AddSkillModifier(SKILL_DISPERSION, SKILLMOD_CLOUD_TIME, 0.1)

GM:AddSkillModifier(SKILL_BRASH, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.16)
GM:AddSkillModifier(SKILL_BRASH, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, -10)
-- начало кровавой категория
GM:AddSkillModifier(SKILL_HAEMOSTASIS, SKILLMOD_BLOODARMOR_DMG_REDUCTION, -0.1)

GM:AddSkillModifier(SKILL_IRONBLOOD, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.25)
GM:AddSkillModifier(SKILL_IRONBLOOD, SKILLMOD_BLOODARMOR_MUL, -0.5)
GM:AddSkillModifier(SKILL_IRONBLOOD, SKILLMOD_VAMPIRISMSPEED_MUL, 0.25)

GM:AddSkillModifier(SKILL_CIRCULATION, SKILLMOD_BLOODARMOR, -5)

GM:AddSkillModifier(SKILL_ANTIGEN, SKILLMOD_BLOODARMOR_DMG_REDUCTION, 0.05)
GM:AddSkillModifier(SKILL_ANTIGEN, SKILLMOD_HEALTH, -3)

GM:AddSkillModifier(SKILL_BLOODGAINER1, SKILLMOD_VAMPIRISMSPEED_MUL, -0.02)

GM:AddSkillModifier(SKILL_BLOODGAINER2, SKILLMOD_VAMPIRISMSPEED_MUL, -0.04)

GM:AddSkillModifier(SKILL_BLOODGAINER3, SKILLMOD_VAMPIRISMSPEED_MUL, -0.06)

GM:AddSkillModifier(SKILL_BLOODGAINER4, SKILLMOD_VAMPIRISMSPEED_MUL, -0.08)

GM:AddSkillModifier(SKILL_BLOODGAINER5, SKILLMOD_VAMPIRISMSPEED_MUL, -0.10)

GM:AddSkillModifier(SKILL_SANGUINE1, SKILLMOD_BLOODARMOR, 2)
GM:AddSkillModifier(SKILL_SANGUINE1, SKILLMOD_HEALTH, -2)

GM:AddSkillModifier(SKILL_SANGUINE2, SKILLMOD_BLOODARMOR, 4)
GM:AddSkillModifier(SKILL_SANGUINE2, SKILLMOD_HEALTH, -4)

GM:AddSkillModifier(SKILL_SANGUINE3, SKILLMOD_BLOODARMOR, 6)
GM:AddSkillModifier(SKILL_SANGUINE3, SKILLMOD_HEALTH, -6)

GM:AddSkillModifier(SKILL_SANGUINE4, SKILLMOD_BLOODARMOR, 8)
GM:AddSkillModifier(SKILL_SANGUINE4, SKILLMOD_HEALTH, -8)

GM:AddSkillModifier(SKILL_SANGUINE5, SKILLMOD_BLOODARMOR, 10)
GM:AddSkillModifier(SKILL_SANGUINE5, SKILLMOD_HEALTH, -10)

GM:AddSkillModifier(SKILL_INSTRUMENTS, SKILLMOD_TURRET_RANGE_MUL, 0.1)

GM:AddSkillModifier(SKILL_TAUT, SKILLMOD_PROP_CARRY_SLOW_MUL, 0.4)

GM:AddSkillModifier(SKILL_STRONGMUSCLE, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.75)
GM:AddSkillModifier(SKILL_STRONGMUSCLE, SKILLMOD_RELOADSPEED_MUL, -0.25)
GM:AddSkillModifier(SKILL_STRONGMUSCLE, SKILLMOD_MELEE_SWING_DELAY_MUL, 0.3)
GM:AddSkillModifier(SKILL_STRONGMUSCLE, SKILLMOD_PROP_CARRY_CAPACITY_MUL, 2)

GM:AddSkillModifier(SKILL_TURRETOVERLOAD, SKILLMOD_TURRET_RANGE_MUL, -0.3)

GM:AddSkillFunction(SKILL_TRUEWOOISM, function(pl, active)
	pl.TrueWooism = active
end)
