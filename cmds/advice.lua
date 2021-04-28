return Command 'advice'
    :setCategory 'Fun'
    :setDesc 'Returns random advice.'
    :setAliases {'giveadvice'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://api.adviceslip.com/advice';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s random advice!'
                :setDescription(res.slip.advice)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);