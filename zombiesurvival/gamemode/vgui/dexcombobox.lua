local PANEL = {}

PANEL.Spacers = {}

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:PerformLayout()
    self.DropButton:SetSize(15, 15)
    self.DropButton:AlignRight(4)
    self.DropButton:CenterVertical()

    self:SetTextColor(color_white)
    self:SetFont("ZSHUDFontTiny")
    
    DButton.PerformLayout(self, w, h)
end

function PANEL:OpenMenu(pControlOpener)
    if pControlOpener and pControlOpener == self.TextEntry then
        return
    end

    if #self.Choices == 0 then
        return
    end

    if IsValid(self.Menu) then
        self.Menu:Remove()
        self.Menu = nil
    end

    self.Menu = ZSDermaMenu(false, self)

    if self:GetSortItems() then
        local sorted = {}
        for k, v in pairs(self.Choices) do
            local val = tostring(v)
            if string.len(val) > 1 and not tonumber(val) and val:StartWith("#") then
                val = language.GetPhrase(val:sub(2))
            end
            table.insert(sorted, {id = k, data = v, label = val})
        end
        for _, v in SortedPairsByMemberValue(sorted, "label") do
            local option = self.Menu:AddOption(v.data, function() self:ChooseOption(v.data, v.id) end)
            if self.ChoiceIcons[v.id] then
                option:SetIcon(self.ChoiceIcons[v.id])
            end
            if self.Spacers[v.id] then
                self.Menu:AddSpacer()
            end
        end
    else
        for k, v in pairs(self.Choices) do
            local option = self.Menu:AddOption(v, function() self:ChooseOption(v, k) end)
            if self.ChoiceIcons[k] then
                option:SetIcon(self.ChoiceIcons[k])
            end
            if self.Spacers[k] then
                self.Menu:AddSpacer()
            end
        end
    end

    local x, y = self:LocalToScreen(0, self:GetTall())

    self.Menu:SetMinimumWidth(self:GetWide())
    self.Menu:Open(x, y, false, self)
    
    self:OnMenuOpened(self.Menu)
end

derma.DefineControl("DEXComboBox", "", PANEL, "DComboBox")
