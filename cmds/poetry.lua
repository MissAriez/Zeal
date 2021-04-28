return Command 'poetry'
    :setCategory 'Fun'
    :setDesc 'Returns a random poem.'
    :setAliases {'poem'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://www.stands4.com/services/v2/poetry.php?uid=1001&tokenid=tk324324&term=grass&format=xml';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a poem!'
                :setDescription(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);