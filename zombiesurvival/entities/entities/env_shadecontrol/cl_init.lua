INC_CLIENT()

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
    self:DrawShadow(false)
    self:SetModelScale(self:GetModelScale(), 0)
    self:SetMaterial("models/spawn_effect2")
    self.AmbientSound = CreateSound(self, ")weapons/physcannon/superphys_hold_loop.wav")
    self.AmbientSound:PlayEx(1, 60)
    self:GetOwner().ShadeControl = self
end

function ENT:OnRemove()
    self.AmbientSound:Stop()
    local owner = self:GetOwner()
    if owner.ShadeControl == self then
        owner.ShadeControl = nil
    end
end

function ENT:DrawTranslucent()
    render.SetBlend(0.5)
    render.SetColorModulation(0, 0, 1)
    self:DrawModel()
    render.SetBlend(1)
    render.SetColorModulation(1, 1, 1)
end
