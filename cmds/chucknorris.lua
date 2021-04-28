return Command 'chucknorris'
    :setCategory 'Fun'
    :setDesc 'Returns a random Chuck Norris joke.'
    :run(function(msg, args, util)
        util.request {
            url = 'https://api.chucknorris.io/jokes/random';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Funny Words From Magic Man'
                :setColor 'random'
                :setDescription(res.value)
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();
            
            msg.channel:send(embed)
        end)
    end);