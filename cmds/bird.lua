return Command 'bird'
    :setCategory 'Images'
    :setDesc 'Return a random bird image.'
    :setAliases {'birdy'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/birb';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a bird!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);