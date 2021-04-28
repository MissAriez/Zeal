return Command 'insult'
    :setCategory 'Fun'
    :setDesc 'Returns a random insult'
    :setAliases {'hateon'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://evilinsult.com/generate_insult.php?lang=en&type=json';
        }:next(function(res)
            res = res[1]
            msg.channel:send(res.insult)
        end);
    end);