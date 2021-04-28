local class = require 'class'
local roman = require 'roman'

return function(msg)
    local uid = msg.author.id
    local gid = msg.guild.id
    local function tag(name, id, id2)
        return ('%s_%s_%s'):format(name, id, id2)
    end

    local Stats = class {
        constructor = function(self) end;
        get = function(self, key, id)
            return db:get(tag(key, id or uid, gid))
        end;
        set = function(self, key, value, id)
            db:set(tag(key, id or uid, gid), value)
        end;
    }

    local stats = Stats()
    msg.client._stats = stats

    local level = stats:get 'level' or 1 --default level is 1
    local prestige = stats:get 'prestige' or 0
    local xp = stats:get 'xp' or 0

    local function xp_formula()
        if level == 100 then
            return 999999999999999
        end
        return math.ceil(.08 * (level / 2) + 2 * (level ^ 1.75) + 6 * (level / 2) * (100 - (prestige * 2.25)))
    end

    local tolvl = stats:get 'tolvl' or xp_formula()

    local function gain_formula(mult)
        local random_mult = (105 + ((prestige / 8)) * (mult or math.random(125))) * level / 5
        if mult then
            return random_mult
        end
        mult = mult or math.random(125)
        return math.random(random_mult)
    end

    xp = xp + gain_formula()

    if xp >= tolvl and level < 100 then
        xp = 0
        level = level + 1
        tolvl = xp_formula()
        local lvl
        if prestige > 0 then
            lvl = roman(prestige)..'-'..level
        else
            lvl = level
        end
        msg.channel:send('<@!'..uid..'>, you are now level '..lvl..'!')
    end

    stats:set('level', level)
    stats:set('xp', xp)
    stats:set('tolvl', tolvl)
    stats:set('prestige', prestige)

    return gain_formula
end