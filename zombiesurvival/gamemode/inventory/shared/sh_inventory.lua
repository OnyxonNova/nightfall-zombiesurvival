INVCAT_TRINKETS = 1

GM.ZSInventoryItemData = {}
GM.ZSInventoryPrefix = {[INVCAT_TRINKETS] = "trin"}

function GM:GetInventoryItemType(item)
	for typ, aff in pairs(self.ZSInventoryPrefix) do
		if string.sub(item, 1, 4) == aff then
			return typ
		end
	end

	return -1
end

local hpweles = {
	["ammo"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2.5, 3), angle = Angle(15.194, 80.649, 180), size = Vector(0.6, 0.6, 1.2), color = Color(145, 132, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local oweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.799, 2, -1.5), angle = Angle(5, 180, 0), size = Vector(0.05, 0.039, 0.07), color = Color(196, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local pweles = {
	["perf"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 0.5, -2), angle = Angle(5, 90, 0), size = Vector(0.25, 0.15, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local deweles = {
	["perf"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 2, -5.715), angle = Angle(0, 180, 0), size = Vector(0.1, 0.039, 0.09), color = Color(168, 155, 0, 255), surpresslightning = false, material = "models/props_pipes/pipeset_metal", skin = 0, bodygroup = {} }
}

local ammoweles = {
	["ammo"] = { type = "Model", model = "models/props/de_prodigy/ammo_can_02.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2, -1.558), angle = Angle(5.843, 82.986, 111.039), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local mweles = {
	["band++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(2.599, 1, 1), angle = Angle(0, -25, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "band", pos = Vector(-2.401, -1, 0.5), angle = Angle(0, 155.455, 0), size = Vector(0.019, 0.15, 0.15), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} },
	["band"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 2, -0.5), angle = Angle(111.039, -92.338, 97.013), size = Vector(0.045, 0.045, 0.025), color = Color(55, 52, 51, 255), surpresslightning = false, material = "models/props_pipes/pipemetal001a", skin = 0, bodygroup = {} }
}

local supweles = {
	["perf"] = { type = "Model", model = "models/props_lab/reciever01c.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.5, -2), angle = Angle(5, 180, 92.337), size = Vector(0.2, 0.699, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local blcorew = {
	["black_core_2"] = { type = "Sprite", sprite = "effects/splashwake3", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 7.697, y = 7.697 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core_2+"] = { type = "Sprite", sprite = "effects/splashwake1", bone = "ValveBiped.Bip01_R_Hand", rel = "black_core", pos = Vector(0, 0.1, -0.201), size = { x = 10, y = 10 }, color = Color(0, 0, 0, 255), nocull = false, additive = false, vertexalpha = true, vertexcolor = true, ignorez = false},
	["black_core"] = { type = "Model", model = "models/dav0r/hoverball.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, 0), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(20, 20, 20, 255), surpresslightning = false, material = "models/shiny", skin = 0, bodygroup = {} }
}

local oxygweles = {
    ["oxyg"] = { type = "Model", model = "models/props_c17/canister01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 3, -1), angle = Angle(180, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local arsweles = {
    ["base"] = { type = "Model", model = "models/Items/item_item_crate.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 2, -1), angle = Angle(0, -90, 180), size = Vector(0.35, 0.35, 0.35), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

local trinket, trinketwep

trinket, trinketwep = GM:AddTrinket("healthpack", hpweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_HEALTH, 10)
GM:AddSkillModifier(trinket, SKILLMOD_HEALING_RECEIVED, 0.05)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_HEALTH, 5)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_HEALING_RECEIVED, 0.02)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_HEALTH, 12)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_HEALING_RECEIVED, 0.04)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_HEALTH, 20)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_HEALING_RECEIVED, 0.06)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("bloodbank", hpweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_BLOODARMOR, 10)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BLOODARMOR, 9)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BLOODARMOR, 19)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, 0.15)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BLOODARMOR, 30)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, 0.35)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("cutlery", hpweles)
GM:AddSkillModifier(trinket, SKILLMOD_FOODEATTIME_MUL, -0.5)
GM:AddSkillModifier(trinket, SKILLMOD_FOODRECOVERY_MUL, 0.25)

trinket, trinketwep = GM:AddTrinket("regenimplant", hpweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_REGENIMPLANT, 15)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_REGENIMPLANT, -2)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_REGENIMPLANT, -4)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_REGENIMPLANT, -6)

trinket, trinketwep = GM:AddTrinket("biocleanser", hpweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_BIOCLEANSER, 23)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BIOCLEANSER, -3)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BIOCLEANSER, -6)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BIOCLEANSER, -9)

