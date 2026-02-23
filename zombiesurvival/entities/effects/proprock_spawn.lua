local modelPath = "models/props_debris/destroyedceiling01d.mdl"
local traceData = {mask = MASK_SOLID_BRUSHONLY}
local offset = -7
local holeMaterial = CreateMaterial("propmonster_hole", "VertexLitGeneric", {["$basetexture"] = "", ["$model"] = 1})

function EFFECT:Init(effectData)
    local origin = effectData:GetOrigin()
    local angles = effectData:GetAngles()
    local upwardVector = vector_up
    angles.p = 0
    self:SetModel(modelPath)
    self:SetModelScale(0.95, 0)
    angles:RotateAroundAxis(angles:Up(), 180)
    angles:RotateAroundAxis(angles:Right(), 180)
    traceData.start = origin + vector_up * 15
    traceData.endpos = traceData.start - vector_up * 300
    local traceResult = util.TraceLine(traceData)
    local useHoleMaterial = false

    if traceResult and traceResult.Hit and traceResult.HitWorld and traceResult.HitNormal then
        local hitNormalAngle = traceResult.HitNormal:Angle()
        angles = hitNormalAngle
        angles:RotateAroundAxis(angles:Right(), 90)
        upwardVector = traceResult.HitNormal
        util.Decal("Scorch", traceResult.HitPos + traceResult.HitNormal, traceResult.HitPos - traceResult.HitNormal)

        if traceResult.HitTexture and string.find(traceResult.HitTexture, "/") then
            local texture = Material(traceResult.HitTexture):GetTexture("$basetexture")
            if texture then
                holeMaterial:SetTexture("$basetexture", texture)
                self:SetMaterial("!propmonster_hole")
                useHoleMaterial = true
            end
        end
    end

    self:SetAngles(angles)
    self:SetPos(traceResult.HitPos - angles:Up() * offset)
    self.RenderPosition1 = Vector(self:GetPos().x, self:GetPos().y, self:GetPos().z)
    self.RenderPosition1 = self.RenderPosition1 + angles:Right() * 11 + angles:Forward() * -11
    self.RenderPosition2 = Vector(self:GetPos().x, self:GetPos().y, self:GetPos().z)
    self.RenderPosition2 = self.RenderPosition2 + angles:Right() * -11 + angles:Forward() * 11
    self.RenderAngles1 = Angle(angles.p, angles.y, angles.r)
    angles:RotateAroundAxis(angles:Up(), 180)
    self.RenderAngles2 = Angle(angles.p, angles.y, angles.r)
    self:SetRenderBounds(Vector(-50, -50, -50), Vector(60, 60, 60))
    origin = self:GetPos() + angles:Up() * offset * 2

    sound.Play("physics/wood/wood_crate_break4.wav", origin, 77, math.Rand(35, 45))
    sound.Play("physics/concrete/concrete_break2.wav", origin, 77, math.Rand(110, 120))

    local boxSize = Vector(3, 3, 3)
    local boxSizeNeg = boxSize * -1

    for i = 1, 6 do
        local direction = upwardVector
        local rockModel = ClientsideModel("models/props_junk/Rock001a.mdl", RENDERGROUP_OPAQUE)
        if rockModel:IsValid() then
            rockModel:SetModelScale(math.Rand(0.7, 2), 0)
            rockModel:SetPos(origin + direction * 10)
            rockModel:PhysicsInitBox(boxSizeNeg, boxSize)
            rockModel:SetCollisionBounds(boxSizeNeg, boxSize)
            if useHoleMaterial then
                rockModel:SetMaterial("!propmonster_hole")
            end
            local physicsObject = rockModel:GetPhysicsObject()
            if physicsObject:IsValid() then
                physicsObject:Wake()
                physicsObject:SetMaterial("rock")
                physicsObject:ApplyForceCenter(direction * math.Rand(400, 800))
            end
            SafeRemoveEntityDelayed(rockModel, math.Rand(6, 10))
        end
    end

    self.SpawnDuration = 0.2
    self.SpawnTime = CurTime() + self.SpawnDuration
    self.DieTime = CurTime() + 4

    local particleEmitter = ParticleEmitter(origin)
    if not particleEmitter then
        return
    end
    particleEmitter:SetNearClip(24, 32)
    local particle

    for i = 1, 12 do
        particle = particleEmitter:Add("particles/smokey", origin)
        particle:SetVelocity(upwardVector * 28 + VectorRand() * 72)
        particle:SetDieTime(math.Rand(3.5, 4.5))
        particle:SetStartAlpha(110)
        particle:SetEndAlpha(0)
        particle:SetStartSize(math.Rand(60, 100))
        particle:SetEndSize(0)
        particle:SetRollDelta(math.Rand(-2.5, 2.5))
        particle:SetRoll(math.Rand(0, 360))
        particle:SetColor(80, 80, 80)
    end

    particleEmitter:Finish()
    particleEmitter = nil
    collectgarbage("step", 64)
end

function EFFECT:Think()
    return self.DieTime and self.DieTime >= CurTime()
end

local offsetVector = Vector(0, 0, 30)
local rotationAngle = Angle(25, 0, 25)

function EFFECT:Render()
    if self.RenderPosition1 and self.RenderPosition2 and self.RenderAngles1 and self.RenderAngles2 then
        local fadeOutFactor = math.Clamp(self.DieTime - CurTime(), 0, 1)
        local fadeInFactor = math.Clamp((self.SpawnTime - CurTime()) / self.SpawnDuration, 0, 1)
        local inverseFadeInFactor = 1 - fadeInFactor
        fadeInFactor = fadeInFactor ^ 10
        local normalVector = -1 * self:GetUp()
        local clippingPlaneDistance = normalVector:Dot(self:GetPos() - self:GetUp() * 3)
        local previousClipState = render.EnableClipping(true)
        render.PushCustomClipPlane(normalVector, clippingPlaneDistance)
        render.SetBlend(fadeOutFactor)
        self:SetPos(self.RenderPosition1 - fadeInFactor * offsetVector)
        self:SetAngles(self.RenderAngles1 + fadeInFactor * rotationAngle - rotationAngle / 5)
        self:SetupBones()
        self:DrawModel()
        self:SetPos(self.RenderPosition2 - fadeInFactor * offsetVector)
        self:SetAngles(self.RenderAngles2 + fadeInFactor * rotationAngle - rotationAngle / 5)
        self:SetupBones()
        self:DrawModel()
        render.SetBlend(1)
        render.PopCustomClipPlane()
        render.EnableClipping(previousClipState)
    end
end
