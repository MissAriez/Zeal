return Command 'lyrics'
    :setCategory 'Info'
    :setDesc 'Returns the lyrics to a song specified.'
    :setUsage '<songTitle>'
    :setAliases { 'songlyrics' }
    :run(function(msg, args, util)
        util.request {
            url = 'https://some-random-api.ml/lyrics/?title='..args:join '+';
        }:next(function(res)
            res = res[1]
            if not res then
                return msg:reply 'I could not find that song.'
            end
            local embed = util.Embed()
                :setTitle('Lyrics to '..res.author..' - '..res.title)
                :setDescription(res.lyrics:trim():slice(2040))
                :setThumbnail(res.thumbnail.genius)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);