AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    local schema = LoadResourceFile(GetCurrentResourceName(), 'schema.sql')
    if not schema then return end

    MySQL.rawExecute.await(schema)
end)

AddEventHandler('playerJoining', function()
    local player = source
    local identifier = GetPlayerIdentifierByType(player, 'fivem'):sub(7)

    MySQL.insert('INSERT IGNORE INTO `economy` (identifier, cash, bank) VALUES (?, ?, ?)', {
        identifier, BondrixEconomy.Config.startingCash, BondrixEconomy.Config.startingBank
    }, function()
        Player(player).state:set('cash', BondrixEconomy.GetCash(identifier), true)
        Player(player).state:set('bank', BondrixEconomy.GetBank(identifier), true)
    end)
end)

AddEventHandler('playerDropped', function()
    local player = source
    local cash = Player(player).state.cash
    local bank = Player(player).state.bank
    local identifier = GetPlayerIdentifierByType(player, 'fivem'):sub(7)

    BondrixEconomy.SetCash(identifier, cash)
    BondrixEconomy.SetBank(identifier, bank)
end)