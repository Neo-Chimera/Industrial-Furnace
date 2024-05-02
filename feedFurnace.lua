os.loadAPI("getFurnaces.lua")
local allPeripheralsNames = peripheral.getNames()
local fuelChest = peripheral.wrap("toms_storage:ts.inventory_connector.tile_4")
local allFurnacesNames = getFurnaces.getGenericFurnaces()

local fuelTypes = {
    { name = "minecraft:lava_bucket", minCount = 1 },
    { name = "minecraft:bamboo", minCount = 32 },
    { name = "minecraft:dried_kelp_block", minCount = 5 },
}

for number, furnaceName in pairs(allFurnacesNames) do
    local furnace = peripheral.wrap(furnaceName)    
end

function getFirstSlotWithFuel(fuelArray)
    for slot, item in pairs(fuelChest.list()) do
        for _, fuel in pairs(fuelArray) do
            if item.name == fuel.name and item.count >= fuel.minCount then
                return slot, fuel.minCount
            end
        end
    end
    return nil, 0
end

function getFirstSlotWithLava() 
    for slot, item in pairs(fuelChest.list()) do    
        if(item.name == "minecraft:lava_bucket") then
            return slot
        end
    end
end

function getFirstSlotWithBamboo() 
    for slot, item in pairs(fuelChest.list()) do    
        if(item.name == "minecraft:bamboo" and item.cound >= 32) then
            return slot
        end
    end
end

function getFirstSlotWithKelp() 
    for slot, item in pairs(fuelChest.list()) do    
        if(item.name == "minecraft:dried_kelp_block" and item.cound >= 32) then
            return slot
        end
    end
end


function feedFurnaces() 
    for number, furnaceName in pairs(allFurnacesNames) do
        local furnace = peripheral.wrap(furnaceName)
        if not furnace.list()[2] then
            local slot, count = getFirstSlotWithFuel(fuelTypes)
            if slot then
                fuelChest.pushItems(furnaceName, slot, count, 2)        
            end
        end  
    end
end

function feedFurnacesLoop()
    while true do
        feedFurnaces()
    end
end
