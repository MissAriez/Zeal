return Command 'prestige'
    :setDesc 'Prestiges if you are level 100 and not max prestige'
    :setCategory 'Levels'
    :setAliases {'rebirth', 'reset'}
    :run(function(msg, args, util)
        local stats = msg.client._stats
        local id = msg.author.id
        local lvl = stats:get('level', id)
        local prestige = stats:get('prestige', id)

        if lvl < 100 then return msg:reply 'You need to be level 100 to prestige!' end
        if prestige == 25 then return msg:reply 'You are at the maximum prestige!' end

        local embed = Embed()
            :setTitle ':star2::star2: ***_PRESTIGE_*** :star2::star2:'
            :setDescription('**'..msg.author.name..' has prestiged for their '..util.ordinal(prestige + 1)..' time!**')
            :setColor(0xffff00)
            :setFooter(settings.footer)
            :setTimestamp()
            :finish();

        msg.channel:send(embed)
    end)