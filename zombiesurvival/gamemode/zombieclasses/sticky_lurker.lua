CLASS.Base = "zombie_torso"

CLASS.Hidden = true

CLASS.Name = "Sticky Lurker"
CLASS.TranslationName = "class_sticky_lurker"
CLASS.Description = "description_sticky_lurker"

CLASS.Model = Model("models/zombie/fast_torso.mdl")

CLASS.SWEP = "weapon_zs_sticky_lurker"

CLASS.Health = 75
CLASS.Speed = 145
CLASS.JumpPower = 130

CLASS.Points = CLASS.Health/GM.TorsoZombiePointRatio

CLASS.PainSounds = {"NPC_FastZombie.Pain"}
CLASS.DeathSounds = {"npc/fast_zombie/leap1.wav"}

CLASS.VoicePitch = 0.75

CLASS.IsTorso = true

local ACT_IDLE = ACT_IDLE
local ACT_WALK = ACT_WALK

function CLASS:CalcMainActivity(pl, velocity)
	if velocity:Length2DSqr() <= 1 then
		return ACT_IDLE, -1
	end

	return ACT_WALK, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
end

if SERVER then
	function CLASS:OnSecondWind(pl)
		pl:EmitSound("NPC_FastZombie.Frenzy")
	end
end

if CLIENT then
	CLASS.Icon = "zombiesurvival/killicons/fast_torso"
    CLASS.IconColor = Color(140, 140, 140)
    
    local render_SetColorModulation = render.SetColorModulation
    local render_SetMaterial = render.SetMaterial
    local matFlesh = Material("models/flesh")
    
    function CLASS:PrePlayerDraw(pl)
        render_SetColorModulation(0, 0, 0)
        render.ModelMaterialOverride(matFlesh)
    end

    function CLASS:PostPlayerDraw(pl)
        render.ModelMaterialOverride(nil)
    end
end

