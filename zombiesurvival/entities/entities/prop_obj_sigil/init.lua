INC_SERVER()

ENT.HealthLock = 0

function ENT:Initialize()
    self:DrawShadow(false)
    self:SetRenderFX(kRenderFxDistort)

    self:SetModel("models/props_wasteland/medbridge_post01.mdl")
    self:PhysicsInitBox(Vector(-16.285, -16.285, -0.29) * self.ModelScale, Vector(16.285, 16.285, 104.29) * self.ModelScale)
    self:SetUseType(SIMPLE_USE)

    self:CollisionRulesChanged()

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:EnableMotion(false)
        phys:Wake()
    end

    self:SetSigilHealthBase(self.MaxHealth)
    self:SetSigilHealthRegen(self.HealthRegen)
    self:SetSigilLastDamaged(0)

    local ent = ents.Create("prop_prop_blocker")
    if ent:IsValid() then
        ent:SetPos(self:GetPos())
        ent:SetAngles(self:GetAngles())
        ent:Spawn()
        ent:SetOwner(self)
        ent:SetParent(self)
        self:DeleteOnRemove(ent)
    end

    self.NextAttackTime = CurTime()
end

function ENT:Think()
    if CurTime() >= self.NextAttackTime then
        self:AttackNearbyEnemies()
        self.NextAttackTime = CurTime() + 1
    end
end

ENT.LegDamage = 16

function ENT:AttackNearbyEnemies()
    local Wave = GAMEMODE:GetWave()

    if Wave >= 3 then
        return
    end

    if self:GetSigilCorrupted() then
        return
    end

    local enemies = ents.FindInSphere(self:GetPos(), 300)
    local potentialTargets = {}
    local maxTargets = 3
    local humanNearby = false

    for _, ent in ipairs(enemies) do
        if ent:IsValid() and ent:IsPlayer() and ent:Alive() then
            if ent:Team() == TEAM_UNDEAD then
                table.insert(potentialTargets, ent)
            elseif ent:Team() == TEAM_HUMAN then
                local trace = util.TraceLine({
                    start = self:GetPos() + Vector(0, 0, 60),
                    endpos = ent:GetPos() + Vector(0, 0, 60),
                    filter = {self, ent},
                    mask = MASK_SOLID
                })

                if not trace.Hit then
                    humanNearby = true
                end
            end
        end
    end

    if not humanNearby then
        return
    end

    table.sort(potentialTargets, function(a, b)
        return self:GetPos():DistToSqr(a:GetPos()) < self:GetPos():DistToSqr(b:GetPos())
    end)

    local targets = {}
    for i = 1, math.min(#potentialTargets, maxTargets) do
        table.insert(targets, potentialTargets[i])
    end

    for _, target in ipairs(targets) do
        local trace = util.TraceLine({
            start = self:GetPos(),
            endpos = target:GetPos(),
            filter = {self, target},
            mask = MASK_SOLID_BRUSHONLY
        })

        if not trace.Hit then
            if target:Alive() then
                local damage = 15

                if target:IsHeadcrab() then
                    damage = damage * 3
                end

                local dmginfo = DamageInfo()
                dmginfo:SetDamage(damage)
                dmginfo:SetAttacker(self)
                dmginfo:SetInflictor(self)
                dmginfo:SetDamageType(DMG_GENERIC)
                target:TakeDamageInfo(dmginfo)

                if target.AddLegDamageExt then
                    target:AddLegDamageExt(self.LegDamage, self, self, SLOWTYPE_PULSE)
                end

                if target.AddArmDamage then
                    target:AddArmDamage(13)
                end

                local effectdata = EffectData()
                effectdata:SetOrigin(target:WorldSpaceCenter())
                effectdata:SetStart(self:GetPos() + Vector(0, 0, 60))
                effectdata:SetEntity(self)
                util.Effect("tracer_zapper", effectdata)

                self:EmitSound("ambient/levels/labs/electric_explosion5.wav", 80, 200)
            end
        end
    end
end

function ENT:Use(pl)
    if pl.NextSigilTPTry and pl.NextSigilTPTry >= CurTime() then return end

    if pl:Team() == TEAM_HUMAN and pl:Alive() and not self:GetSigilCorrupted() then
        local tpexist = pl:GetStatus("sigilteleport")
        if tpexist and tpexist:IsValid() then return end

        if GAMEMODE:NumUncorruptedSigils() >= 2 then
            local status = pl:GiveStatus("sigilteleport")
            if status:IsValid() then
                status:SetFromSigil(self)
                status:SetEndTime(CurTime() + 2 * (pl.SigilTeleportTimeMul or 1))

                pl.NextSigilTPTry = CurTime() + 1
            end
        end
    end
end

function ENT:OnTakeDamage(dmginfo)
    if self:GetSigilHealth() <= 0 or dmginfo:GetDamage() <= 0 then return end

    local attacker = dmginfo:GetAttacker()
    if attacker:IsValid() and attacker:IsPlayer() and dmginfo:GetDamage() > 2 and CurTime() >= self.HealthLock then
        if self:CanBeDamagedByTeam(attacker:Team()) then
            if attacker:Team() == TEAM_HUMAN then
                local dmgtype = dmginfo:GetDamageType()
                if bit.band(dmgtype, DMG_SLASH) ~= 0 or bit.band(dmgtype, DMG_CLUB) ~= 0 then
                    dmginfo:SetDamage(dmginfo:GetDamage() * 1.6)
                else
                    dmginfo:SetDamage(0)
                    return
                end
            end

            local oldhealth = self:GetSigilHealth()
            self:SetSigilLastDamaged(CurTime())
            self:SetSigilHealthBase(oldhealth - dmginfo:GetDamage())

            if self:GetSigilHealth() <= 0 then
                if self:GetSigilCorrupted() then
                    gamemode.Call("PreOnSigilUncorrupted", self, dmginfo)
                    self:SetSigilCorrupted(false)
                    self:SetSigilHealthBase(self.MaxHealth)
                    self:SetSigilLastDamaged(0)
                    gamemode.Call("OnSigilUncorrupted", self, dmginfo)
                else
                    gamemode.Call("PreOnSigilCorrupted", self, dmginfo)
                    self:SetSigilCorrupted(true)
                    self:SetSigilHealthBase(self.MaxHealth)
                    self:SetSigilLastDamaged(0)
                    gamemode.Call("OnSigilCorrupted", self, dmginfo)
                end
            end
        elseif attacker:Team() == TEAM_UNDEAD then
            self.HealthLock = CurTime() + 1
        end
    end
end

function ENT:UpdateTransmitState()
    return TRANSMIT_ALWAYS
end