trinket, trinketwep = GM:AddTrinket("reactiveflasher", deweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_REACTIVEFLASHER, 80)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_REACTIVEFLASHER, -8)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_REACTIVEFLASHER, -16)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_REACTIVEFLASHER, -24)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("antitoxinpack", deweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_POISON_SPEED_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_POISON_SPEED_MUL, -0.07)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.09)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_POISON_SPEED_MUL, -0.15)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.14)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_POISON_SPEED_MUL, -0.24)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_POISON_DAMAGE_TAKEN_MUL, -0.2)

trinket, trinketwep = GM:AddTrinket("bandage", deweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_BLEED_SPEED_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BLEED_SPEED_MUL, -0.1)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.2)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BLEED_SPEED_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BLEED_DAMAGE_TAKEN_MUL, -0.3)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BLEED_SPEED_MUL, -0.35)

trinket, trinketwep = GM:AddTrinket("bodyarmor", deweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.1)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.04)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.09)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_SPEED, -6)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_SPEED, -12)
trinketwep.ScrapMultiplier = 1.5

trinket, trinketwep = GM:AddTrinket("eodvest", deweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_SELF_DAMAGE_MUL, -0.05)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.2)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_SELF_DAMAGE_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, -0.25)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_EXP_DAMAGE_TAKEN_MUL, -0.3)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_SELF_DAMAGE_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FIRE_DAMAGE_TAKEN_MUL, -0.50)
trinketwep.ScrapMultiplier = 1.5

trinket, trinketwep = GM:AddTrinket("forcedamp", deweles)
GM:AddSkillModifier(trinket, SKILLMOD_PHYSICS_DAMAGE_TAKEN_MUL, -0.3)

trinket, trinketwep = GM:AddTrinket("strengthenedswing", mweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.13)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.04)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.05)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_KNOCKBACK_MUL, 0.06)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_SWING_DELAY_MUL, -0.11)

trinket, trinketwep = GM:AddTrinket("adrenalinerush", mweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 9)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 3)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 6)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_MOVEMENTSPEED_ON_KILL, 9)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("longgrip", mweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_RANGE_MUL, 0.03)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_RANGE_MUL, 0.015)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_RANGE_MUL, 0.03)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_RANGE_MUL, 0.045)

trinket, trinketwep = GM:AddTrinket("powergauntlet", mweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_POWERATTACK_MUL, 0.10)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_POWERATTACK_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_POWERATTACK_MUL, 0.1)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_POWERATTACK_MUL, 0.15)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("analgesic", pweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.15)
GM:AddSkillModifier(trinket, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.15)
GM:AddSkillModifier(trinket, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.15)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.25)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.25)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.25)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.35)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.35)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.35)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_SLOW_EFF_TAKEN_MUL, -0.5)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_LOW_HEALTH_SLOW_MUL, -0.5)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_KNOCKDOWN_RECOVERY_MUL, -0.5)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("featherfallboots", pweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.2)
GM:AddSkillModifier(trinket, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.15)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.4)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FALLDAMAGE_DAMAGE_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FALLDAMAGE_THRESHOLD_MUL, 0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FALLDAMAGE_SLOWDOWN_MUL, -0.65)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("agilitymagnifier", pweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.20)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_JUMPPOWER_MUL, 0.07)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_JUMPPOWER_MUL, 0.14)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_SIGIL_TELEPORT_MUL, -0.15)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BARRICADE_PHASE_SPEED_MUL, 0.2)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_JUMPPOWER_MUL, 0.21)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_SIGIL_TELEPORT_MUL, -0.25)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("exoskeleton", pweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.3)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_PROP_THROW_STRENGTH_MUL, 0.25)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_PROP_THROW_STRENGTH_MUL, 0.25)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.2)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_PROP_THROW_STRENGTH_MUL, 0.5)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.2)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_PROP_CARRY_SLOW_MUL, -0.3)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_DEPLOYABLE_PACKTIME_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_PROP_THROW_STRENGTH_MUL, 0.75)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_WEAPON_WEIGHT_SLOW_MUL, -0.2)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("nightvision", pweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_DIMVISION_EFF_MUL, -0.2)
GM:AddSkillModifier(trinket, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_DIMVISION_EFF_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.05)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FRIGHT_DURATION_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_DIMVISION_EFF_MUL, -0.2)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.15)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FRIGHT_DURATION_MUL, -0.3)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_DIMVISION_EFF_MUL, -0.35)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_VISION_ALTER_DURATION_MUL, -0.25)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FRIGHT_DURATION_MUL, -0.45)

trinket, trinketwep = GM:AddTrinket("weights", pweles)

trinket, trinketwep = GM:AddTrinket("oxygentank", oxygweles)

