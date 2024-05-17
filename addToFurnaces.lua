os.loadAPI("getFurnaces.lua")
local allPeripheralsNames = peripheral.getNames()
local allFurnaces = getFurnaces.getFurnaces()
local allBlastFurnaces = getFurnaces.getBlastFurnaces()
local allSmokers = getFurnaces.getSmokers()
local materialChest = peripheral.wrap("toms_storage:ts.inventory_proxy.tile_2")

function tableHasKey(tbl, key)
    return tbl[key] ~= nil
end
   

function getFirstItemSlot() 
    if not materialChest or not materialChest.list() then
        return nil
    end
    for slot, item in pairs(materialChest.list()) do
        if(item ~= nil) then
            return slot
        end
    end
end


function addToFurnace(furnaceName, amount)
    if getFirstItemSlot() then 
        local firstSlot = getFirstItemSlot()
        materialChest.pushItems(peripheral.getName(furnaceName), firstSlot, amount, 1)
    end
end

function addToBlastFurnaces()
    local firstSlot = getFirstItemSlot()
    local itemTags = materialChest.getItemDetail(firstSlot).tags
    local isRawMaterial = tableHasKey(itemTags, "forge:raw_materials")
    if(isRawMaterial) then
        if not firstSlot then return nil end
        
        local intAmount = math.floor(materialChest.getItemDetail(firstSlot).count / #allBlastFurnaces)
        local restAmount = math.fmod(materialChest.getItemDetail(firstSlot).count, #allBlastFurnaces)
        if(intAmount > 0) then
            for i, furnaceName in pairs(allBlastFurnaces) do
                if (i <= restAmount) then
                    addToFurnace(furnaceName, intAmount + 1)
                else
                    addToFurnace(furnaceName, intAmount)
                end
            end
        end
    end
end

function addToFurnaces()
    local firstSlot = getFirstItemSlot()
    if not firstSlot or firstSlot == nil then return nil end
    local intAmount = math.floor(materialChest.getItemDetail(firstSlot).count / #allFurnaces)
    local restAmount = math.fmod(materialChest.getItemDetail(firstSlot).count, #allFurnaces)
    if(intAmount > 0 or restAmount > 0) then
        for i, furnaceName in pairs(allFurnaces) do
            if (i <= restAmount) then
                addToFurnace(furnaceName, intAmount + 1)
            else
                addToFurnace(furnaceName, intAmount)
            end
        end
    end
end

function addToAllFurnaces()
    while true do
        sleep(0.05)
        local firstSlot = getFirstItemSlot()
        if not firstSlot then goto continue end
        local itemTags = materialChest.getItemDetail(firstSlot).tags
        local isRawMaterial = tableHasKey(itemTags, "forge:raw_materials")
        if isRawMaterial and not getFurnaces.areAllBlastFurnacesFull() then
            addToBlastFurnaces()
        else
            addToFurnaces()
        end
        ::continue::
    end
end
