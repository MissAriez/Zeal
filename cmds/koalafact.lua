return Command 'koalafact'
    :setCategory 'Facts'
    :setDesc 'Returns a random koala bear fact.'
    :setAliases {'koalabearfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/koala';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a koala bear fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);