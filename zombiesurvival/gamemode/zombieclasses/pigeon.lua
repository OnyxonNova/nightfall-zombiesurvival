CLASS.Base = "crow"

CLASS.Name = "Pigeon"
CLASS.TranslationName = "class_pigeon"
CLASS.Description = "description_pigeon"

CLASS.SWEP = "weapon_zs_pigeon"
CLASS.Model = Model("models/pigeon.mdl")

CLASS.PainSounds = {"ambient/creatures/pigeon_idle1.wav", "ambient/creatures/pigeon_idle2.wav"}
CLASS.DeathSounds = {"ambient/creatures/pigeon_idle1.wav", "ambient/creatures/pigeon_idle2.wav"}

if not CLIENT then return end

function CLASS:ShouldDrawLocalPlayer(pl)
	return true
end

CLASS.Icon = "zombiesurvival/killicons/blank"
CLASS.IconColor = Color(255, 255, 255)	