return Command 'birdfact'
    :setCategory 'Facts'
    :setDesc 'Returns a random bird fact.'
    :setAliases {'birdyfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/bird';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a bird fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);