return Command 'redpanda'
    :setCategory 'Images'
    :setDesc 'Return a random red panda image.'
    :setAliases {'bloodpanda'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/red_panda';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a red panda!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);