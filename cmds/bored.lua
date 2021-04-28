return Command 'bored'
    :setCategory 'Fun'
    :setDesc 'Returns a activity to do when bored.'
    :setAliases {'activity', 'boredom'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://www.boredapi.com/api/activity';
        }:next(function(res)
            msg:reply(
            util.Embed()
                :setTitle ('Activity')
                :setDescription(res.activity)
                :addField('Type', res.type:title())
                :addField('Participants', res.participants)
                :addFiled('Effort', tostring(res.price * 100)..'$')
                :addFiled('Accessibility', tostring(res.accessibility * 100)..'$')
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :Finish()

        );
    end);
end)