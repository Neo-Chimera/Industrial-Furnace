os.loadAPI("getFurnaces.lua")
os.loadAPI("invProvider.lua")

local allPeripheralsNames = peripheral.getNames()
local allFurnaces = getFurnaces.getFurnaces()
local allBlastFurnaces = getFurnaces.getBlastFurnaces()
local allGenericFurnaces = getFurnaces.getGenericFurnaces()
local materialChest = invProvider.materialChest

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
    if firstSlot and not furnace.getItemDetail(1) or furnace.getItemDetail(1).count < 2 then 
        materialChest.pushItems(peripheral.getName(furnace), firstSlot, amount, 1)
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
            if isRawMaterial and not getFurnaces.areAllBlastFurnacesFull(furnace) then
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
