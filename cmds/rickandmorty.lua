return Command 'rickandmorty'
    :setCategory 'Fun'
    :setDesc 'Return a random rick and morty character.'
    :setAliases {'character', 'r&m'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://rickandmortyapi.com/api/character/';
        }:next(function(res)
            res = table.random(res[1].results)
            if not res then return msg:reply 'I could not find a character.' end
            local embed = util.Embed()
                :setTitle 'Here\'s a rick and morty character!'
                :addField('Name', res.name, true)
                :addField('Status', res.status, true)
                :addField('Species', res.species, true)
                :addField('Type', res.type, true)
                :addField('Gender', res.gender, true)
                :setImage(res.image)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();
p(res.image)
            msg.channel:send(embed)
        end);
    end);