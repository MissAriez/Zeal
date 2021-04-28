return Command 'meal'
    :setCategory 'Fun'
    :setDesc 'Returns a random meal.'
    :setAliases {'food', 'munchies', 'hunger'}
    :run(function(msg, args, util)
        util.request {
            url = 'https://www.themealdb.com/api/json/v1/1/random.php';
        }:next(function(res)
            res = res[1].meals[1]
            local embed = util.Embed()
                :setTitle(res.strMeal)
                :setDescription(res.strInstructions)
                :setThumbnail(res.strMealThumb)
                :addField('Category', res.strCategory, true)
                :addField('Area', res.strArea, true)
                :setColor 'random'
                :setFooter(settings.footer)
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);