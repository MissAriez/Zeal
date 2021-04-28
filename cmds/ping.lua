return Command 'ping'
    :setDesc 'Returns "Pong!" and the arguments provided.'
    :setCategory 'Fun'
    :setAliases { 'beep' }
    :run(function(msg, args)
        msg.channel:send 'Pong!'
    end);