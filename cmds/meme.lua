return Command 'meme'
    :setCategory 'Fun'
    :setDesc 'Return a random meme.'
    :setAliases {'lmao', 'lmfao', 'lol'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/meme';
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