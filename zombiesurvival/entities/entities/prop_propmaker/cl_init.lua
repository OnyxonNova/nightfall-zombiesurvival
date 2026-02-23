INC_CLIENT()

ENT.Contents = "EMPTY"

ENT.WElements = {
	{
		model = "models/props_wasteland/buoy01.mdl",
		pos = Vector( 0, 0, -23.6 ),
		ang = Angle( 0, 0, 0 ),
		size = Vector( 0.6, 0.6, 0.1 ),
		color = Color( 255, 255, 255 ),
		blend = 255,
		material = "metal2",
	},

	{
		model = "models/props_wasteland/buoy01.mdl",
		pos = Vector( 0, 0, -23.6 ),
		ang = Angle( 0, 0, 0 ),
		size = Vector( 1, 1, 0.2 ),
		color = Color( 255, 255, 255 ),
		blend = 255,
		material = "metal2",
	},

	{
		model = "models/props_c17/utilityconnecter005.mdl",
		pos = Vector( 0, 0, -4.5 ),
		ang = Angle( 0, 45, 0 ),
		size = Vector( 2, 3.5, 0.35 ),
		color = Color( 255, 255, 255 ),
		blend = 255,
		material = "metal2",
	},

	{
		model = "models/props_c17/utilityconnecter005.mdl",
		pos = Vector( 0, 0, -4.5 ),
		ang = Angle( 0, -45, 0 ),
		size = Vector( 2, 3.5, 0.25 ),
		color = Color( 255, 255, 255 ),
		blend = 255,
		material = "metal2",
	},
}

function ENT:Initialize()
	local matrix = Matrix()
	matrix:Scale( Vector( 1, 1, 2 ) )
	matrix:SetTranslation( Vector( -1, 1, -24 ) )
	self:EnableMatrix( "RenderMultiply", matrix )

	self.WorldEnts = {}

	for name, tab in ipairs( self.WElements ) do
		local model = ClientsideModel( tab.model )
		if model:IsValid() then
			model:SetPos( self:LocalToWorld( tab.pos ) )
			model:SetAngles( self:LocalToWorldAngles( tab.ang ) )
			model:SetSolid( SOLID_NONE )
			model:SetMoveType( MOVETYPE_NONE )
			model:SetColor( tab.color )
			model:SetRenderMode( RENDERMODE_NORMAL )
			model:SetAlpha( tab.blend )
			model:SetMaterial( tab.material )

			model:SetParent( self )
			model:SetOwner( self )

			matrix = Matrix()
			matrix:Scale( tab.size )
			model:EnableMatrix( "RenderMultiply", matrix )

			model:Spawn()
			self.WorldEnts[ name ] = model
		end
	end

	--self:SetRenderBounds( Vector( -72, -72, -72 ), Vector( 2, 72, 128 ) )
end

function ENT:OnRemove()
	for name, ent in pairs( self.WorldEnts ) do
		ent:Remove()
	end
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
end

local matWhite = Material( "models/debug/debugwhite" )
function ENT:RenderInfo(pos, ang, owner)
	cam.Start3D2D( self:LocalToWorld( Vector( -18, 0, -19 ) ), ang, 0.05 )
		local name = ""
		if owner:IsValid() and owner:IsPlayer() then
			name = owner:ClippedName()
		end

		self:Draw3DHealthBar( math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1 ), name, 0, 0.7 )
	cam.End3D2D()

	cam.Start3D2D( self:LocalToWorld( Vector( 18, 0, -19 ) ), ang, 0.05 )
		local name = ""
		if owner:IsValid() and owner:IsPlayer() then
			name = owner:ClippedName()
		end

		self:Draw3DHealthBar( math.Clamp(self:GetObjectHealth() / self:GetMaxObjectHealth(), 0, 1 ), name, 0, 0.7 )
	cam.End3D2D()
end

ENT.Mins = Vector( -15, -15, -24 )
ENT.Maxs = Vector( 15, 15, 0 )

local vOffset = Vector( 12.75, 0, 13 )
local vOffset2 = Vector( -12.75, 0, 13 )
local aOffset = Angle( 0, 90, 90 )
local aOffset2 = Angle( 0, 270, 90 )
local matBlend = CreateMaterial( "blend18", "LightmappedGeneric", {
	[ "$basetexture" ] = "cs_italy/black",
	[ "$alphatest" ] = 1,
	[ "$alphatestreference" ] = .9,
	[ "$allowalphatocoverage" ] = 1
} )

function ENT:Draw()
	--render.ModelMaterialOverride( matBlend )
	render.SetBlend( 0 )
	self:DrawModel()
	render.SetBlend( 1 )
	--render.ModelMaterialOverride( nil )

	if not MySelf:IsValid() or MySelf:Team() ~= TEAM_HUMAN then return end

	--render.DrawWireframeBox( self:GetPos(), self:GetAngles(), self.Mins, self.Maxs, Color( 255, 255, 255 ), true )

	if self.PropModel and self.PropCreating and self.PropCreating > CurTime() then
		if self.PropEnt and self.PropEnt:IsValid() then self.PropEnt:Remove() end
		self.PropEnt = ClientsideModel( self.PropModel, RENDERGROUP_OPAQUE )
		if self.PropEnt:IsValid() then
			if self.PropMins.z > -10 then
				self.PropEnt:SetPos( self:GetPos() + Vector( 0, 0, self.PropMins.z ) )
			else
				self.PropEnt:SetPos( self:GetPos() + Vector( 0, 0, self.PropMaxs.z ) )
			end
			self.PropEnt:SetAngles( Angle( 0, 0, 0 ) )
			self.PropEnt:SetSolid( SOLID_NONE )
			self.PropEnt:SetMoveType( MOVETYPE_NONE )
			//self.PropEnt:SetColor( 255, 255, 255 )
			self.PropEnt:SetRenderMode( RENDERMODE_TRANSALPHA )
			self.PropEnt:SetAlpha( 0 )

			local z = Vector( self.PropEnt:GetPos().x, self.PropEnt:GetPos().y, self.PropEnt:GetPos().z + self.PropMaxs.z )
			local pos = z + Vector( 0, 0, -( self.PropCreating - CurTime() ) * self.PropMaxs.z / 24 )
			local normal = Vector( 0, 0, 1 )

			render.EnableClipping( true )
				render.PushCustomClipPlane( normal, normal:Dot( pos ) )
				render.ModelMaterialOverride( Material( "models/wireframe" ) )
				self.PropEnt:DrawModel()
				render.PopCustomClipPlane()
				render.ModelMaterialOverride()

				normal = normal * -1
				render.PushCustomClipPlane( normal, normal:Dot( pos ) )
				render.SetColorModulation( 1, 1, 1 )
				self.PropEnt:DrawModel()
				render.PopCustomClipPlane()
			render.EnableClipping( false )

			self.PropEnt:Spawn()
		end
	else
		if self.PropEnt and self.PropEnt:IsValid() then
			self.PropEnt:Remove()
		end
	end

	local owner = self:GetObjectOwner()
	self:RenderInfo( self:LocalToWorld( vOffset ), self:LocalToWorldAngles( aOffset ), owner )
	self:RenderInfo( self:LocalToWorld( vOffset2 ), self:LocalToWorldAngles( aOffset2 ), owner )
end

net.Receive( "zs_propmaker_send", function( length )
	local ent = net.ReadEntity()

	ent.PropMins = net.ReadVector()
	ent.PropMaxs = net.ReadVector()
	ent.PropCreating = net.ReadFloat()
	ent.PropModel = net.ReadString()

	MySelf.PropMaker = ent
end )