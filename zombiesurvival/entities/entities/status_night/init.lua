INC_SERVER()

function ENT:Think()
    local owner = self:GetOwner()

    if self:GetDamage() <= 0 or owner:WaterLevel() > 0 or not owner:Alive() or (owner:Team() == self.Damager:Team() and owner ~= self.Damager) then
        self:Remove()
        return
    end

    local dmg = math.Clamp(self:GetDamage(), 1, 2)

    owner:TakeSpecialDamage(dmg, DMG_BURN, self.Damager and self.Damager:IsValid() and self.Damager:IsPlayer() and self.Damager:Team() ~= owner:Team() and self.Damager or owner, self)
    self:AddDamage(-dmg)

    -- Применяем невидимость к владельцу сущности
    owner:SetRenderMode(RENDERMODE_NONE) -- Устанавливаем невидимый режим отображения
    owner:SetMaterial("sprites/heatwave") -- Устанавливаем тепловой эффект (можете заменить на другой эффект или прозрачный материал по вашему выбору)
    owner:SetColor(Color(255, 255, 255, 0)) -- Устанавливаем альфа-канал цвета на 0, чтобы сделать владельца сущности невидимым

    self:NextThink(CurTime() + 0.5)
    return true
end
