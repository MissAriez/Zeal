return Command 'question'
    :setCategory 'Fun'
    :setDesc 'Returns a random jeopardy question with a set answer.'
    :setAliases { 'jeopardy' }
    :run(function(msg, args, util)
        util.request {
            url = 'https://jservice.io/api/random';
        }:next(function(res)
            res = res[1][1]
            local embed = util.Embed()
                :setTitle('Random Q&A')
                :addField('Question', res.question)
                :addField('Answer', res.answer)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish()

            msg.channel:send(embed)
        end)
    end);