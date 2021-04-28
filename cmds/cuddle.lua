return Command 'cuddle'
    :setCategory 'Roleplay'
    :setDesc 'Cuddles the mentioned user.'
    :setAliases {'snuggles'}
    :setUsage '<@user>'
    :run(function(msg, args, util)
    local user = msg.mentionedUsers:toArray()[1]
    p(util.giphy 'cuddle')
        local embed = util.Embed()
            :setTitle(msg.author.name..' cuddles '..user.name)
            :setImage(util.giphy 'cuddle' )
            :setColor 'random'
            :setFooter(settings.footer)
            :setTimestamp()
            :finish();

        msg.channel:send(embed)
    end);