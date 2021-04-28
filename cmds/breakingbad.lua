return Command 'breakingbad'
    :setCategory 'Fun'
    :setDesc 'Return a random breaking bad quote.'
    :setAliases {'breakingbadquote', 'breaking'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://breaking-bad-quotes.herokuapp.com/v1/quotes';
        }:next(function(res)
            res = res[1][1]
            local embed = util.Embed()
                :setTitle 'Here\'s a breaking bad quote!'
                :setDescription(res.quote)
                :setAuthor(res.author)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);