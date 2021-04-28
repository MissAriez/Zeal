return Command 'pikacu'
    :setCategory 'Fun'
    :setDesc 'Return a random pikachu image.'
    :setAliases {'pika'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/pikachu';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s pikachu!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);