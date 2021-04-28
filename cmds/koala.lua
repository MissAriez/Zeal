return Command 'koala'
    :setCategory 'Images'
    :setDesc 'Return a random koala picture.'
    :setAliases {'koalabear', 'koobor'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/koala';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a koala bear!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);