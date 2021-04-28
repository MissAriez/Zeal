return Command 'about'
    :setDesc 'Returns information about Zeal.'
    :setCategory 'Info'
    :setAliases { 'info', 'botinfo' }
    :run(function(msg, args, util)
        local embed = util.Embed()
            :setTitle(settings.name..' :deciduous_tree:')
            :addField('Author', ('<@!%s>'):format(settings.author), true)
            :addField('Bot Version', settings.version, true)
            :addField('Lua Version', _VERSION..' on Luvit Environment', true)
            :addField('Command Count', client._commands:size(), true)
            :addField('Created At', util.Discord.Date.fromSeconds(client.user.createdOn):toISO('T', 'Z'):slice(10), true)
            :addField('Server Count', #client.guilds, true)
            :setThumbnail(client.user.iconURL)
            :setFooter(settings.footer)
            :setColor 'random'
            :setTimestamp()
            :finish();
        
        msg.channel:send(embed)
    end);