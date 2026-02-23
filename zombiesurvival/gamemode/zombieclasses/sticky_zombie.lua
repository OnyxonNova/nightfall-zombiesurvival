CLASS.Base = "zombie"

CLASS.Name = "Sticky"
CLASS.TranslationName = "class_sticky"
CLASS.Description = "description_sticky"
CLASS.Help = "controls_sticky"

CLASS.Health = 165
CLASS.HealthPerWave = 10
CLASS.Speed = 160

CLASS.CanTaunt = true
CLASS.Wave = 2 / 6
CLASS.ClassType = 3

CLASS.SWEP = "weapon_zs_sticky"
CLASS.Model = Model("models/player/zombie_fast.mdl")
CLASS.Points = CLASS.Health / GM.HumanoidZombiePointRatio
CLASS.VoicePitch = 0.7

CLASS.TorsoClass = "Sticky Lurker"

local CurTime = CurTime
local math_random = math.random
local math_max = math.max
local math_min = math.min
local math_ceil = math.ceil
local format = string.format

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
    	    pl:EmitSound("npc/headcrab_poison/ph_warning2.wav", 100, 85)

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

function CLASS:PlayPainSound(pl)
    pl:EmitSound(format("npc/headcrab_poison/ph_wallpain%d.wav", math_random(1, 3)), 75, math_random(50, 55))
    pl.NextPainSound = CurTime() + 0.5
    return true
end

function CLASS:PlayDeathSound(pl)
    pl:EmitSound("npc/headcrab_fast/die" .. math_random(2) .. ".wav", 72, 60)
    return true
end

if CLIENT then
    CLASS.Icon = "zombiesurvival/killicons/nightmare"
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

