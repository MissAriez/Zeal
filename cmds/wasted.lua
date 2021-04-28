return Command 'wasted'
    :setCategory 'Fun'
    :setDesc 'Returns a wasted version of the mentioned users avatar'
    :setAliases {'death'}
    :setUsage '<@user>'
    :optionalArgs()
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local image = 'https://some-random-api.ml/canvas/wasted?avatar='..user.avatarURL
            local embed = util.Embed()
                :setImage(image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg:reply(embed)
        end);