trinket, trinketwep = GM:AddTrinket("processor", supweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.05)
GM:AddSkillModifier(trinket, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.08)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.03)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_CLOUD_TIME, 0.1)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.06)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.09)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_CLOUD_TIME, 0.2)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MEDKIT_COOLDOWN_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MEDGUN_FIRE_DELAY_MUL, -0.16)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MEDKIT_EFFECTIVENESS_MUL, 0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_CLOUD_TIME, 0.3)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("matrixchip", supweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_RANGE_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_FIELD_DELAY_MUL, -0.07)
GM:AddSkillModifier(trinket, SKILLMOD_TURRET_RANGE_MUL, 0.1)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_FIELD_RANGE_MUL, 0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_FIELD_DELAY_MUL, -0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_TURRET_RANGE_MUL, 0.04)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FIELD_RANGE_MUL, 0.08)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_FIELD_DELAY_MUL, -0.08)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_TURRET_RANGE_MUL, 0.08)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FIELD_RANGE_MUL, 0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_FIELD_DELAY_MUL, -0.13)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_TURRET_RANGE_MUL, 0.15)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("controlplat", supweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.1)
GM:AddSkillModifier(trinket, SKILLMOD_MANHACK_DAMAGE_MUL, 0.07)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.04)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MANHACK_DAMAGE_MUL, 0.04)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.08)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.08)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MANHACK_DAMAGE_MUL, 0.08)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_CONTROLLABLE_HEALTH_MUL, 0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_CONTROLLABLE_SPEED_MUL, 0.15)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MANHACK_DAMAGE_MUL, 0.13)
trinketwep.ScrapMultiplier = 1.25

trinket, trinketwep = GM:AddTrinket("blueprints", supweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_REPAIRRATE_MUL, 0.1)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_REPAIRRATE_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_REPAIRRATE_MUL, 0.12)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_REPAIRRATE_MUL, 0.2)

trinket, trinketwep = GM:AddTrinket("acqmanifest", supweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_RESUPPLY_DELAY_MUL, -0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_RESUPPLY_DELAY_MUL, -0.03)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_RESUPPLY_DELAY_MUL, -0.06)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_RESUPPLY_DELAY_MUL, -0.1)
trinketwep.ScrapMultiplier = 1.75

trinket, trinketwep = GM:AddTrinket("arsenalpack", arsweles, false, "arsenalpack")
trinketwep.PermitDismantle = true

trinket, trinketwep = GM:AddTrinket("holster", oweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_DEPLOYSPEED_MUL, 0.10)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_DEPLOYSPEED_MUL, 0.10)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_DEPLOYSPEED_MUL, 0.20)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_DEPLOYSPEED_MUL, 0.30)

trinket, trinketwep = GM:AddTrinket("cartridgebelt", ammoweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_RELOADSPEED_MUL, 0.05)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_RELOADSPEED_MUL, 0.1)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_RELOADSPEED_MUL, 0.15)

trinket, trinketwep = GM:AddTrinket("sightingvisor", oweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_AIMSPREAD_MUL, -0.05)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_AIMSPREAD_MUL, -0.04)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_AIMSPREAD_MUL, -0.1)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_AIMSPREAD_MUL, -0.17)

trinket, trinketwep = GM:AddTrinket("aimcomp", oweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_AIM_SHAKE_MUL, -0.25)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_AIM_SHAKE_MUL, -0.09)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_TARGETLOCUS, 1)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_AIM_SHAKE_MUL, -0.19)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_TARGETLOCUS, 1)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_AIM_SHAKE_MUL, -0.3)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_TARGETLOCUS, 1)

trinket, trinketwep = GM:AddTrinket("impulseinfuser", oweles, true)
GM:AddSkillModifier(trinket, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.14)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.14)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.28)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_PULSE_WEAPON_SLOW_MUL, 0.36)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_IMPULSEINFUSER, 1)
trinketwep.ScrapMultiplier = 1.5

trinket, trinketwep = GM:AddTrinket("bleaksoul", blcorew, true)
GM:AddSkillModifier(trinket, SKILLMOD_BLEAKSOUL, 40)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_BLEAKSOUL, -5)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_BLEAKSOUL, -10)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_BLEAKSOUL, -15)
trinketwep.AlternativeColors = true
trinketwep.ScrapMultiplier = 2

trinket, trinketwep = GM:AddTrinket("barbedarmor", blcorew, true)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 8)
GM:AddSkillModifier(trinket, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 0.5)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 2)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 0.16)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 4)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 0.32)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT, 6)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_ATTACKER_DMG_REFLECT_PERCENT, 0.5)
trinketwep.AlternativeColors = true
trinketwep.ScrapMultiplier = 2

trinket, trinketwep = GM:AddTrinket("escapemanual", blcorew, true)
GM:AddSkillModifier(trinket, SKILLMOD_SPEED, 3)

GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_SPEED, 2)
GM:AddSkillModifierQuality(trinket, 1, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.03)

GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_SPEED, 5)
GM:AddSkillModifierQuality(trinket, 2, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.07)

GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_SPEED, 9)
GM:AddSkillModifierQuality(trinket, 3, SKILLMOD_MELEE_DAMAGE_TAKEN_MUL, 0.12)
trinketwep.AlternativeColors = true
trinketwep.ScrapMultiplier = 2
