QBCore = exports['qb-core']:GetCoreObject()
local sharedItems = QBCore.Shared.Items

RegisterServerEvent('rs-vendings:server:EatMoney', function(price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveMoney('cash', price)
end)

RegisterServerEvent('rs-vending:server:GetVendingItem', function(price, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveMoney('cash', price)
    Player.Functions.AddItem(item, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[item], "add")
end)

QBCore.Functions.CreateCallback('rs-vendings:server:HasCash',function(source, cb, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CashAmount = Player.Functions.GetMoney('cash')
    local callback = false

    if CashAmount >= price then
        callback = true
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough cash for this!', 'error')
    end

    cb(callback)
end)
