fx_version 'cerulean'
game 'gta5'

name 'bondrix-resource'
author 'Bondrix'
description 'Resource description goes here.'
repository 'https://github.com/bondrix/bondrix-resource'
version '1.0.0'

dependencies {
    'bondrix-example-1',
    'bondrix-example-2'
}

client_scripts {
    'client/main.lua'
}
shared_scripts {
    'shared/main.lua',
    'shared/config.lua'
}
server_scripts {
    'server/main.lua'
}