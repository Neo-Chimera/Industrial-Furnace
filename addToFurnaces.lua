os.loadAPI("getFurnaces.lua")
local allPeripheralsNames = peripheral.getNames()
local allFurnaces = getFurnaces.getFurnaces()
local allBlastFurnaces = getFurnaces.getBlastFurnaces()
local allGenericFurnaces = getFurnaces.getGenericFurnaces()
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


function addToFurnace(furnace, amount)
    local firstSlot = getFirstItemSlot()
    if firstSlot then 
        materialChest.pushItems(peripheral.getName(furnace), firstSlot, amount, 1)
    end
end

function addToFurnaces(furnaceType)
    local firstSlot = getFirstItemSlot()
    if not firstSlot then return nil end
    
    local furnaces = furnaceType == "blast" and allBlastFurnaces or allFurnaces
    local itemTags = materialChest.getItemDetail(firstSlot).tags
    local isRawMaterial = tableHasKey(itemTags, "forge:raw_materials")
    
    if furnaceType == "blast" and not isRawMaterial then
        return nil
    end
    
    local itemCount = materialChest.getItemDetail(firstSlot).count
    local intAmount = math.floor(itemCount / #furnaces)
    local restAmount = math.fmod(itemCount, #furnaces)
    
    if intAmount > 0 or restAmount > 0 then
        for i, furnaceName in pairs(furnaces) do
            if i <= restAmount then
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

function addToSelf(furnace)
    
    while true do
        sleep(0.2)
        local furnaceType = peripheral.getType(furnace)
        local firstSlot = getFirstItemSlot()
        if not firstSlot then goto continue end
        
        local itemDetail = materialChest.getItemDetail(firstSlot)
        if not itemDetail then goto continue end
        local itemTags = itemDetail.tags
        local isRawMaterial = tableHasKey(itemTags, "forge:raw_materials")
        
        if furnaceType == "minecraft:blast_furnace" then
            if isRawMaterial and not getFurnaces.isBlastFurnaceFull(furnace) then
                addToFurnace(furnace, 1)
            end
        else
            addToFurnace(furnace, 1)
        end

        ::continue::
        
    end
end
function addToAllFurnacesIndependant()
    local tasks = {}
    for _, furnace in pairs(allGenericFurnaces) do
        table.insert(tasks, function() addToSelf(furnace) end)
    end
    parallel.waitForAll(table.unpack(tasks))
end
