INC_SERVER()

ENT.PropCreating = 1

local function RefreshPropMakerOwners( pl )
	for _, ent in pairs(ents.FindByClass( "prop_propmaker" ) ) do
		if ent:IsValid() and ent:GetObjectOwner() == pl then
			ent:SetObjectOwner( NULL )
		end
	end
end
hook.Add( "PlayerDisconnected", "PropMaker.PlayerDisconnected", RefreshPropMakerOwners )
hook.Add( "OnPlayerChangedTeam", "PropMaker.OnPlayerChangedTeam", RefreshPropMakerOwners )

function ENT:Initialize()
	self.Contents = {}

	self:SetModel( "models/Items/item_item_crate.mdl" )
	self:SetModelScale( 0.5, 0 )
	self:SetUseType( SIMPLE_USE )

	self:PhysicsInit( SOLID_NONE )

	self:CollisionRulesChanged()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	self:SetMaxObjectHealth( 320 )
	self:SetObjectHealth( self:GetMaxObjectHealth() )
	self:SetTrigger( true )
end

function ENT:SetObjectHealth(health)
	self:SetDTFloat(0, health)
	if health <= 0 and not self.Destroyed then
		self.Destroyed = true

		if self:GetObjectOwner():IsValidLivingHuman() then
			self:GetObjectOwner():SendDeployableLostMessage(self)
		end

		local ent = ents.Create( "prop_physics" )
		if ent:IsValid() then
			ent:SetModel( self:GetModel() )
			ent:SetMaterial( self:GetMaterial() )
			ent:SetAngles( self:GetAngles())
			ent:SetPos( self:GetPos() )
			ent:SetSkin( self:GetSkin() or 0 )
			ent:SetColor( self:GetColor() )
			ent:Spawn()
			ent:Fire( "break", "", 0 )
			ent:Fire( "kill", "", 0.1 )
		end

		local pos = self:LocalToWorld( self:OBBCenter() )

		local effectdata = EffectData()
			effectdata:SetOrigin( pos )
		util.Effect( "Explosion", effectdata, true, true )
	end
end

function ENT:OnTakeDamage( dmginfo )
	self:TakePhysicsDamage( dmginfo )

	local attacker = dmginfo:GetAttacker()
	if not (attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN) then
		self:SetObjectHealth( self:GetObjectHealth() - dmginfo:GetDamage() )
		self:ResetLastBarricadeAttacker( attacker, dmginfo )
	end
end

function ENT:PropCreate( tab, sender )
	if self.PropCreating and self.PropCreating > CurTime() then return end
	self.PropCreating = CurTime() + tab.Price * 1.375
	self.PropTab = tab
	self.Sender = sender

	local prop = ents.Create( "prop_physics" )
	if self.PropTab and prop:IsValid() then
		prop:SetModel( self.PropTab.Model )
		prop:SetPos( Vector( 0, 0, 0 ) )
		prop:SetAngles( Angle( 0, 0, 0 ) )
		prop:SetMoveType( MOVETYPE_NONE )
		prop:SetRenderMode( RENDERMODE_TRANSALPHA )
		prop:SetAlpha( 0 )

		self.PropMins = prop:OBBMins()
		self.PropMaxs = prop:OBBMaxs()

		net.Start( "zs_propmaker_send" )
			net.WriteEntity( self )
			net.WriteVector( prop:OBBMins() )
			net.WriteVector( prop:OBBMaxs() )
			net.WriteFloat( self.PropCreating )
			net.WriteString( self.PropTab.Model )
		net.Broadcast()

		prop:Remove()
	end
end

function ENT:AltUse( activator, tr )
	self:PackUp( activator )
end

function ENT:OnPackedUp( pl )
	pl:GiveEmptyWeapon("weapon_zs_propmaker")
	pl:GiveAmmo(1, "propmaker")

	pl:PushPackedItem(self:GetClass(), self:GetObjectHealth())

	self:Remove()
end

function ENT:Think()
	if self.Destroyed then
		self:Remove()
	end

	if self.PropTab and self.PropCreating and self.PropCreating <= CurTime() then
		if self.PropEnt and self.PropEnt:IsValid() then return end
		self.PropEnt = ents.Create( "prop_physics" )
		if self.PropEnt:IsValid() then
			self.PropEnt:SetModel( self.PropTab.Model )
			if self.PropMins.z > -10 then
				self.PropEnt:SetPos( self:GetPos() + Vector( 0, 0, self.PropMins.z ) )
			else
				self.PropEnt:SetPos( self:GetPos() + Vector( 0, 0, self.PropMaxs.z ) )
			end
			self.PropEnt:SetAngles( Angle( 0, 0, 0 ) )
			self.PropEnt:SetMoveType( MOVETYPE_NONE )

			self.PropEnt:Spawn()
			if GAMEMODE.SetupProps then gamemode.Call( "SetupProps" ) end
			if self.Sender and self.Sender:IsValid() then
				self.Sender:CenterNotify( COLOR_GREEN, translate.ClientFormat( self.Sender, "prop_x_created", self.PropTab.Name ) )
			end

			self.PropEnt = nil
			self.PropCreating = nil
			self.Sender = nil
		end
	end
end

function ENT:Use( activator, caller )
	if activator:Team() ~= TEAM_HUMAN or not activator:Alive() then return end

	local owner = self:GetObjectOwner()
	if not owner:IsValid() then
		self:SetObjectOwner( activator )
		self:GetObjectOwner():SendDeployableClaimedMessage( self )
		return
	end

	activator.PropMaker = self

	activator:SendLua( "GAMEMODE:OpenPropMakerMenu( MySelf:NearestPropMaker() )" )
end
