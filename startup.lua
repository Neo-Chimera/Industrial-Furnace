os.loadAPI("feedFurnace.lua")
os.loadAPI("moveToChest.lua")
os.loadAPI("addToFurnaces.lua")
local feedFurnacesLoop = feedFurnace.feedFurnacesLoop
local moveToChest = moveToChest.moveToChestLoop
local addToAllFurnaces = addToFurnaces.addToAllFurnaces

print("Bot 64")
print("Computador central da fornalha autom�tica")
parallel.waitForAll(addToAllFurnaces, feedFurnacesLoop, moveToChest)
--[[ while true do
    sleep(0.05)
     
end ]]
