return Command 'pandafact'
    :setCategory 'Facts'
    :setDesc 'Return a random panda fact.'
    :setAliases {'pandafacto', 'bambooeaterfact'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/facts/panda';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a panda fact!'
                :setDescription(res.fact)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);