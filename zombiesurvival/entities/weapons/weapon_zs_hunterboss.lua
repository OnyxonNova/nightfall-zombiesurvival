AddCSLuaFile()

SWEP.Base = "weapon_zs_fastzombie"
DEFINE_BASECLASS("weapon_zs_fastzombie")

SWEP.PrintName = "Охотник"

SWEP.ViewModelFOV = 42

SWEP.PounceDamage = 35

SWEP.MeleeDamage = 21

SWEP.PounceVelocity = 845
SWEP.PounceDelay = 0.2
SWEP.PouncWallDelay = 0.85

SWEP.FastHitOnly = true

SWEP.Anchor = 10

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() and self.Anchor then
		ent:GiveStatus("anchor", self.Anchor)
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:Reload()
    if self.nextWallP and CurTime() < self.nextWallP then
        return
    end

    self.nextWallP = CurTime() + self.PouncWallDelay

    if self:GetClimbing() then
        local forwardVel = self.Owner:EyeAngles():Forward() * 525
        local vel = forwardVel
        vel.z = 750
        self.Owner:SetVelocity(vel)
        self:StopClimbing()
        self:PlayPounceStartSound()

        timer.Simple(0.45, function()
            if IsValid(self) then
                self:SetPouncing(true)
            end
        end)
    end
end

function SWEP:Think()
	BaseClass.Think(self)
	
	local curtime = CurTime()
	local owner = self:GetOwner()

	if self.NextAllowJump and self.NextAllowJump <= curtime then
		self.NextAllowJump = nil

		owner:ResetJumpPower()
	end

	if self:GetClimbing() then
		if self:GetClimbSurface() and owner:KeyDown(IN_ATTACK2) then
			if curtime >= self.NextClimbSound and IsFirstTimePredicted() then
				local speed = owner:GetVelocity():LengthSqr()
				if speed >= 2500 then
					if speed >= 10000 then
						self.NextClimbSound = curtime + 0.25
					else
						self.NextClimbSound = curtime + 0.8
					end

					self:EmitSound("player/footsteps/metalgrate"..math.random(4)..".wav")
				end
			end
		else
			self:StopClimbing()
		end
	end

	if self:GetPouncing() then
		if owner:IsOnGround() or owner:WaterLevel() >= 2 then
			self:StopPounce()
		else
			local dir = owner:GetAimVector()
			dir.z = math.Clamp(dir.z, -0.5, 0.9)
			dir:Normalize()

			local traces = owner:CompensatedZombieMeleeTrace(self.PounceReach, self.PounceSize, owner:WorldSpaceCenter(), dir)
			local damage = self:GetDamage(self:GetTracesNumPlayers(traces), self.PounceDamage)

			local hit = false
			for _, trace in ipairs(traces) do
				if not trace.Hit then continue end

				if trace.HitWorld then
					if trace.HitNormal.z < 0.8 then
						hit = true
						self:MeleeHitWorld(trace)
					end
				else
					local ent = trace.Entity
					if ent and ent:IsValid() then
						hit = true
						self:MeleeHit(ent, trace, damage * (ent:IsPlayer() and self.PounceDamageVsPlayerMul or ent.PounceWeakness or 1), ent:IsPlayer() and 1 or 10)
						if ent:IsPlayer() then
							ent:GiveStatus("slow", 3)
							ent:AddLegDamage(12)
						end
					end
				end
			end

			if hit then
				if IsFirstTimePredicted() then
					self:PlayPounceHitSound()
				end

				self:StopPounce()
			end
		end
	elseif self:GetPounceTime() > 0 and curtime >= self:GetPounceTime() then
		self:StartPounce()
	end

	self:NextThink(curtime)
	return true
end

function SWEP:Move(mv)
	if self:GetPounceTime() > 0 then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)
	elseif self:GetClimbing() then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)

		local owner = self:GetOwner()
		local tr = self:GetClimbSurface()
		local angs = owner:SyncAngles()
		local dir = tr and tr.Hit and (tr.HitNormal.z <= -0.5 and (angs:Forward() * -1) or math.abs(tr.HitNormal.z) < 0.75 and tr.HitNormal:Angle():Up()) or Vector(0, 0, 1)
		local vel = Vector(0, 0, 4)

		if owner:KeyDown(IN_FORWARD) then
			owner:SetGroundEntity(nil)
			vel = vel + dir * 250
		end
		if owner:KeyDown(IN_BACK) then
			vel = vel + dir * -250
		end

		if vel.z == 4 then
			if owner:KeyDown(IN_MOVERIGHT) then
				vel = vel + angs:Right() * 200
			end
			if owner:KeyDown(IN_MOVELEFT) then
				vel = vel + angs:Right() * -200
			end
		end

		mv:SetVelocity(vel)

		return true
	end
end

local climbtrace = {mask = MASK_SOLID_BRUSHONLY, mins = Vector(-5, -5, -5), maxs = Vector(5, 5, 5)}

function SWEP:GetClimbSurface()
    local owner = self:GetOwner()

    local angles = owner:SyncAngles()
    local fwd = angles:Forward()
    local right = angles:Right()
    local up = owner:GetUp()
    local pos = owner:GetPos()
    local height = owner:OBBMaxs().z

    local directions = {
        fwd,
        -fwd,
        right,
        -right
    }

    local bestTrace = nil
    local bestHeight = 0

    for _, dir in ipairs(directions) do
        local tr, ha
        for i = 5, height, 5 do
            if not tr or not tr.Hit then
                climbtrace.start = pos + up * i
                climbtrace.endpos = climbtrace.start + dir * 36
                tr = util.TraceHull(climbtrace)
                ha = i

                if tr.Hit and not tr.HitSky then break end
            end
        end

        if tr and tr.Hit and not tr.HitSky then
            climbtrace.start = pos + up * ha
            climbtrace.endpos = climbtrace.start + up * (height - ha)
            local tr2 = util.TraceHull(climbtrace)

            if tr2.Hit and not tr2.HitSky then
                return tr2
            end

            if not bestTrace or ha > bestHeight then
                bestTrace = tr
                bestHeight = ha
            end
        end
    end

    return bestTrace
end


function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(70,75))
	self:SetRoarEndTime(CurTime() + self.RoarTime)
end

function SWEP:StartSwingingSound()
	self:GetOwner():EmitSound("npc/fast_zombie/gurgle_loop1.wav", nil, math.random(85, 90), 0.75)
end

function SWEP:StopSwingingSound()
	self:GetOwner():StopSound("npc/fast_zombie/gurgle_loop1.wav", nil, math.random(85, 90), 0.75)
end

function SWEP:PlayPounceSound()
    self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 75, math.random(100, 116))
end

function SWEP:PlayPounceStartSound()
    self:EmitSound(")npc/fast_zombie/leap1.wav", 75, math.random(75, 80))
end

function SWEP:PlayPounceHitSound()
	self:EmitSound("physics/flesh/flesh_strider_impact_bullet1.wav")
	self:EmitSound("npc/fast_zombie/wake1.wav", nil, nil, nil, CHAN_AUTO)
end

function SWEP:PlaySwingEndSound()
end

if CLIENT then

	local matSkin = Material("models/flesh")
	function SWEP:PreDrawViewModel(vm)
		render.ModelMaterialOverride(matSkin)
		render.SetColorModulation(0.57, 0.37, 0.39)
	end

	function SWEP:ViewModelDrawn()
		render.ModelMaterialOverride()
		render.SetColorModulation(1, 1, 1)
	end
end