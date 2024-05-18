os.loadAPI("feedFurnace.lua")
os.loadAPI("moveToChest.lua")
os.loadAPI("addToFurnaces.lua")
local feedAllFurnaces = feedFurnace.feedAllFurnaces
local moveToChest = moveToChest.moveToChestLoop
local addToAllFurnaces = addToFurnaces.addToAllFurnaces

print("Bot 64")
print("Computador central da fornalha automática")
parallel.waitForAll(addToAllFurnaces, feedAllFurnaces, moveToChest)

