fx_version 'cerulean'
game 'gta5'

name 'bondrix-economy'
author 'Bondrix'
description 'A lightweight and optimized economy system for FiveM servers. Combines in-memory transaction handling with periodic MySQL syncing for high performance and reliable data persistence.'
repository 'https://github.com/bondrix/economy'
version '1.0.0'

dependencies {
    'oxmysql',
    'bondrix-lib',
    'bondrix-inventory'
}

client_scripts {
    'client/main.lua'
}
shared_scripts {
    'shared/main.lua',
    'shared/config.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/cash.lua',
    'server/bank.lua',
    'server/main.lua'
}