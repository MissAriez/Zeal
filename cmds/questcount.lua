local w101 = require 'w101'

return Command 'questcount'
    :setCategory 'Wizard101'
    :setDesc 'Returns the amount of quests in a Wizard101 world.'
    :setAliases { 'questsin' }
    :setUsage '<world>'
    :run(function(msg, args, util)
        local world_name = args:join ' ':lower()
        local world = w101:searchWorld(world_name)

        if not world then return msg:reply('Invalid world "'..world_name..'"') end
        local amount
        if world.quest_count == 'unknown' then
            amount = 'an unknown amount of'
        else
            amount = world.quest_count.total
        end

        msg.channel:send(
            util.Embed()
                :setTitle(world.name..' has '..amount..' quests.')
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish()
        )
    end);