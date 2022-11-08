fx_version 'cerulean'
game 'gta5'

description 'rs-vendings : A simple vending mahcine script'
author 'Redline Studios'
version '1.0'

shared_scripts { 'shared/*.lua' }

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

lua54 'yes'