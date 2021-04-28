return Command 'dogfact'
    :setCategory 'Facts'
    :setDesc 'Returns a random dogfact.'
    :setAliases {'doggyfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/dog';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a dog fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);