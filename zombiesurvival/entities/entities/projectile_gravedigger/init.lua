INC_SERVER()

function ENT:Initialize()
	self.DieTime = CurTime() + 30
	self.Touched = {}
	self.OriginalAngles = self:GetAngles()

	self:SetModel("models/props_junk/harpoon002a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetupGenericProjectile(true)

	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
	self.LastPhysicsUpdate = UnPredictedCurTime()
end

function ENT:PhysicsUpdate(phys)
	self.LastPhysicsUpdate = UnPredictedCurTime()
	local vel = phys:GetVelocity()
	phys:SetAngles(phys:GetVelocity():Angle())
	phys:SetVelocityInstantaneous(vel)
end

function ENT:Think()
	if self.PhysicsData then
		self:Explode(self.PhysicsData.HitPos, self.PhysicsData.HitNormal)
	end

	if self.DieTime <= CurTime() then
		self:Remove()
	end
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed >= 50 then
		self.PhysicsData = data
		self:NextThink(CurTime())
	end
end

function ENT:StartTouch(ent)
	if self.DieTime ~= 0 and ent:IsValidLivingPlayer() then
		local owner = self:GetOwner()
		if not owner:IsValid() then owner = self end

		if ent ~= owner and ent:Team() ~= self.Team then
			ent:EmitSound("weapons/crossbow/hitbod"..math.random(2)..".wav")
			ent:TakeSpecialDamage(self.Damage, DMG_CLUB, owner, self, nil)
			local gt = ent:KnockDown()
			if gt and gt:IsValid() then
				gt.Applier = owner
			end
			local direction = (ent:GetPos() - owner:GetPos()):GetNormalized()
			
			direction = direction + Vector(0, 0, 0.05)
			local force = direction * 850
			
			ent:SetVelocity(ent:GetVelocity() + force)

			self:Explode()
		end
	end
end


function ENT:Explode(hitpos, hitnormal)
	if self.DieTime == 0 then return end
	self.DieTime = 0

	hitpos = hitpos or self:GetPos()
	hitnormal = hitnormal or (self:GetVelocity():GetNormalized() * -1)

	local effectdata = EffectData()
		effectdata:SetOrigin(hitpos)
		effectdata:SetNormal(hitnormal)
	util.Effect("hit_hunter", effectdata)

	self:NextThink(CurTime())
end
