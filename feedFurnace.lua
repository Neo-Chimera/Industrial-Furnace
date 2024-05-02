os.loadAPI("getFurnaces.lua")
local allPeripheralsNames = peripheral.getNames()
local lavaChest = peripheral.wrap("toms_storage:ts.inventory_connector.tile_4")
local allFurnacesNames = getFurnaces.getGenericFurnaces()

for number, furnaceName in pairs(allFurnacesNames) do
    local furnace = peripheral.wrap(furnaceName)    
end

function getFirstSlotWithLava() 
    for slot, item in pairs(lavaChest.list()) do    
        if(item.name == "minecraft:lava_bucket") then
            return slot            
        end
    end
end


function feedFurnaces() 
    for number, furnaceName in pairs(allFurnacesNames) do
        local furnace = peripheral.wrap(furnaceName)
        if furnace.list()[2] == nil and getFirstSlotWithLava() ~= nil then
            lavaChest.pushItems(furnaceName, getFirstSlotWithLava(),64, 2)        
        end
    end
end

function feedFurnacesLoop()
    while true do
        feedFurnaces()
    end
end
