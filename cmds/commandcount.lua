return Command 'commandcount'
    :setCategory 'Info'
    :setDesc 'Returns how many commands Zeal has implemented.'
    :setAliases { 'cmdcount', 'cmds', 'cc' }
    :run(function(msg, args, util)
        local count = client._commands:size()
        msg.channel:send('Zeal has '..count..' commands.')
    end);