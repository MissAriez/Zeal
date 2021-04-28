return Command 'coinflip'
    :setDesc 'Returns heads or tails.'
    :setCategory 'Utility'
    :setAliases { 'flipcoin' }
    :run(function(msg, args, util)
        local binary = math.round(math.random())
        if binary == 0 then
            msg:reply 'Heads!'
        else
            msg:reply 'Tails!'
        end
    end);