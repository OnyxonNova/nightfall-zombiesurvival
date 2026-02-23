INC_CLIENT()

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.NextEmit = 0
ENT.Radius = 0
ENT.MaxRadius = 100
ENT.AnimationSpeed = 150

function ENT:Initialize()
    self:DrawShadow(false)
    self.Appearing = false
    self.Disappearing = false
end

function ENT:Draw()
    local owner = self:GetOwner()
    if not owner:IsValid() or (owner == MySelf and not owner:ShouldDrawLocalPlayer()) then return end
    if owner.SpawnProtection then return end

    local weapon = owner:GetActiveWeapon()
    if weapon and weapon.GetBattlecry and weapon:GetBattlecry() > CurTime() then
        self.Appearing = true
        self.Disappearing = false
    else
        self.Appearing = false
        self.Disappearing = true
    end

    self:AnimateRadius()
    self:DrawCircle(owner)
end

function ENT:AnimateRadius()
    if self.Appearing then
        self.Radius = math.min(self.Radius + FrameTime() * self.AnimationSpeed, self.MaxRadius)
    elseif self.Disappearing then
        self.Radius = math.max(self.Radius - FrameTime() * self.AnimationSpeed, 0)
    end
end

function ENT:DrawCircle(owner)
    if MySelf:Team() ~= TEAM_ZOMBIE or self.Radius <= 0 then return end
    local pos = owner:GetPos() + Vector(0, 0, 4)

    local segments = 32
    local angleStep = (2 * math.pi) / segments

    local vertices = {}

    for i = 0, segments do
        local angle = angleStep * i
        local x = math.cos(angle) * self.Radius
        local y = math.sin(angle) * self.Radius
        table.insert(vertices, {x = x, y = y})
    end

    cam.Start3D2D(pos, Angle(0, 0, 0), 1)
        surface.SetDrawColor(255, 0, 0, 45)
        surface.DrawPoly(vertices)
    cam.End3D2D()
end
