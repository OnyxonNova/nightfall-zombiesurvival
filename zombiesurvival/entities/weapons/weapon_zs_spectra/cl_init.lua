INC_CLIENT()

SWEP.ViewModelFOV = 47

function SWEP:PreDrawViewModel(vm)
	self:GetOwner():CallZombieFunction0("PrePlayerDraw")
end

function SWEP:PostDrawViewModel(vm)
	self:GetOwner():CallZombieFunction0("PostPlayerDraw")
end