return Command 'reddit'
    :setCategory 'Fun'
    :setDesc 'Return a random reddit post.'
    :setAliases {'redditpost', 'red'}
    :run(function(msg, args, util)
        util.request {
            url = '';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle(res.caption)
                :setImage(res.image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);