function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local normal = data:GetNormal() * -1

	pos = pos + normal

	sound.Play("npc/zombie_poison/pz_call1.wav", pos, 100, math.Rand(50, 75))
	for i=0, math.random(2, 3) do
		timer.Simple(i * math.Rand(0.1, 0.3), function() sound.Play("physics/flesh/flesh_squishy_impact_hard"..math.random(4)..".wav", pos, 77, math.Rand(90, 110)) end)
	end

	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(24, 32)

	local particle, size, heading

	for i=1, 12 do
		particle = emitter:Add("particles/smokey", pos)
		particle:SetVelocity(normal * 48 + VectorRand() * 32)
		particle:SetDieTime(math.Rand(6.5, 7.5))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(200)
		particle:SetEndSize(0)
		particle:SetRollDelta(math.Rand(-2.5, 2.5))
		particle:SetRoll(math.Rand(0, 360))
		particle:SetColor(100, 24, 24)
	end

	local grav = Vector(0, 0, 170)
	for i=1, 24 do
		particle = emitter:Add("!sprite_bloodspray"..math.random(8), pos)
		particle:SetVelocity(normal * -48 + VectorRand() * 64)
		particle:SetGravity(-grav)
		particle:SetDieTime(math.Rand(2, 2.5))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(math.Rand(13, 14))
		particle:SetEndSize(math.Rand(10, 12))
		particle:SetRoll(180)
		particle:SetDieTime(3)
		particle:SetColor(0, 0, 0)
		particle:SetLighting(true)
	end

	for i=1, 80 do
		heading = VectorRand()
		heading:Normalize()

		size = math.Rand(15, 25)

		particle = emitter:Add("particles/smokey", pos + heading * math.Rand(2, 64))
		particle:SetVelocity(heading * math.Rand(-128, 256))
		particle:SetDieTime(math.Rand(4.5, 6))
		particle:SetStartAlpha(200)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(size)
		particle:SetRollDelta(math.Rand(-1.5, 1.5))
		particle:SetRoll(math.Rand(0, 360))
		particle:SetColor(0, 15, 15)
		particle:SetAirResistance(math.Rand(50, 200))
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)

	util.Blood(pos, math.random(22, 26), Vector(0,0,1), 300)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
