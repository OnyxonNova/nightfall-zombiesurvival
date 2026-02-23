EFFECT.Height = 2000
EFFECT.Bits = 20

function EFFECT:Init(effectData)
    local origin = effectData:GetOrigin()
    local angles = effectData:GetAngles()
    local randomOffset = VectorRand() * math.Rand(360, 520)
    randomOffset.z = 0
    self:SetRenderBounds(Vector(-200, -200, -20), Vector(200, 200, self.Height))

    local particleEmitter = ParticleEmitter(origin)
    if not particleEmitter then
        return
    end

    particleEmitter:SetNearClip(24, 32)
    local particle

    for i = 1, self.Bits do
        local fraction = i / self.Bits
        local position = origin + vector_up * self.Height * fraction + randomOffset * fraction
        particle = particleEmitter:Add("particles/smokey", position + VectorRand() * 3)
        particle:SetVelocity(VectorRand() * 30 - vector_up * 150 * fraction)
        particle:SetDieTime(math.Rand(2.5, 3.5) + 7 * (1 - fraction))
        particle:SetStartAlpha(math.random(160, 210) + 55 * (1 - fraction))
        particle:SetEndAlpha(0)
        particle:SetStartSize(math.Rand(40, 60) + 135 * (1 - fraction))
        particle:SetEndSize(particle:GetStartSize() / 4)
        particle:SetRollDelta(math.Rand(-0.5, 0.5))
        particle:SetRoll(math.Rand(0, 360))
        particle:SetAirResistance(10)
        particle:SetColor(80, 80, 80)
    end

    particleEmitter:Finish()
    particleEmitter = nil
    collectgarbage("step", 64)

    self:EmitSound("npc/env_headcrabcanister/explosion.wav", 100, math.Rand(70, 80), nil, CHAN_AUTO)

    local effectData = EffectData()
    effectData:SetOrigin(origin)
    effectData:SetAngles(angles)
    util.Effect("proprock_spawn", effectData)
end

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end
