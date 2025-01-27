function BondrixEconomy.GetCash(player)
    if not DoesPlayerExist(player) then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't get the cash of a nil player!") end
        return
    end

    local cash = MySQL.scalar.await('SELECT `cash` FROM `economy` WHERE `identifier` = ? LIMIT 1', {
        BondrixLib.GetIdentifier(player)
    })

    if BondrixEconomy.Config.debug then
        if cash then BondrixLib.Debug('Successfully fetched cash balance of ' .. GetPlayerName(player) .. ', $' .. cash .. '!')
        else BondrixLib.Debug('Failed to fetch cash balance of ' .. GetPlayerName(player) .. '!') end
    end

    return cash
end

function BondrixEconomy.SetCash(player, cash)
    if not DoesPlayerExist(player) then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't set the cash of a nil player!") end
        return
    end

    if cash < 0 then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Setting a negative amount of $" .. cash .. " of cash is not allowed!") end
    end

    local response = MySQL.update.await('UPDATE `economy` SET `cash` = ? WHERE identifier = ?', {
        cash, BondrixLib.GetIdentifier(player)
    })

    if BondrixEconomy.Config.debug then
        if response then BondrixLib.Debug('Successfully set cash balance of ' .. GetPlayerName(player) .. ' to $' .. cash)
        else BondrixLib.Debug('Failed to set cash balance of ' .. GetPlayerName(player) .. ' to $' .. cash) end
    end

    Player(player).state.cash = cash
end
RegisterNetEvent('bondrix-economy:server:onCashSet')
AddEventHandler('bondrix-economy:server:onCashSet', function(player, cash)
    BondrixEconomy.SetCash(player, cash)
end)

function BondrixEconomy.AddCash(player, amount)
    if amount < 0 then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't add the negative amount $" .. amount .. " to player's cash!") end
        return
    end

    BondrixEconomy.SetCash(player, (Player(player).state.cash or 0) + amount)
end
RegisterNetEvent('bondrix-economy:server:onCashAdd')
AddEventHandler('bondrix-economy:server:onCashAdd', function(player, amount)
    BondrixEconomy.AddCash(player, amount)
end)

function BondrixEconomy.RemoveCash(player, amount)
    if amount < 0 then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Can't remove the negative amount $" .. amount .. " to player's cash!") end
        return
    end

    BondrixEconomy.SetCash(player, (Player(player).state.cash or 0) - amount)
end
RegisterNetEvent('bondrix-economy:server:onCashRemove')
AddEventHandler('bondrix-economy:server:onCashRemove', function(player, amount)
    BondrixEconomy.RemoveCash(player, amount)
end)