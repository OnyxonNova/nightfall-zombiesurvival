local meta = FindMetaTable("Player")

function meta:AddInventoryItem(item)
	if not GAMEMODE:IsInventoryItem(item) then return false end

	self.ZSInventory[item] = self.ZSInventory[item] and self.ZSInventory[item] + 1 or 1

	if GAMEMODE:GetInventoryItemType(item) == INVCAT_TRINKETS then
		self:ApplyTrinkets()
	end

	net.Start("zs_inventoryitem")
		net.WriteString(item)
		net.WriteInt(self.ZSInventory[item], 5)
	net.Send(self)

	return true
end

function meta:TakeInventoryItem(item, upgrading)
	if not self:HasInventoryItem(item) then return false end

	local setnil = self.ZSInventory[item] == 1
	self.ZSInventory[item] = self.ZSInventory[item] - 1

	if setnil then
		self.ZSInventory[item] = nil
	end

	if GAMEMODE:GetInventoryItemType(item) == INVCAT_TRINKETS then
		self:ApplyTrinkets()
	end

	net.Start("zs_inventoryitem")
		net.WriteString(item)
		net.WriteInt(self.ZSInventory[item] or 0, 5)
		net.WriteBool(upgrading and true or false)
	net.Send(self)

	return true -- Return true aka item was taken
end

function meta:WipePlayerInventory()
	if not self.ZSInventory or table.Count(self.ZSInventory) == 0 then return end

	self.ZSInventory = {}
	self:ApplyTrinkets()

	net.Start("zs_wipeinventory")
	net.Send(self)
end

function meta:DropInventoryItemByType(itype)
	if GAMEMODE.ZombieEscape then return end
	if not self:HasInventoryItem(itype) then return end

	local ent = ents.Create("prop_invitem")
	if ent:IsValid() then
		ent:SetInventoryItemType(itype)
		ent:Spawn()
		ent.DroppedTime = CurTime()

		self:TakeInventoryItem(itype)
		self:UpdateAltSelectedWeapon()

		return ent
	end
end

function meta:DropAllInventoryItems()
	local vPos = self:GetPos()
	local vVel = self:GetVelocity()
	local zmax = self:OBBMaxs().z * 0.75
	for invitem, count in pairs(self:GetInventoryItems()) do
		for i = 1, count do
			local ent = self:DropInventoryItemByType(invitem)
			if ent and ent:IsValid() then
				ent:SetPos(vPos + Vector(math.Rand(-16, 16), math.Rand(-16, 16), math.Rand(2, zmax)))
				ent:SetAngles(VectorRand():Angle())
				local phys = ent:GetPhysicsObject()
				if phys:IsValid() then
					phys:AddAngleVelocity(Vector(math.Rand(-720, 720), math.Rand(-720, 720), math.Rand(-720, 720)))
					phys:ApplyForceCenter(phys:GetMass() * (math.Rand(32, 328) * VectorRand():GetNormalized() + vVel))
				end
			end
		end
	end
end

function meta:GiveInventoryItemByType(itype, plyr)
	if GAMEMODE.ZombieEscape then return end
	if not self:HasInventoryItem(itype) then return end

	if GAMEMODE:GetInventoryItemType(itype) == INVCAT_TRINKETS and (plyr:HasInventoryItem(itype) or plyr:HasInventoryItemTier(itype) or plyr:HasInventoryItemTier(string.sub(itype,0,#itype-3))) or plyr:HasInventoryItem(string.sub(itype,0,#itype-3)) then
		self:CenterNotify(COLOR_RED, translate.ClientGet(self, "they_already_have_this_trinket"))
		return
	end

	self:TakeInventoryItem(itype)
	self:UpdateAltSelectedWeapon()

	net.Start("zs_invgiven")
		net.WriteString(itype)
		net.WriteEntity(self)
	net.Send(plyr)

	plyr:AddInventoryItem(itype)
end

function GM:IsInventoryItem(item)
	return self.ZSInventoryItemData[item]
end

function meta:GetInventoryItems()
	return self.ZSInventory
end

function meta:HasInventoryItem(item)
	return self.ZSInventory[item]
end

function meta:HasInventoryItemTier(item)
	local newi = ""
	local newi2 = ""
	local newi3 = ""
	local opt = string.sub(item ,0,#item-1)
	local opt3 = string.sub(item ,#item,#item)
	if string.sub(item ,#item-1,#item-1) ~= "q" then
		newi = item.."_q1"
		newi2 = item.."_q2"
		newi3 = item.."_q3"
	else
		newi = opt..(tonumber(opt3)+1)
		newi2 = opt..(tonumber(opt3)+2)
		newi3 = opt..(tonumber(opt3)+3)
	end
	
	return self.ZSInventory[newi] or self.ZSInventory[newi2] or self.ZSInventory[newi3]
end

function meta:GetInventoryItemTier(item)
    local basename = GAMEMODE:GetBaseItemName(item)
    local inventory = self.ZSInventory
    if inventory then
        return inventory[basename] and inventory[basename] > 0 and 0 
		or inventory[basename .. "_q1"] and inventory[basename .. "_q1"] > 0 and 1 
		or inventory[basename .. "_q2"] and inventory[basename .. "_q2"] > 0 and 2 
		or inventory[basename .. "_q3"] and inventory[basename .. "_q3"] > 0 and 3
    end
end

function meta:GetInventoryItemTierData(item)
    local basename = GAMEMODE:GetBaseItemName(item)
    local inventory = self.ZSInventory
    if inventory then
        return inventory[basename] and inventory[basename] > 0 and basename
		or inventory[basename .. "_q1"] and inventory[basename .. "_q1"] > 0 and basename .. "_q1"
		or inventory[basename .. "_q2"] and inventory[basename .. "_q2"] > 0 and basename .. "_q2"
		or inventory[basename .. "_q3"] and inventory[basename .. "_q3"] > 0 and basename .. "_q3"
    end
end


function GM:GetBaseItemName(item)
    return string.gsub(item, "_q%d$", "", 1)
end

function GM:GetNextTrinketQuality(item)
	local newi = ""
	if string.sub(item, #item - 1, #item - 1) ~= "q" then
		newi = item.."_q1"
	else
		newi = string.sub(item, 0, #item - 1)..(tonumber(string.sub(item , #item, #item)) + 1)
	end

    return newi
end