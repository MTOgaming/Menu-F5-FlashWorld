fx_version "adamant"
lua54 "yes"
author "Bdv"
description "Crée par @userbdv pour bScripts - FiveM"
game "gta5"

shared_scripts '@base/imports.lua'

shared_scripts {
    "Shared/*.lua"
}


client_scripts {
    "Rui/ruidebdv.lua",
    "Client/*.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "Shared/*.lua",
    "Server/*.lua"

}