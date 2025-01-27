function BondrixEconomy.GetBank(player)
    if not DoesPlayerExist(player) then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't get the bank of a nil player!") end
        return
    end

    local bank = MySQL.scalar.await('SELECT `bank` FROM `economy` WHERE `identifier` = ? LIMIT 1', {
        BondrixLib.GetIdentifier(player)
    })

    if BondrixEconomy.Config.debug then
        if bank then BondrixLib.Debug('Successfully fetched bank balance of ' .. GetPlayerName(player) .. ', $' .. bank .. '!')
        else BondrixLib.Debug('Failed to fetch bank balance of ' .. GetPlayerName(player) .. '!') end
    end

    return bank
end

function BondrixEconomy.SetBank(player, bank, negativeBank)
    if not DoesPlayerExist(player) then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't set the bank of a nil player!") end
        return
    end

    if bank < 0 then
        if not BondrixEconomy.Config.negativeBank then
            if BondrixEconomy.Config.debug then BondrixLib.Debug('A negative bank amount is disabled in the config!') end
            return
        elseif not negativeBank then
            if BondrixEconomy.Config.debug then BondrixLib.Debug('A negative bank amount is not allowed with the given parameters!') end
            return
        end
    end

    local response = MySQL.update.await('UPDATE `economy` SET `bank` = ? WHERE identifier = ?', {
        bank, BondrixLib.GetIdentifier(player)
    })

    if BondrixEconomy.Config.debug then
        if response then BondrixLib.Debug('Successfully set bank balance of ' .. GetPlayerName(player) .. ' to $' .. bank)
        else BondrixLib.Debug('Failed to set bank balance of ' .. GetPlayerName(player) .. ' to $' .. bank) end
    end

    Player(player).state.bank = bank
end
RegisterNetEvent('bondrix-economy:server:onBankSet')
AddEventHandler('bondrix-economy:server:onBankSet', function(player, bank, negativeBank)
    BondrixEconomy.SetBank(player, bank, negativeBank)
end)

function BondrixEconomy.AddBank(player, amount)
    if amount < 0 then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't add the negative amount $" .. amount .. " to player's bank!") end
        return
    end
    BondrixEconomy.SetBank(player, (Player(player).state.bank or 0) + amount)
end
RegisterNetEvent('bondrix-economy:server:onBankAdd')
AddEventHandler('bondrix-economy:server:onBankAdd', function(player, amount)
    BondrixEconomy.AddBank(player, amount)
end)

function BondrixEconomy.RemoveBank(player, amount, negativeBank)
    if amount < 0 then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't remove the negative amount $" .. amount .. " to player's bank!") end
        return
    end

    BondrixEconomy.SetBank(player, (Player(player).state.bank or 0) - amount, negativeBank)
end
RegisterNetEvent('bondrix-economy:server:onBankRemove')
AddEventHandler('bondrix-economy:server:onBankRemove', function(player, amount, negativeBank)
    BondrixEconomy.RemoveBank(player, amount, negativeBank)
end)