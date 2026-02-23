function statusValueFunction(statusname)
    return function(self, lp)
        local status = lp:GetStatus(statusname)
        if status and status:IsValid() then
            return math.max(status:GetStartTime() + status:GetDuration() - CurTime(), 0)
        end

        return 0
    end
end

local getpoison = function(self, lp)
    return lp:GetPoisonDamage()
end
local getbleed = function(self, lp)
    return lp:GetBleedDamage()
end
local getvamp = function(self, lp)
	return lp:GetPlayerVampirism()
end
local getregen = function(self, lp)
	return lp:GetRegeneration()
end

HUMAN_BUFF = 1
HUMAN_DEBUFF = 2
ZOMBIE_BUFF = 3
GM.StatusDisplays = {}
function GM:AddStatusDisplay(statusid, name, categ, desc, color, getdam, max, icon, shortname, doround)
    local datastat = {
        Name = name,
        Category = categ,
        Description = desc,
        Color = color,
        ValFunc = getdam or statusValueFunction(statusid),
        Max = max or 10,
        Icon = icon,
        StatusId = statusid,
        ShortName = shortname,
        DoRound = doround or false
    }
    self.StatusDisplays[statusid] = datastat
    return datastat
end

GM:AddStatusDisplay(
    "poison",
    "Яд",
    HUMAN_DEBUFF,
    "Наносит урон с течением времени",
    Color(180, 200, 0),
    getpoison,
    GM.MaxPoisonDamage,
    Material("zombiesurvival/statuseffects/poison.png"),
    "ЯД",
    true
)
GM:AddStatusDisplay(
    "bleed",
    "Кровотечение",
    HUMAN_DEBUFF,
    "Наносит урон с течением времени",
    Color(220, 0, 0),
    getbleed,
    GM.MaxBleedDamage,
    Material("zombiesurvival/statuseffects/bleed.png"),
    "КРОВО",
    true
)
GM:AddStatusDisplay(
    "vampirism",
    "Вампиризм",
    HUMAN_BUFF,
    "Восполняет кровавую броню с течением времени",
    Color(235, 65, 65),
    getvamp,
    60,
    Material("zombiesurvival/statuseffects//vampirism.png"),
    "ВАМП",
    true
)
GM:AddStatusDisplay(
    "enfeeble",
    "Хрупкость",
    HUMAN_DEBUFF,
    "На 40% получаете больше урона от зомби",
    Color(255, 50, 50),
    nil,
    10,
    Material("zombiesurvival/statuseffects/infeeble.png"),
    "ХРУП"
)
GM:AddStatusDisplay(
    "dimvision",
    "Слепота",
    HUMAN_DEBUFF,
    "Уменьшает дальность видимости",
    Color(90, 90, 90),
    nil,
    10,
    Material("zombiesurvival/statuseffects/dim_vision.png"),
    "СЛЕП"
)
GM:AddStatusDisplay(
    "slow",
    "Замедление",
    HUMAN_DEBUFF,
    "Заставляет вас двигаться медленнее",
    Color(75, 140, 75),
    nil,
    10,
    Material("zombiesurvival/statuseffects/slow.png"),
    "ЗАМЕ"
)
GM:AddStatusDisplay(
    "frost",
    "Мороз",
    HUMAN_DEBUFF,
    "Уменьшает скорость перезарядки, стрельбы и увеличивает время замаха в ближнем бою",
    Color(0, 135, 255),
    nil,
    9,
    Material("zombiesurvival/statuseffects/frost.png"),
    "МОРОЗ"
)
GM:AddStatusDisplay(
    "frightened",
    "Испуганный",
    HUMAN_DEBUFF,
    "Создаёт сильный эффект прицельной встряски",
    Color(155, 0, 255),
    nil,
    10,
    Material("zombiesurvival/statuseffects/tremors.png"),
    "ИСПУГ"
)
GM:AddStatusDisplay(
    "nightmarescare",
    "Растерянность",
    HUMAN_DEBUFF,
    "Вводит в замешательство ваш интерфейс",
    Color(80, 80, 80),
    nil,
    16,
    Material("zombiesurvival/statuseffects/confused.png"),
    "РАСТ"
)
GM:AddStatusDisplay(
    "sickness",
    "Болезнь",
    HUMAN_DEBUFF,
    "-50% Силы лечения по вам и не позволяет есть еду",
    Color(255, 120, 0),
    nil,
    15,
    Material("zombiesurvival/statuseffects/sickness.png"),
    "БОЛЕН"
)
GM:AddStatusDisplay(
    "knockdown",
    "Сбитый",
    HUMAN_DEBUFF,
    "Не позволяет вам делать что-либо, пока вы сбиты с ног",
    Color(157, 75, 20),
    nil,
    5,
    Material("zombiesurvival/statuseffects/knock_down.png"),
    "СБИТ"
)
GM:AddStatusDisplay(
    "anchor",
    "Якорь",
    HUMAN_DEBUFF,
    "Увеличивает вес на 25%",
    Color(140, 140, 140),
    nil,
    8,
    Material("zombiesurvival/statuseffects/anchor.png"),
    "ЯКОР"
)
GM:AddStatusDisplay(
    "strengthdartboost",
    "Сила",
    HUMAN_BUFF,
    "Увеличивает урон на 25%",
    Color(200, 100, 90),
    nil,
    10,
    Material("zombiesurvival/statuseffects/strength_shot.png"),
    "СИЛА"
)
GM:AddStatusDisplay(
    "laststand",
    "Последний бой",
    HUMAN_BUFF,
    "Увеличивает урон в ближнем бою в 2 раза",
    Color(155, 25, 25),
    nil,
    60,
    Material("zombiesurvival/statuseffects/strength_shot.png"),
    "БОЙ"
)
GM:AddStatusDisplay(
    "adrenalineamp",
    "Скорость",
    HUMAN_BUFF,
    "Увеличивает скорость передвижения",
    Color(170, 200, 120),
    nil,
    10,
    Material("zombiesurvival/statuseffects/speed_up.png"),
    "СКОР"
)
GM:AddStatusDisplay(
    "healdartboost",
    "Спешка",
    HUMAN_BUFF,
    "Увеличивает скорость передвижения на 35 единиц",
    Color(130, 220, 110),
    nil,
    10,
    Material("zombiesurvival/statuseffects/speed_up.png"),
    "СПЕШ"
)
GM:AddStatusDisplay(
    "medrifledefboost",
    "Защита",
    HUMAN_BUFF,
    "Уменьшает урон на 30%.",
    Color(90, 120, 220),
    nil,
    10,
    Material("zombiesurvival/statuseffects/defense.png"),
    "ЗАЩ"
)
GM:AddStatusDisplay(
    "reaper",
    "Жнец",
    HUMAN_BUFF,
    "Увеличивает урон на +8% за каждый уровень Жнеца",
    Color(130, 30, 140),
    nil,
    14,
    Material("zombiesurvival/statuseffects/reaper.png"),
    "ЖНЕЦ"
)
GM:AddStatusDisplay(
    "adrenaline",
    "Адреналин",
    HUMAN_BUFF,
    "Увеличивает скорость передвижения на 40 единиц",
    Color(100, 240, 100),
    nil,
    20,
    Material("zombiesurvival/statuseffects/adrenaline.png"),
    "АДРЕН"
)
GM:AddStatusDisplay(
    "renegade",
    "Ренегат",
    HUMAN_BUFF,
    "Увеличивает урон по голове на 10%",
    Color(235, 160, 40),
    nil,
    17,
    Material("zombiesurvival/statuseffects/headshot_stacks.png"),
    "РЕНЕ"
)
GM:AddStatusDisplay(
    "renegeration",
    "Регенерация",
    HUMAN_BUFF,
    "Восстанавливает постепенно здоровье",
    Color(255, 35, 152),
    getregen,
    GM.MaxRegeneration,
    Material("zombiesurvival/statuseffects/regeneration.png"),
    "РЕГЕ",
    true
)
GM:AddStatusDisplay(
    "rally",
    "Скорость",
    ZOMBIE_BUFF,
    "Увеличивает скорость передвижения",
    Color(215, 0, 100),
    nil,
    10,
    Material("zombiesurvival/statuseffects/speed_up.png"),
    "СКОР"
)
GM:AddStatusDisplay(
    "zombie_battlecry",
    "Рёв",
    ZOMBIE_BUFF,
    "Увеличивает скорость атаки",
    Color(255, 50, 50),
    nil,
    1,
    Material("zombiesurvival/statuseffects/battlecry.png"),
    "РЁВ"
)
GM:AddStatusDisplay(
    "zombieshield",
    "Щит",
    ZOMBIE_BUFF,
    "Уменьшает урон на 35%",
    Color(255, 25, 25),
    nil,
    1,
    Material("zombiesurvival/statuseffects/defense.png"),
    "ЩИТ"
)
GM:AddStatusDisplay(
    "shieldrmarrow",
    "Марой",
    ZOMBIE_BUFF,
    "Создаёт Щит который поглощает 99% урона",
    Color(0, 25, 255),
    nil,
    7,
    Material("zombiesurvival/statuseffects/marrow.png"),
    "МАРОЙ"
)
GM:AddStatusDisplay(
    "shieldfmarrow",
    "Марой",
    ZOMBIE_BUFF,
    "Даёт Щит который поглощает 99% урона",
    Color(255, 25, 0),
    nil,
    6,
    Material("zombiesurvival/statuseffects/marrow.png"),
    "МАРОЙ"
)

