return Command 'cat'
    :setCategory 'Images'
    :setDesc 'Return a random cat image.'
    :setAliases {'kitty', 'kittycat', 'kittykat'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://api.thecatapi.com/v1/images/search';
            headers = {
                {'X-API-KEY'; env.CAT_API};
            };
        }:next(function(res)
            res = res[1][1]
            local embed = util.Embed()
                :setTitle 'Here\'s a cat!'
                :setDescription(Array(res.breeds):join ', ')
                :setImage(res.url)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);