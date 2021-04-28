return Command 'invert'
    :setCategory 'Fun'
    :setDesc 'Returns a random invert image '
    :setAliases {'invertme'}
    :setUsage '<@user>'
    :optionalArgs()
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local image = 'https://some-random-api.ml/canvas/invert?avatar='..user.avatarURL
            local embed = util.Embed()
                :setImage(image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg:reply(embed)
        end);
    