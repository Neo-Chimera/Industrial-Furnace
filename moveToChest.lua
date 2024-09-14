os.loadAPI("getFurnaces.lua")
os.loadAPI("invProvider.lua")
local allPeripherals = peripheral.getNames()
local resultChest = invProvider.resultChest
local bucketStorage = invProvider.bucketStorage
local allFurnaces = getFurnaces.getGenericFurnaces()

function checkEmptyBucket() 
    for _, furnace in pairs(allFurnaces) do
        local fuel = furnace.list()[2]
        if fuel ~= nil and fuel.name == "minecraft:bucket" then
            bucketStorage.pullItems(peripheral.getName(furnace), 2)
        end
    end
end


function moveToChestSingle(furnace)
    while true do
        checkEmptyBucket()
        local result = furnace.list()[3]
        if result then
            resultChest.pullItems(peripheral.getName(furnace), 3)
        end
        sleep(0.05)
    end
end
function moveToChestAll()
    local tasks = {}
    for _, furnace in pairs(allFurnaces) do
        table.insert(tasks, function() moveToChestSingle(furnace) end)
    end
    parallel.waitForAll(table.unpack(tasks))
end


