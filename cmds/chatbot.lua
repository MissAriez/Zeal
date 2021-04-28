return Command 'chatbot'
    :setCategory 'Fun'
    :setDesc 'Returns a response to what you say to it.'
    :setAliases {'chatty', 'bottalk'}
    :setUsage '<message>'
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/chatbot?message='..args:join '+';
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Message from chatbot!'
                :setDescription(res.response)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                
                if not res.response then return msg:reply 'No response' end

            msg.channel:send(embed:finish())
        end);
    end);