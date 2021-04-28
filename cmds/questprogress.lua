local w101 = require 'w101'

return Command 'questprogress'
    :setCategory 'Wizard101'
    :setDesc 'Returns progress through a world in Wizard101 based on a quest number.'
    :setAliases { 'questprog', 'quest' }
    :setUsage '<questNumber> <world>'
    :run(function(msg, args, util)
        local quest = tonumber(args:first())
        if not quest then
            return msg:reply('"'..args:first()..'" is not a valid quest number.')
        end
        
        local world_name = args:shift():join ' '
        local world = w101:searchWorld(world_name)

        if not world then return msg:reply('Invalid world "'..world_name..'"') end

        local progress = world:progress(quest)

        msg.channel:send(
            util.Embed()
                :setTitle('You are '..progress..'% through '..world.name..'. You have '..world.quest_count.total - quest..' quests left.')
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish()
        )
    end);