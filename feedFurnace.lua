os.loadAPI("getFurnaces.lua")
local allPeripheralsNames = peripheral.getNames()
local fuelChest = peripheral.wrap("toms_storage:ts.inventory_connector.tile_4")
local allFurnaces = getFurnaces.getGenericFurnaces()

local fuelTypes = {
    { name = "minecraft:lava_bucket", minCount = 1 },
    { name = "minecraft:bamboo", minCount = 32 },
    { name = "minecraft:dried_kelp_block", minCount = 1 },
    { name = "minecraft:bamboo_planks", minCount = 8 },
}

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

local function feedSingleFurnace(furnace)
    while true do
        local slot, count = getFirstSlotWithFuel(fuelTypes)
        if slot then
            fuelChest.pushItems(peripheral.getName(furnace), slot, count, 2)
        end
        sleep(0.05)
    end
end

function feedAllFurnaces()
    local tasks = {}
    for _, furnace in pairs(allFurnaces) do
        table.insert(tasks, function() feedSingleFurnace(furnace) end)
    end
    parallel.waitForAll(table.unpack(tasks))
end
