return Command 'panda'
    :setCategory 'Images'
    :setDesc 'Return a random panda picture.'
    :setAliases {'bombooeater'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/panda';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a panda!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);