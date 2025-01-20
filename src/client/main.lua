if BondrixEconomy.Config.sync then
    CreateThread(function()
        while true do
            Wait(BondrixEconomy.Config.syncInterval * 60 * 1000)

            TriggerServerEvent('bondrix-economy:server:onCashSet', nil, LocalPlayer.state.cash)
            TriggerServerEvent('bondrix-economy:server:onBankSet', nil, LocalPlayer.state.bank)
        end
    end)
end

if BondrixEconomy.Config.hud then
    Wait(5000)

    StatSetInt('MP0_WALLET_BALANCE', LocalPlayer.state.cash, false)
    AddStateBagChangeHandler('cash', nil, function(_, _, cash)
        StatSetInt('MP0_WALLET_BALANCE', cash, false)
    end)

    StatSetInt('BANK_BALANCE', LocalPlayer.state.bank, false)
    AddStateBagChangeHandler('bank', nil, function(_, _, bank)
        StatSetInt('BANK_BALANCE', bank, false)
    end)
end