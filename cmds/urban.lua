return Command 'urban'
    :setCategory 'Info'
    :setAliases {'urbandictionary', 'urbandict', 'dictionary'}
    :setDesc 'Returns and Urban Dictionary definition'
    :setUsage '<resultNumber> <phrase>'
    :run(function(msg, args, util)
        local resultNumber = tonumber(table.pack(args:first())[1]);
        if not resultNumber then return msg:reply 'You need to input a result number.'; end;

        util.request {
            url = 'http://api.urbandictionary.com/v0/define?term='..args:shift():join '+'
        }:next(function(res)
            local def = res[1].list[resultNumber];
            if not def then return msg:reply 'No resutls found.'; end;
            msg:reply(
             util.Embed()
                :settitle(args:join(' '):title())
                :setAuthor(math.format(def.thumbs_up)..' Upvotes | Written on '..def.written_on:slice(10)..'by "'..def.author..'"')
                :addField('Definition', def.definiton)
                :addField('Example', def.example)
                :setURL(res.permalink)
                :setFooter(resultNumber..' out of '..#res.list..' results | '..util.footer)
                :setColor 'random'
                :setTimestamp()
                :finish()
            );
        end)
        :catch(function(err)
            msg:reply(util.err(err))
        end);
        
    end)