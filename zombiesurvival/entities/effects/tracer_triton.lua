function EFFECT:Init( data )
	self.Position = data:GetStart()- Vector(0, 100, -3000)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
	self.EndPos = data:GetOrigin()

	self.Alpha = 255
	self.Life = 0

	self:SetRenderBoundsWS( self.StartPos, self.EndPos )
end

function EFFECT:Think( )
	self.Life = self.Life + FrameTime() * 6
	self.Alpha = 255 * ( 1 - self.Life )
	return ( self.Life < 1 )
end

local beammat = Material("trails/laser")
local glowmat = Material("sprites/light_glow02_add")
function EFFECT:Render()
	local texcoord = math.Rand( 0, 1 )

	local norm = (self.StartPos - self.EndPos) * self.Life
	local dir = (self.StartPos - self.EndPos):Angle()
	local dfwd = dir:Forward()
	local dup = dir:Up()
	local drgt = dir:Right()
	local nlen = norm:Length()

	local prevspinpos = self.StartPos
	local alpha = 1 - self.Life

	local emitter = ParticleEmitter(self.EndPos)
	emitter:SetNearClip(24, 32)

	local particle = emitter:Add("effects/spark", self.EndPos - (self.EndPos - self.StartPos) * math.Rand(0, 1))
	local vel = VectorRand():GetNormal() * 120
	particle:SetDieTime(0.2)
	particle:SetColor(55, 100, 255)
	particle:SetStartAlpha(250)
	particle:SetEndAlpha(0)
	particle:SetStartSize(2)
	particle:SetEndSize(0)
	particle:SetVelocity(vel)
	particle:SetGravity(vel * -2.5)

	emitter:Finish() emitter = nil collectgarbage("step", 64)

	render.SetMaterial(beammat)
	render.DrawBeam(self.StartPos, self.EndPos, 20, texcoord, texcoord + nlen / 128, Color(255, 255, 255, 255 * alpha))
	render.SetMaterial(glowmat)
	render.DrawSprite(self.EndPos, 50, 50, Color(55, 100, 255, 230 * alpha))
end
