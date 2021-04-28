return Command 'invite'
    :setCategory 'Info'
    :setDesc 'Returns an invite link for Zeal'
    :setAliases { 'inviteme', 'botinvite' }
    :run(function(msg, args, util)
        local embed = util.Embed()
            :setTitle 'Invite Me Bitch! :link:'
            :setURL 'https://discord.com/oauth2/authorize?client_id=768712337405509632&scope=bot&permissions=8'
            :setColor 'random'
            :setFooter(settings.footer)
            :setTimestamp()
            :finish();

        msg.channel:send(embed)
    end);