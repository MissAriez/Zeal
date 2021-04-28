return Command 'avatar'
    :setCategory 'Info'
    :setDesc 'Returns a mentioned user\'s avatar.'
    :setAliases { 'pfp', 'profilepic' }
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local avatar = user:getAvatarURL(1024)
        local embed = util.Embed()
            :setTitle(user.name..'\'s Avatar')
            :setImage(avatar)
            :setFooter(settings.footer)
            :setTimestamp()
            :setColor 'random'
            :finish();

        msg.channel:send(embed)
    end);
