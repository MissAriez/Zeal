return Command 'foxfact'
    :setCategory 'Facts'
    :setDesc 'Returns a random fox fact.'
    :setAliases {'foxyfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/fox';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a fox fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);