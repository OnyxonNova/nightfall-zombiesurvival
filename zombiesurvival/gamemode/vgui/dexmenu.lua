OldDermaMenu = OldDermaMenu or DermaMenu

local function color(self, w, h)
    surface.SetDrawColor(180, 180, 180, 180)
    surface.DrawRect(0, 0, w, h)
end

function ZSDermaMenu()
    local derma = OldDermaMenu()
    derma.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, w, h)
    end

    local oldaddoption = derma.AddOption
    derma.AddOption = function(...)
        local option = oldaddoption(...)
        option.Paint = function(self, w, h)
            local hovered = self:IsHovered()
            if hovered then
                surface.SetDrawColor(150, 150, 150)
                surface.DrawRect(1, 1, w - 2, h - 2)
            else
                surface.SetDrawColor(0, 0, 0)
                surface.DrawRect(0, 0, w, h)
            end
        end

        for _, label in pairs(derma:GetChildren()[1]:GetChildren()) do
            if label.SetTextColor then
                label:SetTextColor(color_white)
                label:SetFont("ZSHUDFontTiny")
            else
                label.Paint = color
            end
        end

        local screenscale = BetterScreenScale()
        local oldperform = option.PerformLayout
        option.PerformLayout = function(self, ...)
            oldperform(self, ...)
            self:SetTall(28 * screenscale)
        end

        return option
    end

    return derma
end
