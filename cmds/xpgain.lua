return Command 'xpgain'
    :setDesc 'Returns the range of XP it\'s possible for you to reach message..'
    :setCategory 'Levels'
    :setAliases { 'expgain'}
    :run(function(msg, args, util)
        local gain = '1-'..math.ceil(util.gain_formula(125))
        msg.channel:send('You gain `'..gain..'` experience per message.')
    end)