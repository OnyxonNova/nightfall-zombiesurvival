CLASS.Base = "freshdead"

CLASS.Hidden = true

CLASS.Name = "Super Zombie ZE"
CLASS.TranslationName = "class_super_zombie"

CLASS.Health = 1500
CLASS.Speed = SPEED_ZOMBIEESCAPE_ZOMBIE
CLASS.Points = 25

CLASS.SWEP = "weapon_zs_superzombieze"

CLASS.UsePlayerModel = true
CLASS.UsePreviousModel = false
CLASS.NoFallDamage = true

if SERVER then
	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo) end

	function CLASS:AltUse(pl) end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/fresh_dead"
