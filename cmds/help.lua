return Command 'help'
    :setDesc 'Returns help about commands in a specified category, or lists categories if no category is provided.'
    :setCategory 'Info'
    :setUsage '<category>'
    :setAliases { 'helpwith' }
    :optionalArgs()
    :run(function(msg, args, util)
        local embed = util.Embed()
            :setFooter(settings.footer)
            :setThumbnail(client.user.iconURL)
            :setColor 'random'
            :setTimestamp();

        local category = args:join ' '
        if not category or category == '' then
            local categories = Array(client._categories:toArray())
            local desc = ''
            categories:forEach(function(_, category)
                desc = desc..('**○ %s**\n'):format(category:title())
            end)

            embed:setTitle 'Commandies'
                :setDescription(desc)
        else
            embed:setTitle('Commands in '..category:title())

            local cmds = client._categories:get(category:lower()) or false
            if not cmds then
                return msg:reply('Could not find the category `'..category..'`.');
            end
            
            for name, cmd in pairs(cmds) do
                local field_title = ('%s%s %s'):format(settings.prefix, cmd.name, cmd.usage)
                local field_desc = ('%s\naliases: %s'):format(cmd.desc, Array(cmd.aliases):join ', ')
                embed:addField(field_title, field_desc, true)
            end
        end

        msg.channel:send 'Sent a help menu to your DMs! :white_check_mark: :relieved:'
        msg.author:send(embed:finish())
    end);