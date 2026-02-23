INC_CLIENT()

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	local eattime = self:GetEatEndTime()
	if eattime == 0 then return end

	local delta = math.Clamp((CurTime() - self:GetEatStartTime()) / self:GetFoodEatTime(), 0, 1)
	if delta > 0 then
		local lerp = math.sin(6 * math.pi * delta)
		lerp = math.abs(lerp)

		local Offset = self.EatViewOffset

		if self.EatViewAngles then
			ang = Angle(ang.p, ang.y, ang.r)
			ang:RotateAroundAxis(ang:Right(), self.EatViewAngles.x * lerp)
			ang:RotateAroundAxis(ang:Up(), self.EatViewAngles.y * lerp)
			ang:RotateAroundAxis(ang:Forward(), self.EatViewAngles.z * lerp)
		end

		pos = pos + Offset.x * lerp * ang:Right() + Offset.y * lerp * ang:Forward() + Offset.z * lerp * ang:Up()
	end

	local rotate = self.VMPos or Vector(0, 0, 0)
    pos:Add(ang:Right() * rotate.x)
    pos:Add(ang:Forward() * rotate.y)
    pos:Add(ang:Up() * rotate.z)

	local rotateang = self.VMAng
    if rotateang then
        ang:RotateAroundAxis(ang:Right(), rotateang.x)
        ang:RotateAroundAxis(ang:Up(), rotateang.y)
        ang:RotateAroundAxis(ang:Forward(), rotateang.z)
    end

	return pos, ang + self:ViewBob(self.Owner)
end
