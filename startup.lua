os.loadAPI("feedFurnace.lua")
os.loadAPI("moveToChest.lua")
os.loadAPI("addToFurnaces.lua")
local allGenericFurnaces = getFurnaces.getGenericFurnaces()

local addToSelf = addToFurnaces.addToSelf
local moveToChestSingle = moveToChest.moveToChestSingle
local feedSingleFurnace = feedFurnace.feedSingleFurnace

print("Bot 64")
print("Computador central da fornalha automática")


local tasks = {}
for _, furnace in pairs(allGenericFurnaces) do
    table.insert(tasks, function() 
        parallel.waitForAll(
            function() addToSelf(furnace) end,
            function() moveToChestSingle(furnace) end,
            function() feedSingleFurnace(furnace) end
        )
    end)
end
parallel.waitForAll(table.unpack(tasks))
