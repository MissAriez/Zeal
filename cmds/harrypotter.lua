return Command 'harrypotter'
    :setCategory 'Fun'
    :setDesc 'Returns what house youre in.'
    :setAliases {'harry', 'potter','sortinghat', 'sort', 'house'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://www.potterapi.com/v1/sortingHat';
            parser = {
                parse = function(self, data)
                    return data
                end;
            };
        }:next(function(res)
            res = res[1]
            local embed = util.Embed()
                :setTitle 'Here\'s what house you\'re in!'
                :setDescription(res:gsub('"',''))
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);