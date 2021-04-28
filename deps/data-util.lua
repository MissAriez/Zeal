function coroutine.spawn(fn, ...)
    local crt = coroutine.create(fn);
    local success, err = coroutine.resume(crt, ...);
    if not success then
        print('ERROR: '..err);
    end
end

function math.limit(n, limit)
    if n > limit then return limit; end;
    if -n < -limit then return -limit end;
    return n;
end

function math.round(val, decimal)
    if (decimal) then
        return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
    else
        return math.floor(val+0.5)
    end
end

function math.format(n, d)
    local function comma_value(amount)
        local formatted = amount
        while true do  
            formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
            if (k==0) then
                break
            end
        end
        return formatted
    end
    
    local function format_num(amount, decimal, prefix, neg_prefix)
        local str_amount,  formatted, famount, remain

        decimal = decimal or 0  -- default 2 decimal places
        neg_prefix = neg_prefix or "-" -- default negative sign

        famount = math.abs(math.round(amount,decimal))
        famount = math.floor(famount)

        remain = math.round(math.abs(amount) - famount, decimal)

                    -- comma to separate the thousands
        formatted = comma_value(famount)

                    -- attach the decimal portion
        if (decimal > 0) then
            remain = tostring(remain):sub(3)
            formatted = formatted .. "." .. remain ..
                                    string.rep("0", decimal - #remain)
        end

                    -- attach prefix string e.g '$' 
        formatted = (prefix or "") .. formatted 

                    -- if value is negative then format accordingly
        if (amount<0) then
            if (neg_prefix=="()") then
                formatted = "("..formatted ..")"
            else
                formatted = neg_prefix .. formatted 
            end
        end

        return formatted
    end

    return format_num(n, d)
end

function string:last(chars)
    local map = self:split();
    local res = '';
    coroutine.spawn(function()
        for i = 1, chars do
            res = res..map[#map - (i - 1)];
        end
    end)
    return res:reverse();
end

function string:slice(keep)
    return self:sub(1, keep)
end

function string:title()
    local res = '';
    coroutine.spawn(function()
        for word in self:gmatch '%S+' do          
            local first = word:sub(1,1);
            res = (res..first:upper()..word:sub(2):lower()..' ');
        end
    end);
    return res;
end

function string:endsWith(ending)
    return ending == "" or self:sub(-#ending) == ending;
end

function string:trim()
    return self:gsub('%s+', '');
end

function table.filter(t, fn)
    local new = {};
    coroutine.spawn(function()
        for k, v in pairs(t) do
            if fn(v) then
                new[k] = v;
            end
        end
    end);
    return new;
end

function table.first(t)
    for i, v in pairs(t) do
        return v, i;
    end
end

function table.some(t, filter)
    for i, v in pairs(t) do
        if filter(v) then
            return v, i;
        end
    end
end

function table.shift(t)
    local _, index = table.first(t);
    table.remove(t, index);
    return t;
end

function table.random(t)
    assert(t);
    local randomIndex = math.random(1, #t);
    local count = 0;
    for _, v in pairs(t) do
        count = count + 1;
        if randomIndex == count then
            return v;
        end
    end
end

function table.merge(t, ...)
    assert(t and type(t) == 'table' and #{ ... } >= 1);
    local res = t;
    for _, ToMerge in pairs { ... } do
        coroutine.spawn(function()
            for i, v in pairs(ToMerge) do
                res[i] = v;
            end
        end)
    end
    return res;
end

function table.push(t, v)
    t[#t + 1] = v;
    return t;
end

function table.forEach(t, callback)
    assert(t);
    local f = {}
    for i, v in pairs(t) do
        f[i] = callback(v, i);
    end
    return f;
end