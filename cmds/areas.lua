local w101 = require 'w101'

return Command 'areas'
    :setCategory 'Wizard101'
    :setDesc 'Returns a list of areas in a Wizard101 world.'
    :setAliases { 'areasin', 'arealist' }
    :setUsage '<world>'
    :run(function(msg, args, util)
        local world_name = args:join ' ':lower()
        local world = w101:searchWorld(world_name)

        if not world then return msg:reply('Invalid world "'..world_name..'"') end

        msg.channel:send(
            util.Embed()
                :setAuthor('Quests in order: '..tostring(world.ordered_areas))
                :setTitle(world.name)
                :setDescription(world.areas:strlist())
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish()
        )
    end);