BondrixEconomy.Config = {}

BondrixEconomy.Config.debug = true

-- Should the server attempt to sync the player's money to the database periodically?
-- You should keep this on to avoid any potential data loss!
BondrixEconomy.Config.sync = true
-- How often should the client sync with the database, in minutes?
BondrixEconomy.Config.syncInterval = 45

-- Starting cash and bank balance when joining the server for the first time.
BondrixEconomy.Config.startingCash = 500
BondrixEconomy.Config.startingBank = 1500

-- Allow negative bank
BondrixEconomy.Config.negativeBank = true

BondrixEconomy.Config.inventory = {
    cash = {
        text = 'Cash',
        leftBadge = 'CASH'
    }
}

-- https://docs.fivem.net/docs/game-references/blips/
local blip = {
    name = 'Bank',
    sprite = 108,
    color = 2
}

BondrixEconomy.Config.banks = {
    [1] = {
        position = vec3(145.85, -1044.46, 29.38),
        blip = blip
    },
    [2] = {
        position = vec3(1175.05, 2708.45, 38.09),
        blip = blip
    },
    [3] = {
        position = vec3(313.47, -280.56, 339.24),
        blip = blip
    },
    [4] = {
        position = vec3(-351.76, -51.35, 49.04),
        blip = blip
    },
    [5] = {
        position = vec3(-1212.19, -332.32, 37.78),
        blip = blip
    },
    [6] = {
        position = vec3(-2960.93, 482.8, 15.7),
        blip = blip
    }
}

-- Use GTA's cash and bank display.
-- Delete this if you want to use your own hud.
BondrixEconomy.Config.hud = {
    cashLabel = 'CASH',
    bankLabel = 'BANK'
}