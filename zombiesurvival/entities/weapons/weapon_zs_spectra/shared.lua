SWEP.Base = "weapon_zs_wraith"
DEFINE_BASECLASS("weapon_zs_wraith")

SWEP.PrintName = "Спектра"

SWEP.MeleeDelay = 1.8
SWEP.MeleeReach = 50
SWEP.MeleeSize = 4.5
SWEP.MeleeDamage = 43
SWEP.MeleeDamageType = DMG_SLASH
SWEP.MeleeAnimationDelay = 0.25

SWEP.BotMeleeReach = 140
SWEP.BotSecondaryReach = 100
SWEP.BotReloadReach = 160

SWEP.AlertDelay = 6

SWEP.Secondary.Delay = 0.88

SWEP.ViewModel = Model("models/weapons/v_pza.mdl")
SWEP.WorldModel = ""

AccessorFuncDT(SWEP, "Tormented", "Float", 1)

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local armdelay = owner:GetMeleeSpeedMul() * ((CurTime() < self:GetTormented() + 2) and 0.75 or 1)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)

	self.MeleeDelay = 0.8
	self.MeleeDamage = 43
	self:StartSwinging()
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local armdelay = owner:GetMeleeSpeedMul() * ((CurTime() < self:GetTormented() + 2) and 0.75 or 1)
	self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay * armdelay)

	self.MeleeDelay = 0.4
	self.MeleeDamage = 27
	self:StartSwinging(true)
end

function SWEP:StartSwinging(secondary)
	if not IsFirstTimePredicted() then return end

	local owner = self:GetOwner()
	local armdelay = owner:GetMeleeSpeedMul()

	self.MeleeAnimationMul = 1 / armdelay
	if self.MeleeAnimationDelay then
		self.NextAttackAnim = CurTime() + self.MeleeAnimationDelay * armdelay
	else
		self:SendAttackAnim()
	end

	if not secondary then
		self:DoSwingEvent()
	else
		owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)
	end

	self:PlayAttackSound(secondary)

	self:StopMoaning()

	if self.FrozenWhileSwinging then
		self:GetOwner():SetSpeed(1)
	end

	if self.MeleeDelay > 0 then
		self:SetSwingEndTime(CurTime() + self.MeleeDelay * armdelay)

		local trace = owner:CompensatedMeleeTrace(self.MeleeReach, self.MeleeSize)
		if trace.HitNonWorld and not trace.Entity:IsPlayer() then
			trace.IsPreHit = true
			self.PreHit = trace
		end

		self.IdleAnimation = CurTime() + (self:SequenceDuration() + (self.MeleeAnimationDelay or 0)) * armdelay
	else
		self:Swung()
	end
end

function SWEP:PlayAttackSound(secondary)
	self:EmitSound("npc/antlion/distract1.wav", 95, 30)

	if secondary then
		self:EmitSound("npc/fast_zombie/wake1.wav", 95, 60, 0.25)
		self:EmitSound("npc/antlion/attack_single2.wav", 95, 140, 0.45, CHAN_AUTO)
	else
		BaseClass.PlayAttackSound(self)
	end
end

function SWEP:PlayHitSound()
	if self.MeleeDamage > 27 then
		self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 95, 65, nil, CHAN_AUTO)
	else
		self:EmitSound("npc/fast_zombie/claw_strike"..math.random(3)..".wav", 95, 65, nil, CHAN_AUTO)
	end
end

local function viewpunch(ent, power)
	if ent:IsValid() and ent:Alive() then
		ent:ViewPunch(Angle(math.Rand(0.75, 1) * (math.random(0, 1) == 0 and 1 or -1), math.Rand(0.75, 1) * (math.random(0, 1) == 0 and 1 or -1), math.Rand(0.75, 1) * (math.random(0, 1) == 0 and 1 or -1)) * power)
	end
end

function SWEP:Reload()
    if not self.ReloadPressed then
        self.ReloadPressed = true
        
        local owner = self:GetOwner()
        if owner:IsValid() and owner:IsPlayer() then
            owner:EmitSound("npc/stalker/go_alert2a.wav", 90, 80)
            owner:ViewPunch(Angle(-30, 0, math.Rand(-25, 25)))
            owner:DoReloadEvent()
            
            owner:LagCompensation(true)
            
            local mouthpos = owner:EyePos() + owner:GetUp() * -3
            local screampos = mouthpos + owner:GetAimVector() * 16
            for _, ent in pairs(ents.FindInSphere(screampos, 92)) do
                if ent and ent:IsValidHuman() then
                    local entearpos = ent:EyePos()
                    local dist = screampos:Distance(entearpos)
                    if dist <= 92 and TrueVisible(entearpos, screampos) then
                        local power = (92 / dist - 1) * 2
                        viewpunch(ent, power)
                        for i=1, 5 do
                            timer.Simple(0.15 * i, function() viewpunch(ent, power - i * 0.125) end)
                        end
                    end
                end
            end
            
            owner:LagCompensation(false)
            
            -- Задержка перед сбросом ReloadPressed обратно в false составляет 6 секунд
            timer.Simple(6, function()
                self.ReloadPressed = false
            end)
        end
    end
end

util.PrecacheSound("npc/antlion/distract1.wav")
util.PrecacheSound("ambient/machines/slicer1.wav")
util.PrecacheSound("ambient/machines/slicer2.wav")
util.PrecacheSound("ambient/machines/slicer3.wav")
util.PrecacheSound("ambient/machines/slicer4.wav")
util.PrecacheSound("npc/zombie/claw_miss1.wav")
util.PrecacheSound("npc/zombie/claw_miss2.wav")
