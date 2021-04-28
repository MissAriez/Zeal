return Command 'drink'
    :setCategory 'Fun'
    :setAliases { 'booze', 'cocktail', 'randomdrink'}
    :setDesc 'Returns a random cocktail mix'
    :run(function(msg, args, util)
        util.request {
            url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php';
        }:next(function(res)
            res = res[1].drinks[1]
            local embed = util.Embed()
                :setTitle(res.strDrink)
                :setDescription(res.strInstructions)
                :addField('Category', res.strCategory, true)
                :addField('Type', res.strAlcoholic, true)
                :addField('Glass', res.strGlass, true)
                :setThumbnail(res.strDrinkThumb)
                :setColor 'random'
                :setTimestamp()
                :finish();

            msg.channel:send(embed)
        end);
    end);