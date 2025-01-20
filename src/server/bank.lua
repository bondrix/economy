function BondrixEconomy.GetBank(identifier)
    local bank = MySQL.scalar.await('SELECT `bank` FROM `economy` WHERE `identifier` = ? LIMIT 1', {
        identifier
    })
    return bank
end

function BondrixEconomy.SetBank(identifier, bank)
    MySQL.update.await('UPDATE economy SET bank = ? WHERE identifier = ?', {
        bank, identifier
    })
end
RegisterNetEvent('bondrix-economy:server:onBankSet')
AddEventHandler('bondrix-economy:server:onBankSet', function(identifier, bank)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.SetBank(identifier, bank)
end)

function BondrixEconomy.AddBank(identifier, amount)
    local bank = BondrixEconomy.GetBank(identifier)
    BondrixEconomy.SetBank(identifier, bank + amount)
end
RegisterNetEvent('bondrix-economy:server:onBankAdd')
AddEventHandler('bondrix-economy:server:onBankAdd', function(identifier, amount)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.AddBank(identifier, amount)
end)

function BondrixEconomy.RemoveBank(identifier, amount)
    local bank = BondrixEconomy.GetBank(identifier)
    BondrixEconomy.SetBank(identifier, bank - amount)
end
RegisterNetEvent('bondrix-economy:server:onBankRemove')
AddEventHandler('bondrix-economy:server:onBankRemove', function(identifier, amount)
    if identifier == nil then identifier = GetPlayerIdentifierByType(source, 'fivem'):sub(7) end
    BondrixEconomy.RemoveBank(identifier, amount)
end)