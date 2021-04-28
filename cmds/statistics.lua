return Command 'statics'
    :setDesc 'Returns a user\'s, or yours if no user is provided'
    :setCategory 'Levels'
    :setAliases { 'stats'}
    :setUsage '<@user>'
    :optionalArgs()
    :run(function(msg, args, util)
        local user = msg.mentionedUsers:toArray()[1] or msg.author
        local id = user.id
        local stats = msg.client._stats
        local lvl, xp, tolvl, prestige = stats:get('level', id), stats:get('xp', id), stats:get('tolvl', id), stats:get('prestige', id)
        local fmt_lvl
        if prestige > 0 then
            fmt_lvl = util.roman(prestige)..'-'..lvl
        else
            fmt_lvl = lvl
        end

        local embed = util.Embed()
            :setTitle(user.name..'\'s Statistics')
            :addField('Level', fmt_lvl, true)
            :addField('Current XP', math.format(xp), true)
            :addField('XP until next level', math.format(tolvl), true)
            :setColor 'random'
            :setFooter(settings.footer)
            :setThumbnail(user.avatarURL)
            :setTimestamp()
            :finish();

        msg.channel:send(embed)
    end);