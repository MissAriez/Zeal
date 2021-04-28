return Command 'weather'
    :setAliases {'forecast'}
    :setDesc 'Returns the weather of the region provided.'
    :setCategory 'Info'
    :setUsage '<region>'
    :run(function(msg, args, util)
        util.request {
            url = ('http://api.openweathermap.org/data/2.5/weather?q=%s&units=imperial&appid=%s'):format(args:join '+', env.WEATHER_API);
        }:next(function(res)
            if res.main ~= nil then
                local embed = util.Embed()
                    :setTitle('Weather for `'..res.name..' ('..res.sys.country..')`')
                    :addField(':white_sun_rain_cloud: Conditions', res.weather[1].description)
                    :addField(':thermometer: Temperature', res.main.temp..' °F (feels like '..res.main.feels_like..' °F)')
                    :addField(':droplet: Humudity', res.main.humidity..' %')
                    :addField(':cloud: Clouds', res.clouds.all..' %')
                    :addField(':dash: Wind Speed', res.wind.speed..' mph')
                    :setFooter(util.footer)
                    :setColor('random')
                    :setTimestamp()
                    :finish();
                msg:reply(embed);
            elseif not res.main then
                return msg:reply 'I am unable to fetch the weather for this area.';
            else
                return msg:reply 'I am unable to fetch the weather for this area.';
            end
        end)
    end)