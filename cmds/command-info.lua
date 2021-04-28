return Command 'commandinfo'
    :setCategory 'Info'
    :setDesc 'Returns information on the specified command'
    :setAliases {'cmdinfo', 'cinfo', 'ci'}
    :setUsage '<command>'
    :run(function(msg, args, util)
        local cmd = args:first()
        local command = client._commands:get(cmd) or client._commands:get(client._aliases:get(cmd))

        if not command then return msg:reply 'I couldn\'t find that command.' end

        local embed = util.Embed()
            :setTitle(settings.prefix..command.name..' '..command.usage)
            :setDescription(command.desc)
            :addField('Category', command.category, true)
            :addField('Aliases', command.aliases:join ', ', true)
            :addField('Optional Arguments',command.optionalargs or false, true)
            :setColor 'random'
            :setFooter(settings.footer)
            :setTimestamp()
            :finish();

        msg.channel:send(embed)
    end);