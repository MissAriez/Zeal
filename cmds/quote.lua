return Command 'quote'
    :setCategory 'Fun'
    :setDesc 'Return a random famous quote.'
    :setAliases {'famousquote'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://zenquotes.io/api/random';
        }:next(function(res)
            res = res[1][1]
            local embed = util.Embed()
                :setTitle 'Here\'s a random quote!'
                :setDescription(res.q)
                :setAuthor(res.a)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);