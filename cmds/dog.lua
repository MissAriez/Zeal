return Command 'dog'
    :setCategory 'Images'
    :setDesc 'Return a random dog image.'
    :setAliases {'doggy', 'puppy', 'doggo', 'doggie', 'doge', 'pooch', 'poochie'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/img/dog';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s a dog!'
                :setImage(res.link)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);