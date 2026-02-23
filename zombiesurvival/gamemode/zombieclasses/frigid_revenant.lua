CLASS.Base = "shadow_walker"

CLASS.Name = "Frigid Revenant"
CLASS.TranslationName = "class_frigid_revenant"
CLASS.Description = "description_frigid_revenant"
CLASS.Help = "controls_frigid_revenant"

CLASS.BetterVersion = "Cryogen Revenant"

CLASS.SWEP = "weapon_zs_frigidrevenant"

CLASS.Wave = 4 / 6
CLASS.ClassType = 1
CLASS.Health = 285
CLASS.HealthPerWave = 12
CLASS.KnockbackScale = 0.35
CLASS.Speed = 175

CLASS.Points = CLASS.Health/GM.HumanoidZombiePointRatio

CLASS.ResistFrost = true
CLASS.CanTaunt = true
CLASS.Skeletal = true
CLASS.TorsoClass = "Frigid Lurker"

local math_random = math.random
local math_min = math.min
local math_max = math.max
local bit_band = bit.band
local DMG_BULLET = DMG_BULLET
local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_IDLE_CROUCH_FIST = ACT_HL2MP_IDLE_CROUCH_FIST
local ACT_HL2MP_IDLE_KNIFE = ACT_HL2MP_IDLE_KNIFE
local ACT_HL2MP_WALK_CROUCH_KNIFE = ACT_HL2MP_WALK_CROUCH_KNIFE
local ACT_HL2MP_RUN_KNIFE = ACT_HL2MP_RUN_KNIFE

if SERVER then
	function CLASS:ReviveCallback(pl, attacker, dmginfo)
		if not pl:ShouldReviveFrom(dmginfo) then return false end

		local classtable = GAMEMODE.ZombieClasses[self.TorsoClass]
		if classtable then
			pl:RemoveStatus("overridemodel", false, true)
			local deathclass = pl.DeathClass or pl:GetZombieClass()
			pl:SetZombieClass(classtable.Index)
			pl:DoHulls(classtable.Index, TEAM_UNDEAD)
			pl.DeathClass = deathclass

			pl:EmitSound("physics/flesh/flesh_bloody_break.wav", 100, 75)
			pl:EmitSound("npc/antlion/attack_double1.wav", 100, 85)

			local effectdata = EffectData()
			effectdata:SetOrigin(pl:GetPos())
			effectdata:SetEntity(pl)
			util.Effect("hit_ice", effectdata)

			pl:Gib()
			pl.Gibbed = nil

			timer.Simple(0, function()
				if IsValid(pl) then
					pl:SecondWind()
				end
			end)
			return true
		end
		return false
	end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/skeletal_walker"
CLASS.IconColor = Color(50, 90, 135)

local render_SetBlend = render.SetBlend
local render_SetColorModulation = render.SetColorModulation
local render_SetMaterial = render.SetMaterial
local render_DrawSprite = render.DrawSprite
local render_ModelMaterialOverride = render.ModelMaterialOverride
local angle_zero = angle_zero
local LocalToWorld = LocalToWorld

local colGlow = Color(200, 175, 255)
local matGlow = Material("sprites/glow04_noz")
local matBlack = CreateMaterial("shadowlurkersheet", "UnlitGeneric", {["$basetexture"] = "Tools/toolsblack", ["$model"] = 1})
local vecEyeLeft = Vector(5, -3.5, -1)
local vecEyeRight = Vector(5, -3.5, 1)

function CLASS:PrePlayerDraw(pl)
	render_SetBlend(0.85)
	render_SetColorModulation(0.6, 0.3, 0.8)
end

function CLASS:PostPlayerDraw(pl)
	render_SetBlend(1)
	render_SetColorModulation(1, 1, 1)
end

function CLASS:PrePlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(matBlack)
end

function CLASS:PostPlayerDrawOverrideModel(pl)
	render_ModelMaterialOverride(nil)

	if pl == MySelf and not pl:ShouldDrawLocalPlayer() or pl.SpawnProtection then return end

	local pos, ang = pl:GetBonePositionMatrixed(6)
	if pos then
		render_SetMaterial(matGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 10, 0.5, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeLeft, angle_zero, pos, ang), 4, 4, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 10, 0.5, colGlow)
		render_DrawSprite(LocalToWorld(vecEyeRight, angle_zero, pos, ang), 4, 4, colGlow)
	end
end