return Command 'fox'
    :setCategory 'Images'
    :setDesc 'Return a random fox image.'
    :setAliases {'foxxy'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/fox';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a fox!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);