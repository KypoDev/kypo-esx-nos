  
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('nos', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local nitroquantity = xPlayer.getInventoryItem('nos').count
    if nitroquantity > 0 then
        TriggerClientEvent('kypo-esx-nos:onUse', source)
    end
end)

RegisterServerEvent('kypo-esx-nos:removeInventoryItem')
AddEventHandler('kypo-esx-nos:removeInventoryItem', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('nos', 1) -- remove item when use
end)
