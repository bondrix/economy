AddEventHandler('onResourceStart', function(name)
    if name ~= GetCurrentResourceName() then return end

    local schema = LoadResourceFile(GetCurrentResourceName(), 'schema.sql')
    if not schema then
        if BondrixEconomy.Config.debug then BondrixLib.Debug("Didn't find schema.sql and the database won't work properly!") end
        return
    end

    MySQL.rawExecute.await(schema)
end)

-- AddEventHandler('onResourceStop', function(name)
--     if name ~= GetCurrentResourceName() then return end

--     if BondrixEconomy.Config.debug then BondrixLib.Debug("The resource has been stopped. Attempting to save all online players' cash and bank balance to the database!") end
--     for _, player in ipairs(GetPlayers()) do
--         print('hey 1')
--         BondrixEconomy.SetCash(player, Player(player).state.cash)
--         print('hey 2')
--         BondrixEconomy.SetBank(player, Player(player).state.bank)
--         print('hey 3')
--     end

--     print('hey 4')
--     Wait(5000)
-- end)

AddEventHandler('playerJoining', function()
    local player = source
    local name = GetPlayerName(player)
    if BondrixEconomy.Config.debug then BondrixLib.Debug('Player ' .. name .. ' is joining the server. Attempting to get cash and bank balance...') end

    MySQL.insert.await('INSERT IGNORE INTO `economy` (identifier, cash, bank) VALUES (?, ?, ?)', {
        BondrixLib.GetIdentifier(player), BondrixEconomy.Config.startingCash or 0, BondrixEconomy.Config.startingBank or 0
    })

    local cash = BondrixEconomy.GetCash(player)
    local bank = BondrixEconomy.GetBank(player)
    Player(player).state:set('cash', cash, true)
    Player(player).state:set('bank', bank, true)

    if BondrixEconomy.Config.debug then
        BondrixLib.Debug("Initialized " .. name .. "'s cash balance to $" .. (cash or 'nil') .. "!")
        BondrixLib.Debug("Initialized " .. name .. "'s bank balance to $" .. (bank or 'nil') .. "!")
    end
end)

AddEventHandler('playerDropped', function()
    local player = source
    local name = GetPlayerName(player)
    local cash = Player(player).state.cash
    local bank = Player(player).state.bank
    local identifier = BondrixLib.GetIdentifier(player)
    if BondrixEconomy.Config.debug then BondrixLib.Debug('Player ' .. name .. ' is exiting the server. Attempting to save cash and bank balance...') end

    local response = MySQL.update.await('UPDATE `economy` SET `cash` = ?, `bank` = ? WHERE identifier = ?', {
        cash, bank, BondrixLib.GetIdentifier(player)
    })

    if BondrixEconomy.Config.debug then
        if response then
            BondrixLib.Debug("Saved " .. name .. "'s cash balance to $" .. (cash or 'nil') .. " in the database!")
            BondrixLib.Debug("Saved " .. name .. "'s bank balance to $" .. (bank or 'nil') .. " in the database!")
        else BondrixLib.Debug("Failed to save " .. name .. "'s cash or bank balance into the database!") end
    end
end)