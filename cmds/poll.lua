return Command 'poll'
    :setCategory 'Fun'
    :setDesc 'Returns a poll.'
    :setAliases {'vote'}
    :run(function(msg, args, util)
        local embed = util.Embed()
            :setTitle 'Poll'
            :setDescription(args:join ' ')
            :setColor 'random'
            :setFooter(settings.footer)
            :setTimestamp()
            :finish();

        local message = msg.channel:send(embed)
        message:addReaction '👍'
        message:addReaction '👎'
    end);