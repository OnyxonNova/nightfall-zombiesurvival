AddCSLuaFile("shared.lua")
include("shared.lua")

function CLASS:ProcessDamage(pl, dmginfo)
    if pl.EradiVived then return end

    local damage = dmginfo:GetDamage()
    if damage >= 80 or damage < pl:Health() then return end

    local attacker, inflictor = dmginfo:GetAttacker(), dmginfo:GetInflictor()
    if attacker == pl or not attacker:IsPlayer() or inflictor.IsMelee or inflictor.NoReviveFromKills then return end

    if pl:WasHitInHead() or pl:GetStatus("shockdebuff") then return end

    local dmgtype = dmginfo:GetDamageType()
    if bit.band(dmgtype, DMG_ALWAYSGIB) ~= 0 or bit.band(dmgtype, DMG_BURN) ~= 0 or bit.band(dmgtype, DMG_CRUSH) ~= 0 then return end

    if CurTime() < (pl.NextZombieRevive or 0) then return end
    pl.NextZombieRevive = CurTime() + 2

    dmginfo:SetDamage(0)
    pl:SetHealth(10)

    local status = pl:GiveStatus("revive_slump")
    if status then
        status:SetReviveTime(CurTime() + 2)
        status:SetReviveAnim(2)
        status:SetReviveHeal(35)

        pl.EradiVived = true
    end

    return true
end