local PANEL = {}

PANEL.StatusPanels = {}

function PANEL:Init()
    self:DockMargin(0, 0, 0, 0)
    self:DockPadding(0, 0, 0, 0)

    self.StatusPanels = {}

    for _, statusdisp in pairs(GAMEMODE.StatusDisplays) do
        status = vgui.Create("ZSStatus", self)
        status:SetAlpha(255)
        status:SetColor(statusdisp.Color)
        status:SetMemberName(statusdisp.ShortName)
        status.GetMemberValue = statusdisp.ValFunc
        status.MemberMaxValue = statusdisp.Max
        status.Icon = statusdisp.Icon
		status.Category = statusdisp.Category
		status.StatusId = statusdisp.StatusId
        status.DoRound = statusdisp.DoRound
        status:Dock(LEFT)

        table.insert(self.StatusPanels, status)
    end

    self:ParentToHUD()
    self:InvalidateLayout()
end

function PANEL:PerformLayout()
    local w = 0
    for _, child in pairs(self:GetChildren()) do
        w = w + child:GetWide()
    end

    self:SetSize(w, 400 * BetterScreenScale())

	self:AlignLeft(math.max(0, ScrW() * 0.01))
	self:CenterVertical(0.91)
end

function PANEL:Think()
    local lp = LocalPlayer()
    if lp:IsValid() then
        for _, panel in pairs(self.StatusPanels) do
            panel:StatusThink(lp)
        end
    end
