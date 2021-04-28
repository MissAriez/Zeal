local settings = require './settings'
local Embed = require 'embed-constructor'

return function(msg)
    local embed = Embed()
        :setTitle 'Error :x:'
        :setColor 'red'
        :setDescription(msg)
        :setFooter(settings.footer)
        :setTimestamp()
        :finish();

    return embed
end