QBCore = exports['qb-core']:GetCoreObject()
local sharedItems = QBCore.Shared.Items

RegisterNetEvent("rs-vendings:client:UseVendingMachine", function(type)
    local VendingMenu = {
        {
            header = Config.Machines[type].Target.Label,
            isMenuHeader = true
        }
    }

    for k, v in pairs(Config.Machines[type].Vending) do
        print(v.item)
        VendingMenu[#VendingMenu + 1] = {
            header = sharedItems[v.item].label,
            txt = 'Price: $'..v.price,
            icon = v.item,
            params = {
                event = 'rs-vendings:client:Purchase',
                args = {
                    item =  v.item,
                    price = v.price
                }
            }
        }
    end

    exports['qb-menu']:openMenu(VendingMenu)
end)

local function PurchaseSuccess(bool, price, item)
    ClearPedTasks(PlayerPedId())
    if bool then
        QBCore.Functions.Progressbar('vending_item', 'Vending your item...', math.random(3000,5000), false, true, { -- Name | Label | Time | useWhileDead | canCancel
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@heists@humane_labs@finale@strip_club',
            anim = 'ped_b_celebrate_loop',
            flags = 48,
        }, {}, {}, function()
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('rs-vending:server:GetVendingItem', price, item)
        end, function()
            QBCore.Functions.Notify('Canceled...', "error", 2000)
        end)
    else
        ClearPedTasks(PlayerPedId())
        local eatMoney = math.random(1,10)
        if eatMoney <= Config.EatMoney then
            TriggerServerEvent('rs-vendings:server:EatMoney', price)
            QBCore.Functions.Notify('It ate your money! Nice!', 'error', 5000)
        else
            QBCore.Functions.Notify('Usually, it helps if you press the right buttons!', 'error', 5000)
        end
    end
end

RegisterNetEvent("rs-vendings:client:Purchase", function(data)
    local Item = data.item
    local Price = data.price
    QBCore.Functions.TriggerCallback('rs-vendings:server:HasCash', function(hasCash)
        if hasCash then
            QBCore.Functions.Progressbar('vending_money', 'Inserting Money...', math.random(3000,5000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim_casino_a@amb@casino@games@arcadecabinet@maleright",
                anim = "insert_coins",
                flags = 49
            }, {}, {}, function()
                exports['ps-ui']:Circle(function(success)
                    if success then
                        PurchaseSuccess(true, Price, Item)
                    else
                        PurchaseSuccess(false, Price, Item)
                    end
                end, Config.Minigame.Circles, Config.Minigame.Time)
            end, function()
                QBCore.Functions.Notify('Canceled...', "error", 2000)
            end)
        end
    end, Price)

end)

local function CreateVendingMachines()
    for k, v in pairs(Config.Machines) do
        exports['qb-target']:AddTargetModel(v.Models, {
            options = {
                {
                    type = "client",
                    action = function()
                        TriggerEvent("rs-vendings:client:UseVendingMachine", k)
                    end,
                    icon = v.Target.Icon,
                    label = v.Target.Label,
                },
            },
            distance = 2.0
        })
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateVendingMachines()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateVendingMachines()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(Config.Machines) do
            exports['qb-target']:RemoveTargetModel(v.Models)
        end
    end
end)