end

vgui.Register("ZSStatusArea", PANEL, "Panel")

PANEL = {}

PANEL.MemberValue = 0
PANEL.LerpMemberValue = 0
PANEL.MemberMaxValue = 100
PANEL.MemberName = "Unnamed"

function PANEL:SetColor(col) self.m_Color = col end
function PANEL:GetColor() return self.m_Color end
function PANEL:SetMemberName(n) self.MemberName = n end
function PANEL:GetMemberName() return self.MemberName end

function PANEL:Init()
    self:SetColor(Color(255, 255, 255))
    self:SetTall(BetterScreenScale() * 68)
    self:SetWide(BetterScreenScale() * 50)
end

function PANEL:StatusThink(lp)
    if self.GetMemberValue then
        self.MemberValue = self:GetMemberValue(lp) or self.MemberValue
    end
    if self.GetMemberMaxValue then
        self.MemberMaxValue = self:GetMemberMaxValue(lp) or self.MemberMaxValue
    end

    if self.MemberValue > self.LerpMemberValue then
        self.LerpMemberValue = self.MemberValue
    elseif self.MemberValue < self.LerpMemberValue then
        self.LerpMemberValue = math.Approach(self.LerpMemberValue, self.MemberValue, FrameTime() * 30)
    end

    if self.MemberValue < 0.1 and self:GetWide() ~= 0 then
        self:SetWide(0)
        self:GetParent():InvalidateLayout()
    elseif self.MemberValue > 0.1 and self:GetWide() == 0 then
        self:SetWide(BetterScreenScale() * 50)
        self:GetParent():InvalidateLayout()
    end
