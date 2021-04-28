return Command 'pat'
    :setCategory 'Roleplay'
    :setDesc 'Pats the mentioned user.'
    :setAliases {'pattie'}
    :setUsage '<@user>'
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1]
        util.request {
            url = 'https://some-random-api.ml/animu/pat';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle(msg.author.name..' pats '..user.name)
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);