os.loadAPI("getFurnaces.lua")
local allPeripherals = peripheral.getNames()
local chest = peripheral.wrap("toms_storage:ts.inventory_proxy.tile_1")
local allFurnaces = getFurnaces.getGenericFurnaces()

function checkEmptyBucket() do
    for _,furnaceName in pairs(allFurnaces) do
        local furnace = peripheral.wrap(furnaceName)        
        local fuel = furnace.list()[2]
        if fuel ~= nil and fuel.name == "minecraft:bucket" then
            chest.pullItems(furnaceName, 2)
        end
    end
end
end

function moveToChest()
    checkEmptyBucket()
    for _, furnaceName in pairs(allFurnaces) do
        sleep(0.05)    
        local furnace = peripheral.wrap(furnaceName)
        local result = furnace.list()[3]
        if result ~= nil then
            chest.pullItems(furnaceName, 3)
        end
    end
end
function moveToChestLoop()
    while true do
        moveToChest()
        sleep(0.05)
    end
end

