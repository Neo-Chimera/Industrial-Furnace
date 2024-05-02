local allPeripheralsNames = peripheral.getNames()
local allFurnaces = {}
local allBlastFurnaces = {}
local materialChest = peripheral.wrap("toms_storage:ts.inventory_proxy.tile_2")

function concatTables(table1, table2)
    local result = {}
    for _, value in ipairs(table1) do
        table.insert(result, value)
    end
    for _, value in ipairs(table2) do
        table.insert(result, value)
    end

    return result
end



for _, name in pairs(allPeripheralsNames) do
    if peripheral.getType(name) == "minecraft:furnace" then
        table.insert(allFurnaces, name)
    end
    if peripheral.getType(name) == "minecraft:blast_furnace" then
        table.insert(allBlastFurnaces, name)
    end
end

function getBlastFurnaces()
    return allBlastFurnaces
end

function areAllBlastFurnacesFull()
    for _, name in pairs(allBlastFurnaces) do
        if not peripheral.wrap(name).getItemDetail(1) then
            return false
        end
    end
    return true    
end

function areAllFurnacesFull()
    for _, name in pairs(allFurnaces) do
        if not peripheral.wrap(name).getItemDetail(1) then
            return false
        end
    end
    return true
end


function getFurnaces()
    return allFurnaces
end

function getGenericFurnaces()
    return concatTables(allBlastFurnaces, allFurnaces)
end