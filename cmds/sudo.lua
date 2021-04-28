return Command 'sudo'
    :setCategory 'Fun'
    :setAliases {'say', 'saythis'}
    :setDesc 'Returns what is inputted and deletes the message calling command'
    :run(function(msg, args, util)
        msg:delete()
        msg.channel:send(args:join ' ')
    end);