function BondrixEconomy.GetCash(identifier)
    local cash = MySQL.scalar.await('SELECT `cash` FROM `economy` WHERE `identifier` = ? LIMIT 1', {
        identifier
    })
    return cash
end

function BondrixEconomy.SetCash(identifier, cash)
    MySQL.update.await('UPDATE economy SET cash = ? WHERE identifier = ?', {
        cash, identifier
    })
end
RegisterNetEvent('bondrix-economy:server:onCashSet')
AddEventHandler('bondrix-economy:server:onCashSet', function(identifier, cash)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.SetCash(identifier, cash)
end)

function BondrixEconomy.AddCash(identifier, amount)
    local cash = BondrixEconomy.GetCash(identifier)
    BondrixEconomy.SetCash(identifier, cash + amount)
end
RegisterNetEvent('bondrix-economy:server:onCashAdd')
AddEventHandler('bondrix-economy:server:onCashAdd', function(identifier, amount)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.AddCash(identifier, amount)
end)

function BondrixEconomy.RemoveCash(identifier, amount)
    local cash = BondrixEconomy.GetCash(identifier)
    if cash - amount < 0 then return end
    BondrixEconomy.SetCash(identifier, cash - amount)
end
RegisterNetEvent('bondrix-economy:server:onCashRemove')
AddEventHandler('bondrix-economy:server:onCashRemove', function(identifier, amount)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.RemoveCash(identifier, amount)
end)