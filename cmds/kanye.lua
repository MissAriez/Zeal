local Command = require 'command-class'
return Command 'kanye'
    :setCategory 'Fun'
    :setAliases { 'kanyequote', 'kanyewest' }
    :setDesc 'Returns a random Kanye West quote.'
    :run(function(msg, args, util)
        util.request {
            url = 'https://api.kanye.rest';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Big Mans Juju'
                :setDescription(res.quote)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();
            
            msg.channel:send(embed)
        end)
    end);