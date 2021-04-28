return Command 'greyscale'
    :setCategory 'Images'
    :setDesc 'Returns a greyscale version of the mentioned users avatar'
    :setAliases {'grey', 'silver'}
    :setUsage '<@user>'
    :optionalArgs()
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local image = 'https://some-random-api.ml/canvas/greyscale?avatar='..user.avatarURL
            local embed = util.Embed()
                :setImage(image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg:reply(embed)
        end);