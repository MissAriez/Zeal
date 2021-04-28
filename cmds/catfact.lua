return Command 'catfact'
    :setCategory 'Facts'
    :setDesc 'Returns a random cat fact.'
    :setAliases {'kittyfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/cat';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a cat fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);