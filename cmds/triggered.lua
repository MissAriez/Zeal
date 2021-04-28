return Command 'triggered'
    :setCategory 'Fun'
    :setDesc 'Returns a triggered image of the mentioned users avatar'
    :setAliases {'trigger', 'mad','hoesmad', 'bitchesbebonkers', 'ree', 'triggeredgif', 'rage'}
    :setUsage '<@user>'
    :optionalArgs()
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local image = 'https://some-random-api.ml/canvas/triggered?avatar='..user.avatarURL
            local embed = util.Embed()
                :setImage(image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg:reply(embed)
        end);