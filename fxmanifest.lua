fx_version 'cerulean'
game 'gta5'

author 'Kruimol'
description 'The fivedash logs resource'
version '1.0.0'

resource_type 'gametype' { name = 'My awesome game type!' }

server_script {
    'server.lua',
    'config.lua'
}
server_export 'SayHello'