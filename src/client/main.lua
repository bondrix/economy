CreateThread(function()
    for _, bank in pairs(BondrixEconomy.Config.banks) do
        local blip = AddBlipForCoord(bank.position)
        SetBlipSprite(blip, bank.blip.sprite)
        SetBlipColour(blip, bank.blip.color)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(bank.blip.name)
        EndTextCommandSetBlipName(blip)
    end
end)

-- CreateThread(function()
--     local cash = BondrixEconomy.Config.inventory.cash
--     cash.rightLabel = '$' .. LocalPlayer.state.cash
--     BondrixInventory.AddMenuItem(cash)
-- end)

if BondrixEconomy.Config.sync then
    CreateThread(function()
        while true do
            Wait(BondrixEconomy.Config.syncInterval * 1000 * 60)
            if BondrixEconomy.Config.debug then BondrixLib.Debug('Attempting to sync cash and bank balance with the database!') end

            TriggerServerEvent('bondrix-economy:server:onCashSet', nil, LocalPlayer.state.cash)
            TriggerServerEvent('bondrix-economy:server:onBankSet', nil, LocalPlayer.state.bank)
        end
    end)
end

if BondrixEconomy.Config.hud then
    CreateThread(function()
        AddTextEntry('MENU_PLYR_CASH', BondrixEconomy.Config.hud.cashLabel or '')
        StatSetInt('MP0_WALLET_BALANCE', LocalPlayer.state.cash, false)
        AddStateBagChangeHandler('cash', nil, function(_, _, cash)
            StatSetInt('MP0_WALLET_BALANCE', cash, false)
        end)

        AddTextEntry('MENU_PLYR_BANK', BondrixEconomy.Config.hud.bankLabel or '')
        StatSetInt('BANK_BALANCE', LocalPlayer.state.bank, false)
        AddStateBagChangeHandler('bank', nil, function(_, _, bank)
            StatSetInt('BANK_BALANCE', bank, false)
        end)
    end)
end