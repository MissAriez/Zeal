local function format(n, d)
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
    local function round(val, decimal)
        if (decimal) then
            return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
        else
            return math.floor(val+0.5)
        end
    end
    local function format_num(amount, decimal, prefix, neg_prefix)
        local str_amount,  formatted, famount, remain

        decimal = decimal or 0  -- default 2 decimal places
        neg_prefix = neg_prefix or "-" -- default negative sign

        famount = math.abs(round(amount,decimal))
        famount = math.floor(famount)

        remain = round(math.abs(amount) - famount, decimal)

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

return function(n) 
    n = tonumber(n);
    local suffixes = {'th','st','nd','rd','th'}
    local suffix = suffixes[math.min(n % 10, 4) + 1];
    if 11 <= n % 100 and n % 100 <= 13 then
        suffix = 'th';
    end
    return format(n)..suffix; 
end;