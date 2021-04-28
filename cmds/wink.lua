return Command 'wink'
    :setCategory 'Roleplay'
    :setDesc 'Winks at the mentioned user.'
    :setAliases {';)'}
    :setUsage '<@user>'
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1]
        util.request {
            url = 'https://some-random-api.ml/animu/wink';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle(msg.author.name..' winks at '..user.name)
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);