end

local texDownEdge = surface.GetTextureID("gui/gradient_down")
function PANEL:Paint(w, h)
    local value = self.LerpMemberValue
    if value <= 0 then return end

    local col = self:GetColor()
    local max = self.MemberMaxValue
    local screenscale = BetterScreenScale()
    local scare = LocalPlayer():GetStatus("nightmarescare")

    local y = 0

    y = y + draw.GetFontHeight("ZSBodyTextFont") * 2

    local boxsize = 42 * screenscale	

    surface.SetDrawColor(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * 0.75)
    surface.SetTexture(texDownEdge)
    surface.DrawTexturedRect(w * 0.5 - boxsize * 0.5, h * 0.5 - boxsize * 0.5, boxsize, boxsize)
    surface.SetDrawColor(col.r * 0.8, col.g * 0.8, col.b * 0.8, col.a * 0.3)
    surface.DrawRect(w * 0.5 - boxsize * 0.5, h * 0.5 - boxsize * 0.5, boxsize, boxsize)

    local perc = function(add) return scare and 1 or math.Clamp((value - max * add) / (max * 0.25), 0, 1) end

    if self.Icon then
        surface.SetMaterial(self.Icon)
        surface.SetDrawColor(col.r * 0.6 + 100, col.g * 0.6 + 100, col.b * 0.6 + 100, col.a * 0.8)
        surface.DrawTexturedRect(w * 0.5 - boxsize * 0.5, h * 0.5 - boxsize * 0.5, boxsize, boxsize)
    end

    surface.SetDrawColor(col)
    surface.DrawRect(
        w * 0.5 + boxsize * 0.5,
        h * 0.5 + boxsize * 0.5 - (boxsize + 2) * perc(0.75),
        2,
        math.ceil((boxsize + 2) * perc(0.75))
    )
    surface.DrawRect(
        w * 0.5 - boxsize * 0.5,
        h * 0.5 + boxsize * 0.5,
        (boxsize + 2) * perc(0.5),
        2
    )
    surface.DrawRect(
        w * 0.5 - boxsize * 0.5 - 2,
        h * 0.5 - boxsize * 0.5,
        2,
        (boxsize + 2) * perc(0.25)
    )
    surface.DrawRect(
        w * 0.5 + boxsize * 0.5 + 2 - (boxsize + 4) * perc(0),
        h * 0.5 - boxsize * 0.5 - 2,
        math.ceil((boxsize + 2) * perc(0)),
        2
    )

    if scare and self.StatusId ~= "nightmarescare" then
        value = math.floor(math.abs(math.sin(CurTime())) * 100)
    end

    local num = self.DoRound and math.ceil(value) or math.Round(value, 1)
    draw.SimpleText(num, "ZSHUDFontSmall", w * 0.5, y + h * 0.5 - boxsize / 1.25, color_white_alpha230, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(self:GetMemberName(), "ZSHUDFontSmallest", w * 0.5, y + h * 0.5 - boxsize * 0.5 - 48 * screenscale, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("ZSStatus", PANEL, "Panel")