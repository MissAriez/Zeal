require 'data-util'
class = require 'class'
Command = require 'command-class'
Array = require 'Array'
Collection = require 'Collection'
Promise = require 'Promise'
Discord = require 'discordia'
Discord.extensions()

_G.client = Discord.Client {
    cacheAllMembers = true;
    autoReconnect = true;
    syncGuilds = true;
    logLevel = 3;
    largeThreshold = 125;
}

client._commands = Collection()
client._aliases = Collection()
client._categories = Collection()

_G.class = class
_G.settings = require './settings'
_G.Embed = require 'embed-constructor'
_G.Array = Array
_G.Collection = Collection
_G.Promise = Promise
_G.Command = Command

local QuickDB = require 'quick.db'
local db = QuickDB './db'
_G.db = db

require './cmd'
require './dotenv'
local events = require './events'
for event_name, callback in pairs(events) do
    client:on(event_name, callback)
end

local function memory()
    local kb = collectgarbage 'count'
    local mb = kb / 1000
    local mem
    if kb < 1000 then
        mem = kb..' KB'
    else
        mem = mb..' MB'
    end
    return mem
end

settings.memory = memory

client:run('Bot '..env.TOKEN) --settings.token