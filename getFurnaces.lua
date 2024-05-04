local allPeripheralsNames = peripheral.getNames()
local allFurnaces = {peripheral.find("minecraft:furnace")}
local allBlastFurnaces = {peripheral.find("minecraft:blast_furnace")}

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

function getBlastFurnaces()
    return allBlastFurnaces
end

function getFurnaces()
    return allFurnaces
end

function getSmokers()
    return allFurnaces
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


function getGenericFurnaces()
    return concatTables(allBlastFurnaces, allFurnaces)
end
