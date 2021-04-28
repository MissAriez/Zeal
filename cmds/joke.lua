return Command 'joke'
    :setCategory 'Fun'
    :setDesc 'Returns a random joke.'
    :setAliases {'pun', 'darkhumour', 'funny'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://sv443.net/jokeapi/v2/joke/Dark,Pun';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a joke!'
                :setDescription()
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
            
            if res.type == 'twopart' then
                embed:addField('Setup', res.setup, true)
                embed:addField('Delivery', res.delivery, true)
            else
                embed:setDescription(res.joke)
            end
            
            msg.channel:send(embed:finish())
        end);
    end);